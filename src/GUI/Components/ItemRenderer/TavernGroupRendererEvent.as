package GUI.Components.ItemRenderer
{
    import flash.events.Event;

    public class TavernGroupRendererEvent extends Event
    {
        public static const ACTION:String = "tavernGroupRendererAction";

        public var action:String;
        public var index:int;
        public var alternative:int;
        public var value:String;
        public var uid:String;

        public function TavernGroupRendererEvent(_arg_1:String, _arg_2:int, _arg_3:int = 0, _arg_4:String = "", _arg_5:String = "")
        {
            super(ACTION, true);
            this.action = _arg_1;
            this.index = _arg_2;
            this.alternative = _arg_3;
            this.value = _arg_4;
            this.uid = _arg_5;
        }

        override public function clone():Event
        {
            return new TavernGroupRendererEvent(this.action, this.index, this.alternative, this.value, this.uid);
        }
    }
}
