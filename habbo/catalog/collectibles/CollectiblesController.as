package com.sulake.habbo.catalog.collectibles
{
    import assets.class_14

    import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.collectibles.renderer.model.IRenderableCollectibleItem;
   import com.sulake.habbo.catalog.purse.PurseEvent;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.class_1809;
   import com.sulake.habbo.freeflowchat.data.ChatItem;
   import com.sulake.habbo.freeflowchat.viewer.visualization.PooledChatBubble;
   import com.sulake.habbo.freeflowchat.viewer.visualization.style.ChatStyle;
   import com.sulake.habbo.inventory.class_1814;
   import com.sulake.habbo.inventory.events.HabboInventoryCategoryInitializeEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.notifications.IHabboNotifications;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.class_3499;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.RoomSessionChatEvent;
   import com.sulake.habbo.session.furniture.class_3365;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboFreeFlowChat;
   import com.sulake.iid.IIDHabboInventory;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNotifications;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.utils.getTimer;
   
   public class CollectiblesController extends Component implements ILinkEventTracker, class_3479
   {
       
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var _localizationManager:IHabboLocalizationManager;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _avatarRenderManager:IAvatarRenderManager;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _freeFlowChat:class_1809;
      
      private var _inventory:class_1814;
      
      private var _notifications:IHabboNotifications;
      
      private var _roomEngine:IRoomEngine;
      
      private var _catalog:IHabboCatalog;
      
      private var var_1631:CollectiblesView;
      
      private var var_318:Boolean = false;
      
      private var var_4726:int = -1;
      
      private var var_4696:String = "";
      
      private var var_2173:int = 0;
      
      public function CollectiblesController(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
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
         }),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },false),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         }),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:IAvatarRenderManager):void
         {
            _avatarRenderManager = param1;
         }),new ComponentDependency(new IIDHabboFreeFlowChat(),function(param1:class_1809):void
         {
            _freeFlowChat = param1;
         }),new ComponentDependency(new IIDHabboNotifications(),function(param1:IHabboNotifications):void
         {
            _notifications = param1;
         }),new ComponentDependency(new IIDHabboInventory(),function(param1:class_1814):void
         {
            _inventory = param1;
         },false,[{
            "type":"HABBO_INVENTORY_CATEGORY_INITIALIZED",
            "callback":onInventoryInitialize
         }])]);
      }
      
      override protected function initComponent() : void
      {
         context.addLinkEventTracker(this);
         _catalog.events.addEventListener("catalog_purse_emerald_balance",onEmeraldBalance);
         _catalog.events.addEventListener("catalog_purse_silver_balance",onSilverBalance);
      }
      
      override public function dispose() : void
      {
         if(!var_318)
         {
            if(_catalog)
            {
               if(_catalog.events)
               {
                  _catalog.events.removeEventListener("catalog_purse_emerald_balance",onEmeraldBalance);
                  _catalog.events.removeEventListener("catalog_purse_silver_balance",onSilverBalance);
               }
               _catalog = null;
            }
            if(var_1631)
            {
               var_1631.dispose();
               var_1631 = null;
            }
            _communicationManager = null;
            _sessionDataManager = null;
            _windowManager = null;
            _localizationManager = null;
            _roomEngine = null;
            var_318 = true;
         }
         super.dispose();
      }
      
      private function onEmeraldBalance(param1:PurseEvent) : void
      {
         updateView();
      }
      
      public function onSilverBalance(param1:PurseEvent) : void
      {
         updateView();
      }
      
      private function updateView() : void
      {
         if(var_1631)
         {
            var_1631.updateBalances(_catalog.getPurse());
         }
      }
      
      public function send(param1:IMessageComposer) : void
      {
         _communicationManager.connection.send(param1);
      }
      
      public function addMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _communicationManager.addHabboConnectionMessageEvent(param1);
      }
      
      public function removeMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _communicationManager.removeHabboConnectionMessageEvent(param1);
      }
      
      public function getProductName(param1:IRenderableCollectibleItem) : String
      {
         var _loc2_:class_3365 = null;
         _loc2_ = null;
         switch(param1.productTypeId - -1)
         {
            case 0:
               return "unknown";
            case 1:
               _loc2_ = _sessionDataManager.getWallItemData(parseInt(param1.itemTypeId));
               if(_loc2_ == null)
               {
                  return "(missing wall item)";
               }
               return _loc2_.localizedName;
               break;
            case 2:
            case 12:
               _loc2_ = _sessionDataManager.getFloorItemData(parseInt(param1.itemTypeId));
               if(_loc2_ == null)
               {
                  return "(missing floor item)";
               }
               return _loc2_.localizedName;
               break;
            case 3:
               return localizationManager.getLocalization("fx_" + param1.itemTypeId);
            case 5:
               return localizationManager.getBadgeName(param1.itemTypeId);
            case 10:
               return localizationManager.getLocalization("product.type.chatstyle");
            case 11:
               return localizationManager.getLocalization("pet.type." + param1.itemTypeId);
            default:
               class_14.log("[CollectiblesController] Can not yet handle this type of product: ");
               return "(missing)";
         }
      }
      
      public function previewIcon(param1:IRenderableCollectibleItem, param2:class_3573) : void
      {
         var _loc4_:class_3365 = null;
         _loc4_ = null;
         var _loc5_:int = 0;
         var _loc3_:class_3499 = null;
         var _loc6_:int = 0;
         _loc3_ = null;
         switch(param1.productTypeId - -1)
         {
            case 0:
               param2.setUnknownImage();
               break;
            case 1:
               if((_loc4_ = _sessionDataManager.getWallItemData(parseInt(param1.itemTypeId))) == null)
               {
                  param2.clearPreviewer();
                  break;
               }
               if((_loc5_ = tempCategoryMapping("I",_loc4_.id)) == 1)
               {
                  param2.imageResult = _roomEngine.getWallItemIcon(_loc4_.id,param2);
                  break;
               }
               param2.clearPreviewer();
               break;
            case 2:
            case 12:
               if((_loc4_ = _sessionDataManager.getFloorItemData(parseInt(param1.itemTypeId))) == null)
               {
                  param2.clearPreviewer();
                  break;
               }
               param2.imageResult = _roomEngine.getFurnitureIcon(_loc4_.id,param2);
               break;
            case 3:
               _loc3_ = new class_3499();
               _loc3_.data = _catalog.getPixelEffectIcon(parseInt(param1.itemTypeId));
               param2.imageResult = _loc3_;
               break;
            case 5:
               param2.badgeResult = param1.itemTypeId;
               break;
            case 10:
               _loc6_ = parseInt(param1.itemTypeId);
               _loc3_ = new class_3499();
               _loc3_.data = _freeFlowChat.chatStyleLibrary.getStyle(_loc6_).selectorPreview;
               param2.imageResult = _loc3_;
               break;
            case 11:
               param2.petResult = param1.petFigureString;
               break;
            default:
               class_14.log("[CollectiblesController] Can not yet handle this type of product: ");
               param2.clearPreviewer();
         }
      }
      
      public function previewImage(param1:IRenderableCollectibleItem, param2:class_3573) : void
      {
         var _loc7_:String = null;
         var _loc4_:class_3365 = null;
         _loc4_ = null;
         var _loc6_:int = 0;
         var _loc3_:class_3499 = null;
         var _loc5_:BitmapData = null;
         if(handlePreviewImageEasterEgg(param1,param2))
         {
            return;
         }
         switch(param1.productTypeId - -1)
         {
            case 0:
               param2.setUnknownImage();
               break;
            case 1:
               if((_loc4_ = _sessionDataManager.getWallItemData(parseInt(param1.itemTypeId))) == null)
               {
                  param2.clearPreviewer();
                  break;
               }
               if((_loc6_ = tempCategoryMapping("I",_loc4_.id)) == 1)
               {
                  param2.imageResult = _roomEngine.getWallItemImage(_loc4_.id,new Vector3d(90),64,param2);
               }
               else
               {
                  param2.clearPreviewer();
               }
               break;
            case 2:
               if((_loc4_ = _sessionDataManager.getFloorItemData(parseInt(param1.itemTypeId))) == null)
               {
                  param2.clearPreviewer();
                  break;
               }
               param2.imageResult = _roomEngine.getFurnitureImage(_loc4_.id,new Vector3d(90,0,0),64,param2);
               break;
            case 3:
               if(param1.itemTypeId == "")
               {
                  param2.clearPreviewer();
                  break;
               }
               param2.setEffectResult(_sessionDataManager.figure,parseInt(param1.itemTypeId));
               break;
            case 5:
               param2.badgeResult = param1.itemTypeId;
               break;
            case 10:
               _loc3_ = new class_3499();
               if((_loc5_ = createChatItemPreview(parseInt(param1.itemTypeId))) == null)
               {
                  param2.clearPreviewer();
                  break;
               }
               _loc3_.data = _loc5_;
               param2.imageResult = _loc3_;
               break;
            case 11:
               param2.petResult = param1.petFigureString;
               break;
            case 12:
               _loc7_ = _avatarRenderManager.getFigureStringWithFigureIds(_sessionDataManager.figure,_sessionDataManager.gender,param1.figureSetIds);
               param2.avatarResult = _loc7_;
               break;
            default:
               class_14.log("[CollectiblesController] Can not yet handle this type of product: ");
               param2.clearPreviewer();
         }
      }
      
      private function onInventoryInitialize(param1:HabboInventoryCategoryInitializeEvent) : void
      {
         var _loc2_:String = param1.category;
         if(var_1631 != null && var_1631.mintInventoryListWidget != null)
         {
            var_1631.mintInventoryListWidget.onInventoryInitialize(_loc2_);
         }
      }
      
      public function itemAddedToInventory(param1:int, param2:int, param3:Boolean) : void
      {
         if(var_1631 != null && var_1631.mintInventoryListWidget != null)
         {
            var_1631.mintInventoryListWidget.amountChangedForItem("furni",param1,param3);
         }
      }
      
      public function itemRemovedFromInventory(param1:int, param2:int, param3:Boolean) : void
      {
         if(var_1631 != null && var_1631.mintInventoryListWidget != null)
         {
            var_1631.mintInventoryListWidget.amountChangedForItem("furni",param1,param3);
         }
      }
      
      private function handlePreviewImageEasterEgg(param1:IRenderableCollectibleItem, param2:class_3573) : Boolean
      {
         var _loc5_:String = null;
         var _loc3_:class_3499 = null;
         var _loc4_:BitmapData = null;
         if(param1.productTypeId == var_4726 && param1.itemTypeId == var_4696)
         {
            var_2173 += 1;
         }
         else
         {
            var_2173 = 1;
         }
         var_4726 = param1.productTypeId;
         var_4696 = param1.itemTypeId;
         if(param1.productTypeId == 9)
         {
            _loc5_ = "";
            if(var_2173 == 7)
            {
               _loc5_ = "Evil Frank";
            }
            if(var_2173 == 10)
            {
               _loc5_ = "Bonne Blonde";
            }
            if(var_2173 == 15)
            {
               _loc5_ = "Furni fairy";
            }
            if(var_2173 == 22)
            {
               _loc5_ = "Wacky Wired";
            }
            if(var_2173 == 35)
            {
               _loc5_ = "Quacky duck";
            }
            if(var_2173 == 70)
            {
               _loc5_ = "Pixel poo";
            }
            if(var_2173 == 100)
            {
               _loc5_ = "Bobba filtered";
            }
            if(_loc5_ != "")
            {
               _loc3_ = new class_3499();
               if((_loc4_ = createChatItemPreview(parseInt(param1.itemTypeId),_loc5_)) == null)
               {
                  return false;
               }
               _loc3_.data = _loc4_;
               param2.imageResult = _loc3_;
               return true;
            }
         }
         return false;
      }
      
      private function createChatItemPreview(param1:int, param2:String = null) : BitmapData
      {
         if(param2 == null)
         {
            param2 = _sessionDataManager.userName;
         }
         var _loc6_:ChatStyle;
         if((_loc6_ = _freeFlowChat.chatStyleLibrary.getStyle(param1) as ChatStyle) == null)
         {
            return null;
         }
         var _loc3_:RoomSessionChatEvent = new RoomSessionChatEvent("RSCE_CHAT_EVENT",null,-1,"",0);
         var _loc4_:ChatItem = new ChatItem(_loc3_,getTimer(),null,0,null,null,null,param2);
         var _loc5_:PooledChatBubble;
         (_loc5_ = new PooledChatBubble(_freeFlowChat as HabboFreeFlowChat)).chatItem = _loc4_;
         _loc5_.face = null;
         _loc5_.style = _loc6_;
         _loc5_.recreate(param2,0,false);
         var _loc7_:BitmapData;
         (_loc7_ = new BitmapData(_loc5_.width,_loc5_.height,true,0)).draw(_loc5_);
         return _loc7_;
      }
      
      private function tempCategoryMapping(param1:String, param2:int) : int
      {
         if(param1 == "S")
         {
            return 1;
         }
         if(param1 == "I")
         {
            if(param2 == 3001)
            {
               return 2;
            }
            if(param2 == 3002)
            {
               return 3;
            }
            if(param2 == 4057)
            {
               return 4;
            }
            return 1;
         }
         return 1;
      }
      
      public function get linkPattern() : String
      {
         return "collectibles/";
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         if(_loc2_[1] == "open")
         {
            showCollectibleHub();
         }
      }
      
      private function showCollectibleHub() : void
      {
         if(!var_1631 || var_1631.disposed)
         {
            var_1631 = new CollectiblesView(this,_windowManager);
            updateView();
         }
         else
         {
            var_1631.showWindow();
         }
      }
      
      public function get localizationManager() : IHabboLocalizationManager
      {
         return _localizationManager;
      }
      
      public function get avatarRenderManager() : IAvatarRenderManager
      {
         return _avatarRenderManager;
      }
      
      public function get inventory() : class_1814
      {
         return _inventory;
      }
      
      public function get notifications() : IHabboNotifications
      {
         return _notifications;
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return _windowManager;
      }
   }
}
