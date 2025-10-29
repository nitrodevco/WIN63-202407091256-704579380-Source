package com.sulake.habbo.ui.handler
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.inventory.events.HabboInventoryFurniListParsedEvent;
   import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
   import com.sulake.habbo.session.furniture.class_3365;
   import com.sulake.habbo.session.product.class_3423;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.RoomDesktop;
   import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.room.object.IRoomObject;
   import flash.events.Event;
   import com.sulake.habbo.communication.messages.incoming.crafting.CraftableProductsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.crafting.CraftingRecipesAvailableMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.crafting.CraftingRecipeMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.crafting.CraftingResultMessageEvent;
   import com.sulake.habbo.communication.messages.parser.crafting.class_1649;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListInvalidateEvent;
   import com.sulake.habbo.communication.messages.outgoing.inventory.furni.RequestFurniInventoryComposer;
   import com.sulake.habbo.communication.messages.outgoing.crafting.CraftComposer;
   import com.sulake.habbo.communication.messages.outgoing.crafting.GetCraftableProductsComposer;
   import com.sulake.habbo.communication.messages.outgoing.crafting.CraftSecretComposer;
   import com.sulake.habbo.communication.messages.outgoing.crafting.GetCraftingRecipesAvailableComposer;
   import com.sulake.habbo.communication.messages.outgoing.crafting.GetCraftingRecipeComposer;
   
   public class CraftingWidgetHandler implements IRoomWidgetHandler
   {
       
      
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer;
      
      private var var_1629:CraftingWidget;
      
      private var var_2687:RoomDesktop;
      
      private var var_2806:IMessageEvent;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var var_2516:int;
      
      private var var_3483:Boolean;
      
      private var var_3265:Boolean;
      
      private var var_3686:Boolean;
      
      private var var_3717:class_3423;
      
      private var var_3413:String;
      
      public function CraftingWidgetHandler(param1:RoomDesktop)
      {
         super();
         var_2687 = param1;
      }
      
      public function dispose() : void
      {
         removeMessageEvents();
         var_1629 = null;
         _container = null;
         var_2687 = null;
         var_3717 = null;
         var_3413 = null;
         _disposed = true;
      }
      
      private function addMessageEvents() : void
      {
         if(!_container || !_container.connection)
         {
            return;
         }
         _messageEvents = new Vector.<IMessageEvent>(0);
         _messageEvents.push(new CraftableProductsMessageEvent(onCraftableProductsMessage));
         _messageEvents.push(new CraftingRecipeMessageEvent(onCraftingRecipeMessage));
         _messageEvents.push(new CraftingResultMessageEvent(onCraftingResultMessage));
         _messageEvents.push(new CraftingRecipesAvailableMessageEvent(onCraftingRecipesAvailableMessage));
         for each(var _loc1_ in _messageEvents)
         {
            _container.connection.addMessageEvent(_loc1_);
         }
      }
      
      private function removeMessageEvents() : void
      {
         if(!_container || !_container.connection || !_messageEvents)
         {
            return;
         }
         for each(var _loc1_ in _messageEvents)
         {
            _container.connection.removeMessageEvent(_loc1_);
            _loc1_.dispose();
         }
         removeInventoryUpdateEvent();
         if(_container.inventory && _container.inventory.events)
         {
            _container.inventory.events.removeEventListener("HFLPE_FURNI_LIST_PARSED",onFurniListParsed);
         }
         _messageEvents = null;
      }
      
      public function initializeData() : void
      {
         if(var_3483)
         {
            return;
         }
         var_3483 = true;
         if(_container.inventory.checkCategoryInitilization("furni"))
         {
            getCraftableProducts();
         }
      }
      
      private function onFurniListParsed(param1:HabboInventoryFurniListParsedEvent) : void
      {
         if(var_3483 && param1.category == "furni")
         {
            getCraftableProducts();
         }
      }
      
      private function getCraftableProducts() : void
      {
         _container.connection.send(new GetCraftableProductsComposer(var_2516));
      }
      
      private function onCraftableProductsMessage(param1:CraftableProductsMessageEvent) : void
      {
         var_3483 = false;
         if(!var_1629)
         {
            return;
         }
         if(!param1.getParser().hasData())
         {
            var_1629.hide();
            return;
         }
         var_1629.showWidget();
         var_1629.showCraftingCategories(param1.getParser().recipeProductItems,param1.getParser().usableInventoryFurniClasses,_container.roomEngine,_container.sessionDataManager);
         var_3265 = false;
      }
      
      public function getCraftingRecipe(param1:String, param2:String) : void
      {
         var_3717 = _container.sessionDataManager.getProductData(param2);
         var_3413 = param1;
         _container.connection.send(new GetCraftingRecipeComposer(param1));
      }
      
      private function onCraftingRecipeMessage(param1:CraftingRecipeMessageEvent) : void
      {
         var_1629.showCraftingRecipe(param1.getParser().ingredients);
      }
      
      public function getCraftingRecipesAvailable(param1:Vector.<int>) : void
      {
         _container.connection.send(new GetCraftingRecipesAvailableComposer(var_2516,param1));
      }
      
      private function onCraftingRecipesAvailableMessage(param1:CraftingRecipesAvailableMessageEvent) : void
      {
         var_1629.infoCtrl.craftingSecretRecipesAvailable(param1.getParser().count,param1.getParser().recipeComplete);
      }
      
      public function doCraftingWithRecipe() : void
      {
         if(!var_3717 || !var_3413)
         {
            return;
         }
         var_1629.infoCtrl.setState(1000);
         registerForFurniListInvalidate();
         _container.connection.send(new CraftComposer(var_2516,var_3413));
      }
      
      public function doCraftingWithMixer() : void
      {
         var_1629.infoCtrl.setState(1000);
         var _loc1_:Vector.<int> = var_1629.getSelectedIngredients();
         registerForFurniListInvalidate();
         _container.connection.send(new CraftSecretComposer(var_2516,_loc1_));
      }
      
      private function onCraftingResultMessage(param1:CraftingResultMessageEvent) : void
      {
         var _loc2_:class_1649 = null;
         var _loc3_:class_3365 = null;
         var_3686 = false;
         if(!param1.getParser().success)
         {
            var_1629.clearMixerItems();
            var_3265 = false;
            removeInventoryUpdateEvent();
            var_1629.setInfoState(1);
         }
         else
         {
            var_1629.clearMixerItems();
            _loc2_ = param1.getParser().productData;
            _loc3_ = _container.sessionDataManager.getFloorItemDataByName(_loc2_.furnitureClassName);
            if(!_loc3_)
            {
               return;
            }
            var_1629.setInfoState(999,_loc3_);
         }
      }
      
      private function registerForFurniListInvalidate() : void
      {
         var_3265 = true;
         if(var_2806 == null)
         {
            var_2806 = new FurniListInvalidateEvent(onFurniListInvalidate);
            _container.connection.addMessageEvent(var_2806);
         }
      }
      
      private function onFurniListInvalidate(param1:FurniListInvalidateEvent) : void
      {
         _container.connection.send(new RequestFurniInventoryComposer());
         _container.connection.send(new GetCraftableProductsComposer(var_2516));
         removeInventoryUpdateEvent();
      }
      
      public function removeInventoryUpdateEvent() : void
      {
         if(var_2806)
         {
            _container.connection.removeMessageEvent(var_2806);
            var_2806 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get type() : String
      {
         return "RWE_CRAFTING";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
         addMessageEvents();
         if(_container.inventory && _container.inventory.events)
         {
            _container.inventory.events.addEventListener("HFLPE_FURNI_LIST_PARSED",onFurniListParsed);
         }
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function set widget(param1:CraftingWidget) : void
      {
         var_1629 = param1;
      }
      
      public function getWidgetMessages() : Array
      {
         return null;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return ["RETWE_OPEN_WIDGET","RETWE_CLOSE_WIDGET"];
      }
      
      public function processEvent(param1:Event) : void
      {
         if(_container.roomEngine == null || var_1629 == null)
         {
            return;
         }
         var _loc3_:RoomEngineToWidgetEvent = param1 as RoomEngineToWidgetEvent;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:IRoomObject = _container.roomEngine.getRoomObject(_loc3_.roomId,_loc3_.objectId,_loc3_.category);
         switch(param1.type)
         {
            case "RETWE_OPEN_WIDGET":
               if(var_1629.window != null)
               {
                  return;
               }
               if(_loc2_ != null)
               {
                  var_2516 = _loc2_.getId();
                  initializeData();
               }
               break;
            case "RETWE_CLOSE_WIDGET":
               var_2516 = -1;
               var_1629.hide();
         }
      }
      
      public function get isOwner() : Boolean
      {
         var _loc1_:int = _container.roomEngine.activeRoomId;
         var _loc2_:IRoomObject = _container.roomEngine.getRoomObject(_loc1_,var_2516,10);
         return _loc2_ != null && _container.isOwnerOfFurniture(_loc2_);
      }
      
      public function get craftingInProgress() : Boolean
      {
         return var_3686;
      }
      
      public function set craftingInProgress(param1:Boolean) : void
      {
         var_3686 = param1;
      }
      
      public function get inventoryDirty() : Boolean
      {
         return var_3265;
      }
      
      public function update() : void
      {
      }
   }
}
