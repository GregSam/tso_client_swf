#!/bin/bash
# Minimal build: runtime theme (mxmlc 3.6) + client (mxmlc 4.16 + 3.6 runtime libs).
# Usage: ./build.sh [-DebugBuild|-MinimalBuild] [-KeepGeneratedCode] [-Stage=live|-Stage=test]
set -u
ROOT="$(cd "$(dirname "$0")" && pwd)"
JAVA="${JAVA:-java}"
MODE=""
KEEP=""
STAGE="live"
for arg in "$@"; do
    case "$arg" in
        -DebugBuild) MODE="-compiler.debug=true" ;;
        -MinimalBuild) MODE="-compiler.debug=false -compiler.optimize=true -compiler.compress=true" ;;
        -KeepGeneratedCode) KEEP="-compiler.keep-generated-actionscript=true" ;;
        -Stage=*) STAGE="${arg#-Stage=}" ;;
    esac
done
command -v "$JAVA" >/dev/null 2>&1 || { echo "Java not found in PATH."; exit 1; }

# ---- server stage data ----
case "$STAGE" in
    live|test) ;;
    *) echo "Unknown stage '$STAGE'. Expected live or test."; exit 1 ;;
esac
STAGE_DIR="$ROOT/stage/$STAGE"
MAPPING_SOURCE="$STAGE_DIR/mapping.data"
VERSION_SOURCE="$STAGE_DIR/version.txt"
[ -f "$MAPPING_SOURCE" ] || { echo "Missing $MAPPING_SOURCE"; exit 1; }
[ -f "$VERSION_SOURCE" ] || { echo "Missing $VERSION_SOURCE"; exit 1; }
GAME_VERSION="$(tr -d '\r\n' < "$VERSION_SOURCE")"
case "$GAME_VERSION" in
    *[!0-9a-fA-F]*|'') echo "Invalid VERSION_NR in $VERSION_SOURCE"; exit 1 ;;
esac
[ "${#GAME_VERSION}" -eq 40 ] || { echo "Invalid VERSION_NR length in $VERSION_SOURCE"; exit 1; }
cp "$MAPPING_SOURCE" "$ROOT/assets/gAssetManager/FileHashing_Mapping.bin" || exit 1
sed -i.bak -E "s|(public static var VERSION_NR:String = \")[^\"]*(\";)|\1${GAME_VERSION}\2|" "$ROOT/src/defines.as" || exit 1
rm -f "$ROOT/src/defines.as.bak"
grep -q "VERSION_NR:String = \"${GAME_VERSION}\";" "$ROOT/src/defines.as" || { echo "Could not update VERSION_NR."; exit 1; }
echo "Using stage: $STAGE ($GAME_VERSION)"

# ---- theme (mxmlc 3.6 needs localFonts.ser in CWD) ----
cd "$ROOT/sdk/3.6.0/frameworks" || exit 1
"$JAVA" -jar ../lib/mxmlc.jar -load-config=../../../theme-config.xml ../../../assets/theme/swmmoTheme.css -output ../../../assets/theme/swmmo-theme.swf
if [ $? -ne 0 ]; then echo "Theme build failed."; exit 1; fi
echo "Build succeeded: assets/theme/swmmo-theme.swf"
cd "$ROOT" || exit 1

# ---- frames config (force-link string-loaded classes) ----
CFG="$ROOT/linker-config.xml"
{
echo '<flex-config>'
echo '  <frames><frame><label>main</label>'
find src -name '*.as' -o -name '*.mxml' | grep -v 'generated/' | sed -e 's|^src/||' -e 's|\.mxml$||' -e 's|\.as$||' -e 's|/|.|g' | grep -v '^_SWMMO_mx_managers_SystemManager$' | sort -u | sed -e 's|.*|    <classname>&</classname>|'
echo '  </frame></frames>'
echo '</flex-config>'
} > "$CFG"

# ---- client (relative paths, CWD=root) ----
"$JAVA" -Duser.language=en -Duser.country=US -Xmx2g -Dfile.encoding=UTF-8 -Dflexlib=sdk/4.16.1/frameworks -jar sdk/4.16.1/lib/mxmlc.jar -load-config=compiler-config.xml -load-config+=linker-config.xml $MODE $KEEP -output=client.swf src/_SWMMO_mx_managers_SystemManager.as > compile.log 2>&1
if [ $? -ne 0 ]; then echo "Compilation failed. See compile.log."; exit 1; fi
echo "Build succeeded: client.swf"
