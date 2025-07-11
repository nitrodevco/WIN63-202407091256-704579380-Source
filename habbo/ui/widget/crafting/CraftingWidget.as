package com.sulake.habbo.ui.widget.crafting
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.furniture.class_3365;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.RoomUI;
   import com.sulake.habbo.ui.handler.CraftingWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.crafting.controller.CraftingInfoController;
   import com.sulake.habbo.ui.widget.crafting.controller.CraftingInventoryListController;
   import com.sulake.habbo.ui.widget.crafting.controller.CraftingMixerController;
   import com.sulake.habbo.ui.widget.crafting.controller.CraftingRecipeListController;
   import com.sulake.habbo.ui.widget.crafting.utils.CraftingFurnitureItem;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.utils.IModalDialog;
   import com.sulake.habbo.communication.messages.parser.crafting.class_1640;
   import com.sulake.habbo.communication.messages.parser.crafting.class_1649;
   
   public class CraftingWidget extends RoomWidgetBase
   {
      
      public static const MODE_NONE:int = 0;
      
      public static const MODE_SECRET_RECIPE:int = 1;
      
      public static const MODE_PUBLIC_RECIPE:int = 2;
       
      
      private var _roomUI:RoomUI;
      
      private var var_2826:CraftingFurnitureItem;
      
      private var var_1828:IModalDialog;
      
      private var var_2797:IWindowContainer;
      
      private var var_2646:CraftingInventoryListController;
      
      private var var_2427:CraftingRecipeListController;
      
      private var var_2284:CraftingMixerController;
      
      private var var_2548:CraftingInfoController;
      
      private var var_2539:int = 0;
      
      public function CraftingWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:RoomUI)
      {
         super(param1,param2,assets,localizations);
         _roomUI = param3;
         var_2646 = new CraftingInventoryListController(this);
         var_2427 = new CraftingRecipeListController(this);
         var_2284 = new CraftingMixerController(this);
         var_2548 = new CraftingInfoController(this);
         _assets = param3.assets;
         this.handler.widget = this;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         hide();
         _roomUI = null;
         if(var_2646)
         {
            var_2646.dispose();
            var_2646 = null;
         }
         if(var_2427)
         {
            var_2427.dispose();
            var_2427 = null;
         }
         if(var_2284)
         {
            var_2284.dispose();
            var_2284 = null;
         }
         if(var_2548)
         {
            var_2548.dispose();
            var_2548 = null;
         }
         if(var_2797)
         {
            var_2797.dispose();
            var_2797 = null;
         }
         super.dispose();
      }
      
      public function hide() : void
      {
         handler.removeInventoryUpdateEvent();
         var_2284.clearItems();
         var_2646.clearItems();
         var_2427.clearItems();
         if(craftingInProgress)
         {
            var_2548.cancelCrafting();
         }
         var_2539 = 0;
         if(var_1828 != null)
         {
            var_1828.dispose();
            var_1828 = null;
         }
      }
      
      private function createMainWindow() : void
      {
         if(window != null)
         {
            return;
         }
         var_1828 = windowManager.buildModalDialogFromXML(XML(assets.getAssetByName("craftingwidget_xml").content));
         if(!var_1828 || !var_1828.rootWindow)
         {
            return;
         }
         var _loc2_:IWindow = window.findChildByTag("close");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onClose);
         }
         var _loc1_:IItemGridWindow = window.findChildByName("itemgrid_products") as IItemGridWindow;
         var_2797 = _loc1_.getGridItemAt(0) as IWindowContainer;
         _loc1_.removeGridItem(var_2797);
         window.procedure = onInput;
         window.center();
      }
      
      public function populateInventoryItems(param1:Vector.<CraftingFurnitureItem>) : void
      {
         var_2646.populateInventoryItems(param1);
      }
      
      public function populateRecipeItems(param1:Vector.<CraftingFurnitureItem>) : void
      {
         var_2427.populateRecipeItems(param1);
      }
      
      public function setInfoState(param1:int, ... rest) : void
      {
         if(var_2548)
         {
            var_2548.setState(param1,rest);
         }
      }
      
      private function onInput(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_DOWN")
         {
            return;
         }
         var _loc3_:* = param2.name;
         if("header_button_close" === _loc3_)
         {
            hide();
         }
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         hide();
      }
      
      public function setInfoText(param1:String) : void
      {
         var _loc2_:ITextWindow = !!window ? window.findChildByName("header_mixer") as ITextWindow : null;
         if(_loc2_)
         {
            _loc2_.text = param1;
         }
      }
      
      public function showWidget() : void
      {
         if(window)
         {
            return;
         }
         createMainWindow();
         setInfoText("");
         setInfoState(0);
      }
      
      public function showCraftingCategories(param1:Vector.<class_1649>, param2:Vector.<String>, param3:IRoomEngine, param4:ISessionDataManager) : void
      {
         var _loc9_:* = undefined;
         var _loc6_:* = null;
         var _loc10_:class_3365 = null;
         var _loc12_:class_3365 = null;
         var _loc8_:Boolean = false;
         var _loc11_:CraftingFurnitureItem = null;
         var _loc5_:Array = null;
         _loc9_ = new Vector.<CraftingFurnitureItem>(0);
         for each(_loc6_ in param2)
         {
            _loc8_ = false;
            if(!(_loc10_ = param4.getFloorItemDataByName(_loc6_)))
            {
               _loc10_ = param4.getWallItemDataByName(_loc6_);
               _loc8_ = true;
               if(!_loc10_)
               {
                  continue;
               }
            }
            _loc11_ = new CraftingFurnitureItem(null,null,_loc10_);
            if((_loc5_ = handler.container.inventory.getNonRentedInventoryIds("furni",_loc11_.typeId,_loc8_)) && _loc5_.length > 0)
            {
               _loc11_.inventoryIds = Vector.<int>(_loc5_);
            }
            _loc9_.push(_loc11_);
         }
         populateInventoryItems(_loc9_);
         _loc9_ = new Vector.<CraftingFurnitureItem>(0);
         for each(var _loc7_ in param1)
         {
            _loc10_ = param4.getFloorItemDataByName(_loc7_.furnitureClassName);
            _loc12_ = param4.getWallItemDataByName(_loc7_.furnitureClassName);
            if(_loc10_)
            {
               _loc9_.push(new CraftingFurnitureItem(_loc7_.recipeCode,_loc7_.productCode,_loc10_));
            }
            else if(_loc12_)
            {
               _loc9_.push(new CraftingFurnitureItem(_loc7_.recipeCode,_loc7_.productCode,_loc12_));
            }
         }
         populateRecipeItems(_loc9_);
      }
      
      public function showCraftableProduct(param1:CraftingFurnitureItem) : void
      {
         var_2826 = param1;
         if(!var_2826)
         {
            return;
         }
         setInfoText(!!var_2826.furnitureData ? var_2826.furnitureData.localizedName : "");
         handler.getCraftingRecipe(var_2826.recipeCode,var_2826.productCode);
      }
      
      public function showCraftingRecipe(param1:Vector.<class_1640>) : void
      {
         showCraftableProductView();
         var_2427.showRecipe(var_2826,param1);
      }
      
      public function clearMixerItems() : void
      {
         if(var_2284)
         {
            var_2284.clearItems();
         }
      }
      
      public function mixerContentChanged(param1:Vector.<int>) : void
      {
         if(param1.length > 0)
         {
            setInfoState(1000);
            handler.getCraftingRecipesAvailable(param1);
         }
         else
         {
            setInfoState(1);
         }
      }
      
      public function showSecretRecipeView() : void
      {
         if(var_2539 != 1)
         {
            clearMixerItems();
         }
         var_2539 = 1;
         setInfoText("");
         setInfoState(1);
      }
      
      public function showCraftableProductView() : void
      {
         if(var_2539 != 2)
         {
            clearMixerItems();
         }
         var_2539 = 2;
         setInfoState(6);
      }
      
      public function doCrafting() : void
      {
         switch(var_2539 - 1)
         {
            case 0:
               handler.doCraftingWithMixer();
               break;
            case 1:
               handler.doCraftingWithRecipe();
         }
      }
      
      public function getSelectedIngredients() : Vector.<int>
      {
         return var_2284.collectSelectedFurnitureIds();
      }
      
      public function get inSecretRecipeMode() : Boolean
      {
         return var_2539 == 1;
      }
      
      public function get craftingInProgress() : Boolean
      {
         return handler.craftingInProgress;
      }
      
      public function get inventoryDirty() : Boolean
      {
         return handler.inventoryDirty;
      }
      
      public function get itemTemplate() : IWindowContainer
      {
         return var_2797;
      }
      
      public function get handler() : CraftingWidgetHandler
      {
         return var_1653 as CraftingWidgetHandler;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return handler.container.sessionDataManager;
      }
      
      public function get inventoryCtrl() : CraftingInventoryListController
      {
         return var_2646;
      }
      
      public function get recipeCtrl() : CraftingRecipeListController
      {
         return var_2427;
      }
      
      public function get mixerCtrl() : CraftingMixerController
      {
         return var_2284;
      }
      
      public function get infoCtrl() : CraftingInfoController
      {
         return var_2548;
      }
      
      public function get window() : IWindowContainer
      {
         return !!var_1828 ? var_1828.rootWindow as IWindowContainer : null;
      }
   }
}
