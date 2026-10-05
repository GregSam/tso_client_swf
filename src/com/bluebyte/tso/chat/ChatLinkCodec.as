package com.bluebyte.tso.chat
{
    import com.hurlant.util.Base64;

    public final class ChatLinkCodec
    {
        private static const PREFIX:String = "[[u1:";
        private static const SUFFIX:String = "]]";

        public static function encodeLinks(value:String):String
        {
            var pattern:RegExp;
            var match:Object;
            var raw:String;
            var link:String;
            var result:String;
            var position:int;
            if (!value)
            {
                return value;
            };
            pattern = /(https?:\/\/[^\s]+|www\.[^\s]+)/gi;
            result = "";
            position = 0;
            match = pattern.exec(value);
            while (match != null)
            {
                raw = String(match[0]);
                link = raw.replace(/[.,!?;:)\]}]+$/, "");
                result = (result + value.substring(position, int(match.index)));
                if (link.length > 0)
                {
                    result = (result + PREFIX + toUrlSafeBase64(link) + SUFFIX + raw.substr(link.length));
                }
                else
                {
                    result = (result + raw);
                };
                position = (int(match.index) + raw.length);
                match = pattern.exec(value);
            };
            return (result + value.substr(position));
        }

        public static function decodeLinks(value:String):String
        {
            var pattern:RegExp;
            var match:Object;
            var decoded:String;
            var result:String;
            var position:int;
            if (!value || value.indexOf(PREFIX) == -1)
            {
                return value;
            };
            pattern = /\[\[u1:([A-Za-z0-9_-]+)\]\]/g;
            result = "";
            position = 0;
            match = pattern.exec(value);
            while (match != null)
            {
                result = (result + value.substring(position, int(match.index)));
                decoded = decodeUrlSafeBase64(String(match[1]));
                result = (result + ((isSupportedUrl(decoded)) ? decoded : String(match[0])));
                position = (int(match.index) + String(match[0]).length);
                match = pattern.exec(value);
            };
            return (result + value.substr(position));
        }

        private static function toUrlSafeBase64(value:String):String
        {
            return Base64.encode(value).replace(/\+/g, "-").replace(/\//g, "_").replace(/=+$/, "");
        }

        private static function decodeUrlSafeBase64(value:String):String
        {
            var encoded:String = value.replace(/-/g, "+").replace(/_/g, "/");
            while ((encoded.length % 4) != 0)
            {
                encoded = (encoded + "=");
            };
            try
            {
                return Base64.decode(encoded);
            }
            catch(error:Error)
            {
                return null;
            };
        }

        private static function isSupportedUrl(value:String):Boolean
        {
            if (!value)
            {
                return false;
            };
            value = value.toLowerCase();
            return ((value.indexOf("http://") == 0) || (value.indexOf("https://") == 0) || (value.indexOf("www.") == 0));
        }
    }
}
