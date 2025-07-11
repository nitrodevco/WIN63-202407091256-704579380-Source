package com.sulake.habbo.campaign
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.habbo.campaign.calendar.CalendarView;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.class_3499;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.furniture.class_3365;
   import com.sulake.habbo.session.product.class_3423;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   import com.sulake.habbo.communication.messages.incoming.campaign.class_712;
   import com.sulake.habbo.communication.messages.incoming.campaign.class_961;
   import com.sulake.habbo.communication.messages.parser.campaign.class_1115;
   import com.sulake.habbo.communication.messages.parser.campaign.class_1499;
   import com.sulake.habbo.communication.messages.parser.campaign.class_1641;
   import com.sulake.habbo.communication.messages.outgoing.campaign.class_375;
   import com.sulake.habbo.communication.messages.outgoing.campaign.class_631;
   
   public class HabboCampaigns extends Component implements ILinkEventTracker
   {
       
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var _localizationManager:IHabboLocalizationManager;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _catalog:IHabboCatalog;
      
      private var _roomEngine:IRoomEngine;
      
      private var var_2446:CalendarView;
      
      private var var_2067:class_1641;
      
      private var var_3081:int = -1;
      
      private var var_4083:Boolean = false;
      
      public function HabboCampaigns(param1:IContext, param2:uint, param3:IAssetLibrary)
      {
         super(param1,param2,param3);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         },true),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManager):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         }),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         if(false && var_4083)
         {
            var_2067 = new class_1641();
            var_2067.campaignDays = 24;
            var_2067.currentDay = 5;
            var_2067.campaignName = "summer";
            var_2067.openedDays = new <int>[0,1];
            var_2067.missedDays = new <int>[2,3];
            showCalendar();
         }
         _communicationManager.addHabboConnectionMessageEvent(new class_712(onCampaignCalendarDataMessageEvent));
         _communicationManager.addHabboConnectionMessageEvent(new class_961(onCampaignCalendarDoorOpenedMessageEvent));
         context.addLinkEventTracker(this);
      }
      
      private function onCampaignCalendarDataMessageEvent(param1:class_712) : void
      {
         if(false && var_4083)
         {
            return;
         }
         var _loc2_:class_1499 = param1.getParser();
         var_2067 = _loc2_.cloneData();
      }
      
      private function onCampaignCalendarDoorOpenedMessageEvent(param1:class_961) : void
      {
         var _loc2_:class_1115 = param1.getParser();
         if(_loc2_.doorOpened)
         {
            showProductNotification(_loc2_.productName,_loc2_.customImage,_loc2_.furnitureClassName);
         }
      }
      
      public function openPackage(param1:int) : void
      {
         var_3081 = param1;
         if(false && var_4083)
         {
            showProductNotification("A1 KUMIANKKA","","duck");
         }
         else
         {
            _communicationManager.connection.send(new class_631(var_2067.campaignName,param1));
         }
      }
      
      public function openPackageAsStaff(param1:int) : void
      {
         var_3081 = param1;
         if(false && var_4083)
         {
            showProductNotification("hween_c15_evilcrystal2","targetedoffers/web_offer_credits_small.png","hween_c15_evilcrystal2");
         }
         else
         {
            _communicationManager.connection.send(new class_375(var_2067.campaignName,param1));
         }
      }
      
      private function showProductNotification(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:class_3423;
         if((_loc4_ = _sessionDataManager.getProductData(param1)) != null)
         {
            var_2067.openedDays.push(var_3081);
            var_3081 = -1;
            if(param2 && param2 != "")
            {
               var_2446.setReceivedProduct(_loc4_,getImageGalleryUrl() + param2);
            }
            else if(param3 && param3 != "")
            {
               var_2446.setReceivedProduct(_loc4_);
               requestIconFromRoomEngine(var_2446,param3);
            }
         }
      }
      
      private function requestIconFromRoomEngine(param1:IGetImageListener, param2:String) : class_3499
      {
         var _loc3_:class_3499 = null;
         var _loc4_:class_3365 = null;
         if(_loc4_ = _sessionDataManager.getFloorItemDataByName(param2))
         {
            _loc3_ = _roomEngine.getFurnitureIcon(_loc4_.id,param1);
         }
         else if(_loc4_ = _sessionDataManager.getWallItemDataByName(param2))
         {
            _loc3_ = _roomEngine.getWallItemIcon(_loc4_.id,param1);
         }
         if(_loc3_ && _loc3_.data)
         {
            param1.imageReady(_loc3_.id,_loc3_.data);
         }
         return _loc3_;
      }
      
      public function get linkPattern() : String
      {
         return "openView/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         if(_loc2_[1] == "calendar")
         {
            showCalendar();
         }
      }
      
      private function showCalendar() : void
      {
         if(!var_2446 && var_2067)
         {
            var_2446 = new CalendarView(this,_windowManager);
         }
      }
      
      public function hideCalendar() : void
      {
         if(var_2446)
         {
            var_2446.dispose();
            var_2446 = null;
         }
      }
      
      private function getImageGalleryUrl() : String
      {
         return getProperty("image.library.url");
      }
      
      public function get calendarData() : class_1641
      {
         return var_2067;
      }
      
      public function get isAnyRoomController() : Boolean
      {
         return _sessionDataManager.isAnyRoomController;
      }
      
      public function get localizationManager() : IHabboLocalizationManager
      {
         return _localizationManager;
      }
   }
}
