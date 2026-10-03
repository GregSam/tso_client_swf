package Specialists
{
    public class cSpecialistGroupStarItem
    {
        public var entry:Object;
        public var representative:cSpecialist;
        public var name:String;
        public var memberCount:int;
        public var groupIndex:int;

        public function cSpecialistGroupStarItem(_arg_1:Object, _arg_2:cSpecialist, _arg_3:String, _arg_4:int, _arg_5:int)
        {
            this.entry = _arg_1;
            this.representative = _arg_2;
            this.name = _arg_3;
            this.memberCount = _arg_4;
            this.groupIndex = _arg_5;
        }

        public function get isActive():Boolean
        {
            return this.groupTask != null;
        }

        public function get groupTask():Object
        {
            var task:Object = this.representative != null ? this.representative.GetTask() : null;
            return task;
        }
    }
}
