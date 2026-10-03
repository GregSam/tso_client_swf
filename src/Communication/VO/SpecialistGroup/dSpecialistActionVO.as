package Communication.VO.SpecialistGroup
{
    import mx.collections.ArrayCollection;

    public class dSpecialistActionVO
    {
        public var SpecialistGroupId:dSpecialistGroupIdVO;
        public var AddedSpecialistUniqueID:ArrayCollection = new ArrayCollection();
        public var RemovedSpecialistUniqueID:ArrayCollection = new ArrayCollection();
    }
}
