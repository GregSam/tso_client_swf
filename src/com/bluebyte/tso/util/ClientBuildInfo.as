package com.bluebyte.tso.util
{
    import flash.utils.ByteArray;

    public final class ClientBuildInfo
    {
        [Embed(source="../../../../../assets/version.txt", mimeType="application/octet-stream")]
        private static var SwfCommit:Class;

        public static function getSwfCommit():String
        {
            var bytes:ByteArray = new SwfCommit() as ByteArray;
            bytes.position = 0;
            return bytes.readUTFBytes(bytes.length).replace(/^\s+|\s+$/g, "");
        }
    }
}
