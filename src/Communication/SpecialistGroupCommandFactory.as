package Communication
{
    import Communication.VO.dSpecialistGroupCommandVO;
    import Communication.VO.SpecialistGroup.dBuyVO;
    import Communication.VO.SpecialistGroup.dRenameVO;
    import Communication.VO.SpecialistGroup.dSpecialistActionVO;
    import Communication.VO.SpecialistGroup.dSpecialistGroupIdVO;
    import Communication.VO.SpecialistGroup.dStartTaskVO;
    import mx.collections.ArrayCollection;

    public final class SpecialistGroupCommandFactory
    {
        public static function makeBuy(_arg_1:int, _arg_2:int):dSpecialistGroupCommandVO
        {
            var _local_3:dBuyVO = new dBuyVO();
            _local_3.NumberOfOwnedGroupsBeforePurchase = _arg_1;
            _local_3.CostAlternativeIndex = _arg_2;
            return createCommand(1, _local_3);
        }

        public static function makeRename(_arg_1:int, _arg_2:int, _arg_3:String):dSpecialistGroupCommandVO
        {
            var _local_4:dRenameVO = new dRenameVO();
            _local_4.SpecialistGroupId = createId(_arg_1, _arg_2);
            _local_4.Name = _arg_3;
            return createCommand(2, _local_4);
        }

        public static function makeMove(_arg_1:int, _arg_2:int, _arg_3:Array, _arg_4:Array):dSpecialistGroupCommandVO
        {
            var _local_5:dSpecialistActionVO = new dSpecialistActionVO();
            _local_5.SpecialistGroupId = createId(_arg_1, _arg_2);
            _local_5.AddedSpecialistUniqueID = new ArrayCollection(_arg_3 != null ? _arg_3 : []);
            _local_5.RemovedSpecialistUniqueID = new ArrayCollection(_arg_4 != null ? _arg_4 : []);
            return createCommand(5, _local_5);
        }

        public static function makeStartTask(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):dSpecialistGroupCommandVO
        {
            var _local_5:dStartTaskVO = new dStartTaskVO();
            _local_5.SpecialistGroupId = createId(_arg_1, _arg_2);
            _local_5.MainTaskId = _arg_3;
            _local_5.SubTaskId = _arg_4;
            return createCommand(6, _local_5);
        }

        private static function createId(_arg_1:int, _arg_2:int):dSpecialistGroupIdVO
        {
            var _local_3:dSpecialistGroupIdVO = new dSpecialistGroupIdVO();
            _local_3.Type = _arg_1;
            _local_3.Id = _arg_2;
            return _local_3;
        }

        private static function createCommand(_arg_1:int, _arg_2:Object):dSpecialistGroupCommandVO
        {
            var _local_3:dSpecialistGroupCommandVO = new dSpecialistGroupCommandVO();
            _local_3.Command = _arg_1;
            _local_3.Payload = _arg_2;
            return _local_3;
        }

    }
}
