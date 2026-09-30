package GuiWrapper
{
    import flash.events.IEventDispatcher;
    import GUI.GAME.cHintPointer;
    import GUI.GAME.cApplyBuffResourcePanel;
    import nLib.MapTextRenderer;
    import GUI.GAME.cTrackedMissionList;
    import GUI.GAME.cGameActionBar;
    import GUI.GAME.cTimedProductionInfoPanel;
    import GUI.GAME.cCombat30ToolTip;
    import GUI.GAME.cSkillTreeWindow;
    import GUI.GAME.cAvatar;
    import GUI.GAME.cSupportLockZone;
    import GUI.GAME.cGenericLinkBuildingInfoPanel;
    import GUI.GAME.cCombatScenarioTooltip;
    import GUI.GAME.cSkillProductionPanel;
    import GUI.GAME.cEventInfoPanel;
    import GUI.GAME.cGuildBankTransactionHistory;
    import GUI.GAME.cStarMenu;
    import GUI.GAME.cPvPReportWindow;
    import GUI.GAME.cLoadingZonePanel;
    import GUI.GAME.cTradingPanel;
    import GUI.GAME.cMoveBuildingPanel;
    import GUI.GAME.cGuildPayResourcePanel;
    import GUI.GAME.cAdventWindow;
    import GUI.GAME.cPremiumAccountActivationWindow;
    import GUI.GAME.cSpecialistCooldownPanel;
    import GUI.GAME.cEventPanel;
    import GUI.GAME.cAddFriendsPanel;
    import GUI.GAME.cWelcomeWindow;
    import GUI.GAME.cGuildTransferResourcePanel;
    import GUI.GAME.cColonyWindow;
    import GUI.GAME.cAdventurePanel;
    import GUI.GAME.cLevelUpWindow;
    import GUI.GAME.achievement.AchievementPanel;
    import GUI.GAME.cSpecialistTravelPanel;
    import GUI.GAME.cCultureBuildingPanel;
    import GUI.GAME.cBuildingInfoPanel;
    import flash.events.EventDispatcher;
    import GUI.GAME.cContentGeneratorRewardPanel;
    import GUI.GAME.cPacketLossAlert;
    import GUI.GAME.cFoundGuildPanel;
    import GUI.GAME.cSplashScreen;
    import GUI.cGuiBaseElement;
    import GUI.GAME.cShopWindow;
    import GUI.GAME.cMailWindow;
    import GUI.GAME.cPlayerOptionsPanel;
    import GUI.GAME.cResidenceInfoPanel;
    import GUI.GAME.cBlockList;
    import GUI.GAME.cHelpWindow;
    import GUI.GAME.cPvPLevelRewardsPanel;
    import GUI.GAME.cHiredTroopsPoolPanel;
    import GUI.GAME.cEventMonster;
    import GUI.GAME.cHelpOverview;
    import GUI.GAME.cNewsWindow;
    import GUI.GAME.cGuildBankEnlargePanel;
    import GUI.GAME.cCancelActionPanel;
    import GUI.GAME.cDailyLoginPanel;
    import GUI.GAME.MountainInfoPanel;
    import com.bluebyte.tso.quests.view.controller.cQuestBook;
    import GUI.GAME.cEventWidgetList;
    import GUI.GAME.cMayorhouseInfoPanel;
    import GUI.GAME.cOptionsPanel;
    import GUI.GAME.cGuildWindow;
    import GUI.GAME.cSpecialistPanel;
    import GUI.GAME.cMysteryBoxPanel;
    import GUI.GAME.cFriendsList;
    import GUI.GAME.cTradeOfficePanel;
    import GUI.GAME.cAvatarMessageList;
    import GUI.GAME.cLoadingMailPanel;
    import GUI.GAME.cTaskBuildingPanel;
    import GUI.GAME.cSingleInfoBar;
    import GUI.GAME.cDefenseBuildingPanel;
    import GUI.GAME.cInfoBar;
    import GUI.GAME.cContentGeneratorPanel;
    import GUI.GAME.cDeleteBuffResourcePanel;
    import GUI.GAME.cDecorationInfoPanel;
    import GUI.GAME.cCombatPreviewPanel;
    import GUI.GAME.cEpicWorkyardInfoPanel;
    import GUI.GAME.cPvPProgressionPanel;
    import GUI.GAME.cTavernInfoPanel;
    import GUI.GAME.cBuildQueue;
    import GUI.GAME.cGuildBankWindow;
    import GUI.GAME.cToolboxPanel;
    import GUI.GAME.Chat.TSOChatMediator;
    import GUI.GAME.cFriendsListMenu;
    import GUI.GAME.WindowController;
    import GUI.GAME.avatarSelection.AvatarSelectionPanel;
    import GUI.GAME.cEconomyOverview;
    import GUI.GAME.cConstructionInfoPanel;
    import GUI.GAME.cCameraControlPanel;
    import GUI.GAME.cMemoryMonitorPanel;
    import Interface.cGeneralInterface;
    import GUI.GAME.cZoneBuffPanel;
    import GUI.GAME.cWarehouseInfoPanel;
    import GUI.GAME.cEnemyBuildingInfoPanel;
    import GUI.GAME.cGuildBankBuyTabPanel;
    import GUI.GAME.cTradeWindow;
    import GUI.GAME.cBattleWindow;
    import GUI.GAME.cMinimalInfoPanel;
    import GUI.GAME.cPvPColoniesWindow;
    import GUI.GAME.cWatchTowerInfoPanel;
    import GUI.GAME.cDarkenPanel;
    import flash.utils.Dictionary;
    import __AS3__.vec.Vector;
    import Interface.cGameInterface;
    import mx.core.Application;
    import flash.events.Event;
    import Communication.VO.dContextItemVO;
    import flash.events.MouseEvent;
    import Communication.VO.dPlayerListItemVO;
    import Communication.VO.dQuestElementVO;
    import nLib.gMisc;
    import Utils.StringUtils;
    import GO.cBuilding;
    import ServerState.dResourceDefaultDefinition;
    import flash.display.BitmapData;
    import GUI.GAME.cBasicPanel;
    import com.bluebyte.tso.adventure.logic.AdventureManager;
    import mx.events.PropertyChangeEvent;
    import GUI.ApplicationFacade;
    import Achievements.AchievementConsts;
    import GUI.GAME.cBasicInfoPanel;
    import flash.utils.setTimeout;
    import Enums.COMMAND;
    import nLib.cPosInt;
    import nLib.cBackbuffer;
    import Specialists.cSpecialist;
    import __AS3__.vec.*;
	import com.bluebyte.tso.util.ClientLogger;

    public class cGuiWrapper implements IEventDispatcher 
    {

        public var mQuestHintPointer:cHintPointer;
        private var _mApplyBuffResourcePanel:cApplyBuffResourcePanel;
        private var mRenderTextDebug:MapTextRenderer;
        public var mTrackedMissionList:cTrackedMissionList;
        public var mActionBar:cGameActionBar;
        private var _mTimedProductionInfoPanel:cTimedProductionInfoPanel;
        public var mCombat30ToolTip:cCombat30ToolTip;
        private var _mSkillTreeWindow:cSkillTreeWindow;
        public var mAvatar:cAvatar;
        public var mSupportLockZone:cSupportLockZone;
        public var mGenericLinkBuildingInfoPanel:cGenericLinkBuildingInfoPanel;
        public var mCombatScenarioToolTip:cCombatScenarioTooltip;
        private var _mSkillProductionPanel:cSkillProductionPanel;
        private var _mEventInfoPanel:cEventInfoPanel;
        private var _mGuildBankTransactionHistory:cGuildBankTransactionHistory;
        public var mStarMenu:cStarMenu;
        private var _mPvpReportWindow:cPvPReportWindow;
        public var mLoadingZonePanel:cLoadingZonePanel;
        public var mTradingPanel:cTradingPanel;
        private var _mMoveBuildingPanel:cMoveBuildingPanel;
        private var _mGuildPayResourcePanel:cGuildPayResourcePanel;
        private var _mAdventWindow:cAdventWindow;
        private var _mPremiumAccountActivationWindow:cPremiumAccountActivationWindow;
        public var mSpecialistCooldownPanel:cSpecialistCooldownPanel;
        private var _mEventWindow:cEventPanel;
        private var _mAddFriendsPanel:cAddFriendsPanel;
        private var _mWelcomeWindow:cWelcomeWindow;
        private var _mGuildTransferResourcePanel:cGuildTransferResourcePanel;
        private var _mColonyWindow:cColonyWindow;
        private var _mAdventurePanel:cAdventurePanel;
        private var _mLevelUpWindow:cLevelUpWindow;
        private var _mAchievementPanel:AchievementPanel;
        private var _mSpecialistTravelPanel:cSpecialistTravelPanel;
        private var _mCultureBuildingPanel:cCultureBuildingPanel;
        private var _mBuildingInfoPanel:cBuildingInfoPanel;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _mContentGeneratorRewardPanel:cContentGeneratorRewardPanel;
        private var _mBarracksInfoPanel:cTimedProductionInfoPanel;
        public var mPacketLostAlert:cPacketLossAlert;
        private var _mFoundGuildPanel:cFoundGuildPanel;
        public var mSplashScreen:cSplashScreen;
        private var mDelayedPanel:cGuiBaseElement;
        private var _mShopWindow:cShopWindow;
        public var mMailWindow:cMailWindow;
        private var _mPlayerOptionsPanel:cPlayerOptionsPanel;
        public var mResidenceInfoPanel:cResidenceInfoPanel;
        private var _mBlockList:cBlockList;
        private var _mHelpWindow:cHelpWindow;
        private var _mPvPLeveLRewardsPanel:cPvPLevelRewardsPanel;
        private var _mHiredTroopsPoolPanel:cHiredTroopsPoolPanel;
        private var _mExpeditionWeaponSmithInfoPanel:cTimedProductionInfoPanel;
        public var mEventMonster:cEventMonster;
        private var _mHelpOverview:cHelpOverview;
        public var mNewsWindow:cNewsWindow;
        private var _mGuildBankEnlargePanel:cGuildBankEnlargePanel;
        private var _1434131879mCancelActionPanel:cCancelActionPanel;
        private var _mDailyLoginPanel:cDailyLoginPanel;
        public var mMountainInfoPanel:MountainInfoPanel;
        private var _mQuestBook:cQuestBook;
        public var mEventWidgetList:cEventWidgetList;
        private var _mMayorhouseInfoPanel:cMayorhouseInfoPanel;
        public var mOptionsPanel:cOptionsPanel;
        private var _mGuildWindow:cGuildWindow;
        private var mRenderTextBigFont:MapTextRenderer;
        private var _mSpecialistPanel:cSpecialistPanel;
        private var _mMysteryBoxPanel:cMysteryBoxPanel;
        public var mFriendsList:cFriendsList;
        public var mTradeOfficePanel:cTradeOfficePanel;
        public var mPvPLevelUpHintPointer:cHintPointer;
        public var mAvatarMessageList:cAvatarMessageList;
        public var mLoadingMailPanel:cLoadingMailPanel;
        private var _mTaskBuildingPanel:cTaskBuildingPanel;
        private var mDefaultGuiElementsLoaded:Boolean;
        public var mExpeditionInfoBar:cSingleInfoBar;
        private var _mDefenseBuildingPanel:cDefenseBuildingPanel;
        public var mInfoBar:cInfoBar;
        private var _mBarracks3InfoPanel:cTimedProductionInfoPanel;
        private var _mContentGeneratorPanel:cContentGeneratorPanel;
        private var _mDeleteBuffResourcePanel:cDeleteBuffResourcePanel;
        public var mDecorationInfoPanel:cDecorationInfoPanel;
        private var _mCombatPreviewPanel:cCombatPreviewPanel;
        private var _mEpicWorkyardInfoPanel:cEpicWorkyardInfoPanel;
        public var mPvPProgressionPanel:cPvPProgressionPanel;
        public var mTavernInfoPanel:cTavernInfoPanel;
        public var mBuildQueue:cBuildQueue;
        private var _274569870mGuildBankWindow:cGuildBankWindow;
        public var mToolboxPanel:cToolboxPanel;
        public var mChatPanel:TSOChatMediator;
        public var mFriendsListMenu:cFriendsListMenu;
        public var windowController:WindowController;
        public var mAvatarSelectionPanel:AvatarSelectionPanel;
        private var _mEconomyOverview:cEconomyOverview;
        public var mConstructionInfoPanel:cConstructionInfoPanel;
        public var mCameraControlPanel:cCameraControlPanel;
        private var _mMemoryMonitorPanel:cMemoryMonitorPanel;
        private var mGeneralInterface:cGeneralInterface;
        private var _mZoneBuffPanel:cZoneBuffPanel;
        private var _mWarehouseInfoPanel:cWarehouseInfoPanel;
        public var mEnemyBuildingInfoPanel:cEnemyBuildingInfoPanel;
        private var _mGuildBankBuyTabPanel:cGuildBankBuyTabPanel;
        private var _mTradeWindow:cTradeWindow;
        private var _mBattleWindow:cBattleWindow;
        public var mMinimalInfoPanel:cMinimalInfoPanel;
        private var _mPvPColoniesWindow:cPvPColoniesWindow;
        public var mCalendarHintPointer:cHintPointer;
        public var mWatchTowerInfoPanel:cWatchTowerInfoPanel;
        public var mDarkenPanel:cDarkenPanel;

        public var map_BuildingName_InfoPanel:Dictionary = new Dictionary();
        public var map_BuildingName_UIContent:Dictionary = new Dictionary();
        private var mWindowQueue:Vector.<cGuiBaseElement> = new Vector.<cGuiBaseElement>();
        private var mPendingQuestNotification:dQuestElementVO;

        public function cGuiWrapper()
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
        }

        public function InitGuiElements(_arg_1:cGeneralInterface):void
        {
            var _local_2:SWMMO = global.getApplication();
            this.windowController = new WindowController(_local_2.GAMESTATE_ID_DARKEN_PANEL);
            this.mGeneralInterface = _arg_1;
            cGuiBaseElement.InitStatic();
            this.mActionBar = new cGameActionBar();
            this.mActionBar.Init(_local_2.GAMESTATE_ID_ACTIONBAR);
            this.mToolboxPanel = new cToolboxPanel();
            this.mToolboxPanel.Init(_local_2.GAMESTATE_ID_TOOLBOX_PANEL);
            this.mInfoBar = new cInfoBar();
            this.mInfoBar.Init(_local_2.GAMESTATE_ID_INFO_BAR);
            this.mExpeditionInfoBar = new cSingleInfoBar();
            this.mExpeditionInfoBar.Init(_local_2.GAMESTATE_ID_EXPEDITION_INFO_BAR);
            this.mWatchTowerInfoPanel = new cWatchTowerInfoPanel();
            this.mWatchTowerInfoPanel.Init(_local_2.GAMESTATE_ID_WATCHTOWER_INFO_PANEL);
            this.mTavernInfoPanel = new cTavernInfoPanel();
            this.mTavernInfoPanel.Init(_local_2.GAMESTATE_ID_TAVERN_INFO_PANEL);
            this.mResidenceInfoPanel = new cResidenceInfoPanel();
            this.mResidenceInfoPanel.Init(_local_2.GAMESTATE_ID_RESIDENCE_INFO_PANEL);
            this.mConstructionInfoPanel = new cConstructionInfoPanel();
            this.mConstructionInfoPanel.Init(_local_2.GAMESTATE_ID_CONSTRUCTION_INFO_PANEL);
            this.mDecorationInfoPanel = new cDecorationInfoPanel();
            this.mDecorationInfoPanel.Init(_local_2.GAMESTATE_ID_DECORATION_INFO_PANEL);
            this.mMinimalInfoPanel = new cMinimalInfoPanel();
            this.mMinimalInfoPanel.Init(_local_2.GAMESTATE_ID_MINIMAL_INFO_PANEL);
            this.mTradeOfficePanel = new cTradeOfficePanel();
            this.mTradeOfficePanel.Init(_local_2.GAMESTATE_ID_TRADE_OFFICE_PANEL);
            this.mSpecialistCooldownPanel = new cSpecialistCooldownPanel();
            this.mSpecialistCooldownPanel.Init(_local_2.SPECIALIST_COOLDOWN_PANEL);
            this.mEnemyBuildingInfoPanel = new cEnemyBuildingInfoPanel();
            this.mEnemyBuildingInfoPanel.Init(_local_2.GAMESTATE_ID_ENEMY_BUILDING_INFO_PANEL);
            this.mLoadingZonePanel = new cLoadingZonePanel();
            this.mLoadingZonePanel.Init(_local_2.GAMESTATE_ID_LOADING_ZONE_PANEL);
            this.mBuildQueue = new cBuildQueue();
            this.mBuildQueue.Init(_local_2.GAMESTATE_ID_BUILD_QUEUE);
            this.mOptionsPanel = new cOptionsPanel();
            this.mOptionsPanel.Init(_local_2.GAMESTATE_ID_AVATAR.options);
            this.mCameraControlPanel = new cCameraControlPanel();
            this.mCameraControlPanel.Init(_local_2.GAMESTATE_ID_CAMERA_CONTROL_PANEL);
            this.mAvatar = new cAvatar();
            this.mAvatar.Init(_local_2.GAMESTATE_ID_AVATAR);
            this.mFriendsListMenu = new cFriendsListMenu();
            this.mFriendsListMenu.Init(_local_2.GAMESTATE_ID_FRIENDS_LIST_MENU);
            this.mFriendsList = new cFriendsList();
            this.mFriendsList.Init(_local_2.GAMESTATE_ID_FRIENDS_LIST);
            this.mTradingPanel = new cTradingPanel();
            this.mStarMenu = new cStarMenu();
            this.mStarMenu.Init(_local_2.GAMESTATE_ID_STAR_MENU);
            this.mCancelActionPanel = new cCancelActionPanel();
            this.mCancelActionPanel.Init(_local_2.GAMESTATE_ID_CANCEL_ACTION_PANEL);
            this.mAvatarMessageList = new cAvatarMessageList();
            this.mAvatarMessageList.Init(_local_2.GAMESTATE_ID_AVATAR_MESSAGE_LIST);
            this.mTrackedMissionList = new cTrackedMissionList();
            this.mTrackedMissionList.Init(_local_2.GAMESTATE_ID_TRACKED_MISSION_LIST);
            this.mEventWidgetList = new cEventWidgetList();
            this.mEventWidgetList.Init(_local_2.GAMESTATE_ID_EVENT_WIDGET_LIST);
            this.mLoadingMailPanel = new cLoadingMailPanel();
            this.mLoadingMailPanel.init(_local_2.GAMESTATE_ID_LOADING_MAIL_PANEL);
            this.mMailWindow = new cMailWindow();
            this._mHelpWindow = new cHelpWindow();
            this._mHelpWindow.Init(_local_2.GAMESTATE_ID_HELP_WINDOW);
            this.mQuestHintPointer = new cHintPointer();
            this.mQuestHintPointer.Init(_local_2.GAMESTATE_ID_QUEST_HINT_POINTER);
            this.mPvPLevelUpHintPointer = new cHintPointer();
            this.mPvPLevelUpHintPointer.Init(_local_2.GAMESTATE_ID_PVP_LEVEL_UP_HINT_POINTER);
            this.mCalendarHintPointer = new cHintPointer();
            this.mCalendarHintPointer.Init(_local_2.GAMESTATE_ID_CALENDAR_HINT_POINTER);
            this.mDarkenPanel = new cDarkenPanel();
            this.mDarkenPanel.Init(_local_2.GAMESTATE_ID_DARKEN_PANEL);
            this.mNewsWindow = new cNewsWindow();
            this.mNewsWindow.Init(_local_2.GAMESTATE_ID_NEWS_WINDOW);
            this.mEventMonster = new cEventMonster();
            this.mEventMonster.Init(_local_2.GAMESTATE_ID_EVENT_MONSTER);
            this.mAvatarSelectionPanel = new AvatarSelectionPanel();
            this.mAvatarSelectionPanel.init(_arg_1, Application.application.GAMESTATE_ID_AVATAR_SELECTION);
            this.mPacketLostAlert = new cPacketLossAlert();
            this.mPacketLostAlert.Init(Application.application.GAMESTATE_ID_PACKET_LOST_ALERT);
            this.mMountainInfoPanel = new MountainInfoPanel();
            this.mMountainInfoPanel.Init(_local_2.GAMESTATE_ID_MOUNTAIN_INFO_PANEL);
            this.mCombat30ToolTip = new cCombat30ToolTip();
            this.mCombat30ToolTip.Init(_local_2.GAMESTATE_ID_COMBAT30_TOOLTIP);
            this.mCombatScenarioToolTip = new cCombatScenarioTooltip();
            this.mCombatScenarioToolTip.Init(_local_2.GAMESTATE_ID_COMBAT_SCENARIO_TOOLTIP);
            this.mSplashScreen = new cSplashScreen();
            this.mSplashScreen.Init(_local_2.GAMESTATE_ID_SPLASH_SCREEN);
            this.mGenericLinkBuildingInfoPanel = new cGenericLinkBuildingInfoPanel();
            this.mGenericLinkBuildingInfoPanel.Init(_local_2.GAMESTATE_ID_GENERIC_LINK_BUILDING_INFO_PANEL);
            this.mSupportLockZone = new cSupportLockZone();
            this.mSupportLockZone.Init(_local_2.GAMESTATE_ID_SUPPORT_LOCK_ZONE_CLOCK);
            this.mPvPProgressionPanel = new cPvPProgressionPanel();
            this.mSupportLockZone = new cSupportLockZone();
            this.mSupportLockZone.Init(_local_2.GAMESTATE_ID_SUPPORT_LOCK_ZONE_CLOCK);
            _local_2.nLibFlexBridgeManager.init();
            this.AssignInfoPannels();
        }

        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (this._bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            this._bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

public function ShowDefaultGuiElements():void
{
if (this.mChatPanel != null)
            {
                this.mChatPanel.Show();
            };
            this.mActionBar.Show();
            this.mInfoBar.Show();
            this.mAvatar.Show();
            this.mFriendsList.Show();
this.mOptionsPanel.Show();
this.mDefaultGuiElementsLoaded = true;
}

        public function ShowContextMenu(_arg_1:Vector.<dContextItemVO>, _arg_2:int, _arg_3:int):void
        {
            if (_arg_1.length == 0)
            {
                return;
            };
            this.mFriendsListMenu.SetContextMenu(_arg_1);
            this.mFriendsListMenu.Show();
        }

        public function ShowFriendListMenu(_arg_1:MouseEvent, _arg_2:dPlayerListItemVO):void
        {
            this.mFriendsListMenu.SetData(_arg_2);
            _arg_1.stopPropagation();
            this.mFriendsListMenu.Show();
        }

        public function get mShopWindow():cShopWindow
        {
            if (this._mShopWindow == null)
            {
                this._mShopWindow = new cShopWindow();
                this._mShopWindow.Init(global.getApplication().ensureShopWindow());
            }
            return (this._mShopWindow);
        }

        public function get mTradeWindow():cTradeWindow
        {
            if (this._mTradeWindow == null)
            {
                this._mTradeWindow = new cTradeWindow();
                this.initializeLazyController(this._mTradeWindow, global.getApplication().ensureTradeWindow());
            }
            return (this._mTradeWindow);
        }

        public function get mBlockList():cBlockList
        {
            if (this._mBlockList == null)
            {
                this._mBlockList = new cBlockList();
                this._mBlockList.Init(global.getApplication().ensureBlockList());
            }
            return (this._mBlockList);
        }

        public function get mGuildPayResourcePanel():cGuildPayResourcePanel
        {
            if (this._mGuildPayResourcePanel == null)
            {
                this._mGuildPayResourcePanel = new cGuildPayResourcePanel();
                this._mGuildPayResourcePanel.Init(global.getApplication().ensureGuildPayResourcePanel());
            }
            return (this._mGuildPayResourcePanel);
        }

        public function get mGuildTransferResourcePanel():cGuildTransferResourcePanel
        {
            if (this._mGuildTransferResourcePanel == null)
            {
                this._mGuildTransferResourcePanel = new cGuildTransferResourcePanel();
                this.initializeLazyController(this._mGuildTransferResourcePanel, global.getApplication().ensureGuildTransferResourcePanel());
            }
            return (this._mGuildTransferResourcePanel);
        }

        public function get mGuildBankBuyTabPanel():cGuildBankBuyTabPanel
        {
            if (this._mGuildBankBuyTabPanel == null)
            {
                this._mGuildBankBuyTabPanel = new cGuildBankBuyTabPanel();
                this.initializeLazyController(this._mGuildBankBuyTabPanel, global.getApplication().ensureGuildBankBuyTabPanel());
            }
            return (this._mGuildBankBuyTabPanel);
        }

        public function get mGuildBankEnlargePanel():cGuildBankEnlargePanel
        {
            if (this._mGuildBankEnlargePanel == null)
            {
                this._mGuildBankEnlargePanel = new cGuildBankEnlargePanel();
                this.initializeLazyController(this._mGuildBankEnlargePanel, global.getApplication().ensureGuildBankEnlargePanel());
            }
            return (this._mGuildBankEnlargePanel);
        }

        public function get mGuildBankTransactionHistory():cGuildBankTransactionHistory
        {
            if (this._mGuildBankTransactionHistory == null)
            {
                this._mGuildBankTransactionHistory = new cGuildBankTransactionHistory();
                this.initializeLazyController(this._mGuildBankTransactionHistory, global.getApplication().ensureGuildBankTransactionHistory());
            }
            return (this._mGuildBankTransactionHistory);
        }

        public function get mPlayerOptionsPanel():cPlayerOptionsPanel
        {
            if (this._mPlayerOptionsPanel == null)
            {
                this._mPlayerOptionsPanel = new cPlayerOptionsPanel();
                var panel:* = global.getApplication().ensurePlayerOptionsPanel();
                this._mPlayerOptionsPanel.Init(panel);
                global.getApplication().mountLazyWindow(panel);
            }
            return (this._mPlayerOptionsPanel);
        }

        public function get mZoneBuffPanel():cZoneBuffPanel
        {
            if (this._mZoneBuffPanel == null)
            {
                this._mZoneBuffPanel = new cZoneBuffPanel();
                this._mZoneBuffPanel.Init(global.getApplication().ensureZoneBuffPanel());
            }
            return (this._mZoneBuffPanel);
        }

        public function get mAddFriendsPanel():cAddFriendsPanel
        {
            if (this._mAddFriendsPanel == null)
            {
                this._mAddFriendsPanel = new cAddFriendsPanel();
                var panel:* = global.getApplication().ensureAddFriendsPanel();
                this._mAddFriendsPanel.Init(panel);
                global.getApplication().mountLazyWindow(panel);
            }
            return (this._mAddFriendsPanel);
        }

        public function get mFoundGuildPanel():cFoundGuildPanel
        {
            if (this._mFoundGuildPanel == null)
            {
                this._mFoundGuildPanel = new cFoundGuildPanel();
                this.initializeLazyController(this._mFoundGuildPanel, global.getApplication().ensureFoundGuildPanel());
            }
            return (this._mFoundGuildPanel);
        }

        public function get mPremiumAccountActivationWindow():cPremiumAccountActivationWindow
        {
            if (this._mPremiumAccountActivationWindow == null)
            {
                this._mPremiumAccountActivationWindow = new cPremiumAccountActivationWindow();
                this.initializeLazyController(this._mPremiumAccountActivationWindow, global.getApplication().ensurePremiumAccountActivationWindow());
            }
            return (this._mPremiumAccountActivationWindow);
        }

        public function get mTaskBuildingPanel():cTaskBuildingPanel
        {
            if (this._mTaskBuildingPanel == null)
            {
                this._mTaskBuildingPanel = new cTaskBuildingPanel();
                this.initializeLazyController(this._mTaskBuildingPanel, global.getApplication().ensureTaskBuildingPanel());
            }
            return (this._mTaskBuildingPanel);
        }

        public function get mApplyBuffResourcePanel():cApplyBuffResourcePanel
        {
            if (this._mApplyBuffResourcePanel == null)
            {
                this._mApplyBuffResourcePanel = new cApplyBuffResourcePanel();
                this.initializeLazyController(this._mApplyBuffResourcePanel, global.getApplication().ensureApplyBuffResourcePanel());
            }
            return (this._mApplyBuffResourcePanel);
        }

        public function get mDeleteBuffResourcePanel():cDeleteBuffResourcePanel
        {
            if (this._mDeleteBuffResourcePanel == null)
            {
                this._mDeleteBuffResourcePanel = new cDeleteBuffResourcePanel();
                this.initializeLazyController(this._mDeleteBuffResourcePanel, global.getApplication().ensureDeleteBuffResourcePanel());
            }
            return (this._mDeleteBuffResourcePanel);
        }

        public function get mEventInfoPanel():cEventInfoPanel
        {
            if (this._mEventInfoPanel == null)
            {
                this._mEventInfoPanel = new cEventInfoPanel();
                this._mEventInfoPanel.Init(global.getApplication().ensureEventInfoPanel());
            }
            return (this._mEventInfoPanel);
        }

        public function get mCultureBuildingPanel():cCultureBuildingPanel
        {
            if (this._mCultureBuildingPanel == null)
            {
                this._mCultureBuildingPanel = new cCultureBuildingPanel();
                this.initializeLazyController(this._mCultureBuildingPanel, global.getApplication().ensureCultureBuildingPanel());
            }
            return (this._mCultureBuildingPanel);
        }

        public function get mMoveBuildingPanel():cMoveBuildingPanel
        {
            if (this._mMoveBuildingPanel == null)
            {
                this._mMoveBuildingPanel = new cMoveBuildingPanel();
                var panel:* = global.getApplication().ensureMoveBuildingPanel();
                this._mMoveBuildingPanel.Init(panel);
                global.getApplication().mountLazyWindow(panel);
            }
            return (this._mMoveBuildingPanel);
        }

        public function get mMysteryBoxPanel():cMysteryBoxPanel
        {
            if (this._mMysteryBoxPanel == null)
            {
                this._mMysteryBoxPanel = new cMysteryBoxPanel();
                var panel:* = global.getApplication().ensureMysteryBoxPanel();
                this._mMysteryBoxPanel.Init(panel);
                global.getApplication().mountLazyWindow(panel);
            }
            return (this._mMysteryBoxPanel);
        }

        public function get mCombatPreviewPanel():cCombatPreviewPanel
        {
            if (this._mCombatPreviewPanel == null)
            {
                this._mCombatPreviewPanel = new cCombatPreviewPanel();
                var panel:* = global.getApplication().ensureCombatPreviewPanel();
                this._mCombatPreviewPanel.Init(panel);
                global.getApplication().mountLazyWindow(panel);
            }
            return (this._mCombatPreviewPanel);
        }

        public function get mColonyWindow():cColonyWindow
        {
            if (this._mColonyWindow == null)
            {
                this._mColonyWindow = new cColonyWindow();
                var panel:* = global.getApplication().ensureColonyWindow();
                global.getApplication().mountLazyWindow(panel);
                this._mColonyWindow.Init(panel);
            }
            return (this._mColonyWindow);
        }

        public function get mSpecialistTravelPanel():cSpecialistTravelPanel
        {
            if (this._mSpecialistTravelPanel == null)
            {
                this._mSpecialistTravelPanel = new cSpecialistTravelPanel();
                var panel:* = global.getApplication().ensureSpecialistTravelPanel();
                this._mSpecialistTravelPanel.Init(panel);
                global.getApplication().mountLazyWindow(panel);
            }
            return (this._mSpecialistTravelPanel);
        }

        public function get mQuestBook():cQuestBook
        {
            if (this._mQuestBook == null)
            {
                this._mQuestBook = new cQuestBook();
                var panel:* = global.getApplication().ensureQuestBook();
                this._mQuestBook.Init(panel);
                global.getApplication().mountLazyWindow(panel);
                this._mQuestBook.SetQuestData(global.ui.mQuestClientCallbacks.GetClientQuestPool());
                this._mQuestBook.SetNotificationQuest(this.mPendingQuestNotification);
            }
            return (this._mQuestBook);
        }

        public function SetQuestBookNotification(_arg_1:dQuestElementVO):void
        {
            this.mPendingQuestNotification = _arg_1;
            if (this._mQuestBook != null)
                this._mQuestBook.SetNotificationQuest(_arg_1);
        }

        public function get mHelpOverview():cHelpOverview
        {
            if (this._mHelpOverview == null)
            {
                this._mHelpOverview = new cHelpOverview();
                var panel:* = global.getApplication().ensureHelpOverview();
                this._mHelpOverview.Init(panel);
                global.getApplication().mountLazyWindow(panel);
            }
            return (this._mHelpOverview);
        }

        public function get mAdventurePanel():cAdventurePanel
        {
            if (this._mAdventurePanel == null)
            {
                this._mAdventurePanel = new cAdventurePanel();
                var panel:* = global.getApplication().ensureAdventurePanel();
                this._mAdventurePanel.Init(panel);
                global.getApplication().mountLazyWindow(panel);
            }
            return (this._mAdventurePanel);
        }

        public function get mAdventWindow():cAdventWindow
        {
            if (this._mAdventWindow == null)
            {
                this._mAdventWindow = new cAdventWindow();
                var panel:* = global.getApplication().ensureAdventWindow();
                global.getApplication().mountLazyWindow(panel);
                this._mAdventWindow.init(panel);
            }
            return (this._mAdventWindow);
        }

        public function get mPvPLeveLRewardsPanel():cPvPLevelRewardsPanel
        {
            if (this._mPvPLeveLRewardsPanel == null)
            {
                this._mPvPLeveLRewardsPanel = new cPvPLevelRewardsPanel();
                var panel:* = global.getApplication().ensurePvPLevelRewardsPanel();
                this._mPvPLeveLRewardsPanel.Init(panel);
                global.getApplication().mountLazyWindow(panel);
            }
            return (this._mPvPLeveLRewardsPanel);
        }

        private function initializeLazyController(_arg_1:Object, _arg_2:*, _arg_3:String="Init"):void
        {
            _arg_1[_arg_3](_arg_2);
            global.getApplication().mountLazyWindow(_arg_2);
        }

        public function get mHiredTroopsPoolPanel():cHiredTroopsPoolPanel
        {
            if (this._mHiredTroopsPoolPanel == null)
            {
                this._mHiredTroopsPoolPanel = new cHiredTroopsPoolPanel();
                this.initializeLazyController(this._mHiredTroopsPoolPanel, global.getApplication().ensureHiredTroopsPoolPanel());
            }
            return (this._mHiredTroopsPoolPanel);
        }

        public function get mBuildingInfoPanel():cBuildingInfoPanel
        {
            if (this._mBuildingInfoPanel == null)
            {
                this._mBuildingInfoPanel = new cBuildingInfoPanel();
                this.initializeLazyController(this._mBuildingInfoPanel, global.getApplication().ensureBuildingInfoPanel());
            }
            return (this._mBuildingInfoPanel);
        }

        public function get mEpicWorkyardInfoPanel():cEpicWorkyardInfoPanel
        {
            if (this._mEpicWorkyardInfoPanel == null)
            {
                this._mEpicWorkyardInfoPanel = new cEpicWorkyardInfoPanel();
                this.initializeLazyController(this._mEpicWorkyardInfoPanel, global.getApplication().ensureEpicWorkyardInfoPanel());
            }
            return (this._mEpicWorkyardInfoPanel);
        }

        public function get mTimedProductionInfoPanel():cTimedProductionInfoPanel
        {
            if (this._mTimedProductionInfoPanel == null)
            {
                this._mTimedProductionInfoPanel = new cTimedProductionInfoPanel();
                this.initializeLazyController(this._mTimedProductionInfoPanel, global.getApplication().ensureTimedProductionInfoPanel());
            }
            return (this._mTimedProductionInfoPanel);
        }

        public function get mBarracksInfoPanel():cTimedProductionInfoPanel
        {
            if (this._mBarracksInfoPanel == null)
            {
                this._mBarracksInfoPanel = new cTimedProductionInfoPanel();
                this.initializeLazyController(this._mBarracksInfoPanel, global.getApplication().ensureBarracksInfoPanel());
            }
            return (this._mBarracksInfoPanel);
        }

        public function get mBarracks3InfoPanel():cTimedProductionInfoPanel
        {
            if (this._mBarracks3InfoPanel == null)
            {
                var panel:* = global.getApplication().ensureBarracks3InfoPanel();
                this._mBarracks3InfoPanel = new cTimedProductionInfoPanel();
                this._mBarracks3InfoPanel.Init(panel, true);
                global.getApplication().mountLazyWindow(panel);
            }
            return (this._mBarracks3InfoPanel);
        }

        public function get mExpeditionWeaponSmithInfoPanel():cTimedProductionInfoPanel
        {
            if (this._mExpeditionWeaponSmithInfoPanel == null)
            {
                var panel:* = global.getApplication().ensureExpeditionWeaponsmithInfoPanel();
                this._mExpeditionWeaponSmithInfoPanel = new cTimedProductionInfoPanel();
                this._mExpeditionWeaponSmithInfoPanel.Init(panel, true);
                global.getApplication().mountLazyWindow(panel);
            }
            return (this._mExpeditionWeaponSmithInfoPanel);
        }

        public function get mSkillProductionPanel():cSkillProductionPanel
        {
            if (this._mSkillProductionPanel == null)
            {
                var panel:* = global.getApplication().ensureSkillProductionPanel();
                global.getApplication().mountLazyWindow(panel);
                this._mSkillProductionPanel = new cSkillProductionPanel();
                this._mSkillProductionPanel.Init(panel);
            }
            return (this._mSkillProductionPanel);
        }

        public function get mBattleWindow():cBattleWindow
        {
            if (this._mBattleWindow == null)
            {
                var panel:* = global.getApplication().ensureBattleWindow();
                global.getApplication().mountLazyWindow(panel);
                this._mBattleWindow = new cBattleWindow();
                this._mBattleWindow.Init(panel);
            }
            return (this._mBattleWindow);
        }

        private function initializeWarehouseControllers():void
        {
            if (this._mWarehouseInfoPanel == null)
            {
                var panel:* = global.getApplication().ensureWarehouseInfoPanel();
                global.getApplication().mountLazyWindow(panel);
                this._mWarehouseInfoPanel = new cWarehouseInfoPanel();
                this._mWarehouseInfoPanel.Init(panel);
                this._mMayorhouseInfoPanel = new cMayorhouseInfoPanel();
                this._mMayorhouseInfoPanel.Init(panel);
            }
        }

        public function get mWarehouseInfoPanel():cWarehouseInfoPanel
        {
            this.initializeWarehouseControllers();
            return (this._mWarehouseInfoPanel);
        }

        public function get mMayorhouseInfoPanel():cMayorhouseInfoPanel
        {
            this.initializeWarehouseControllers();
            return (this._mMayorhouseInfoPanel);
        }

        public function get mSpecialistPanel():cSpecialistPanel
        {
            if (this._mSpecialistPanel == null)
            {
                this._mSpecialistPanel = new cSpecialistPanel();
                this.initializeLazyController(this._mSpecialistPanel, global.getApplication().ensureSpecialistPanel());
            }
            return (this._mSpecialistPanel);
        }

        public function get mEventWindow():cEventPanel
        {
            if (this._mEventWindow == null)
            {
                this._mEventWindow = new cEventPanel();
                this.initializeLazyController(this._mEventWindow, global.getApplication().ensureEventWindow());
            }
            return (this._mEventWindow);
        }

        public function get mLevelUpWindow():cLevelUpWindow
        {
            if (this._mLevelUpWindow == null)
            {
                this._mLevelUpWindow = new cLevelUpWindow();
                this.initializeLazyController(this._mLevelUpWindow, global.getApplication().ensureLevelUpWindow());
            }
            return (this._mLevelUpWindow);
        }

        public function get mWelcomeWindow():cWelcomeWindow
        {
            if (this._mWelcomeWindow == null)
            {
                this._mWelcomeWindow = new cWelcomeWindow();
                this.initializeLazyController(this._mWelcomeWindow, global.getApplication().ensureWelcomeWindow());
            }
            return (this._mWelcomeWindow);
        }

        public function get mDailyLoginPanel():cDailyLoginPanel
        {
            if (this._mDailyLoginPanel == null)
            {
                this._mDailyLoginPanel = new cDailyLoginPanel();
                this.initializeLazyController(this._mDailyLoginPanel, global.getApplication().ensureDailyLoginPanel());
            }
            return (this._mDailyLoginPanel);
        }

        public function get mMemoryMonitorPanel():cMemoryMonitorPanel
        {
            if (this._mMemoryMonitorPanel == null)
            {
                this._mMemoryMonitorPanel = new cMemoryMonitorPanel();
                this.initializeLazyController(this._mMemoryMonitorPanel, global.getApplication().ensureMemoryMonitorPanel());
            }
            return (this._mMemoryMonitorPanel);
        }

        public function get mDefenseBuildingPanel():cDefenseBuildingPanel
        {
            if (this._mDefenseBuildingPanel == null)
            {
                this._mDefenseBuildingPanel = new cDefenseBuildingPanel();
                this.initializeLazyController(this._mDefenseBuildingPanel, global.getApplication().ensureDefenseBuildingPanel());
            }
            return (this._mDefenseBuildingPanel);
        }

        public function get mPvpReportWindow():cPvPReportWindow
        {
            if (this._mPvpReportWindow == null)
            {
                this._mPvpReportWindow = new cPvPReportWindow();
                this.initializeLazyController(this._mPvpReportWindow, global.getApplication().ensurePvpReportWindow());
            }
            return (this._mPvpReportWindow);
        }

        public function get mGuildWindow():cGuildWindow
        {
            if (this._mGuildWindow == null)
            {
                this._mGuildWindow = new cGuildWindow();
                this.initializeLazyController(this._mGuildWindow, global.getApplication().ensureGuildWindow());
            }
            return (this._mGuildWindow);
        }

        public function get mHelpWindow():cHelpWindow
        {
            return (this._mHelpWindow);
        }

        public function get mEconomyOverview():cEconomyOverview
        {
            if (this._mEconomyOverview == null)
            {
                this._mEconomyOverview = new cEconomyOverview();
                this.initializeLazyController(this._mEconomyOverview, global.getApplication().ensureEconomyOverview());
            }
            return (this._mEconomyOverview);
        }

        public function get mPvPColoniesWindow():cPvPColoniesWindow
        {
            if (this._mPvPColoniesWindow == null)
            {
                this._mPvPColoniesWindow = new cPvPColoniesWindow();
                this._mPvPColoniesWindow.Init(global.getApplication().ensurePvPColoniesWindow());
            }
            return (this._mPvPColoniesWindow);
        }

        public function get mSkillTreeWindow():cSkillTreeWindow
        {
            if (this._mSkillTreeWindow == null)
            {
                this._mSkillTreeWindow = new cSkillTreeWindow();
                this.initializeLazyController(this._mSkillTreeWindow, global.getApplication().ensureSkillTreeWindow());
            }
            return (this._mSkillTreeWindow);
        }

        public function get mAchievementPanel():AchievementPanel
        {
            if (this._mAchievementPanel == null)
            {
                this._mAchievementPanel = new AchievementPanel();
                this._mAchievementPanel.init((this.mGeneralInterface as cGameInterface), global.getApplication().ensureAchievementPanel());
            }
            return (this._mAchievementPanel);
        }

        public function sendAchievementNotificationWhenReady(_arg_1:String, _arg_2:Object=null, _arg_3:String=null):void
        {
            var panel:AchievementPanel = this.mAchievementPanel;
            if (panel.isReady())
            {
                ApplicationFacade.sendNotification(_arg_1, _arg_2, _arg_3);
                return;
            }
            global.getApplication().callLater(this.sendAchievementNotificationWhenReady, [_arg_1, _arg_2, _arg_3]);
        }

        public function get mContentGeneratorPanel():cContentGeneratorPanel
        {
            if (this._mContentGeneratorPanel == null)
            {
                this._mContentGeneratorPanel = new cContentGeneratorPanel();
                this._mContentGeneratorPanel.Init(global.getApplication().ensureContentGeneratorPanel());
            }
            return (this._mContentGeneratorPanel);
        }

        public function get mContentGeneratorRewardPanel():cContentGeneratorRewardPanel
        {
            if (this._mContentGeneratorRewardPanel == null)
            {
                this._mContentGeneratorRewardPanel = new cContentGeneratorRewardPanel();
                this._mContentGeneratorRewardPanel.Init(global.getApplication().ensureContentGeneratorRewardPanel());
            }
            return (this._mContentGeneratorRewardPanel);
        }

        public function ToggleTradeWindow(_arg_1:Event):void
        {
            if (this.mTradeWindow.IsVisible())
            {
                this.mTradeWindow.Hide();
            }
            else
            {
                this.mTradeWindow.Show();
            };
        }

        public function ToggleStarMenu(_arg_1:Event):void
        {
            if (this.mStarMenu.IsVisible())
            {
                this.mStarMenu.ClosePanel(_arg_1);
            }
            else
            {
                this.mStarMenu.Show();
            };
        }

        public function RegisterBuildingType(_arg_1:String, _arg_2:String, _arg_3:String):void
        {
            if (((_arg_1 == "") || (_arg_2 == "")))
            {
                gMisc.Assert(false, ("No UI type specified for building: " + _arg_1));
            };
            this.map_BuildingName_InfoPanel[_arg_1] = _arg_2;
            this.map_BuildingName_UIContent[_arg_1] = _arg_3;
        }

        public function ToggleShop(_arg_1:Event):void
        {
            if (this.mShopWindow.IsVisible())
            {
                this.mShopWindow.Hide();
            }
            else
            {
                this.mShopWindow.Show();
            };
        }

        public function AssignInfoPannels():void
        {
            var _local_2:String;
            var _local_1:Dictionary = new Dictionary();
            for (_local_2 in this.map_BuildingName_InfoPanel)
            {
                switch (this.map_BuildingName_InfoPanel[_local_2])
                {
                    case "achievementWorkyard":
                    case "workyard":
                        _local_1[_local_2] = "lazy:building";
                        break;
                    case "epicWorkyard":
                        _local_1[_local_2] = "lazy:epicworkyard";
                        break;
                    case "residence":
                        _local_1[_local_2] = this.mResidenceInfoPanel;
                        break;
                    case "genericLink":
                        _local_1[_local_2] = this.mGenericLinkBuildingInfoPanel;
                        break;
                    case "timedproduction":
                        if (this.map_BuildingName_UIContent[_local_2] == 2)
                        {
                            _local_1[_local_2] = "lazy:skillproduction";
                        }
                        else
                        {
                            if (_local_2 == defines.BARRACKS_NAME_string)
                            {
                                _local_1[_local_2] = "lazy:barracks";
                            }
                            else
                            {
                                if (_local_2 == defines.BARRACKS3_NAME_string)
                                {
                                    _local_1[_local_2] = "lazy:barracks3";
                                }
                                else
                                {
                                    if (_local_2 == defines.EXPEDITION_WEAPONSMITH_NAME_string)
                                    {
                                        _local_1[_local_2] = "lazy:expeditionweaponsmith";
                                    }
                                    else
                                    {
                                        _local_1[_local_2] = "lazy:timedproduction";
                                    };
                                };
                            };
                        };
                        break;
                    case "achievementWarehouse":
                    case "warehouse":
                        if (defines.MAYORHOUSE_NAME_string == _local_2)
                        {
                            _local_1[_local_2] = "lazy:mayorhouse";
                        }
                        else
                        {
                            _local_1[_local_2] = "lazy:warehouse";
                        };
                        break;
                    case "decoration":
                        _local_1[_local_2] = this.mDecorationInfoPanel;
                        break;
                    case "enemy":
                        if (StringUtils.startsWith(_local_2, defines.DESTROYABLE_MOUNTAIN_string))
                        {
                            _local_1[_local_2] = this.mMountainInfoPanel;
                        }
                        else
                        {
                            _local_1[_local_2] = this.mEnemyBuildingInfoPanel;
                        };
                        break;
                    case "minimal":
                        _local_1[_local_2] = this.mMinimalInfoPanel;
                        break;
                    case "tradeOffice":
                        _local_1[_local_2] = "lazy:trade";
                        break;
                    case "tavern":
                        _local_1[_local_2] = this.mTavernInfoPanel;
                        break;
                    case "watchtower":
                        _local_1[_local_2] = this.mWatchTowerInfoPanel;
                        break;
                    case "guildbank":
                        _local_1[_local_2] = "lazy:guildbank";
                        break;
                    case "guild":
                        _local_1[_local_2] = "lazy:guild";
                        break;
                    case defines.TASK_BUILDING_UI_NAME_string:
                        _local_1[_local_2] = "lazy:taskbuilding";
                        break;
                    case "culture":
                        _local_1[_local_2] = "lazy:culture";
                        break;
                    case "contentgenerator":
                        _local_1[_local_2] = "lazy:contentgenerator";
                        break;
                    case "player_camp":
                    case "none":
                        break;
                    case "garrison":
                        break;
                    default:
                        gMisc.Assert(false, ((('Unknown UI type "' + this.map_BuildingName_InfoPanel[_local_2]) + '" for building: ') + _local_2));
                };
            };
            this.map_BuildingName_InfoPanel = _local_1;
        }

        public function ShowBarracks():void
        {
            var _local_1:cBuilding;
            for each (_local_1 in global.ui.mCurrentPlayerZone.mStreetDataMap.GetBuildings_vector())
            {
                if (_local_1 != null)
                {
                    if (_local_1.GetBuildingName_string() == defines.BARRACKS_NAME_string)
                    {
                        global.ui.SelectBuilding(_local_1);
                        this.mBarracksInfoPanel.SetData(_local_1);
                        this.mBarracksInfoPanel.Show();
                        return;
                    };
                };
            };
        }

        public function ShowEconomy(_arg_1:dResourceDefaultDefinition):void
        {
            if (_arg_1 != null)
            {
                this.mEconomyOverview.SetSelection(_arg_1);
            };
            this.mEconomyOverview.Show();
        }

        public function WriteDebugTextCenterBackground(_arg_1:BitmapData, _arg_2:String, _arg_3:int, _arg_4:int, _arg_5:int):void
        {
            this.mRenderTextDebug.render(_arg_2, _arg_1, _arg_3, _arg_4, true, _arg_5);
        }

        public function InitFonts(_arg_1:String):void
        {
            trace((('cGUIWrapper::InitFonts("' + _arg_1) + '")'));
            MapTextRenderer.DEFAULT_FONT_NAME = _arg_1;
            this.mRenderTextDebug = new MapTextRenderer();
            this.mRenderTextBigFont = new MapTextRenderer(16, 0xFF00);
        }

        public function ToggleEconomyWindow(_arg_1:Event):void
        {
            if (this.mEconomyOverview.IsVisible())
            {
                this.mEconomyOverview.Hide();
            }
            else
            {
                this.mEconomyOverview.Show();
            };
        }

        public function UpdateGuiOnZoneLoad():void
        {
            if (this.mEventInfoPanel.IsVisible())
            {
                this.mEventInfoPanel.StartEventInfoState();
            }
            else
            {
                cBasicPanel.HideCurrentActivePanel();
            };
            AdventureManager.getInstance().SetScoutingForPvP(false);
            this.mLoadingZonePanel.Hide();
            globalFlash.gui.windowController.closeModal();
            if (!global.ui.isOnHomzone())
            {
                this.mEventInfoPanel.Hide();
                this.mEventWidgetList.Hide();
            }
            else
            {
                if (!global.hasEventInfoPanelBeenShown)
                {
                    this.mEventInfoPanel.Show();
                };
                this.mEventWidgetList.Show();
            };
            if (this.IsLazyControllerCreated("GAMESTATE_ID_TRADE_WINDOW")) this.mTradeWindow.Hide();
            this.mToolboxPanel.ClosePanel(null);
            if (this.IsLazyControllerCreated("GAMESTATE_ID_STAR_MENU")) this.mStarMenu.ClosePanel(null);
            if (this._mDeleteBuffResourcePanel != null) this.mDeleteBuffResourcePanel.Hide();
        }

        public function ShowBuilding(_arg_1:String):cBuilding
        {
            var _local_2:cBuilding = global.ui.mCurrentPlayerZone.mStreetDataMap.getBuildingByName(_arg_1);
            this.mGeneralInterface.SelectBuilding(_local_2);
            return (_local_2);
        }

        public function set mGuildBankWindow(_arg_1:cGuildBankWindow):void
        {
            var _local_2:Object = this._274569870mGuildBankWindow;
            if (_local_2 !== _arg_1)
            {
                this._274569870mGuildBankWindow = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mGuildBankWindow", _local_2, _arg_1));
            };
        }

        public function WriteDebugTextCenter(_arg_1:BitmapData, _arg_2:String, _arg_3:int, _arg_4:int):void
        {
            this.mRenderTextDebug.render(_arg_2, _arg_1, _arg_3, _arg_4, true);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function OpenWindow(_arg_1:String, _arg_2:String=null):void
        {
            var _local_3:cGuiBaseElement;
            switch (_arg_1)
            {
                case "GAMESTATE_ID_PVP_PROGRESSION":
                    this.mPvPProgressionPanel.SetState(cPvPProgressionPanel.STATE_RANKS);
                    this.mPvPProgressionPanel.Show();
                    return;
                case "GAMESTATE_ID_ACHIEVEMENT_PANEL":
                    this.sendAchievementNotificationWhenReady(AchievementConsts.SHOW_HIDE_ACHIEVEMENT_PANEL, null, AchievementConsts.NORMAL_MODE);
                    if (!isNaN(parseInt(_arg_2)))
                    {
                        ApplicationFacade.sendNotification(AchievementConsts.ACHIEVEMENT_CATEGORY_SELECTED, parseInt(_arg_2), null);
                    };
                    return;
                case "GAMESTATE_ID_HELP_WINDOW":
                    this.mHelpOverview.ShowItem(global.map_HelpName_HelpDefinition[_arg_2], 1);
                    this.mHelpOverview.Show();
                    return;
                case "GAMESTATE_ID_SHOP_WINDOW":
                    if (!isNaN(parseInt(_arg_2)))
                    {
                        this.mShopWindow.ShowDeepLink("OpenWindowEffect", -1, parseInt(_arg_2));
                    }
                    else
                    {
                        this.mShopWindow.Show();
                    };
                    return;
                case "CLOSE_WINDOW":
                    cBasicPanel.HideCurrentActivePanel();
                    return;
                case "GAMESTATE_ID_QUEST_BOOK_START_WITH":
                    this.mQuestBook.SetPreselectedQuestThatStartsWith(_arg_2);
                    this.mQuestBook.Show();
                default:
                    _local_3 = this.GetPanelControllerById(_arg_1);
                    if (_local_3 != null)
                    {
                        _local_3.Show();
                    };
            };
        }

        public function IsLazyGuiElement(_arg_1:String):Boolean
        {
            switch (_arg_1)
            {
                case "GAMESTATE_ID_SHOP_WINDOW":
                case "GAMESTATE_ID_PVP_REPORT_WINDOW":
                case "GAMESTATE_ID_GUILD_WINDOW":
                case "GAMESTATE_ID_HELP_WINDOW":
                case "GAMESTATE_ID_MAIL_WINDOW":
                case "GAMESTATE_ID_ECONOMY_OVERVIEW":
                case "GAMESTATE_ID_PVPCOLONIES_WINDOW":
                case "GAMESTATE_ID_SKILLTREEWINDOW":
                case "GAMESTATE_ID_ACHIEVEMENT_PANEL":
                case "GAMESTATE_ID_CONTENT_GENERATOR_PANEL":
                case "GAMESTATE_ID_CONTENT_GENERATOR_REWARD_PANEL":
                case "GAMESTATE_ID_TRADE_WINDOW":
                case "GAMESTATE_ID_BLOCK_LIST":
                case "GAMESTATE_ID_GUILD_BANK_WINDOW":
                case "GAMESTATE_ID_GUILD_PAY_RESOURCE_PANEL":
                case "GAMESTATE_ID_GUILD_TRANSFER_RESOURCE_PANEL":
                case "GAMESTATE_ID_GUILD_BUY_TAB_PANEL":
                case "GAMESTATE_ID_GUILD_ENLARGE_PANEL":
                case "GAMESTATE_ID_GUILD_TRANSACTION_HISTORY":
                case "GAMESTATE_ID_PLAYER_OPTIONS":
                case "GAMESTATE_ID_ZONE_BUFF_PANEL":
                case "GAMESTATE_ID_ADD_FRIENDS_PANEL":
                case "GAMESTATE_ID_FOUND_GUILD_PANEL":
                case "GAMESTATE_ID_ACTIVATE_PREMIUM_ACCOUNT_WINDOW":
                case "GAMESTATE_ID_TASK_BUILDING_PANEL":
                case "GAMESTATE_ID_APPLY_BUFF_RESOURCE_PANEL":
                case "GAMESTATE_ID_DELETE_BUFF_RESOURCE_PANEL":
                case "GAMESTATE_ID_EVENT_INFO_PANEL":
                case "GAMESTATE_ID_CULTURE_BUILDING_PANEL":
                case "GAMESTATE_ID_MOVE_BUILDING_PANEL":
                case "GAMESTATE_ID_MYSTERYBOX_PANEL":
                case "GAMESTATE_ID_PRECOMBAT_PANEL":
                case "GAMESTATE_ID_COLONY_WINDOW":
                case "GAMESTATE_ID_SPECIALIST_TRAVEL_PANEL":
                case "GAMESTATE_ID_QUEST_BOOK":
                case "GAMESTATE_ID_HELP_OVERVIEW":
                case "GAMESTATE_ID_ADVENTURE_PANEL":
                case "GAMESTATE_ID_ADVENT_WINDOW":
                case "GAMESTATE_ID_PVP_LEVEL_REWARDS":
                case "GAMESTATE_ID_SPECIALIST_PANEL":
                case "GAMESTATE_ID_EVENT_WINDOW":
                case "GAMESTATE_ID_LEVELUP_WINDOW":
                case "GAMESTATE_ID_WELCOME_WINDOW":
                case "GAMESTATE_ID_DAILY_LOGIN_PANEL":
                case "GAMESTATE_ID_MEMORY_MONITOR":
                case "GAMESTATE_ID_DEFENSE_BUILDING":
                case "GAMESTATE_HIRED_TROOPS_POOL_PANEL":
                case "GAMESTATE_ID_BUILDING_INFO_PANEL":
                case "GAMESTATE_ID_EPIC_WORKYARD_INFO_PANEL":
                case "GAMESTATE_ID_WAREHOUSE_INFO_PANEL":
                case "GAMESTATE_ID_TIMED_PRODUCTION_INFO_PANEL":
                case "GAMESTATE_ID_BARRACKS":
                case "GAMESTATE_ID_BARRACKS3":
                case "GAMESTATE_ID_EXPEDITION_WEAPONSMITH":
                case "GAMESTATE_ID_SKILL_PRODUCTION_PANEL":
                case "GAMESTATE_ID_BATTLE_WINDOW":
                    return (true);
            }
            return (false);
        }

        public function IsLazyControllerCreated(_arg_1:String):Boolean
        {
            switch (_arg_1)
            {
                case "GAMESTATE_ID_TIMED_PRODUCTION_INFO_PANEL": return (this._mTimedProductionInfoPanel != null);
                case "GAMESTATE_ID_SKILL_PRODUCTION_PANEL": return (this._mSkillProductionPanel != null);
                case "GAMESTATE_ID_BARRACKS": return (this._mBarracksInfoPanel != null);
                case "GAMESTATE_ID_BARRACKS3": return (this._mBarracks3InfoPanel != null);
                case "GAMESTATE_ID_SPECIALIST_TRAVEL_PANEL": return (this._mSpecialistTravelPanel != null);
                case "GAMESTATE_ID_SKILLTREEWINDOW": return (this._mSkillTreeWindow != null);
                case "GAMESTATE_HIRED_TROOPS_POOL_PANEL": return (this._mHiredTroopsPoolPanel != null);
                case "GAMESTATE_ID_GUILD_WINDOW": return (this._mGuildWindow != null);
                case "GAMESTATE_ID_CONTENT_GENERATOR_PANEL": return (this._mContentGeneratorPanel != null);
                case "GAMESTATE_ID_STAR_MENU": return (this.mStarMenu != null);
                case "GAMESTATE_ID_PLAYER_OPTIONS": return (this._mPlayerOptionsPanel != null);
                case "GAMESTATE_ID_TASK_BUILDING_PANEL": return (this._mTaskBuildingPanel != null);
                case "GAMESTATE_ID_QUEST_BOOK": return (this._mQuestBook != null);
                case "GAMESTATE_ID_TRADE_WINDOW": return (this._mTradeWindow != null);
                case "GAMESTATE_ID_COLONY_WINDOW": return (this._mColonyWindow != null);
                case "GAMESTATE_ID_ZONE_BUFF_PANEL": return (this._mZoneBuffPanel != null);
                case "GAMESTATE_ID_WAREHOUSE_INFO_PANEL": return (this._mWarehouseInfoPanel != null);
                case "GAMESTATE_ID_HELP_WINDOW": return (this._mHelpWindow != null);
            }
            return (false);
        }

        public function GetPanelControllerById(_arg_1:String):cGuiBaseElement
        {
            var result:cGuiBaseElement = cGuiBaseElement.GetPanelController(_arg_1);
            if (result != null)
                return (result);
            switch (_arg_1)
            {
                case "GAMESTATE_ID_SHOP_WINDOW": return (this.mShopWindow);
                case "GAMESTATE_ID_PVP_REPORT_WINDOW": return (this.mPvpReportWindow);
                case "GAMESTATE_ID_GUILD_WINDOW": return (this.mGuildWindow);
                case "GAMESTATE_ID_HELP_WINDOW": return (this.mHelpWindow);
                case "GAMESTATE_ID_MAIL_WINDOW": return (this.mMailWindow);
                case "GAMESTATE_ID_ECONOMY_OVERVIEW": return (this.mEconomyOverview);
                case "GAMESTATE_ID_PVPCOLONIES_WINDOW": return (this.mPvPColoniesWindow);
                case "GAMESTATE_ID_SKILLTREEWINDOW": return (this.mSkillTreeWindow);
                case "GAMESTATE_ID_ACHIEVEMENT_PANEL": return (this.mAchievementPanel);
                case "GAMESTATE_ID_CONTENT_GENERATOR_PANEL": return (this.mContentGeneratorPanel);
                case "GAMESTATE_ID_CONTENT_GENERATOR_REWARD_PANEL": return (this.mContentGeneratorRewardPanel);
                case "GAMESTATE_ID_TRADE_WINDOW": return (this.mTradeWindow);
                case "GAMESTATE_ID_BLOCK_LIST": return (this.mBlockList);
                case "GAMESTATE_ID_GUILD_BANK_WINDOW": return (this.mGuildBankWindow);
                case "GAMESTATE_ID_GUILD_PAY_RESOURCE_PANEL": return (this.mGuildPayResourcePanel);
                case "GAMESTATE_ID_GUILD_TRANSFER_RESOURCE_PANEL": return (this.mGuildTransferResourcePanel);
                case "GAMESTATE_ID_GUILD_BUY_TAB_PANEL": return (this.mGuildBankBuyTabPanel);
                case "GAMESTATE_ID_GUILD_ENLARGE_PANEL": return (this.mGuildBankEnlargePanel);
                case "GAMESTATE_ID_GUILD_TRANSACTION_HISTORY": return (this.mGuildBankTransactionHistory);
                case "GAMESTATE_ID_PLAYER_OPTIONS": return (this.mPlayerOptionsPanel);
                case "GAMESTATE_ID_ZONE_BUFF_PANEL": return (this.mZoneBuffPanel);
                case "GAMESTATE_ID_ADD_FRIENDS_PANEL": return (this.mAddFriendsPanel);
                case "GAMESTATE_ID_FOUND_GUILD_PANEL": return (this.mFoundGuildPanel);
                case "GAMESTATE_ID_ACTIVATE_PREMIUM_ACCOUNT_WINDOW": return (this.mPremiumAccountActivationWindow);
                case "GAMESTATE_ID_TASK_BUILDING_PANEL": return (this.mTaskBuildingPanel);
                case "GAMESTATE_ID_APPLY_BUFF_RESOURCE_PANEL": return (this.mApplyBuffResourcePanel);
                case "GAMESTATE_ID_DELETE_BUFF_RESOURCE_PANEL": return (this.mDeleteBuffResourcePanel);
                case "GAMESTATE_ID_EVENT_INFO_PANEL": return (this.mEventInfoPanel);
                case "GAMESTATE_ID_CULTURE_BUILDING_PANEL": return (this.mCultureBuildingPanel);
                case "GAMESTATE_ID_MOVE_BUILDING_PANEL": return (this.mMoveBuildingPanel);
                case "GAMESTATE_ID_MYSTERYBOX_PANEL": return (this.mMysteryBoxPanel);
                case "GAMESTATE_ID_PRECOMBAT_PANEL": return (this.mCombatPreviewPanel);
                case "GAMESTATE_ID_COLONY_WINDOW": return (this.mColonyWindow);
                case "GAMESTATE_ID_SPECIALIST_TRAVEL_PANEL": return (this.mSpecialistTravelPanel);
                case "GAMESTATE_ID_QUEST_BOOK": return (this.mQuestBook);
                case "GAMESTATE_ID_HELP_OVERVIEW": return (this.mHelpOverview);
                case "GAMESTATE_ID_ADVENTURE_PANEL": return (this.mAdventurePanel);
                case "GAMESTATE_ID_ADVENT_WINDOW": return (this.mAdventWindow);
                case "GAMESTATE_ID_PVP_LEVEL_REWARDS": return (this.mPvPLeveLRewardsPanel);
                case "GAMESTATE_ID_SPECIALIST_PANEL": return (this.mSpecialistPanel);
                case "GAMESTATE_ID_EVENT_WINDOW": return (this.mEventWindow);
                case "GAMESTATE_ID_LEVELUP_WINDOW": return (this.mLevelUpWindow);
                case "GAMESTATE_ID_WELCOME_WINDOW": return (this.mWelcomeWindow);
                case "GAMESTATE_ID_DAILY_LOGIN_PANEL": return (this.mDailyLoginPanel);
                case "GAMESTATE_ID_MEMORY_MONITOR": return (this.mMemoryMonitorPanel);
                case "GAMESTATE_ID_DEFENSE_BUILDING": return (this.mDefenseBuildingPanel);
                case "GAMESTATE_ID_STAR_MENU": return (this.mStarMenu);
                case "GAMESTATE_HIRED_TROOPS_POOL_PANEL": return (this.mHiredTroopsPoolPanel);
                case "GAMESTATE_ID_BUILDING_INFO_PANEL": return (this.mBuildingInfoPanel);
                case "GAMESTATE_ID_EPIC_WORKYARD_INFO_PANEL": return (this.mEpicWorkyardInfoPanel);
                case "GAMESTATE_ID_WAREHOUSE_INFO_PANEL": return (this.mWarehouseInfoPanel);
                case "GAMESTATE_ID_TIMED_PRODUCTION_INFO_PANEL": return (this.mTimedProductionInfoPanel);
                case "GAMESTATE_ID_BARRACKS": return (this.mBarracksInfoPanel);
                case "GAMESTATE_ID_BARRACKS3": return (this.mBarracks3InfoPanel);
                case "GAMESTATE_ID_EXPEDITION_WEAPONSMITH": return (this.mExpeditionWeaponSmithInfoPanel);
                case "GAMESTATE_ID_SKILL_PRODUCTION_PANEL": return (this.mSkillProductionPanel);
                case "GAMESTATE_ID_BATTLE_WINDOW": return (this.mBattleWindow);
            }
            return (null);
        }

        public function GetDefaultGuiElementsLoaded():Boolean
        {
            return (this.mDefaultGuiElementsLoaded);
        }

        public function ToggleColonyWindow(_arg_1:Event=null):void
        {
            if (this.mColonyWindow.IsVisible())
            {
                this.mColonyWindow.Hide();
            }
            else
            {
                this.mColonyWindow.Show();
            };
        }

        public function WriteDebugText(_arg_1:BitmapData, _arg_2:String, _arg_3:int, _arg_4:int):void
        {
            this.mRenderTextDebug.render(_arg_2, _arg_1, _arg_3, _arg_4);
        }

        public function ToggleMailWindow(_arg_1:Event):void
        {
            if (this.mMailWindow.IsVisible())
            {
                this.mMailWindow.Hide();
            }
            else
            {
                this.mMailWindow.Show();
            };
        }

        public function ToggleToolbox(_arg_1:Event):void
        {
            if (this.mToolboxPanel.IsVisible())
            {
                this.mToolboxPanel.ClosePanel(_arg_1);
            }
            else
            {
                this.mToolboxPanel.Show();
            };
        }

        public function ExitGuiElements():void
        {
        }

        public function set mCancelActionPanel(_arg_1:cCancelActionPanel):void
        {
            var _local_2:Object = this._1434131879mCancelActionPanel;
            if (_local_2 !== _arg_1)
            {
                this._1434131879mCancelActionPanel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mCancelActionPanel", _local_2, _arg_1));
            };
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            this._bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        public function GetInfoPanel(_arg_1:String):cBasicInfoPanel
        {
            var value:Object = this.map_BuildingName_InfoPanel[_arg_1];
            if (value == "lazy:guild")
            {
                value = this.mGuildWindow;
                this.map_BuildingName_InfoPanel[_arg_1] = value;
            }
            else if (value == "lazy:contentgenerator")
            {
                value = this.mContentGeneratorPanel;
                this.map_BuildingName_InfoPanel[_arg_1] = value;
            }
            else if (value == "lazy:trade")
            {
                value = this.mTradeWindow;
                this.map_BuildingName_InfoPanel[_arg_1] = value;
            }
            else if (value == "lazy:guildbank")
            {
                value = this.mGuildBankWindow;
                this.map_BuildingName_InfoPanel[_arg_1] = value;
            }
            else if (value == "lazy:taskbuilding")
            {
                value = this.mTaskBuildingPanel;
                this.map_BuildingName_InfoPanel[_arg_1] = value;
            }
            else if (value == "lazy:culture")
            {
                value = this.mCultureBuildingPanel;
                this.map_BuildingName_InfoPanel[_arg_1] = value;
            }
            else if (value == "lazy:building") value = this.mBuildingInfoPanel;
            else if (value == "lazy:epicworkyard") value = this.mEpicWorkyardInfoPanel;
            else if (value == "lazy:skillproduction") value = this.mSkillProductionPanel;
            else if (value == "lazy:barracks") value = this.mBarracksInfoPanel;
            else if (value == "lazy:barracks3") value = this.mBarracks3InfoPanel;
            else if (value == "lazy:expeditionweaponsmith") value = this.mExpeditionWeaponSmithInfoPanel;
            else if (value == "lazy:timedproduction") value = this.mTimedProductionInfoPanel;
            else if (value == "lazy:mayorhouse") value = this.mMayorhouseInfoPanel;
            else if (value == "lazy:warehouse") value = this.mWarehouseInfoPanel;
            if (value is cBasicInfoPanel)
                this.map_BuildingName_InfoPanel[_arg_1] = value;
            return (value as cBasicInfoPanel);
        }

        [Bindable(event="propertyChange")]
        public function get mGuildBankWindow():cGuildBankWindow
        {
            if (this._274569870mGuildBankWindow == null)
            {
                this.mGuildBankWindow = new cGuildBankWindow();
                this.initializeLazyController(this._274569870mGuildBankWindow, global.getApplication().ensureGuildBankWindow());
            }
            return (this._274569870mGuildBankWindow);
        }

        public function ShowQuestWindowDelayed():void
        {
            if ((((this.mWindowQueue.length > 0) && (!(cBasicPanel.IsCurrentActivePanelVisible()))) && (this.mDelayedPanel == null)))
            {
                this.mDelayedPanel = this.mWindowQueue.shift();
                setTimeout(function ():void
                {
                    if (!cBasicPanel.IsCurrentActivePanelVisible())
                    {
                        mDelayedPanel.Show();
                    }
                    else
                    {
                        mWindowQueue.unshift(mDelayedPanel);
                    };
                    mDelayedPanel = null;
                }, 100);
            };
        }

        public function GetInfoPanelString(_arg_1:String):String
        {
            return (this.map_BuildingName_InfoPanel[_arg_1]);
        }

        [Bindable(event="propertyChange")]
        public function get mCancelActionPanel():cCancelActionPanel
        {
            return (this._1434131879mCancelActionPanel);
        }

        public function TryShowPanel(_arg_1:cGuiBaseElement):void
        {
            if (((!(_arg_1 is cBasicPanel)) || (((!(cBasicPanel.IsCurrentActivePanelVisible())) && (this.mDelayedPanel == null)) && (this.mGeneralInterface.mCurrentCursor.GetEditMode() == COMMAND.SELECT_BUILDING))))
            {
                _arg_1.Show();
            }
            else
            {
                if ((((!(_arg_1.IsVisible())) && (!(this.mDelayedPanel == _arg_1))) && (this.mWindowQueue.indexOf(_arg_1) == -1)))
                {
                    this.mWindowQueue.push(_arg_1);
                };
            };
        }

        public function TogglePvPColoniesWindow(_arg_1:Event=null):void
        {
            if (this.mPvPColoniesWindow.IsVisible())
            {
                this.mPvPColoniesWindow.Hide();
            }
            else
            {
                this.mPvPColoniesWindow.Show();
            };
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (this._bindingEventDispatcher.willTrigger(_arg_1));
        }

        public function ToggleGuildWindow(_arg_1:Event):void
        {
            if (this.mGuildWindow.IsVisible())
            {
                this.mGuildWindow.Hide();
            }
            else
            {
                this.mGuildWindow.Show();
            };
        }

        public function WriteTextBig(_arg_1:BitmapData, _arg_2:String, _arg_3:int, _arg_4:int):void
        {
            this.mRenderTextBigFont.render(_arg_2, _arg_1, _arg_3, _arg_4);
        }

        public function WriteDebugTextMapPos(_arg_1:BitmapData, _arg_2:String, _arg_3:int, _arg_4:int):void
        {
            var _local_5:cPosInt = new cPosInt();
            _local_5.x = int(_arg_3);
            _local_5.y = int(_arg_4);
            global.getApplication().mGameInterface.mZoom.CalculateScrollPos(_local_5);
            globalFlash.gui.WriteDebugText(cBackbuffer.mBackBuffer, _arg_2, _local_5.x, _local_5.y);
        }

        public function ShowNextGarrison():void
        {
            var _local_4:cSpecialist;
            var _local_1:cBuilding;
            if (((!(this.mGeneralInterface.GetSelectedBuilding() == null)) && (this.mGeneralInterface.GetSelectedBuilding().isGarrison())))
            {
                _local_1 = this.mGeneralInterface.GetSelectedBuilding();
            };
            var _local_2:cSpecialist;
            var _local_3:Vector.<cSpecialist> = this.mGeneralInterface.mCurrentPlayerZone.GetSpecialists_vector();
            for each (_local_4 in _local_3)
            {
                if ((((_local_4.GetSpecialistDescription().isGeneral()) || (_local_4.GetSpecialistDescription().isAdmiral())) && (!(_local_4.GetGarrison() == null))))
                {
                    if (_local_1 == null)
                    {
                        this.mGeneralInterface.SelectBuilding(_local_4.GetGarrison());
                        this.mSpecialistPanel.SetData(_local_4);
                        this.mSpecialistPanel.Show();
                        this.mGeneralInterface.mCurrentPlayerZone.ScrollToGrid(_local_4.GetGarrisonGridIdx());
                        return;
                    };
                    if (_local_1 == _local_4.GetGarrison())
                    {
                        _local_1 = null;
                    };
                    if (_local_2 == null)
                    {
                        _local_2 = _local_4;
                    };
                };
            };
            if (_local_2 != null)
            {
                this.mGeneralInterface.SelectBuilding(_local_2.GetGarrison());
                this.mSpecialistPanel.SetData(_local_2);
                this.mSpecialistPanel.Show();
                this.mGeneralInterface.mCurrentPlayerZone.ScrollToGrid(_local_2.GetGarrisonGridIdx());
            };
        }


    }
}


