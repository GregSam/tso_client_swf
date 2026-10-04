package
{
    import flash.events.Event;

    public class ClientBuffTrackEvent extends Event
    {
        public static const BUFF_APPLY:String = "buffApply";

        public var data:Object;

        public function ClientBuffTrackEvent(type:String, data:Object, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, bubbles, cancelable);
            this.data = data;
        }

        override public function clone():Event
        {
            return new ClientBuffTrackEvent(type, this.data, bubbles, cancelable);
        }
    }
}
