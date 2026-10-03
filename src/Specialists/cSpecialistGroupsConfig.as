package Specialists
{
    import Communication.VO.TriggerVO;
    import ServerState.dResource;
    import __AS3__.vec.Vector;
    import nLib.cXML;

    public class cSpecialistGroupsConfig
    {
        public var maximumNumberOfSpecialistGroups:int;
        public var maximumNumberOfSpecialistsPerGroup:int;
        public const conditions:Vector.<TriggerVO> = new Vector.<TriggerVO>();
        public const groupCosts:Vector.<Vector.<Vector.<dResource>>> = new Vector.<Vector.<Vector.<dResource>>>();

        public static function CreateFromXML(root:cXML):cSpecialistGroupsConfig
        {
            var result:cSpecialistGroupsConfig = new cSpecialistGroupsConfig();
            var node:cXML;
            var groupNode:cXML;
            var alternativeNode:cXML;
            var alternatives:Vector.<Vector.<dResource>>;
            var costs:Vector.<dResource>;
            var costNode:cXML;
            var resource:dResource;
            var index:int;

            result.maximumNumberOfSpecialistGroups = root.GetAttributeInt("maximumNumberOfSpecialistGroups");
            result.maximumNumberOfSpecialistsPerGroup = root.GetAttributeInt("maximumNumberOfSpecialistsPerGroup");
            for each(node in root.MoveToSubNodeAndCreateChildrenArray("Conditions"))
            {
                if(node.GetName_string() == null || node.GetName_string() == "null" || node.GetName_string().length == 0)
                {
                    continue;
                }
                result.conditions.push(TriggerVO.createFromXML(node,index++));
            }
            for each(groupNode in root.MoveToSubNodeAndCreateChildrenArray("Costs"))
            {
                if(groupNode.GetName_string() != "Group")
                {
                    continue;
                }
                alternatives = new Vector.<Vector.<dResource>>();
                for each(alternativeNode in groupNode.CreateChildrenArray())
                {
                    if(alternativeNode.GetName_string() != "Alternative")
                    {
                        continue;
                    }
                    costs = new Vector.<dResource>();
                    for each(costNode in alternativeNode.CreateChildrenArray())
                    {
                        if(costNode.GetName_string() != "Cost")
                        {
                            continue;
                        }
                        resource = new dResource().Init(costNode.GetAttributeString_string("name"),costNode.GetAttributeInt("count"));
                        costs.push(resource);
                    }
                    alternatives.push(costs);
                }
                result.groupCosts.push(alternatives);
            }
            return result;
        }

        public function getCosts(groupIndex:int, alternativeIndex:int):Vector.<dResource>
        {
            if(groupCosts.length == 0)
            {
                return new Vector.<dResource>();
            }
            groupIndex = Math.max(0,Math.min(groupIndex,groupCosts.length - 1));
            var alternatives:Vector.<Vector.<dResource>> = groupCosts[groupIndex];
            if(alternatives == null || alternativeIndex < 0 || alternativeIndex >= alternatives.length)
            {
                return new Vector.<dResource>();
            }
            return alternatives[alternativeIndex];
        }

        public function getAlternativeCount(groupIndex:int):int
        {
            if(groupCosts.length == 0)
            {
                return 0;
            }
            groupIndex = Math.max(0,Math.min(groupIndex,groupCosts.length - 1));
            return groupCosts[groupIndex] != null ? groupCosts[groupIndex].length : 0;
        }
    }
}
