package com.bluebyte.bluefire.api.model.vo
{
    public class PresenceUpdatedVO 
    {

        private var _online:Boolean;
        private var _name:String;
        private var _show:String;
        private var _status:String;

        public function PresenceUpdatedVO(_arg_1:String, _arg_2:Boolean, _arg_3:String=null, _arg_4:String=null)
        {
            super();
            this._name = _arg_1;
            this._online = _arg_2;
            this._show = _arg_3;
            this._status = _arg_4;
        }

        public function get online():Boolean
        {
            return (this._online);
        }

        public function set name(_arg_1:String):void
        {
            this._name = _arg_1;
        }

        public function get name():String
        {
            return (this._name);
        }

        public function set online(_arg_1:Boolean):void
        {
            this._online = _arg_1;
        }

        public function get show():String
        {
            return (this._show);
        }

        public function get status():String
        {
            return (this._status);
        }


    }
}
