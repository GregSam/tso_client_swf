package Effects.Effects
{
    import Effects.Effect;
    import Communication.VO.EffectVO;
    import Interface.cGameInterface;
    import GUI.cGuiBaseElement;

    public final class CloseWindow extends Effect 
    {

        public static const XML_string:String = "closewindow";


        override public function init(_arg_1:EffectVO, _arg_2:cGameInterface):void
        {
            super.init(_arg_1, _arg_2);
            applyAsGameTick = false;
        }

        override protected function action():void
        {
            if (((globalFlash.gui.IsLazyGuiElement(effect.name_string)) && (!(globalFlash.gui.IsLazyControllerCreated(effect.name_string)))))
            {
                return;
            };
            var _local_1:cGuiBaseElement = globalFlash.gui.GetPanelControllerById(effect.name_string);
            _local_1.Hide();
        }


    }
}
