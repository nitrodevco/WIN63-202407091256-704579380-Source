package com.sulake.habbo.notifications
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.event.CatalogEvent;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.inventory.class_1814;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.notifications.feed.NotificationController;
   import com.sulake.habbo.notifications.singular.SingularNotificationController;
   import com.sulake.habbo.notifications.utils.PetImageUtility;
   import com.sulake.habbo.notifications.utils.ProductImageUtility;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboFriendList;
   import com.sulake.iid.IIDHabboHelp;
   import com.sulake.iid.IIDHabboInventory;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.display.BitmapData;
   import adobe.serialization.json.JSONDecoder;
   import com.sulake.habbo.communication.messages.outgoing.users.GetMOTDMessageComposer;
   
   public class HabboNotifications extends Component implements IHabboNotifications
   {
       
      
      private var _communication:IHabboCommunicationManager;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _inventory:class_1814;
      
      private var _friendList:IHabboFriendList;
      
      private var _roomEngine:IRoomEngine;
      
      private var _catalog:IHabboCatalog;
      
      private var _toolBar:IHabboToolbar;
      
      private var var_2772:ProductImageUtility;
      
      private var var_2769:PetImageUtility;
      
      private var _roomSessionManager:IRoomSessionManager;
      
      private var _habboHelp:IHabboHelp;
      
      private var var_3025:NotificationController;
      
      private var var_3563:SingularNotificationController;
      
      private var var_3488:class_3353;
      
      private var var_3617:Boolean;
      
      public function HabboNotifications(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         super(param1,param2,param3);
         var_3617 = false;
      }
      
      public function get assetLibrary() : IAssetLibrary
      {
         return assets;
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return _windowManager;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localization;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get roomSessionManager() : IRoomSessionManager
      {
         return _roomSessionManager;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function get toolBar() : IHabboToolbar
      {
         return _toolBar;
      }
      
      public function get habboHelp() : IHabboHelp
      {
         return _habboHelp;
      }
      
      public function get singularController() : SingularNotificationController
      {
         return var_3563;
      }
      
      public function get feedController() : NotificationController
      {
         return var_3025;
      }
      
      public function get disabled() : Boolean
      {
         return var_3617;
      }
      
      public function set disabled(param1:Boolean) : void
      {
         var_3617 = param1;
      }
      
      public function get productImageUtility() : ProductImageUtility
      {
         if(_roomEngine == null || _inventory == null)
         {
            return null;
         }
         if(var_2772 == null)
         {
            var_2772 = new ProductImageUtility(_roomEngine,_inventory);
         }
         return var_2772;
      }
      
      public function get petImageUtility() : PetImageUtility
      {
         if(_roomEngine == null)
         {
            return null;
         }
         if(var_2769 == null)
         {
            var_2769 = new PetImageUtility(_roomEngine);
         }
         return var_2769;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboInventory(),function(param1:class_1814):void
         {
            _inventory = param1;
         },false),new ComponentDependency(new IIDHabboFriendList(),function(param1:IHabboFriendList):void
         {
            _friendList = param1;
         },false),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },false),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         },false,[{
            "type":"CATALOG_BUILDER_MEMBERSHIP_EXPIRED",
            "callback":onBuilderMembershipExpired
         },{
            "type":"CATALOG_BUILDER_MEMBERSHIP_IN_GRACE",
            "callback":onBuilderMembershipInGrace
         },{
            "type":"COLLECTIBLES_CLAIM_FAIL",
            "callback":onCollectiblesClaimFail
         },{
            "type":"COLLECTIBLE_CLAIM_SUCCESS",
            "callback":onCollectiblesClaimSuccess
         },{
            "type":"COLLECTIBLE_CLAIM_WAIT",
            "callback":onCollectiblesClaimWait
         },{
            "type":"COLLECTIBLES_MINT_FAIL",
            "callback":onCollectiblesMintFail
         },{
            "type":"COLLECTIBLES_MINT_SUCCESS",
            "callback":onCollectiblesMintSuccess
         }]),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolBar = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManager):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboRoomSessionManager(),function(param1:IRoomSessionManager):void
         {
            _roomSessionManager = param1;
         },false),new ComponentDependency(new IIDHabboHelp(),function(param1:IHabboHelp):void
         {
            _habboHelp = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         var_3563 = new SingularNotificationController(this);
         var_3488 = new class_3353(this,_communication);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(var_3488 != null)
         {
            var_3488.dispose();
            var_3488 = null;
         }
         if(var_3025 != null)
         {
            var_3025.dispose();
            var_3025 = null;
         }
         if(var_2769 != null)
         {
            var_2769.dispose();
            var_2769 = null;
         }
         if(var_2772 != null)
         {
            var_2772.dispose();
            var_2772 = null;
         }
         super.dispose();
      }
      
      public function activate() : void
      {
         if(var_3025 != null)
         {
            var_3025.setFeedEnabled(true);
         }
         _communication.connection.send(new GetMOTDMessageComposer());
      }
      
      public function addSongPlayingNotification(param1:String, param2:String) : void
      {
         var_3563.addSongPlayingNotification(param1,param2);
      }
      
      public function addItem(param1:String, param2:String, param3:String = null) : void
      {
         var _loc4_:BitmapData = null;
         if(param3 != null)
         {
            _loc4_ = (assets.getAssetByName(param3).content as BitmapData).clone();
         }
         var_3563.addItem(param1,param2,_loc4_);
      }
      
      public function showNotification(param1:String, param2:Map = null) : void
      {
         var _loc7_:Object = null;
         var _loc9_:String = null;
         var _loc6_:String = null;
         var _loc3_:Boolean = false;
         var _loc5_:String = null;
         if(param2 == null)
         {
            param2 = new Map();
         }
         var _loc4_:String = "notification." + param1;
         if(propertyExists(_loc4_))
         {
            _loc7_ = new JSONDecoder(getProperty(_loc4_),true).getValue();
            for(var _loc8_ in _loc7_)
            {
               param2[_loc8_] = _loc7_[_loc8_];
            }
         }
         if(param2["display"] == "BUBBLE")
         {
            _loc9_ = getNotificationPart(param2,param1,"message",true);
            _loc3_ = (_loc6_ = getNotificationPart(param2,param1,"linkUrl",false)) != null && _loc6_.substr(0,6) == "event:";
            _loc5_ = getNotificationImageUrl(param2,param1);
            var_3563.addItem(_loc9_,"info",null,_loc5_,null,_loc3_ ? _loc6_.substr(6) : _loc6_);
         }
         else
         {
            new NotificationPopup(this,param1,param2);
         }
      }
      
      public function getNotificationPart(param1:Map, param2:String, param3:String, param4:Boolean) : String
      {
         var _loc5_:String = null;
         if(param1.hasKey(param3))
         {
            return param1.getValue(param3);
         }
         _loc5_ = ["notification",param2,param3].join(".");
         if(localization.hasLocalization(_loc5_) || param4)
         {
            return localization.getLocalizationWithParamMap(_loc5_,_loc5_,param1);
         }
         return null;
      }
      
      public function getNotificationImageUrl(param1:Map, param2:String) : String
      {
         var _loc3_:String = param1.getValue("image");
         if(_loc3_ == null)
         {
            _loc3_ = "${image.library.url}notifications/" + param2.replace(/\./g,"_") + ".png";
         }
         return _loc3_;
      }
      
      private function onBuilderMembershipInGrace(param1:CatalogEvent) : void
      {
         showNotification("builders_club.membership_in_grace",null);
      }
      
      private function onBuilderMembershipExpired(param1:CatalogEvent) : void
      {
         showNotification("builders_club.membership_expired",null);
      }
      
      private function onCollectiblesClaimFail(param1:CatalogEvent) : void
      {
         addItem(localization.getLocalization("collectibles.claiming.failed"),"info","icon_curator_stamp_large_png");
      }
      
      private function onCollectiblesClaimSuccess(param1:CatalogEvent) : void
      {
         addItem(localization.getLocalization("collectibles.claiming.success"),"info","icon_curator_stamp_large_png");
      }
      
      private function onCollectiblesClaimWait(param1:CatalogEvent) : void
      {
         addItem(localization.getLocalization("collectibles.claiming.wait"),"info","icon_curator_stamp_large_png");
      }
      
      private function onCollectiblesMintFail(param1:CatalogEvent) : void
      {
         addItem(localization.getLocalization("shop.minting.failed"),"info","icon_curator_stamp_large_png");
      }
      
      private function onCollectiblesMintSuccess(param1:CatalogEvent) : void
      {
         addItem(localization.getLocalization("shop.minting.success"),"info","icon_curator_stamp_large_png");
      }
      
      public function createLinkEvent(param1:String) : void
      {
         context.createLinkEvent(param1);
      }
   }
}
