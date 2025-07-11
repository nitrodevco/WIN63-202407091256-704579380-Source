package com.sulake.habbo.inventory.bots
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.IInventoryModel;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.Event;
   import com.sulake.habbo.communication.messages.outgoing.inventory.bots.class_1022;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.class_1101;
   import com.sulake.habbo.communication.messages.parser.inventory.bots.class_1726;
   
   public class BotsModel implements IInventoryModel
   {
       
      
      private var var_319:HabboInventory;
      
      private var var_1631:BotsView;
      
      private var _assets:IAssetLibrary;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _roomEngine:IRoomEngine;
      
      private var _catalog:IHabboCatalog;
      
      private var _items:Map;
      
      private var var_3386:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      private var var_4340:Boolean;
      
      public function BotsModel(param1:HabboInventory, param2:IHabboWindowManager, param3:IHabboCommunicationManager, param4:IAssetLibrary, param5:IRoomEngine, param6:IHabboCatalog, param7:IAvatarRenderManager)
      {
         super();
         var_319 = param1;
         _assets = param4;
         _communication = param3;
         _roomEngine = param5;
         _roomEngine.events.addEventListener("REOE_PLACED",onObjectPlaced);
         _catalog = param6;
         _items = new Map();
         var_1631 = new BotsView(this,param2,param4,param5,param7);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_1631)
            {
               var_1631.dispose();
               var_1631 = null;
            }
            if(_roomEngine)
            {
               if(_roomEngine.events)
               {
                  _roomEngine.events.removeEventListener("REOE_PLACED",onObjectPlaced);
               }
               _roomEngine = null;
            }
            if(_items)
            {
               _items.dispose();
               _items = null;
            }
            var_319 = null;
            _catalog = null;
            _assets = null;
            _communication = null;
            _disposed = true;
         }
      }
      
      public function get controller() : HabboInventory
      {
         return var_319;
      }
      
      public function isListInitialized() : Boolean
      {
         return var_4340;
      }
      
      public function setListInitialized() : void
      {
         var_4340 = true;
         var_1631.updateState();
      }
      
      public function requestInventory() : void
      {
         if(_communication == null)
         {
            return;
         }
         var _loc1_:IConnection = _communication.connection;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.send(new class_1022());
      }
      
      public function get items() : Map
      {
         return _items;
      }
      
      public function addItem(param1:class_1726) : void
      {
         if(_items.add(param1.id,param1))
         {
            var_1631.addItem(param1);
         }
         var_1631.updateState();
      }
      
      public function updateItems(param1:Map) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = param1.getKeys();
         var _loc4_:Array = _items.getKeys();
         for each(_loc3_ in _loc4_)
         {
            if(_loc2_.indexOf(_loc3_) == -1)
            {
               _items.remove(_loc3_);
               var_1631.removeItem(_loc3_);
            }
         }
         for each(_loc3_ in _loc2_)
         {
            if(_loc4_.indexOf(_loc3_) == -1)
            {
               _items.add(_loc3_,param1.getValue(_loc3_));
               var_1631.addItem(param1.getValue(_loc3_));
            }
         }
      }
      
      public function removeItem(param1:int) : void
      {
         _items.remove(param1);
         var_1631.removeItem(param1);
         var_1631.updateState();
      }
      
      public function requestInitialization() : void
      {
         requestInventory();
      }
      
      public function categorySwitch(param1:String) : void
      {
         if(param1 == "bots" && var_319.isVisible)
         {
            var_319.events.dispatchEvent(new Event("HABBO_INVENTORY_TRACKING_EVENT_BOTS"));
         }
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         return var_1631.getWindowContainer();
      }
      
      public function closingInventoryView() : void
      {
         if(var_1631.isVisible)
         {
            resetUnseenItems();
         }
      }
      
      public function subCategorySwitch(param1:String) : void
      {
      }
      
      public function placeItemToRoom(param1:int, param2:Boolean = false) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:class_1726 = getItemById(param1);
         if(_loc3_ == null)
         {
            return false;
         }
         if(!var_319.roomSession.areBotsAllowed)
         {
            return false;
         }
         if(var_319.roomSession.isRoomOwner)
         {
            _loc4_ = _loc3_.id * -1;
            var_3386 = _roomEngine.initializeRoomObjectInsert("inventory",_loc4_,100,4,_loc3_.figure);
            var_319.closeView();
            return var_3386;
         }
         if(!param2)
         {
            _communication.connection.send(new class_1101(_loc3_.id,0,0));
         }
         return true;
      }
      
      public function updateView() : void
      {
         if(var_1631 == null)
         {
            return;
         }
         var_1631.update();
      }
      
      private function getItemById(param1:int) : class_1726
      {
         for each(var _loc2_ in _items)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function onObjectPlaced(param1:Event) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(var_3386 && param1.type == "REOE_PLACED")
         {
            var_319.showView();
            var_3386 = false;
         }
      }
      
      public function get roomSession() : IRoomSession
      {
         return var_319.roomSession;
      }
      
      public function resetUnseenItems() : void
      {
         var_319.unseenItemTracker.resetCategory(5);
         var_319.updateUnseenItemCounts();
         var_1631.update();
      }
      
      public function isUnseen(param1:int) : Boolean
      {
         return var_319.unseenItemTracker.isUnseen(5,param1);
      }
      
      public function selectItemById(param1:String) : void
      {
         var_1631.selectById(int(param1));
      }
   }
}
