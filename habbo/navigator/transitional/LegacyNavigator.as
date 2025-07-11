package com.sulake.habbo.navigator.transitional
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.navigator.GuestRoomDoorbell;
   import com.sulake.habbo.navigator.GuestRoomPasswordInput;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.HabboNewNavigator;
   import com.sulake.habbo.navigator.IHabboTransitionalNavigator;
   import com.sulake.habbo.navigator.domain.NavigatorData;
   import com.sulake.habbo.navigator.domain.Tabs;
   import com.sulake.habbo.navigator.inroom.RoomEventInfoCtrl;
   import com.sulake.habbo.navigator.inroom.RoomEventViewCtrl;
   import com.sulake.habbo.navigator.inroom.RoomInfoViewCtrl;
   import com.sulake.habbo.navigator.mainview.ITransitionalMainViewCtrl;
   import com.sulake.habbo.navigator.mainview.OfficialRoomEntryManager;
   import com.sulake.habbo.navigator.roomsettings.EnforceCategoryCtrl;
   import com.sulake.habbo.navigator.roomsettings.RoomCreateViewCtrl;
   import com.sulake.habbo.navigator.roomsettings.RoomFilterCtrl;
   import com.sulake.habbo.navigator.roomsettings.RoomSettingsCtrl;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1675;
   
   public class LegacyNavigator implements IHabboTransitionalNavigator
   {
       
      
      private var _newNavigator:HabboNewNavigator;
      
      private var var_1659:HabboNavigator;
      
      private var var_4648:FakeMainViewCtrl;
      
      private var var_3240:RoomSettingsCtrl;
      
      private var var_2271:RoomInfoViewCtrl;
      
      private var var_2473:RoomCreateViewCtrl;
      
      private var _passwordInput:GuestRoomPasswordInput;
      
      private var var_2029:GuestRoomDoorbell;
      
      private var _officialRoomEntryManager:OfficialRoomEntryManager;
      
      private var var_3027:RoomEventViewCtrl;
      
      private var var_4026:RoomEventInfoCtrl;
      
      private var var_3288:RoomFilterCtrl;
      
      private var var_3937:EnforceCategoryCtrl;
      
      public function LegacyNavigator(param1:HabboNewNavigator, param2:HabboNavigator)
      {
         super();
         _newNavigator = param1;
         var_1659 = param2;
         var_4648 = new FakeMainViewCtrl(_newNavigator,var_1659);
         var_3240 = new RoomSettingsCtrl(this);
         var_2271 = new RoomInfoViewCtrl(this);
         var_2473 = new RoomCreateViewCtrl(this);
         _passwordInput = new GuestRoomPasswordInput(this);
         var_2029 = new GuestRoomDoorbell(this);
         _officialRoomEntryManager = new OfficialRoomEntryManager(this);
         var_3027 = new RoomEventViewCtrl(this);
         var_4026 = new RoomEventInfoCtrl(this);
         var_3288 = new RoomFilterCtrl(this);
         var_3937 = new EnforceCategoryCtrl(this);
      }
      
      public function set oldNavigator(param1:HabboNavigator) : void
      {
         var_1659 = param1;
      }
      
      public function get assets() : IAssetLibrary
      {
         return var_1659.assets;
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return _newNavigator.windowManager;
      }
      
      public function get data() : NavigatorData
      {
         return var_1659.data;
      }
      
      public function get mainViewCtrl() : ITransitionalMainViewCtrl
      {
         return var_4648;
      }
      
      public function get tabs() : Tabs
      {
         return var_1659.tabs;
      }
      
      public function get roomInfoViewCtrl() : RoomInfoViewCtrl
      {
         return var_2271;
      }
      
      public function get roomCreateViewCtrl() : RoomCreateViewCtrl
      {
         return var_2473;
      }
      
      public function get communication() : IHabboCommunicationManager
      {
         return var_1659.communication;
      }
      
      public function get roomSettingsCtrl() : RoomSettingsCtrl
      {
         return var_3240;
      }
      
      public function get sessionData() : ISessionDataManager
      {
         return var_1659.sessionData;
      }
      
      public function get passwordInput() : GuestRoomPasswordInput
      {
         return var_1659.passwordInput;
      }
      
      public function get doorbell() : GuestRoomDoorbell
      {
         return var_2029;
      }
      
      public function get roomEventViewCtrl() : RoomEventViewCtrl
      {
         return var_3027;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return var_1659.localization;
      }
      
      public function get officialRoomEntryManager() : OfficialRoomEntryManager
      {
         return var_1659.officialRoomEntryManager;
      }
      
      public function get toolbar() : IHabboToolbar
      {
         return var_1659.toolbar;
      }
      
      public function get habboHelp() : IHabboHelp
      {
         return var_1659.habboHelp;
      }
      
      public function get roomEventInfoCtrl() : RoomEventInfoCtrl
      {
         return var_4026;
      }
      
      public function get roomFilterCtrl() : RoomFilterCtrl
      {
         return var_3288;
      }
      
      public function get roomSessionManager() : IRoomSessionManager
      {
         return var_1659.roomSessionManager;
      }
      
      public function get enforceCategoryCtrl() : EnforceCategoryCtrl
      {
         return var_3937;
      }
      
      public function send(param1:IMessageComposer, param2:Boolean = false) : void
      {
         return var_1659.send(param1,param2);
      }
      
      public function getXmlWindow(param1:String, param2:uint = 1) : IWindow
      {
         return var_1659.getXmlWindow(param1,param2);
      }
      
      public function getText(param1:String) : String
      {
         return var_1659.getText(param1);
      }
      
      public function registerParameter(param1:String, param2:String, param3:String) : String
      {
         return var_1659.registerParameter(param1,param2,param3);
      }
      
      public function getButton(param1:String, param2:String, param3:Function, param4:int = 0, param5:int = 0, param6:int = 0) : IBitmapWrapperWindow
      {
         return var_1659.getButton(param1,param2,param3,param4,param5,param6);
      }
      
      public function refreshButton(param1:IWindowContainer, param2:String, param3:Boolean, param4:Function, param5:int, param6:String = null) : void
      {
         return var_1659.refreshButton(param1,param2,param3,param4,param5,param6);
      }
      
      public function getButtonImage(param1:String, param2:String = "_png") : BitmapData
      {
         return var_1659.getButtonImage(param1,param2);
      }
      
      public function openCatalogClubPage(param1:String) : void
      {
         return var_1659.openCatalogClubPage(param1);
      }
      
      public function openCatalogRoomAdsPage() : void
      {
         return var_1659.openCatalogRoomAdsPage();
      }
      
      public function showFavouriteRooms() : void
      {
         return _newNavigator.performSearch("favorites");
      }
      
      public function showHistoryRooms() : void
      {
         return _newNavigator.performSearch("history");
      }
      
      public function showFrequentRooms() : void
      {
         return _newNavigator.performSearch("history_freq");
      }
      
      public function get tracking() : IHabboTracking
      {
         return var_1659.tracking;
      }
      
      public function goToMainView() : void
      {
         var_2473.hide();
      }
      
      public function reportRoomFromWeb(param1:String, param2:String = null) : void
      {
         var_1659.enterRoomWebRequest(param1,true,param2);
      }
      
      public function goToRoom(param1:int, param2:Boolean, param3:String = "", param4:int = -1) : void
      {
         var_1659.goToRoom(param1,false,param3,param4);
      }
      
      public function isPerkAllowed(param1:String) : Boolean
      {
         return var_1659.isPerkAllowed(param1);
      }
      
      public function trackGoogle(param1:String, param2:String, param3:int = -1) : void
      {
         return var_1659.trackGoogle(param1,param2,param3);
      }
      
      public function getBoolean(param1:String) : Boolean
      {
         return var_1659.getBoolean(param1);
      }
      
      public function getInteger(param1:String, param2:int) : int
      {
         return var_1659.getInteger(param1,param2);
      }
      
      public function get events() : IEventDispatcher
      {
         return _newNavigator.events;
      }
      
      public function goToHomeRoom() : Boolean
      {
         _newNavigator.goToHomeRoom();
         return true;
      }
      
      public function performTagSearch(param1:String) : void
      {
         return _newNavigator.performTagSearch(param1);
      }
      
      public function performTextSearch(param1:String) : void
      {
         return _newNavigator.performTextSearch(param1);
      }
      
      public function performGuildBaseSearch() : void
      {
         return _newNavigator.performSearch("groups");
      }
      
      public function performCompetitionRoomsSearch(param1:int, param2:int) : void
      {
         return _newNavigator.performSearch("competition");
      }
      
      public function showOwnRooms() : void
      {
         return _newNavigator.performSearch("myworld_view");
      }
      
      public function goToPrivateRoom(param1:int) : void
      {
         _newNavigator.goToRoom(param1);
      }
      
      public function hasRoomRightsButIsNotOwner(param1:int) : Boolean
      {
         return var_1659.hasRoomRightsButIsNotOwner(param1);
      }
      
      public function removeRoomRights(param1:int) : void
      {
         return var_1659.removeRoomRights(param1);
      }
      
      public function goToRoomNetwork(param1:int, param2:Boolean) : void
      {
         return goToRoomNetwork(param1,param2);
      }
      
      public function startRoomCreation() : void
      {
         return _newNavigator.createRoom();
      }
      
      public function openNavigator(param1:Point = null) : void
      {
         return _newNavigator.open();
      }
      
      public function closeNavigator() : void
      {
         return _newNavigator.close();
      }
      
      public function get homeRoomId() : int
      {
         return var_1659.homeRoomId;
      }
      
      public function get enteredGuestRoomData() : class_1675
      {
         return var_1659.enteredGuestRoomData;
      }
      
      public function showToolbarHover(param1:Point) : void
      {
      }
      
      public function hideToolbarHover(param1:Boolean) : void
      {
      }
      
      public function toggleRoomInfoVisibility() : void
      {
         if(var_2271)
         {
            var_2271.toggle();
         }
      }
      
      public function canRateRoom() : Boolean
      {
         return var_1659.canRateRoom();
      }
      
      public function queueInterface(param1:IID, param2:Function = null) : IUnknown
      {
         return _newNavigator.queueInterface(param1,param2);
      }
      
      public function release(param1:IID) : uint
      {
         return _newNavigator.release(param1);
      }
      
      public function dispose() : void
      {
         var_3240.dispose();
         var_2271.dispose();
         var_2473.dispose();
         _passwordInput.dispose();
         var_2029.dispose();
         _officialRoomEntryManager.dispose();
         var_3027.dispose();
         var_4026.dispose();
         var_3288.dispose();
         var_3937 = null;
         var_1659 = null;
         _newNavigator = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_1659 == null;
      }
      
      public function openCatalogRoomAdsExtendPage(param1:String, param2:String, param3:Date, param4:int) : void
      {
         return var_1659.openCatalogRoomAdsExtendPage(param1,param2,param3,param4);
      }
      
      public function getProperty(param1:String, param2:Dictionary = null) : String
      {
         return var_1659.getProperty(param1,param2);
      }
      
      public function trackNavigationDataPoint(param1:String, param2:String, param3:String = "", param4:int = 0) : void
      {
         return var_1659.trackNavigationDataPoint(param1,param2,param3,param4);
      }
      
      public function isRoomFavorite(param1:int) : Boolean
      {
         return var_1659.isRoomFavorite(param1);
      }
      
      public function isRoomHome(param1:int) : Boolean
      {
         return var_1659.isRoomHome(param1);
      }
      
      public function get visibleEventCategories() : Array
      {
         return var_1659.data.visibleEventCategories;
      }
      
      public function get roomSettingsControl() : RoomSettingsCtrl
      {
         return var_1659.roomSettingsCtrl;
      }
   }
}
