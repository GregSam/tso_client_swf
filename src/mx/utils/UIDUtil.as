package mx.utils
{
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;
    import flash.utils.getTimer;
    import mx.core.IPropertyChangeNotifier;
    import mx.core.IUIComponent;
    import mx.core.IUID;

    public class UIDUtil
    {
        private static const ALPHA_CHAR_CODES:Array = [48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 65, 66, 67, 68, 69, 70];
        private static const DASH:int = 45;
        private static const UID_BUFFER:ByteArray = new ByteArray();
        private static const TIME_BASE:Number = new Date().time - getTimer();
        private static var uidDictionary:Dictionary = new Dictionary(true);

        public static function createUID():String
        {
            UID_BUFFER.position = 0;
            var random0:uint = uint(Math.random() * 4294967296);
            var random1:uint = uint(Math.random() * 4294967296);
            var random2:uint = uint(Math.random() * 4294967296);
            var i:int;
            for (i = 0; i < 8; i++)
            {
                UID_BUFFER.writeByte(ALPHA_CHAR_CODES[(random0 >>> (i << 2)) & 15]);
            }
            UID_BUFFER.writeByte(DASH);
            for (i = 0; i < 4; i++)
            {
                UID_BUFFER.writeByte(ALPHA_CHAR_CODES[(random1 >>> (i << 2)) & 15]);
            }
            UID_BUFFER.writeByte(DASH);
            for (i = 4; i < 8; i++)
            {
                UID_BUFFER.writeByte(ALPHA_CHAR_CODES[(random1 >>> (i << 2)) & 15]);
            }
            UID_BUFFER.writeByte(DASH);
            for (i = 0; i < 4; i++)
            {
                UID_BUFFER.writeByte(ALPHA_CHAR_CODES[(random2 >>> (i << 2)) & 15]);
            }
            UID_BUFFER.writeByte(DASH);
            var time:uint = uint(TIME_BASE + getTimer());
            var timeString:String = time.toString(16).toUpperCase();
            for (i = 8; i > timeString.length; i--)
            {
                UID_BUFFER.writeByte(48);
            }
            UID_BUFFER.writeUTFBytes(timeString);
            for (i = 4; i < 8; i++)
            {
                UID_BUFFER.writeByte(ALPHA_CHAR_CODES[(random2 >>> (i << 2)) & 15]);
            }
            return (UID_BUFFER.toString());
        }

        public static function fromByteArray(_arg_1:ByteArray):String
        {
            if (((_arg_1 == null) || (_arg_1.length < 16)) || (_arg_1.bytesAvailable < 16))
            {
                return (null);
            }
            UID_BUFFER.position = 0;
            var i:uint;
            while (i < 16)
            {
                if ((((i == 4) || (i == 6)) || (i == 8)) || (i == 10))
                {
                    UID_BUFFER.writeByte(DASH);
                }
                var value:int = _arg_1.readByte();
                UID_BUFFER.writeByte(ALPHA_CHAR_CODES[(value & 0xF0) >>> 4]);
                UID_BUFFER.writeByte(ALPHA_CHAR_CODES[(value & 15)]);
                i++;
            }
            return (UID_BUFFER.toString());
        }

        public static function isUID(_arg_1:String):Boolean
        {
            if (((_arg_1 == null) || (!(_arg_1.length == 36))))
            {
                return (false);
            }
            var i:uint;
            while (i < 36)
            {
                var code:Number = _arg_1.charCodeAt(i);
                if ((((i == 8) || (i == 13)) || (i == 18)) || (i == 23))
                {
                    if (code != DASH)
                    {
                        return (false);
                    }
                }
                else if ((((code < 48) || (code > 70)) || ((code > 57) && (code < 65))))
                {
                    return (false);
                }
                i++;
            }
            return (true);
        }

        public static function toByteArray(_arg_1:String):ByteArray
        {
            if (!isUID(_arg_1))
            {
                return (null);
            }
            var result:ByteArray = new ByteArray();
            var i:uint;
            while (i < _arg_1.length)
            {
                var character:String = _arg_1.charAt(i);
                if (character != "-")
                {
                    var high:uint = getDigit(character);
                    i++;
                    var low:uint = getDigit(_arg_1.charAt(i));
                    result.writeByte((((high << 4) | low) & 0xFF));
                }
                i++;
            }
            result.position = 0;
            return (result);
        }

        public static function getUID(_arg_1:Object):String
        {
            var result:String = null;
            if (_arg_1 == null)
            {
                return (result);
            }
            if (_arg_1 is IUID)
            {
                result = IUID(_arg_1).uid;
                if (((result == null) || (result.length == 0)))
                {
                    result = createUID();
                    IUID(_arg_1).uid = result;
                }
            }
            else if (((_arg_1 is IPropertyChangeNotifier) && (!(_arg_1 is IUIComponent))))
            {
                result = IPropertyChangeNotifier(_arg_1).uid;
                if (((result == null) || (result.length == 0)))
                {
                    result = createUID();
                    IPropertyChangeNotifier(_arg_1).uid = result;
                }
            }
            else if (_arg_1 is String)
            {
                return (_arg_1 as String);
            }
            else
            {
                try
                {
                    if (((_arg_1 is XMLList) && (_arg_1.length() == 1)))
                    {
                        _arg_1 = _arg_1[0];
                    }
                    if (_arg_1 is XML)
                    {
                        var xml:XML = XML(_arg_1);
                        var nodeKind:String = xml.nodeKind();
                        if (((nodeKind == "text") || (nodeKind == "attribute")))
                        {
                            return (xml.toString());
                        }
                        var notificationFunction:Function = xml.notification();
                        if (!(notificationFunction is Function))
                        {
                            notificationFunction = XMLNotifier.initializeXMLForNotification();
                            xml.setNotification(notificationFunction);
                        }
                        if (notificationFunction["uid"] == undefined)
                        {
                            notificationFunction["uid"] = createUID();
                        }
                        result = notificationFunction["uid"];
                    }
                    else
                    {
                        if ("mx_internal_uid" in _arg_1)
                        {
                            return (_arg_1.mx_internal_uid);
                        }
                        if ("uid" in _arg_1)
                        {
                            return (_arg_1.uid);
                        }
                        result = uidDictionary[_arg_1];
                        if (!result)
                        {
                            result = createUID();
                            try
                            {
                                _arg_1.mx_internal_uid = result;
                            }
                            catch (_error:Error)
                            {
                                uidDictionary[_arg_1] = result;
                            }
                        }
                    }
                }
                catch (_error:Error)
                {
                    result = _arg_1.toString();
                }
            }
            return (result);
        }

        private static function getDigit(_arg_1:String):uint
        {
            var code:int = _arg_1.charCodeAt(0);
            if (((code >= 48) && (code <= 57)))
            {
                return (code - 48);
            }
            if (((code >= 65) && (code <= 70)))
            {
                return (code - 55);
            }
            if (((code >= 97) && (code <= 102)))
            {
                return (code - 87);
            }
            return (0);
        }
    }
}
