package com.sulake.habbo.inventory.pets
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.IInventoryModel;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.Event;
   import com.sulake.habbo.communication.messages.outgoing.inventory.pets.GetPetInventoryComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.PlacePetMessageComposer;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.class_1679;
   
   public class PetsModel implements IInventoryModel
   {
       
      
      private var var_319:HabboInventory;
      
      private var var_1631:PetsView;
      
      private var _assets:IAssetLibrary;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _roomEngine:IRoomEngine;
      
      private var _catalog:IHabboCatalog;
      
      private var var_2094:Map;
      
      private var var_3386:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      private var var_4340:Boolean;
      
      public function PetsModel(param1:HabboInventory, param2:IHabboWindowManager, param3:IHabboCommunicationManager, param4:IAssetLibrary, param5:IRoomEngine, param6:IHabboCatalog)
      {
         super();
         var_319 = param1;
         _assets = param4;
         _communication = param3;
         _roomEngine = param5;
         _roomEngine.events.addEventListener("REOE_PLACED",onObjectPlaced);
         _catalog = param6;
         var_2094 = new Map();
         var_1631 = new PetsView(this,param2,param4,param5);
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
            if(var_2094)
            {
               var_2094.dispose();
               var_2094 = null;
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
      
      public function requestPetInventory() : void
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
         _loc1_.send(new GetPetInventoryComposer());
      }
      
      public function get pets() : Map
      {
         return var_2094;
      }
      
      public function addPet(param1:class_1679) : void
      {
         if(var_2094.add(param1.id,param1))
         {
            var_1631.addPet(param1);
         }
         var_1631.updateState();
      }
      
      public function updatePets(param1:Map) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = param1.getKeys();
         var _loc4_:Array = var_2094.getKeys();
         var_319.setInventoryCategoryInit("pets");
         for each(_loc3_ in _loc4_)
         {
            if(_loc2_.indexOf(_loc3_) == -1)
            {
               var_2094.remove(_loc3_);
               var_1631.removePet(_loc3_);
            }
         }
         for each(_loc3_ in _loc2_)
         {
            if(_loc4_.indexOf(_loc3_) == -1)
            {
               var_2094.add(_loc3_,param1.getValue(_loc3_));
               var_1631.addPet(param1.getValue(_loc3_));
            }
         }
         setListInitialized();
      }
      
      public function removePet(param1:int) : void
      {
         var_2094.remove(param1);
         var_1631.removePet(param1);
         var_1631.updateState();
      }
      
      public function requestInitialization() : void
      {
         requestPetInventory();
      }
      
      public function categorySwitch(param1:String) : void
      {
         if(param1 == "pets" && var_319.isVisible)
         {
            var_319.events.dispatchEvent(new Event("HABBO_INVENTORY_TRACKING_EVENT_PETS"));
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
      
      public function placePetToRoom(param1:int, param2:Boolean = false) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:class_1679;
         if((_loc5_ = getPetById(param1)) == null)
         {
            return false;
         }
         var _loc3_:String = null;
         if(_loc5_.typeId == 16)
         {
            if(_loc5_.level >= 7)
            {
               _loc3_ = "std";
            }
            else
            {
               _loc3_ = "grw" + _loc5_.level;
            }
         }
         if(var_319.roomSession.isRoomOwner)
         {
            _loc4_ = _loc5_.id * -1;
            var_3386 = _roomEngine.initializeRoomObjectInsert("inventory",_loc4_,100,2,_loc5_.figureString,null,-1,-1,_loc3_);
            var_319.closeView();
            return var_3386;
         }
         if(!var_319.roomSession.arePetsAllowed)
         {
            return false;
         }
         if(!param2)
         {
            _communication.connection.send(new PlacePetMessageComposer(_loc5_.id,0,0));
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
      
      private function getPetById(param1:int) : class_1679
      {
         for each(var _loc2_ in var_2094)
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
      
      public function updatePetsAllowed() : void
      {
         var_1631.update();
      }
      
      public function resetUnseenItems() : void
      {
         var_319.unseenItemTracker.resetCategory(3);
         var_319.updateUnseenItemCounts();
         var_1631.update();
      }
      
      public function isUnseen(param1:int) : Boolean
      {
         return var_319.unseenItemTracker.isUnseen(3,param1);
      }
      
      public function removeUnseenFurniCounter(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         if(isUnseen(param1))
         {
            _loc2_ = var_319.unseenItemTracker.removeUnseen(3,param1);
            if(_loc2_)
            {
               var_319.unseenItemTracker.resetCategoryIfEmpty(3);
            }
         }
         return _loc2_;
      }
      
      public function selectItemById(param1:String) : void
      {
         var_1631.selectById(int(param1));
      }
   }
}
