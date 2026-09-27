package GUI.States
{
    import mx.core.UIComponent;
    import mx.states.AddChild;

    public class GuiAddChild extends AddChild
    {
        public function GuiAddChild()
        {
            super();
        }

        private function resolveParent(_arg_1:UIComponent):UIComponent
        {
            if (((_arg_1 != null) && (_arg_1.hasOwnProperty("guiScaleLayer"))))
            {
                return (_arg_1["guiScaleLayer"] as UIComponent);
            };
            return (_arg_1);
        }

        override public function apply(_arg_1:UIComponent):void
        {
            super.apply(this.resolveParent(_arg_1));
        }

        override public function remove(_arg_1:UIComponent):void
        {
            super.remove(this.resolveParent(_arg_1));
        }
    }
}
