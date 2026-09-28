package Effects.Effects
{
    import Effects.Effect;
    import Communication.VO.EffectVO;
    import Interface.cGameInterface;
    import GUI.cGuiBaseElement;
    import GUI.GAME.cHelpWindow;

    public final class OpenWindow extends Effect 
    {

        public static const XML_string:String = "openwindow";


        override public function init(_arg_1:EffectVO, _arg_2:cGameInterface):void
        {
            super.init(_arg_1, _arg_2);
            applyAsGameTick = false;
        }

        override protected function action():void
        {
            if (((effect.name_string == "GAMESTATE_ID_HELP_WINDOW") && (!(cHelpWindow.wouldShow(effect.item_string)))))
            {
                return;
            };
            var _local_1:cGuiBaseElement = globalFlash.gui.GetPanelControllerById(effect.name_string);
            _local_1.SetDataByString(effect.item_string);
            globalFlash.gui.TryShowPanel(_local_1);
        }


    }
}
