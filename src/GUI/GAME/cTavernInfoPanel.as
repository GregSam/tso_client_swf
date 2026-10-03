package GUI.GAME
{
   import Enums.*;
   import GO.cBuilding;
   import GUI.Components.ItemRenderer.*;
   import GUI.Components.StarMenuComboBoxItem;
   import GUI.Components.TavernInfoPanel;
   import GUI.Components.CustomAlert;
   import GUI.Assets.gAssetManager;
   import GUI.Effects.*;
   import GUI.Loca.*;
   import Interface.*;
   import Specialists.*;
   import Communication.SpecialistGroupCommandFactory;
   import Communication.VO.dUniqueID;
   import Communication.VO.SpecialistGroup.dSpecialistGroupEntryVO;
   import Communication.VO.SpecialistGroup.dSpecialistGroupVO;
   import Communication.VO.SpecialistGroup.dSpecialistGroupIdVO;
   import Communication.VO.SpecialistGroup.dSpecialistReferenceVO;
   import ServerState.dResource;
   import flash.events.*;
   import mx.core.ClassFactory;
   import mx.collections.ArrayCollection;
   import mx.controls.Alert;
   import mx.events.*;

   public class cTavernInfoPanel extends cBasicInfoPanel
   {
      protected var mBuilding:cBuilding;
      private var mGI:cGameInterface;
      protected var mPanel:TavernInfoPanel;
      private var selectedGroup:int = 0;
      private var editing:Boolean = false;
      private var selectedMembers:Object = {};
      private var explorers:Array = [];
      private var groups:Array = [];
      private var memberMaps:Array = [];
      private var memberOwners:Object = {};
      private var pendingBuy:String = "";
      private var sortAscending:Boolean = true;
      private var renameTarget:int = -1;

      public function cTavernInfoPanel()
      {
         super();
      }

      override public function Show() : void
      {
         super.Show();
         this.refreshTabs();
         if(this.mPanel.groupsCanvas.visible)
         {
            this.refreshGroupsView();
         }
      }

      private function BuySpecialist(param1:ListEvent) : void
      {
         cSpecialist.BuySpecialist(param1.rowIndex,this.mGI);
         this.Hide();
      }

      override public function SetData(param1:cBuilding) : void
      {
         var renderer:BuySpecialistItemRenderer = null;
         var description:cSpecialistDescription = null;
         var buildingName:String = param1.GetBuildingName_string();
         this.mBuilding = param1;
         this.mPanel.label = cLocaManager.GetInstance().GetText(LOCA_GROUP.BUILDINGS,buildingName);
         this.mPanel.upgradeColumn.SetData(param1,this,this.mPanel);
         this.mPanel.buildingHeader.data = this.mBuilding;
         if(this.mPanel.list.getChildren().length == cSpecialist.GetAllSpecialistDescriptions().length)
         {
            for each(renderer in this.mPanel.list.getChildren())
            {
               renderer.refresh();
            }
         }
         else
         {
            this.mPanel.list.removeAllChildren();
            for each(description in cSpecialist.GetAllSpecialistDescriptions())
            {
               renderer = new BuySpecialistItemRenderer();
               renderer.id = "Specialist" + SPECIALIST_TYPE.toString(description.GetType());
               renderer.data = description;
               this.mPanel.list.addChild(renderer);
            }
            gHintManager.TryRemainingHints();
         }
         this.refreshTabs();
         if(this.mPanel.groupsCanvas.visible)
         {
            this.refreshGroupsView();
         }
      }

      public function Init(param1:TavernInfoPanel) : void
      {
         this.mGI = global.ui as cGameInterface;
         globalFlash.gui.windowController.addWindow(param1);
         AddBaseElement(param1);
         this.mPanel = param1;
         this.mPanel.addEventListener(FlexEvent.CREATION_COMPLETE,this.completeHandler);
      }

      private function completeHandler(param1:FlexEvent) : void
      {
         this.mPanel.removeEventListener(FlexEvent.CREATION_COMPLETE,this.completeHandler);
         this.mPanel.btnClose.addEventListener(MouseEvent.CLICK,this.ClosePanel);
         this.mPanel.list.addEventListener("BuySpecialist",this.BuySpecialist);
         this.refreshTabs();
         this.mPanel.selectAllBox.label = "";
         this.mPanel.selectAllBox.toolTip = cLocaManager.GetInstance().GetText(LOCA_GROUP.TOOLTIP,"SelectAllTip");
         this.mPanel.sortDirection.toolTip = cLocaManager.GetInstance().getLabel("ChangeSortingOrder");
         this.mPanel.sortMode.dataProvider = this.localizedSortOptions();
         this.mPanel.sortMode.itemRenderer = new ClassFactory(StarMenuComboBoxItem);
         this.mPanel.editOk.setStyle("icon",gAssetManager.GetClass("ButtonIconOK"));
         this.mPanel.editCancel.setStyle("icon",gAssetManager.GetClass("ButtonIconAbort"));
         this.mPanel.tabBar.addEventListener(ItemClickEvent.ITEM_CLICK,this.switchTab);
         this.mPanel.sortMode.addEventListener("change",this.explorerFilterChanged);
         this.mPanel.sortDirection.addEventListener(MouseEvent.CLICK,this.toggleSortDirection);
         this.updateSortArrow();
         this.mPanel.searchInput.addEventListener(Event.CHANGE,this.explorerFilterChanged);
         this.mPanel.selectAllBox.addEventListener(MouseEvent.CLICK,this.selectAllExplorers);
         this.mPanel.editOk.addEventListener(MouseEvent.CLICK,this.saveGroupMembers);
         this.mPanel.editCancel.addEventListener(MouseEvent.CLICK,this.cancelGroupEdit);
         this.mPanel.groupsList.addEventListener(TavernGroupRendererEvent.ACTION,this.groupRendererAction);
         this.mPanel.explorersTile.addEventListener(TavernGroupRendererEvent.ACTION,this.explorerRendererAction);
         this.showRecruiting();
      }

      private function localizedSortOptions() : Array
      {
         return [{"label":cLocaManager.GetInstance().GetText(LOCA_GROUP.LABELS,"default"),"data":0},{"label":cLocaManager.GetInstance().GetText(LOCA_GROUP.LABELS,"Name"),"data":1},{"label":cLocaManager.GetInstance().GetText(LOCA_GROUP.LABELS,"Date"),"data":2},{"label":cLocaManager.GetInstance().GetText(LOCA_GROUP.LABELS,"Type"),"data":3}];
      }

      private function showRecruiting(param1:Event = null) : void
      {
         this.mPanel.upgradeContainer.visible = true;
         this.mPanel.listBackground.visible = true;
         this.mPanel.listContainer.visible = true;
         this.mPanel.list.visible = true;
         this.mPanel.groupsCanvas.visible = false;
         this.updateTabState(false);
      }

      private function showGroups(param1:Event = null) : void
      {
         if(this.mBuilding == null || this.mBuilding.GetUpgradeLevel() < 2)
         {
            this.showRecruiting();
            return;
         }
         this.mPanel.upgradeContainer.visible = false;
         this.mPanel.listBackground.visible = false;
         this.mPanel.listContainer.visible = false;
         this.mPanel.groupsCanvas.visible = true;
         this.updateTabState(true);
         this.refreshGroupsView();
      }

      private function updateTabState(groupsSelected:Boolean) : void
      {
         this.mPanel.tabBar.selectedIndex = groupsSelected && this.mBuilding != null && this.mBuilding.GetUpgradeLevel() >= 2 ? 1 : 0;
      }

      private function switchTab(param1:ItemClickEvent) : void
      {
         if(param1.index == 1)
         {
            this.showGroups(param1);
         }
         else
         {
            this.showRecruiting(param1);
         }
      }

      private function refreshTabs() : void
      {
         var tabs:Array = [{"id":"Recruitment","label":cLocaManager.GetInstance().GetText(LOCA_GROUP.LABELS,"Recruitment")}];
         var groupsAvailable:Boolean = this.mBuilding != null && this.mBuilding.GetUpgradeLevel() >= 2;
         if(groupsAvailable)
         {
            tabs.push({"id":"Groups","label":cLocaManager.GetInstance().GetText(LOCA_GROUP.LABELS,"GroupExplorers")});
         }
         this.mPanel.tabBar.dataProvider = tabs;
         if(!groupsAvailable && this.mPanel.groupsCanvas.visible)
         {
            this.showRecruiting();
         }
         else
         {
            this.updateTabState(this.mPanel.groupsCanvas.visible);
         }
      }

      private function compareExplorers(left:Object, right:Object) : Number
      {
         var entry:dSpecialistGroupEntryVO;
         var members:Object;
         var leftIsMember:Boolean;
         var rightIsMember:Boolean;
         if(this.editing)
         {
            entry = this.selectedEntry();
            members = this.memberKeys(entry);
            leftIsMember = members[this.uidKey(cSpecialist(left).GetUniqueID())] === true;
            rightIsMember = members[this.uidKey(cSpecialist(right).GetUniqueID())] === true;
            if(leftIsMember != rightIsMember)
            {
               return leftIsMember ? -1 : 1;
            }
         }
         var direction:int = this.sortAscending ? 1 : -1;
         var mode:int = this.mPanel.sortMode != null && this.mPanel.sortMode.selectedItem != null ? int(this.mPanel.sortMode.selectedItem["data"]) : 0;
         if(mode == 1)
         {
            return cStarMenu.CompareName(left,right,direction);
         };
         if(mode == 2)
         {
            return cStarMenu.CompareDate(left,right,direction);
         };
         if(mode == 3)
         {
            return cStarMenu.CompareType(left,right,direction);
         };
         return cStarMenu.CompareDefault(left,right,direction);
      }

      private function visibleExplorers() : Array
      {
         var result:Array = [];
         var specialist:Object = null;
         var activeEntry:dSpecialistGroupEntryVO = this.selectedEntry();
         var activeMembers:Object = activeEntry != null && !this.isGroupIdle(activeEntry) ? this.memberKeys(activeEntry) : null;
         var query:String = this.mPanel.searchInput != null ? String(this.mPanel.searchInput.text).toLocaleLowerCase().replace(/^\s+|\s+$/g,"") : "";
         for each(specialist in this.explorers)
         {
            if((activeMembers == null || activeMembers[this.uidKey(cSpecialist(specialist).GetUniqueID())]) && (query.length == 0 || cStarMenu.GetSortName(specialist).toLocaleLowerCase().indexOf(query) >= 0))
            {
               result.push(specialist);
            }
         }
         result.sort(this.compareExplorers);
         return result;
      }

      private function explorerFilterChanged(param1:Event = null) : void
      {
         this.refreshGroupsView();
      }

      private function toggleSortDirection(param1:MouseEvent = null) : void
      {
         this.sortAscending = !this.sortAscending;
         this.updateSortArrow();
         this.refreshGroupsView();
      }

      private function updateSortArrow() : void
      {
         var skin:String = this.sortAscending ? "ArrowSmallN" : "ArrowSmallS";
         if(this.mPanel.sortDirection == null)
         {
            return;
         }
         this.mPanel.sortDirection.setStyle("upSkin",gAssetManager.GetClass(skin + "Up"));
         this.mPanel.sortDirection.setStyle("overSkin",gAssetManager.GetClass(skin + "Over"));
         this.mPanel.sortDirection.setStyle("downSkin",gAssetManager.GetClass(skin + "Up"));
      }

      private function getGroups() : Array
      {
         var groups:Object = this.mGI.mCurrentPlayerZone != null ? this.mGI.mCurrentPlayerZone.mSpecialistGroups : null;
         if(groups != null && groups.SpecialistGroups is Array)
         {
            return groups.SpecialistGroups as Array;
         }
         if(groups != null && groups.SpecialistGroups is ArrayCollection)
         {
            return ArrayCollection(groups.SpecialistGroups).source;
         }
         return this.groups != null ? this.groups : [];
      }

      private function getExplorers() : Array
      {
         var result:Array = [];
         var specialist:cSpecialist;
         for each(specialist in this.mGI.mCurrentPlayerZone.GetSpecialists_vector())
         {
            if(specialist.getPlayerID() == this.mGI.mCurrentPlayer.GetPlayerId() && specialist.GetBaseType() == SPECIALIST_TYPE.EXPLORER)
            {
               result.push(specialist);
            }
         }
         return result;
      }

      private function selectedEntry() : dSpecialistGroupEntryVO
      {
         return this.selectedGroup >= 0 && this.selectedGroup < this.groups.length ? this.groups[this.selectedGroup] as dSpecialistGroupEntryVO : null;
      }

      private function groupId(entry:dSpecialistGroupEntryVO) : dSpecialistGroupIdVO
      {
         return entry != null && entry.SpecialistGroup != null ? entry.SpecialistGroup.Id : null;
      }

      private function uidKey(uid:dUniqueID) : String
      {
         if(uid == null)
         {
            return "";
         }
         return String(uid.uniqueID1) + ":" + String(uid.uniqueID2);
      }

      private function memberKeys(entry:dSpecialistGroupEntryVO) : Object
      {
         var cachedIndex:int = this.groups.indexOf(entry);
         if(cachedIndex >= 0 && cachedIndex < this.memberMaps.length && this.memberMaps[cachedIndex] != null)
         {
            return this.memberMaps[cachedIndex];
         }
         var result:Object = {};
         var refs:Object = entry != null ? entry.SpecialistReferences : null;
         var ref:dSpecialistReferenceVO;
         var uid:dUniqueID;
         if(refs != null)
         {
            for each(ref in refs)
            {
               uid = ref != null ? ref.UniqueID : null;
               if(uid != null)
               {
                  result[this.uidKey(uid)] = true;
               }
            }
         }
         return result;
      }

      private function rebuildMembershipCache() : void
      {
         var index:int = 0;
         var members:Object = null;
         var key:String = null;
         this.memberMaps = [];
         this.memberOwners = {};
         while(index < this.groups.length)
         {
            members = this.memberKeys(this.groups[index] as dSpecialistGroupEntryVO);
            this.memberMaps.push(members);
            for(key in members)
            {
               if(members[key])
               {
                  this.memberOwners[key] = index;
               }
            }
            index++;
         }
      }

      private function objectCount(values:Object) : int
      {
         var count:int = 0;
         var key:String = null;
         for(key in values)
         {
            if(values[key])
            {
               count++;
            }
         }
         return count;
      }

      private function cloneKeys(values:Object) : Object
      {
         var result:Object = {};
         var key:String = null;
         for(key in values)
         {
            if(values[key])
            {
               result[key] = true;
            }
         }
         return result;
      }

      private function memberOwner(uid:String) : int
      {
         return this.memberOwners[uid] == null ? -1 : int(this.memberOwners[uid]);
      }

      private function isGroupIdle(entry:dSpecialistGroupEntryVO) : Boolean
      {
         var members:Object = this.memberKeys(entry);
         var specialist:cSpecialist;
         var key:String = null;
         for each(specialist in this.explorers)
         {
            key = this.uidKey(cSpecialist(specialist).GetUniqueID());
            if(members[key])
            {
               if(specialist.GetTask() != null)
               {
                  return false;
               }
            }
         }
         return true;
      }

      private function refreshGroupsView() : void
      {
         var groupsScrollPosition:Number = this.mPanel.groupsList.verticalScrollPosition;
         var explorersScrollPosition:Number = this.mPanel.explorersTile.verticalScrollPosition;
         var groupItems:ArrayCollection = new ArrayCollection();
         var explorerItems:ArrayCollection = new ArrayCollection();
         var entry:dSpecialistGroupEntryVO;
         var group:dSpecialistGroupVO;
         var specialist:cSpecialist;
         var representative:cSpecialist;
         var uid:String;
         var owner:int;
         var name:String;
         var count:int;
         var index:int;
         this.groups = this.getGroups();
         this.explorers = this.getExplorers();
         this.rebuildMembershipCache();
         if(this.groups.length > 0 && this.selectedGroup < 0)
         {
            this.selectedGroup = 0;
         }
         else if(this.selectedGroup >= this.groups.length)
         {
            this.selectedGroup = this.groups.length > 0 ? 0 : -1;
         }
         for each(entry in this.groups)
         {
            group = entry != null ? entry.SpecialistGroup : null;
            representative = this.groupRepresentative(entry);
            name = group != null && group.Name != null ? group.Name : "";
            if(name.length == 0)
            {
               name = cLocaManager.GetInstance().GetText(LOCA_GROUP.LABELS,"DefaultSpecialistGroupName",[index + 1]);
            }
            count = index == this.selectedGroup && this.editing ? this.objectCount(this.selectedMembers) : this.objectCount(this.memberKeys(entry));
            groupItems.addItem({
               "index":index,
               "selected":index == this.selectedGroup,
               "editing":index == this.selectedGroup && this.editing,
               "renaming":index == this.renameTarget,
               "buy":false,
               "name":name,
               "specialist":new cSpecialistGroupStarItem(entry,representative,name,count,index),
               "status":index == this.selectedGroup && this.editing ? cLocaManager.GetInstance().GetText(LOCA_GROUP.LABELS,"EditGroup") : cSpecialistPanel.GetTaskText(representative != null ? representative.GetTask() : null),
               "count":String(count) + "/" + String(this.maximumGroupSize())
            });
            index++;
         }
         while(index < this.maximumGroupCount())
         {
            groupItems.addItem({
               "index":index,
               "selected":false,
               "editing":false,
               "renaming":false,
               "buy":true,
               "buyLabel":cLocaManager.GetInstance().GetText(LOCA_GROUP.LABELS,"BuyGroupSlot"),
               "coinLabel":this.pendingBuy == String(index) + ":0" ? cLocaManager.GetInstance().GetText(LOCA_GROUP.ALERT_TITLES,"ConfirmTransaction") : this.groupCostLabel(index,0),
               "coinEnabled":this.canAffordGroupAlternative(index,0),
               "showGems":this.groupAlternativeCount(index) > 1,
               "gemLabel":this.pendingBuy == String(index) + ":1" ? cLocaManager.GetInstance().GetText(LOCA_GROUP.ALERT_TITLES,"ConfirmTransaction") : this.groupCostLabel(index,1),
               "gemEnabled":this.canAffordGroupAlternative(index,1)
            });
            index++;
         }
         for each(specialist in this.visibleExplorers())
         {
            uid = this.uidKey(cSpecialist(specialist).GetUniqueID());
            owner = this.memberOwner(uid);
            explorerItems.addItem({
               "specialist":specialist,
               "uid":uid,
               "groupIndex":this.selectedGroup,
               "editing":this.editing,
               "selected":Boolean(this.selectedMembers[uid]),
               "available":owner < 0 || owner == this.selectedGroup,
               "owner":owner
            });
         }
         this.mPanel.groupsList.dataProvider = groupItems;
         this.mPanel.explorersTile.dataProvider = explorerItems;
         this.mPanel.groupsList.validateNow();
         this.mPanel.explorersTile.validateNow();
         this.mPanel.groupsList.verticalScrollPosition = Math.min(groupsScrollPosition,this.mPanel.groupsList.maxVerticalScrollPosition);
         this.mPanel.explorersTile.verticalScrollPosition = Math.min(explorersScrollPosition,this.mPanel.explorersTile.maxVerticalScrollPosition);
         this.updateModeControls();
      }

      private function maximumGroupCount() : int
      {
         if(global.specialistGroupsConfig != null && global.specialistGroupsConfig.maximumNumberOfSpecialistGroups > 0)
         {
            return global.specialistGroupsConfig.maximumNumberOfSpecialistGroups;
         }
         return 15;
      }

      private function groupRepresentative(entry:dSpecialistGroupEntryVO) : cSpecialist
      {
         var members:Object = this.memberKeys(entry);
         var specialist:cSpecialist;
         var fallback:cSpecialist;
         var slowest:cSpecialist;
         var remainingTime:int;
         var longestRemainingTime:int = -1;
         for each(specialist in this.explorers)
         {
            if(members[this.uidKey(cSpecialist(specialist).GetUniqueID())])
            {
               if(fallback == null)
               {
                  fallback = specialist;
               }
               if(specialist.GetTask() != null)
               {
                  remainingTime = specialist.GetTask().GetRemainingTime();
                  if(slowest == null || remainingTime > longestRemainingTime)
                  {
                     slowest = specialist;
                     longestRemainingTime = remainingTime;
                  }
               }
            }
         }
         return slowest != null ? slowest : fallback;
      }

      private function maximumGroupSize() : int
      {
         var increase:int = this.mGI.mCurrentPlayer != null ? this.mGI.mCurrentPlayer.mSpecialistGroupSizeIncrease : 0;
         if(global.specialistGroupsConfig != null && global.specialistGroupsConfig.maximumNumberOfSpecialistsPerGroup > 0)
         {
            return global.specialistGroupsConfig.maximumNumberOfSpecialistsPerGroup + increase;
         }
         return 20 + increase;
      }

      private function groupAlternativeCount(groupIndex:int) : int
      {
         return global.specialistGroupsConfig != null ? global.specialistGroupsConfig.getAlternativeCount(groupIndex) : 0;
      }

      private function groupCostLabel(groupIndex:int, alternativeIndex:int) : String
      {
         var costs:Vector.<dResource>;
         var cost:dResource;
         var labels:Array = [];
         if(global.specialistGroupsConfig == null)
         {
            return cLocaManager.GetInstance().GetText(LOCA_GROUP.LABELS,"Buy");
         }
         costs = global.specialistGroupsConfig.getCosts(groupIndex,alternativeIndex);
         if(costs.length == 0)
         {
            return cLocaManager.GetInstance().GetText(LOCA_GROUP.LABELS,"Free");
         }
         if(costs.length == 1)
         {
            return String(costs[0].amount);
         }
         for each(cost in costs)
         {
            labels.push(String(cost.amount) + " " + cLocaManager.GetInstance().GetText(LOCA_GROUP.RESOURCES,cost.name_string));
         }
         return labels.join(", ");
      }

      private function canAffordGroupAlternative(groupIndex:int, alternativeIndex:int) : Boolean
      {
         var costs:Vector.<dResource>;
         var resources:Object;
         if(global.specialistGroupsConfig == null)
         {
            return false;
         }
         costs = global.specialistGroupsConfig.getCosts(groupIndex,alternativeIndex);
         if(costs == null || costs.length == 0)
         {
            return true;
         }
         resources = this.mGI.mCurrentPlayerZone.GetResources(this.mGI.mCurrentPlayer);
         return resources != null && resources.HasPlayerResourcesInList(costs,1);
      }

      private function groupRendererAction(param1:TavernGroupRendererEvent):void
      {
         var entry:dSpecialistGroupEntryVO;
         var id:dSpecialistGroupIdVO;
         var name:String;
         var key:String;
         if(param1.action == "select")
         {
            if(this.selectedGroup == param1.index && this.editing)
            {
               this.editing = false;
               this.selectedMembers = {};
               this.refreshGroupsView();
               return;
            }
            this.selectedGroup = param1.index;
            entry = this.selectedEntry();
            this.editing = entry != null && this.isGroupIdle(entry);
            this.selectedMembers = this.editing ? this.cloneKeys(this.memberKeys(entry)) : {};
         }
         else if(param1.action == "openTasks")
         {
            this.selectedGroup = param1.index;
            this.openGroupTasks();
            return;
         }
         else if(param1.action == "rename")
         {
            this.selectedGroup = param1.index;
            this.renameTarget = param1.index;
         }
         else if(param1.action == "renameCancel")
         {
            this.renameTarget = -1;
         }
         else if(param1.action == "renameCommit")
         {
            this.selectedGroup = param1.index;
            entry = this.selectedEntry();
            id = this.groupId(entry);
            name = param1.value.replace(/^\s+|\s+$/g,"");
            if(entry != null && id != null && name.length > 0)
            {
               this.renameTarget = -1;
               entry.SpecialistGroup.Name = name;
               this.mGI.mClientMessages.SendMessagetoServer(COMMAND.SPECIALIST_GROUP,this.mGI.mCurrentPlayer.GetHomeZoneId(),SpecialistGroupCommandFactory.makeRename(id.Type,id.Id,name));
               this.refreshGroupsView();
               return;
            }
         }
         else if(param1.action == "buy")
         {
            key = String(param1.index) + ":" + String(param1.alternative);
            if(param1.index != this.groups.length)
            {
               this.refreshGroupsView();
               return;
            }
            this.pendingBuy = key;
            CustomAlert.show("BuyGroupConfirmation","BuyGroupConfirmation",Alert.OK | Alert.CANCEL,this.mPanel,this.confirmBuyGroup,null,Alert.OK,true,CustomAlert.STYLE_DEFAULT,global.specialistGroupsConfig != null ? global.specialistGroupsConfig.getCosts(param1.index,param1.alternative) : null);
            return;
         }
         this.refreshGroupsView();
      }

      private function openGroupTasks():void
      {
         var entry:dSpecialistGroupEntryVO = this.selectedEntry();
         var representative:cSpecialist = this.groupRepresentative(entry);
         var count:int = this.objectCount(this.memberKeys(entry));
         if(entry == null || representative == null)
         {
            return;
         }
         if(this.isGroupIdle(entry))
         {
            globalFlash.gui.mSpecialistPanel.SetGroupData(representative,entry,count,this.groups.indexOf(entry));
            globalFlash.gui.mSpecialistPanel.ShowSecondaryPanel();
         }
         else
         {
            globalFlash.gui.mSpecialistCooldownPanel.SetGroupData(representative,entry,count,this.groups.indexOf(entry));
            globalFlash.gui.mSpecialistCooldownPanel.ShowSecondaryPanel();
         }
      }

      private function confirmBuyGroup(event:CloseEvent):void
      {
         var values:Array = this.pendingBuy.split(":");
         var groupIndex:int;
         var alternativeIndex:int;
         this.pendingBuy = "";
         if(event.detail != Alert.OK || values.length != 2)
         {
            this.refreshGroupsView();
            return;
         }
         groupIndex = int(values[0]);
         alternativeIndex = int(values[1]);
         if(groupIndex != this.groups.length)
         {
            this.refreshGroupsView();
            return;
         }
         this.mGI.mClientMessages.SendMessagetoServer(COMMAND.SPECIALIST_GROUP,this.mGI.mCurrentPlayer.GetHomeZoneId(),SpecialistGroupCommandFactory.makeBuy(groupIndex,alternativeIndex));
      }

      private function explorerRendererAction(param1:TavernGroupRendererEvent):void
      {
         var specialist:Object;
         if(param1.action == "toggleExplorer")
         {
            if(this.editing && (this.memberOwner(param1.uid) < 0 || this.memberOwner(param1.uid) == this.selectedGroup))
            {
               this.selectedMembers[param1.uid] = !Boolean(this.selectedMembers[param1.uid]);
               this.updateSelectionView(param1.uid);
            }
            return;
         }
         if(param1.action == "openExplorer")
         {
            for each(specialist in this.explorers)
            {
               if(this.uidKey(cSpecialist(specialist).GetUniqueID()) == param1.uid)
               {
                  this.showExplorerOverTavern(specialist);
                  return;
               }
            }
         }
      }

      private function showExplorerOverTavern(specialist:Object):void
      {
         if(specialist == null)
         {
            return;
         }
         if(specialist.GetTask() == null)
         {
            globalFlash.gui.mSpecialistPanel.SetData(specialist);
            globalFlash.gui.mSpecialistPanel.ShowSecondaryPanel();
         }
         else if(specialist.DisplayTaskProgress())
         {
            globalFlash.gui.mSpecialistCooldownPanel.SetData(specialist);
            globalFlash.gui.mSpecialistCooldownPanel.ShowSecondaryPanel();
         }
      }
      private function selectAllExplorers(param1:MouseEvent) : void
      {
         var specialist:Object = null;
         var uid:String = null;
         var owner:int = -1;
         var value:Boolean = Boolean(this.mPanel.selectAllBox.selected);
         if(!this.editing)
         {
            return;
         }
         for each(specialist in this.visibleExplorers())
         {
            uid = this.uidKey(cSpecialist(specialist).GetUniqueID());
            owner = this.memberOwner(uid);
            if(owner < 0 || owner == this.selectedGroup)
            {
               this.selectedMembers[uid] = value;
            }
         }
         this.updateSelectionView();
      }

      private function updateSelectionView(changedUid:String = null) : void
      {
         var explorerItems:ArrayCollection = this.mPanel.explorersTile.dataProvider as ArrayCollection;
         var groupItems:ArrayCollection = this.mPanel.groupsList.dataProvider as ArrayCollection;
         var item:Object;
         var groupItem:Object;
         var count:int = this.objectCount(this.selectedMembers);
         if(explorerItems != null)
         {
            for each(item in explorerItems)
            {
               if(changedUid == null || String(item["uid"]) == changedUid)
               {
                  item["selected"] = Boolean(this.selectedMembers[String(item["uid"])]);
                  explorerItems.itemUpdated(item,"selected");
               }
            }
         }
         if(groupItems != null && this.selectedGroup >= 0 && this.selectedGroup < groupItems.length)
         {
            groupItem = groupItems.getItemAt(this.selectedGroup);
            groupItem["count"] = String(count) + "/" + String(this.maximumGroupSize());
            if(groupItem["specialist"] is cSpecialistGroupStarItem)
            {
               cSpecialistGroupStarItem(groupItem["specialist"]).memberCount = count;
            }
            groupItems.itemUpdated(groupItem,"count");
         }
         this.updateModeControls();
      }

      private function updateModeControls() : void
      {
         var count:int = this.objectCount(this.selectedMembers);
         var eligible:int = 0;
         var selected:int = 0;
         var specialist:Object = null;
         var uid:String = null;
         var owner:int = -1;
         for each(specialist in this.visibleExplorers())
         {
            uid = this.uidKey(cSpecialist(specialist).GetUniqueID());
            owner = this.memberOwner(uid);
            if(owner < 0 || owner == this.selectedGroup)
            {
               eligible++;
               if(this.selectedMembers[uid])
               {
                  selected++;
               }
            }
         }
         this.mPanel.selectAllBox.visible = this.editing;
         this.mPanel.selectAllBox.selected = this.editing && eligible > 0 && selected == eligible;
         this.mPanel.editOk.visible = this.editing;
         this.mPanel.editCancel.visible = this.editing;
         this.mPanel.explorersTile.setStyle("bottom",this.editing ? 38 : 5);
         this.mPanel.editOk.enabled = count <= this.maximumGroupSize();
      }

      private function cancelGroupEdit(param1:MouseEvent = null) : void
      {
         this.editing = false;
         this.selectedMembers = {};
         this.refreshGroupsView();
      }

      private function saveGroupMembers(param1:MouseEvent = null) : void
      {
         var entry:dSpecialistGroupEntryVO = this.selectedEntry();
         var id:dSpecialistGroupIdVO = this.groupId(entry);
         var old:Object = this.memberKeys(entry);
         var added:Array = [];
         var removed:Array = [];
         var specialist:cSpecialist;
         var uid:dUniqueID;
         var key:String = null;
         var command:Object = null;
         var updatedReferences:Array = [];
         var reference:dSpecialistReferenceVO;
         if(entry == null || id == null || !this.isGroupIdle(entry) || this.objectCount(this.selectedMembers) > this.maximumGroupSize())
         {
            return;
         }
         for each(specialist in this.explorers)
         {
            uid = cSpecialist(specialist).GetUniqueID();
            key = this.uidKey(uid);
            if(this.selectedMembers[key] && !old[key])
            {
               added.push(uid);
            }
            else if(!this.selectedMembers[key] && old[key])
            {
               removed.push(uid);
            }
         }
         if(added.length > 0 || removed.length > 0)
         {
            command = SpecialistGroupCommandFactory.makeMove(id.Type,id.Id,added,removed);
            for each(specialist in this.explorers)
            {
               uid = specialist.GetUniqueID();
               if(this.selectedMembers[this.uidKey(uid)])
               {
                  reference = new dSpecialistReferenceVO();
                  reference.PlayerID = this.mGI.mCurrentPlayer.GetPlayerId();
                  reference.UniqueID = uid;
                  updatedReferences.push(reference);
               }
            }
            entry.SpecialistReferences = entry.SpecialistReferences is ArrayCollection ? new ArrayCollection(updatedReferences) : updatedReferences;
            this.editing = false;
            this.mGI.mClientMessages.SendMessagetoServer(COMMAND.SPECIALIST_GROUP,this.mGI.mCurrentPlayer.GetHomeZoneId(),command);
            this.refreshGroupsView();
            return;
         }
         this.editing = false;
         this.refreshGroupsView();
      }

      private function ClosePanel(param1:Event) : void
      {
         this.Hide();
      }

      public function Refresh() : void
      {
         if(this.mBuilding)
         {
            this.SetData(this.mBuilding);
         }
      }
   }
}

