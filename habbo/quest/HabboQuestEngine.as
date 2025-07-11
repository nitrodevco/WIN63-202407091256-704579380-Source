package com.sulake.habbo.quest
{
    import assets.class_14

    import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.runtime.ICoreConfiguration;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.purse.class_3473;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.navigator.IHabboNewNavigator;
   import com.sulake.habbo.notifications.IHabboNotifications;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboHelp;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNewNavigator;
   import com.sulake.iid.IIDHabboNotifications;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboTracking;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   import com.sulake.habbo.communication.messages.outgoing.quest.class_429;
   import com.sulake.habbo.communication.messages.outgoing.quest.class_479;
   import com.sulake.habbo.communication.messages.outgoing.quest.class_577;
   import com.sulake.habbo.communication.messages.incoming.quest.class_1715;
   
   public class HabboQuestEngine extends Component implements class_2197, IUpdateReceiver, ILinkEventTracker
   {
      
      private static const const_507:int = 5;
      
      private static const TWINKLE_ANIMATION_START_TIME:int = 800;
      
      private static const TWINKLE_ANIMATION_OBJECT_COUNT:int = 15;
      
      private static const DELAY_BETWEEN_TWINKLE_STARTS:int = 300;
      
      private static const const_442:Array = ["MOVEITEM","ENTEROTHERSROOM","CHANGEFIGURE","FINDLIFEGUARDTOWER","SCRATCHAPET"];
       
      
      private var _windowManager:IHabboWindowManager;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _localization:IHabboLocalizationManager;
      
      private var var_209:ICoreConfiguration;
      
      private var var_2938:class_3353;
      
      private var var_3213:QuestController;
      
      private var var_1995:AchievementController;
      
      private var var_4074:RoomCompetitionController;
      
      private var _toolbar:IHabboToolbar;
      
      private var _catalog:IHabboCatalog;
      
      private var _navigator:IHabboNewNavigator;
      
      private var _notifications:IHabboNotifications;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _habboHelp:IHabboHelp;
      
      private var _tracking:IHabboTracking;
      
      private var var_2909:TwinkleImages;
      
      private var _currentlyInRoom:Boolean = false;
      
      private var _roomEngine:IRoomEngine;
      
      private var var_1560:Boolean = false;
      
      private var var_3155:AchievementsResolutionController;
      
      public function HabboQuestEngine(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         super(param1,param2,param3);
         var_3213 = new QuestController(this);
         var_1995 = new AchievementController(this);
         var_3155 = new AchievementsResolutionController(this);
         var_4074 = new RoomCompetitionController(this);
         queueInterface(new IIDHabboCommunicationManager(),onCommunicationComponentInit);
         queueInterface(new IIDHabboWindowManager(),onWindowManagerReady);
         queueInterface(new IIDHabboLocalizationManager(),onLocalizationReady);
         queueInterface(new IIDHabboConfigurationManager(),onConfigurationReady);
         queueInterface(new IIDHabboToolbar(),onToolbarReady);
         queueInterface(new IIDHabboCatalog(),onCatalogReady);
         queueInterface(new IIDHabboNotifications(),onNotificationsReady);
         queueInterface(new IIDHabboHelp(),onHabboHelpReady);
         queueInterface(new IIDHabboNewNavigator(),onHabboNavigatorReady);
         queueInterface(new IIDSessionDataManager(),onSessionDataManagerReady);
         queueInterface(new IIDRoomEngine(),onRoomEngineReady);
         queueInterface(new IIDHabboTracking(),onTrackingReady);
         param1.addLinkEventTracker(this);
         registerUpdateReceiver(this,5);
      }
      
      public static function moveChildrenToRow(param1:IWindowContainer, param2:Array, param3:int, param4:int) : void
      {
         var _loc6_:IWindow = null;
         for each(var _loc5_ in param2)
         {
            if((_loc6_ = param1.getChildByName(_loc5_)) != null && _loc6_.visible)
            {
               _loc6_.x = param3;
               param3 += _loc6_.width + param4;
            }
         }
      }
      
      override public function dispose() : void
      {
         removeUpdateReceiver(this);
         context.removeLinkEventTracker(this);
         if(_toolbar)
         {
            _toolbar.release(new IIDHabboToolbar());
            _toolbar = null;
         }
         if(_catalog != null)
         {
            _catalog.release(new IIDHabboCatalog());
            _catalog = null;
         }
         if(_notifications != null)
         {
            _notifications.release(new IIDHabboNotifications());
            _notifications = null;
         }
         if(_windowManager != null)
         {
            _windowManager.release(new IIDHabboWindowManager());
            _windowManager = null;
         }
         if(_localization != null)
         {
            _localization.release(new IIDHabboLocalizationManager());
            _localization = null;
         }
         if(var_209 != null)
         {
            var_209.release(new IIDHabboConfigurationManager());
            var_209 = null;
         }
         if(_communication != null)
         {
            _communication.release(new IIDHabboCommunicationManager());
            _communication = null;
         }
         if(_sessionDataManager != null)
         {
            _sessionDataManager.events.removeEventListener("BIRE_BADGE_IMAGE_READY",var_1995.onBadgeImageReady);
            _sessionDataManager.release(new IIDSessionDataManager());
            _sessionDataManager = null;
         }
         if(var_2938)
         {
            var_2938.dispose();
         }
         if(_habboHelp != null)
         {
            _habboHelp.release(new IIDHabboHelp());
            _habboHelp = null;
         }
         if(_navigator != null)
         {
            _navigator.release(new IIDHabboNewNavigator());
            _navigator = null;
         }
         if(_tracking != null)
         {
            _tracking.release(new IIDHabboTracking());
            _tracking = null;
         }
         if(var_2909)
         {
            var_2909.dispose();
            var_2909 = null;
         }
         if(_roomEngine)
         {
            _roomEngine.release(new IIDRoomEngine());
            _roomEngine = null;
         }
         if(var_3155)
         {
            var_3155.dispose();
            var_3155 = null;
         }
         super.dispose();
      }
      
      public function getXmlWindow(param1:String, param2:int = 1) : IWindow
      {
         var _loc5_:IAsset = null;
         var _loc3_:XmlAsset = null;
         var _loc4_:IWindow = null;
         try
         {
            _loc5_ = this.findAssetByName(param1);
            _loc3_ = XmlAsset(_loc5_);
            _loc4_ = _windowManager.buildFromXML(XML(_loc3_.content),param2);
         }
         catch(e:Error)
         {
         }
         return _loc4_;
      }
      
      private function onCommunicationComponentInit(param1:IID = null, param2:IUnknown = null) : void
      {
         _communication = IHabboCommunicationManager(param2);
         var_2938 = new class_3353(this);
      }
      
      private function onWindowManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _windowManager = IHabboWindowManager(param2);
      }
      
      private function onLocalizationReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _localization = IHabboLocalizationManager(param2);
      }
      
      private function onConfigurationReady(param1:IID, param2:IUnknown) : void
      {
         if(param2 == null)
         {
            return;
         }
         var_209 = param2 as ICoreConfiguration;
      }
      
      private function onCatalogReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _catalog = param2 as IHabboCatalog;
      }
      
      private function onNotificationsReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _notifications = param2 as IHabboNotifications;
      }
      
      private function onSessionDataManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _sessionDataManager = param2 as ISessionDataManager;
         _sessionDataManager.events.addEventListener("BIRE_BADGE_IMAGE_READY",var_1995.onBadgeImageReady);
      }
      
      private function onHabboHelpReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _habboHelp = param2 as IHabboHelp;
      }
      
      private function onHabboNavigatorReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _navigator = param2 as IHabboNewNavigator;
      }
      
      private function onRoomEngineReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _roomEngine = param2 as IRoomEngine;
      }
      
      private function onTrackingReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _tracking = param2 as IHabboTracking;
      }
      
      public function get communication() : IHabboCommunicationManager
      {
         return _communication;
      }
      
      public function get habboHelp() : IHabboHelp
      {
         return _habboHelp;
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return _windowManager;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localization;
      }
      
      public function get questController() : QuestController
      {
         return var_3213;
      }
      
      public function get roomCompetitionController() : RoomCompetitionController
      {
         return var_4074;
      }
      
      public function get achievementController() : AchievementController
      {
         return var_1995;
      }
      
      public function get achievementsResolutionController() : AchievementsResolutionController
      {
         return var_3155;
      }
      
      public function get toolbar() : IHabboToolbar
      {
         return _toolbar;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function get tracking() : IHabboTracking
      {
         return _tracking;
      }
      
      public function openCatalog(param1:class_1715) : void
      {
         var _loc2_:String = param1.catalogPageName;
         if(_loc2_ != "")
         {
            class_14.log("Questing->Open Catalog: " + _loc2_);
            _catalog.openCatalogPage(_loc2_);
         }
         else
         {
            class_14.log("Questing->Open Catalog: Quest Catalog page name not defined");
            _catalog.openCatalog();
         }
      }
      
      public function openNavigator(param1:class_1715) : void
      {
         var _loc3_:String = null;
         var _loc2_:Boolean = hasLocalizedValue(param1.getQuestLocalizationKey() + ".searchtag");
         if(_loc2_)
         {
            _loc3_ = param1.getQuestLocalizationKey() + ".searchtag";
         }
         else
         {
            _loc3_ = param1.getCampaignLocalizationKey() + ".searchtag";
         }
         var _loc4_:String = String(_localization.getLocalization(_loc3_));
         class_14.log("Questing->Open Navigator: " + _loc4_);
         _navigator.performTagSearch(_loc4_);
      }
      
      public function hasQuestRoomsIds() : Boolean
      {
         var _loc1_:String = getQuestRoomIds();
         return _loc1_ != null && _loc1_ != "";
      }
      
      private function getQuestRoomIds() : String
      {
         return _localization.getLocalization("quests." + getSeasonalCampaignCodePrefix() + ".roomids");
      }
      
      public function goToQuestRooms() : void
      {
         if(!hasQuestRoomsIds())
         {
            return;
         }
         var _loc4_:String;
         var _loc2_:Array = (_loc4_ = getQuestRoomIds()).split(",");
         if(_loc2_.length == 0)
         {
            return;
         }
         var _loc3_:int = Math.max(0,Math.min(_loc2_.length - 1,Math.floor(Math.random() * _loc2_.length)));
         var _loc1_:String = String(_loc2_[_loc3_]);
         var _loc5_:int = int(_loc1_);
         class_14.log("Forwarding to a guest room: " + _loc5_);
         _navigator.goToRoom(_loc5_);
      }
      
      private function onToolbarReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _toolbar = IHabboToolbar(param2) as IHabboToolbar;
         _toolbar.events.addEventListener("HTE_TOOLBAR_CLICK",onHabboToolbarEvent);
      }
      
      private function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.type == "HTE_TOOLBAR_CLICK")
         {
            if(param1.iconId == "HTIE_ICON_QUESTS")
            {
               var_3213.onToolbarClick();
            }
            if(param1.iconId == "HTIE_ICON_ACHIEVEMENTS")
            {
               var_1995.onToolbarClick();
            }
         }
      }
      
      public function ensureAchievementsInitialized() : void
      {
         if(var_1995 != null)
         {
            var_1995.ensureAchievementsInitialized();
         }
      }
      
      public function showAchievements() : void
      {
         if(var_1995 != null)
         {
            var_1995.show();
         }
      }
      
      public function showQuests() : void
      {
      }
      
      public function getAchievementLevel(param1:String, param2:String) : int
      {
         if(var_1995 != null)
         {
            return var_1995.getAchievementLevel(param1,param2);
         }
         return 0;
      }
      
      public function reenableRoomCompetitionWindow() : void
      {
         var_4074.dontShowAgain = false;
      }
      
      public function get notifications() : IHabboNotifications
      {
         return _notifications;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function send(param1:IMessageComposer) : void
      {
         communication.connection.send(param1);
      }
      
      public function getQuestRowTitle(param1:class_1715) : String
      {
         var _loc2_:String = param1.waitPeriodSeconds < 1 ? param1.getQuestLocalizationKey() + ".name" : "quests.list.questdelayed";
         return _localization.getLocalization(_loc2_,_loc2_);
      }
      
      public function getQuestName(param1:class_1715) : String
      {
         var _loc2_:String = param1.getQuestLocalizationKey() + ".name";
         return _localization.getLocalization(_loc2_,_loc2_);
      }
      
      public function getQuestDesc(param1:class_1715) : String
      {
         var _loc2_:String = param1.getQuestLocalizationKey() + ".desc";
         return _localization.getLocalization(_loc2_,_loc2_);
      }
      
      public function getQuestHint(param1:class_1715) : String
      {
         var _loc2_:String = param1.getQuestLocalizationKey() + ".hint";
         return _localization.getLocalization(_loc2_,_loc2_);
      }
      
      public function getCampaignNameByCode(param1:String) : String
      {
         var _loc2_:String = param1 + ".name";
         return _localization.getLocalization(_loc2_,_loc2_);
      }
      
      public function getCampaignName(param1:class_1715) : String
      {
         return getCampaignNameByCode(param1.getCampaignLocalizationKey());
      }
      
      public function getAchievementCategoryName(param1:String) : String
      {
         var _loc2_:String = "quests." + param1 + ".name";
         return _localization.getLocalization(_loc2_,_loc2_);
      }
      
      public function setupQuestImage(param1:IWindowContainer, param2:class_1715) : void
      {
         var _loc3_:IStaticBitmapWrapperWindow = param1.findChildByName("quest_pic_bitmap") as IStaticBitmapWrapperWindow;
         var _loc4_:String = param2.waitPeriodSeconds > 0 ? "quest_timer_questionmark" : (param2.campaignCode + "_" + param2.localizationCode + param2.imageVersion + (isQuestWithPrompts(param2) ? "_a" : "")).toLowerCase();
         _loc3_.assetUri = "${image.library.questing.url}" + _loc4_ + ".png";
      }
      
      public function setupPromptFrameImage(param1:IWindowContainer, param2:class_1715, param3:String) : void
      {
         var _loc4_:IStaticBitmapWrapperWindow;
         (_loc4_ = param1.findChildByName("prompt_pic_" + param3) as IStaticBitmapWrapperWindow).assetUri = "${image.library.questing.url}" + (param2.campaignCode + "_" + param2.localizationCode + param2.imageVersion + "_" + param3).toLowerCase() + ".png";
      }
      
      public function setupRewardImage(param1:IWindowContainer, param2:int) : void
      {
         var _loc3_:IWindow = param1.findChildByName("currency_icon");
         _loc3_.style = class_3473.getIconStyleFor(param2,this,true);
      }
      
      public function setupCampaignImage(param1:IWindowContainer, param2:class_1715, param3:Boolean) : void
      {
         var _loc4_:IStaticBitmapWrapperWindow = param1.findChildByName("campaign_pic_bitmap") as IStaticBitmapWrapperWindow;
         if(!param3)
         {
            _loc4_.visible = false;
            return;
         }
         _loc4_.visible = true;
         var _loc5_:String = param2.campaignCode;
         if(isSeasonalQuest(param2))
         {
            _loc5_ = getSeasonalCampaignCodePrefix() + "_campaign_icon";
         }
         _loc4_.assetUri = "${image.library.questing.url}" + _loc5_ + ".png";
      }
      
      public function setupAchievementCategoryImage(param1:IWindowContainer, param2:AchievementCategory, param3:Boolean) : void
      {
         var _loc4_:IStaticBitmapWrapperWindow;
         (_loc4_ = param1.findChildByName("category_pic_bitmap") as IStaticBitmapWrapperWindow).assetUri = "${image.library.questing.url}" + (param3 ? "ach_category_" + param2.code : "achicon_" + param2.code) + ".png";
      }
      
      public function isQuestWithPrompts(param1:class_1715) : Boolean
      {
         return const_442.indexOf(param1.localizationCode) > -1;
      }
      
      public function refreshReward(param1:Boolean, param2:IWindowContainer, param3:int, param4:int) : void
      {
         param1 = param3 < 0 || param4 < 1 ? false : param1;
         var _loc5_:IWindow = param2.findChildByName("reward_caption_txt");
         var _loc6_:IWindow = param2.findChildByName("reward_amount_txt");
         var _loc7_:IWindow = param2.findChildByName("currency_icon");
         _loc6_.visible = param1;
         _loc5_.visible = param1;
         _loc7_.visible = param1;
         if(!param1)
         {
            return;
         }
         _loc6_.caption = "" + param4;
         moveChildrenToRow(param2,["reward_caption_txt","reward_amount_txt","currency_icon"],_loc5_.x,3);
         this.setupRewardImage(param2,param3);
      }
      
      public function update(param1:uint) : void
      {
         var_3213.update(param1);
         var_1995.update(param1);
      }
      
      public function getTwinkleAnimation(param1:IWindowContainer) : Animation
      {
         var _loc3_:int = 0;
         if(var_2909 == null)
         {
            var_2909 = new TwinkleImages(this);
         }
         var _loc4_:int = 800;
         var _loc2_:Animation = new Animation(IBitmapWrapperWindow(param1.findChildByName("twinkle_bitmap")));
         _loc3_ = 0;
         while(_loc3_ < 15)
         {
            _loc2_.addObject(new Twinkle(var_2909,_loc4_));
            _loc4_ += 300;
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function get currentlyInRoom() : Boolean
      {
         return _currentlyInRoom;
      }
      
      public function set currentlyInRoom(param1:Boolean) : void
      {
         _currentlyInRoom = param1;
      }
      
      public function isSeasonalCalendarEnabled() : Boolean
      {
         return var_209.getBoolean("seasonalQuestCalendar.enabled");
      }
      
      public function isSeasonalQuest(param1:class_1715) : Boolean
      {
         var _loc2_:String = getSeasonalCampaignCodePrefix();
         return _loc2_ != "" && param1.campaignCode.indexOf(_loc2_) == 0;
      }
      
      public function getSeasonalCampaignCodePrefix() : String
      {
         return getProperty("seasonalQuestCalendar.campaignPrefix");
      }
      
      public function setIsFirstLoginOfDay(param1:Boolean) : void
      {
         this.var_1560 = param1;
      }
      
      public function get isFirstLoginOfDay() : Boolean
      {
         return this.var_1560;
      }
      
      public function get configuration() : ICoreConfiguration
      {
         return var_209;
      }
      
      public function hasLocalizedValue(param1:String) : Boolean
      {
         return _localization.getLocalization(param1,"") != "";
      }
      
      public function get navigator() : IHabboNewNavigator
      {
         return _navigator;
      }
      
      public function requestSeasonalQuests() : void
      {
         send(new class_479());
      }
      
      public function requestQuests() : void
      {
         send(new class_577());
      }
      
      public function activateQuest(param1:int) : void
      {
         send(new class_429(param1));
      }
      
      public function get linkPattern() : String
      {
         return "questengine/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         switch(_loc2_[1])
         {
            case "gotorooms":
               goToQuestRooms();
               break;
            case "achievements":
               if(_loc2_.length == 3)
               {
                  var_1995.show();
                  var_1995.selectCategoryInternalLink(_loc2_[2]);
               }
               else
               {
                  showAchievements();
               }
               break;
            case "calendar":
               var_3213.seasonalCalendarWindow.onToolbarClick();
               break;
            case "quests":
               var_3213.onToolbarClick();
               break;
            default:
               class_14.log("QuestEngine unknown link-type received: " + _loc2_[1]);
         }
      }
   }
}
