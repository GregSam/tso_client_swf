package
{
    import Model.Notifier;
    import Model.Observer;
    import flash.events.EventDispatcher;

    public class ClientBuff implements Observer
    {
        private var dispatcher:EventDispatcher;

        public function ClientBuff()
        {
            this.dispatcher = new EventDispatcher();
        }

        public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
        {
            this.dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
        }

        public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
        {
            this.dispatcher.removeEventListener(type, listener, useCapture);
        }

        public function update(notifier:Notifier, property:String, value:Object):void
        {
            this.dispatcher.dispatchEvent(new ClientBuffTrackEvent(ClientBuffTrackEvent.BUFF_APPLY, value));
        }
    }
}
