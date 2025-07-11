package com.sulake.habbo.navigator
{
    import assets.class_14

    import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.navigator.cache.NavigatorCache;
   import com.sulake.habbo.navigator.context.ContextContainer;
   import com.sulake.habbo.navigator.context.SearchContext;
   import com.sulake.habbo.navigator.context.SearchContextHistoryManager;
   import com.sulake.habbo.navigator.domain.NavigatorData;
   import com.sulake.habbo.navigator.lift.LiftDataContainer;
   import com.sulake.habbo.navigator.transitional.LegacyNavigator;
   import com.sulake.habbo.navigator.view.NavigatorView;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.PerksUpdatedEvent;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.utils.Base64;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboHelp;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboTracking;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.geom.Point;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1675;
   import com.sulake.habbo.communication.messages.parser.newnavigator.class_1145;
   import com.sulake.habbo.communication.messages.parser.newnavigator.class_1264;
   import com.sulake.habbo.communication.messages.parser.newnavigator.class_1323;
   import com.sulake.habbo.communication.messages.parser.newnavigator.class_1530;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.class_1652;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.class_1706;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.class_1770;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.class_3439;
   import com.sulake.habbo.communication.messages.outgoing.preferences.class_435;
   import com.sulake.habbo.communication.messages.outgoing.navigator.class_387;
   import com.sulake.habbo.communication.messages.outgoing.navigator.class_553;
   import com.sulake.habbo.communication.messages.outgoing.newnavigator.NavigatorRemoveCollapsedCategoryMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.newnavigator.NavigatorSetSearchCodeViewModeMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.newnavigator.class_179;
   import com.sulake.habbo.communication.messages.outgoing.newnavigator.class_225;
   import com.sulake.habbo.communication.messages.outgoing.newnavigator.class_687;
   import com.sulake.habbo.communication.messages.outgoing.newnavigator.class_901;
   import com.sulake.habbo.communication.messages.outgoing.newnavigator.class_990;
   import com.sulake.habbo.communication.messages.incoming.users.class_1199;
   import com.sulake.habbo.communication.messages.outgoing.users.class_201;
   import com.sulake.habbo.communication.messages.outgoing.users.class_322;
   
   public class HabboNewNavigator extends Component implements IHabboNewNavigator, ILinkEventTracker
   {
       
      
      private var _communication:IHabboCommunicationManager;
      
      private var _roomSessionManager:IRoomSessionManager;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _sessionData:ISessionDataManager;
      
      private var _tracking:IHabboTracking;
      
      private var _catalog:IHabboCatalog;
      
      private var _habboHelp:IHabboHelp;
      
      private var _avatarManager:IAvatarRenderManager;
      
      private var var_2938:NewIncomingMessages;
      
      private var _toolbar:IHabboToolbar;
      
      private var var_1659:HabboNavigator;
      
      private var var_2377:LegacyNavigator;
      
      private var var_78:Boolean = false;
      
      private var var_1760:NavigatorView;
      
      private var var_2904:ContextContainer;
      
      private var var_4081:LiftDataContainer;
      
      private var var_3469:SearchContextHistoryManager;
      
      private var _currentResults:class_3439;
      
      private var _groupDetails:Map;
      
      private var var_3525:Map;
      
      private var var_660:Vector.<String>;
      
      private var _navigatorCache:NavigatorCache;
      
      private var var_3900:String = "official_view";
      
      private var var_3744:String = "";
      
      private var var_4565:String = "";
      
      private var var_3618:Boolean = false;
      
      private var _noPushToHistoryDueToNavigation:Boolean = false;
      
      public function HabboNewNavigator(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         _groupDetails = new Map();
         var_3525 = new Map();
         var_660 = new Vector.<String>(0);
         super(param1,param2,param3);
         var_2377 = new LegacyNavigator(this,var_1659);
      }
      
      public static function getEventLogExtraStringFromSearch(param1:String, param2:String) : String
      {
         return param1 + (param2 == "" ? "" : ":" + param2);
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return _windowManager;
      }
      
      public function get communication() : IHabboCommunicationManager
      {
         return _communication;
      }
      
      public function get sessionData() : ISessionDataManager
      {
         return _sessionData;
      }
      
      public function get roomSessionManager() : IRoomSessionManager
      {
         return _roomSessionManager;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localization;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDHabboRoomSessionManager(),function(param1:IRoomSessionManager):void
         {
            _roomSessionManager = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         },false,[{
            "type":"HTE_TOOLBAR_CLICK",
            "callback":onHabboToolbarEvent
         }]),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         },false),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionData = param1;
         },true,[{
            "type":"PUE_perks_updated",
            "callback":onPerksUpdated
         }]),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManager):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboTracking(),function(param1:IHabboTracking):void
         {
            _tracking = param1;
         }),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:IAvatarRenderManager):void
         {
            _avatarManager = param1;
         }),new ComponentDependency(new IIDHabboHelp(),function(param1:IHabboHelp):void
         {
            _habboHelp = param1;
         },false),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboNavigator(),function(param1:IHabboNavigator):void
         {
            var_1659 = HabboNavigator(param1);
            if(var_2377)
            {
               var_2377.oldNavigator = var_1659;
            }
         },true)]);
      }
      
      override protected function initComponent() : void
      {
         var_2938 = new NewIncomingMessages(this);
         context.addLinkEventTracker(this);
         var_1760 = new NavigatorView(this);
         var_2904 = new ContextContainer(this);
         var_3469 = new SearchContextHistoryManager(this);
         var_4081 = new LiftDataContainer(this);
         _navigatorCache = new NavigatorCache();
         _communication.connection.send(new class_990());
         var_78 = true;
      }
      
      private function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.type == "HTE_TOOLBAR_CLICK")
         {
            var _loc2_:* = param1.iconId;
            if("HTIE_ICON_NAVIGATOR" === _loc2_)
            {
               toggle();
            }
         }
      }
      
      public function initialize(param1:class_1145) : void
      {
         var_2904.initialize(param1);
      }
      
      public function onSearchResult(param1:class_3439) : void
      {
         var_3618 = false;
         _currentResults = param1;
         extractRoomNamesFromResults(param1.resultSet);
         if(!_noPushToHistoryDueToNavigation)
         {
            var_3469.addSearchContextAtCurrentOffset(new SearchContext(param1.searchCodeOriginal,param1.filteringData));
         }
         _navigatorCache.put(param1.searchCodeOriginal + "/" + param1.filteringData,param1);
         _noPushToHistoryDueToNavigation = false;
         if(var_1760.visible)
         {
            var_1760.onSearchResults(param1,var_4565);
         }
      }
      
      private function extractRoomNamesFromResults(param1:class_1652) : void
      {
         var_3525 = new Map();
         for each(var _loc2_ in param1.blocks)
         {
            for each(var _loc3_ in _loc2_.guestRooms)
            {
               var_3525.add(_loc3_.flatId,_loc3_.roomName);
            }
         }
      }
      
      public function get newResultsRendered() : Boolean
      {
         return var_3618;
      }
      
      public function set newResultsRendered(param1:Boolean) : void
      {
         var_3618 = param1;
      }
      
      public function onLiftedRooms(param1:class_1530) : void
      {
         var_4081.setLiftedRooms(param1.liftedRooms);
         var_1760.refreshLiftedRooms();
      }
      
      public function onPreferences(param1:class_1323) : void
      {
         var_1760.setInitialWindowDimensions(param1.windowX,param1.windowY,param1.windowHeight,param1.leftPaneHidden,param1.resultsMode);
      }
      
      public function onSavedSearches(param1:class_1264) : void
      {
         var_2904.savedSearches = param1.savedSearches.concat(new Vector.<class_1706>(0));
         var_1760.onSavedSearches(var_2904.savedSearches);
      }
      
      public function onGroupDetails(param1:class_1199) : void
      {
         if(_groupDetails.hasKey(param1.groupId))
         {
            _groupDetails.remove(param1.groupId);
         }
         _groupDetails.add(param1.groupId,param1);
         var_1760.onGroupDetailsArrived(param1.groupId);
      }
      
      public function onCollapsedCategories(param1:Vector.<String>) : void
      {
         var_660 = param1.concat();
      }
      
      public function get collapsedCategories() : Vector.<String>
      {
         return var_660;
      }
      
      public function getCachedGroupDetails(param1:int) : class_1199
      {
         return _groupDetails.getValue(param1);
      }
      
      public function goBack() : void
      {
         if(var_3469.hasPrevious)
         {
            _noPushToHistoryDueToNavigation = true;
            performSearchByContext(var_3469.getPreviousSearchContextAndGoBack());
         }
         trackEventLog("browse.back","Results");
      }
      
      public function performLastSearch() : void
      {
         if(var_3900 != null && var_3744 != null)
         {
            _navigatorCache.removeEntry(var_3900 + "/" + var_3744);
            performSearch(var_3900,var_3744);
         }
      }
      
      public function performSearch(param1:String, param2:String = "", param3:String = "") : void
      {
         var_1760.isBusy = true;
         var_4565 = param3;
         var _loc4_:class_3439;
         if((_loc4_ = _navigatorCache.getEntry(param1 + "/" + param2)) != null)
         {
            onSearchResult(_loc4_);
         }
         else
         {
            var_3900 = param1;
            var_3744 = param2;
            _communication.connection.send(new class_901(param1,param2));
            trackEventLog("search","Search",getEventLogExtraStringFromSearch(param1,param2));
         }
         open();
      }
      
      public function performSearchByContext(param1:SearchContext) : void
      {
         performSearch(param1.searchCode,param1.filtering);
      }
      
      public function addSavedSearch(param1:String, param2:String) : void
      {
         if(_currentResults != null)
         {
            _communication.connection.send(new class_179(param1,param2));
         }
         trackEventLog("savedsearch.add","SavedSearch",getEventLogExtraStringFromSearch(param1,param2));
         var_1760.setLeftPaneVisibility(true);
      }
      
      public function deleteSavedSearch(param1:int) : void
      {
         _communication.connection.send(new class_225(param1));
         trackEventLog("savedsearch.delete","SavedSearch");
      }
      
      private function onPerksUpdated(param1:PerksUpdatedEvent) : void
      {
         if(!_sessionData.isPerkAllowed("NAVIGATOR_PHASE_TWO_2014"))
         {
            context.removeLinkEventTracker(this);
            if(var_78)
            {
               var_2938.removeLegacyMessageListeners();
               close();
            }
            return;
         }
         if(!var_78)
         {
            initComponent();
         }
         else if(_sessionData.isPerkAllowed("NAVIGATOR_PHASE_TWO_2014"))
         {
            var_2938.addMessageListeners();
         }
      }
      
      public function get linkPattern() : String
      {
         return "navigator/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         switch(_loc2_[1])
         {
            case "goto":
               if(_loc2_.length > 2)
               {
                  var _loc4_:* = _loc2_[2];
                  if("home" !== _loc4_)
                  {
                     _loc3_ = int(_loc2_[2]);
                     if(_loc3_ > 0)
                     {
                        var_2377.goToPrivateRoom(_loc3_);
                     }
                     else
                     {
                        communication.connection.send(new class_387(_loc2_[2]));
                     }
                  }
                  else
                  {
                     var_2377.goToHomeRoom();
                  }
               }
               break;
            case "search":
               if(_loc2_.length > 2)
               {
                  performSearch("hotel_view",_loc2_[2]);
               }
               break;
            case "tag":
               if(_loc2_.length > 2)
               {
                  performSearch("hotel_view",_loc2_[2]);
               }
               break;
            case "tab":
               if(_loc2_.length > 2)
               {
                  performSearch(_loc2_[2]);
               }
               break;
            case "report":
               if(_loc2_.length > 3)
               {
                  var_2377.reportRoomFromWeb(_loc2_[2],Base64.decode(_loc2_[3]));
               }
               break;
            default:
               class_14.log("Navigator unknown link-type received: " + _loc2_[1]);
         }
      }
      
      public function showOwnRooms() : void
      {
      }
      
      public function showToolbarHover(param1:Point) : void
      {
      }
      
      public function hideToolbarHover(param1:Boolean) : void
      {
      }
      
      public function get isReady() : Boolean
      {
         return var_2904 != null && var_2904.isReady();
      }
      
      public function get contextContainer() : ContextContainer
      {
         return var_2904;
      }
      
      public function get searchContextHistoryManager() : SearchContextHistoryManager
      {
         return var_3469;
      }
      
      public function get liftDataContainer() : LiftDataContainer
      {
         return var_4081;
      }
      
      public function get currentResults() : class_3439
      {
         return _currentResults;
      }
      
      public function goToRoom(param1:int, param2:String = "mainview") : void
      {
         communication.connection.send(new class_553(param1,false,true));
         var_1760.visible = false;
         var _loc3_:String = var_3525.getValue(param1);
         trackEventLog("go",param2,!_loc3_ ? "" : _loc3_,param1);
      }
      
      public function getExtendedProfile(param1:int) : void
      {
         communication.connection.send(new class_322(param1));
      }
      
      public function get imageLibraryBaseUrl() : String
      {
         return context.configuration.getProperty("image.library.url");
      }
      
      public function performTagSearch(param1:String) : void
      {
         performSearch("hotel_view","tag:" + param1);
      }
      
      public function createRoom() : void
      {
         var_2377.roomCreateViewCtrl.show();
      }
      
      public function open() : void
      {
         if(var_1760 == null)
         {
            return;
         }
         if(!var_1760.visible)
         {
            var_1760.visible = true;
         }
      }
      
      public function close() : void
      {
         if(var_1760.visible)
         {
            var_1760.visible = false;
         }
      }
      
      public function toggle() : void
      {
         if(var_1760 == null)
         {
            return;
         }
         var_1760.visible = !var_1760.visible;
         if(var_1760.visible)
         {
            performLastSearch();
         }
      }
      
      public function get mainWindow() : class_3514
      {
         return var_1760.mainWindow;
      }
      
      public function refresh() : void
      {
         if(_currentResults)
         {
            var_1760.onSearchResults(_currentResults);
         }
      }
      
      public function get legacyNavigator() : IHabboNavigator
      {
         return var_2377;
      }
      
      public function get data() : NavigatorData
      {
         return var_2377.data;
      }
      
      public function sendWindowPreferences(param1:int, param2:int, param3:int, param4:int, param5:Boolean, param6:int) : void
      {
         _communication.connection.send(new class_435(param1,param2,param3,param4,param5,param6));
      }
      
      public function getGuildInfo(param1:int, param2:Boolean = true) : void
      {
         _communication.connection.send(new class_201(param1,param2));
      }
      
      public function sendAddCollapsedCategory(param1:String) : void
      {
         _communication.connection.send(new class_687(param1));
      }
      
      public function sendRemoveCollapsedCategory(param1:String) : void
      {
         _communication.connection.send(new NavigatorRemoveCollapsedCategoryMessageComposer(param1));
      }
      
      public function goToHomeRoom() : void
      {
         goToRoom(var_2377.data.homeRoomId,"external");
      }
      
      public function trackEventLog(param1:String, param2:String, param3:String = "", param4:int = 0) : void
      {
         if(_tracking)
         {
            _tracking.trackEventLog("NewNavigator",param2,param1,param3,param4);
         }
      }
      
      public function get view() : NavigatorView
      {
         return var_1760;
      }
      
      public function toggleSearchCodeViewMode(param1:String, param2:int) : void
      {
         _communication.connection.send(new NavigatorSetSearchCodeViewModeMessageComposer(param1,param2));
         trackEventLog("browse.toggleviewmode","ViewMode","",param2);
      }
      
      public function get habboHelp() : IHabboHelp
      {
         return _habboHelp;
      }
      
      public function performTextSearch(param1:String) : void
      {
      }
      
      public function performGuildBaseSearch() : void
      {
      }
      
      public function performCompetitionRoomsSearch(param1:int, param2:int) : void
      {
      }
   }
}
