package com.bluebyte.bluefire.puremvc.view.xiff
{
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;
    import org.puremvc.as3.multicore.interfaces.IMediator;
    import org.igniterealtime.xiff.im.Roster;
    import org.igniterealtime.xiff.core.XMPPConnection;
    import org.igniterealtime.xiff.events.RosterEvent;
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.igniterealtime.xiff.data.Presence;
    import com.bluebyte.bluefire.puremvc.BlueFireFacade;
    import org.igniterealtime.xiff.data.im.RosterItemVO;
    import com.bluebyte.bluefire.api.model.vo.PresenceUpdatedVO;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    import mx.core.Application;

    public class XIFFRosterMediator extends Mediator implements IMediator 
    {

        public static const NAME:String = "XIFFRosterMediator";
        public static const SET_PRESENCE:String = "setPresence";
        public static const OWN_PRESENCE_CHANGED:String = "ownPresenceChanged";
        private static const AUTO_AWAY_DELAY_MS:int = 300000;

        private var _show:String;
        private var _manualShow:String;
        private var _automaticAway:Boolean;
        private var _awayTimer:Timer = new Timer(AUTO_AWAY_DELAY_MS, 1);

        public function XIFFRosterMediator()
        {
            super(NAME);
        }

        override public function onRegister():void
        {
            Application.application.addEventListener(MouseEvent.MOUSE_MOVE, this.userActivityHandler, true);
            Application.application.addEventListener(MouseEvent.MOUSE_DOWN, this.userActivityHandler, true);
            Application.application.addEventListener(MouseEvent.MOUSE_UP, this.userActivityHandler, true);
            Application.application.addEventListener(KeyboardEvent.KEY_DOWN, this.userActivityHandler, true);
            Application.application.addEventListener(KeyboardEvent.KEY_UP, this.userActivityHandler, true);
            this._awayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.awayTimerCompleteHandler);
        }

        override public function onRemove():void
        {
            Application.application.removeEventListener(MouseEvent.MOUSE_MOVE, this.userActivityHandler, true);
            Application.application.removeEventListener(MouseEvent.MOUSE_DOWN, this.userActivityHandler, true);
            Application.application.removeEventListener(MouseEvent.MOUSE_UP, this.userActivityHandler, true);
            Application.application.removeEventListener(KeyboardEvent.KEY_DOWN, this.userActivityHandler, true);
            Application.application.removeEventListener(KeyboardEvent.KEY_UP, this.userActivityHandler, true);
            this._awayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.awayTimerCompleteHandler);
            this._awayTimer.stop();
        }

        override public function listNotificationInterests():Array
        {
            return ([XIFFConnectionMediator.XIFF_CONNECTION_CREATED, SET_PRESENCE]);
        }

        override public function handleNotification(_arg_1:INotification):void
        {
            switch (_arg_1.getName())
            {
                case XIFFConnectionMediator.XIFF_CONNECTION_CREATED:
                    viewComponent = new Roster((_arg_1.getBody() as XMPPConnection));
                    this.roster.addEventListener(RosterEvent.ROSTER_LOADED, this.roster_RosterLoadedHandler);
                    this.roster.addEventListener(RosterEvent.USER_PRESENCE_UPDATED, this.roster_UserPresenceUpdatedHandler);
                    this.roster.addEventListener(RosterEvent.USER_ADDED, this.roster_UserAddedHandler);
                    this.roster.addEventListener(RosterEvent.SUBSCRIPTION_REQUEST, this.roster_SubscriptionRequestHandler);
                    return;
                case SET_PRESENCE:
                    this.setPresence(_arg_1.getBody() as String);
                    return;
            };
        }

        private function roster_RosterLoadedHandler(_arg_1:RosterEvent):void
        {
            this.sendPresence();
            this._awayTimer.reset();
            this._awayTimer.start();
            this.roster.removeEventListener(RosterEvent.ROSTER_LOADED, this.roster_RosterLoadedHandler);
            sendNotification(BlueFireFacade.ROOM_JOIN_ALL);
        }

        private function setPresence(show:String):void
        {
            switch (show)
            {
                case "online":
                    this._manualShow = null;
                    break;
                case "chat":
                    this._manualShow = Presence.SHOW_CHAT;
                    break;
                case "away":
                    this._manualShow = Presence.SHOW_AWAY;
                    break;
                case "xa":
                    this._manualShow = Presence.SHOW_XA;
                    break;
                case "dnd":
                    this._manualShow = Presence.SHOW_DND;
                    break;
                default:
                    return;
            }
            this._automaticAway = false;
            this._show = this._manualShow;
            this.sendPresence();
            sendNotification(OWN_PRESENCE_CHANGED, this._show);
        }

        private function userActivityHandler(event:Event):void
        {
            this._awayTimer.reset();
            this._awayTimer.start();
            if (this._automaticAway)
            {
                this._automaticAway = false;
                this._show = null;
                this.sendPresence();
                sendNotification(OWN_PRESENCE_CHANGED, this._show);
            }
        }

        private function awayTimerCompleteHandler(event:TimerEvent):void
        {
            if (this._manualShow != null || this._automaticAway)
            {
                return;
            }
            this._automaticAway = true;
            this._show = Presence.SHOW_AWAY;
            this.sendPresence();
            sendNotification(OWN_PRESENCE_CHANGED, this._show);
        }

        private function sendPresence():void
        {
            if (this.roster == null || this.roster.connection == null || this.roster.connection.jid == null)
            {
                return;
            }
            var presence:Presence = new Presence(null, this.roster.connection.jid.escaped, null, this._show, null, 1);
            this.roster.connection.send(presence);
        }

        private function roster_UserPresenceUpdatedHandler(_arg_1:RosterEvent):void
        {
            var _local_2:RosterItemVO = _arg_1.data;
            sendNotification(BlueFireFacade.FRIEND_PRESENCE_UPDATED, new PresenceUpdatedVO(_local_2.nickname, _local_2.online, _local_2.show, _local_2.status));
        }

        private function roster_UserAddedHandler(_arg_1:RosterEvent):void
        {
            var _local_2:RosterItemVO = _arg_1.data;
            sendNotification(BlueFireFacade.FRIEND_PRESENCE_UPDATED, new PresenceUpdatedVO(_local_2.nickname, _local_2.online, _local_2.show, _local_2.status));
        }

        private function get roster():Roster
        {
            return (viewComponent as Roster);
        }

        private function roster_SubscriptionRequestHandler(_arg_1:RosterEvent):void
        {
            this.roster.grantSubscription(_arg_1.jid, true);
        }


    }
}
