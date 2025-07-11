package com.sulake.habbo.inventory
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ILabelWindow;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.utils.WindowToggle;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class InventoryMainView
   {
      
      private static const COUNTER_MARGIN:int = 3;
       
      
      private const DEFAULT_VIEW_LOCATION:Point = new Point(120,150);
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_2286:IAssetLibrary;
      
      private var var_1641:class_3514;
      
      private var var_2006:String;
      
      private var var_3607:IWindowContainer;
      
      private var var_2463:String;
      
      private var var_4008:IWindowContainer;
      
      private var var_319:HabboInventory;
      
      private var _toolbar:IHabboToolbar;
      
      private var var_3033:IWindowContainer;
      
      private var var_3071:IWindowContainer;
      
      private var var_3043:IWindowContainer;
      
      private var var_3183:IWindowContainer;
      
      private var var_3054:IWindowContainer;
      
      private var var_4018:Dictionary;
      
      public function InventoryMainView(param1:HabboInventory, param2:IHabboWindowManager, param3:IAssetLibrary)
      {
         super();
         var_319 = param1;
         var_2286 = param3;
         _windowManager = param2;
      }
      
      public function get isVisible() : Boolean
      {
         return !!var_1641 ? var_1641.visible : false;
      }
      
      public function get isActive() : Boolean
      {
         return !!var_1641 ? var_1641.getStateFlag(1) : false;
      }
      
      public function get emptyContainer() : IWindowContainer
      {
         if(!var_1641)
         {
            return null;
         }
         return var_1641.findChildByName("empty_container") as IWindowContainer;
      }
      
      public function get loadingContainer() : IWindowContainer
      {
         if(!var_1641)
         {
            return null;
         }
         return var_1641.findChildByName("loading_container") as IWindowContainer;
      }
      
      public function get mainContainer() : IWindowContainer
      {
         if(!var_1641)
         {
            return null;
         }
         return var_1641.findChildByName("contentArea") as IWindowContainer;
      }
      
      public function dispose() : void
      {
         var_3033 = null;
         var_3071 = null;
         var_3054 = null;
         var_3183 = null;
         var_3043 = null;
         var_319 = null;
         var_3607 = null;
         var_4008 = null;
         if(var_1641)
         {
            var_1641.dispose();
            var_1641 = null;
         }
         if(_toolbar)
         {
            if(_toolbar.events)
            {
               _toolbar.events.removeEventListener("HTE_TOOLBAR_CLICK",onHabboToolbarEvent);
            }
            _toolbar = null;
         }
         _windowManager = null;
         var_2286 = null;
      }
      
      private function getWindow() : class_3514
      {
         var _loc4_:IAsset = null;
         var _loc1_:XmlAsset = null;
         var _loc2_:ITabContextWindow = null;
         var _loc3_:Array = null;
         var _loc5_:ITabButtonWindow = null;
         if(!var_1641)
         {
            _loc4_ = var_2286.getAssetByName("inventory_xml");
            _loc1_ = XmlAsset(_loc4_);
            var_4018 = new Dictionary();
            var_1641 = _windowManager.buildFromXML(XML(_loc1_.content)) as class_3514;
            if(var_1641 != null)
            {
               var_1641.position = DEFAULT_VIEW_LOCATION;
               var_1641.visible = false;
               var_1641.procedure = windowEventProc;
               var_1641.setParamFlag(65536,var_319.getBoolean("inventory.allow.scaling"));
               extractWindow("furni");
               extractWindow("pets");
               extractWindow("bots");
               extractWindow("badges");
               _loc2_ = var_1641.findChildByName("tabs") as ITabContextWindow;
               _loc3_ = [];
               while(_loc2_.numTabItems > 0)
               {
                  _loc5_ = _loc2_.getTabItemAt(0);
                  _loc3_.push(_loc5_);
                  _loc2_.removeTabItem(_loc5_);
               }
               for each(_loc5_ in _loc3_)
               {
                  switch(_loc5_.name)
                  {
                     case "bots":
                        if(var_319.getBoolean("inventory.bots.enabled"))
                        {
                           _loc2_.addTabItem(_loc5_);
                        }
                        break;
                     case "rentables":
                        if(var_319.getBoolean("duckets.enabled"))
                        {
                           _loc2_.addTabItem(_loc5_);
                        }
                        break;
                     default:
                        _loc2_.addTabItem(_loc5_);
                        break;
                  }
               }
               var_319.preparingInventoryView();
            }
            var_319.updateUnseenItemCounts();
         }
         if(var_1641.y < 0)
         {
            var_1641.y = 0;
         }
         if(var_1641.x < 0)
         {
            var_1641.x = 0;
         }
         return var_1641;
      }
      
      public function getCategoryViewId() : String
      {
         return var_2006;
      }
      
      public function getSubCategoryViewId() : String
      {
         return var_2463;
      }
      
      public function hideInventory() : void
      {
         var_319.closingInventoryView();
         var _loc1_:IWindow = getWindow();
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.visible = false;
      }
      
      public function showInventory() : void
      {
         var _loc1_:IWindow = getWindow();
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.visible = true;
         var_319.inventoryViewOpened(var_2463 && var_2463.length > 0 ? var_2463 : var_2006);
      }
      
      public function toggleCategoryView(param1:String, param2:Boolean = true, param3:Boolean = false) : Boolean
      {
         var _loc4_:IWindow;
         if((_loc4_ = getWindow()) == null)
         {
            return false;
         }
         if(_loc4_.visible)
         {
            if(var_2006 == param1)
            {
               if(param2)
               {
                  if(!WindowToggle.isHiddenByOtherWindows(_loc4_))
                  {
                     hideInventory();
                     return false;
                  }
                  _loc4_.activate();
               }
            }
            else
            {
               setViewToCategory(param1);
            }
         }
         else
         {
            if(param3 && var_2006 != null && var_2006 != param1)
            {
               setViewToCategory(param1);
            }
            _loc4_.visible = true;
            _loc4_.activate();
            if(param1 != var_2006 || !var_319.isInventoryCategoryInit(param1))
            {
               setViewToCategory(param1);
            }
            var_319.inventoryViewOpened(param1);
         }
         return true;
      }
      
      public function toggleSubCategoryView(param1:String, param2:Boolean = true) : void
      {
         var _loc3_:IWindow = getWindow();
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc3_.visible)
         {
            if(var_2463 == param1)
            {
               if(param2)
               {
                  _loc3_.visible = false;
               }
            }
            else
            {
               setSubViewToCategory(param1);
            }
         }
         else
         {
            _loc3_.visible = true;
            if(param1 != var_2463)
            {
               setSubViewToCategory(param1);
            }
         }
      }
      
      public function updateSubCategoryView() : void
      {
         if(var_2463 == null)
         {
            return;
         }
         setSubViewToCategory(var_2463);
      }
      
      public function setToolbar(param1:IHabboToolbar) : void
      {
         _toolbar = param1;
         _toolbar.events.addEventListener("HTE_TOOLBAR_CLICK",onHabboToolbarEvent);
      }
      
      public function windowEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:String = null;
         if(param1.type == "WE_SELECTED")
         {
            _loc3_ = String(ITabContextWindow(param2).selector.getSelected().name);
            if(_loc3_ != var_2006)
            {
               resetUnseenCounters(var_2006);
               var_319.toggleInventoryPage(_loc3_);
            }
         }
         else if(param1.type == "WME_CLICK")
         {
            if(param2.name == "header_button_close")
            {
               hideInventory();
            }
            if(param2.name == "open_catalog_btn")
            {
               var_319.catalog.openCatalog();
            }
         }
         else if(param1.type == "WME_DOUBLE_CLICK")
         {
            if(param2.name == "titlebar")
            {
               var_1641.height = var_1641.limits.minHeight;
            }
         }
      }
      
      public function updateUnseenFurniCount(param1:int) : void
      {
         if(!var_1641)
         {
            return;
         }
         if(!var_3033)
         {
            var_3033 = createCounter("furni");
         }
         updateCounter(var_3033,param1);
         var_319.furniModel.updateView();
      }
      
      public function updateUnseenRentedFurniCount(param1:int) : void
      {
         if(!var_1641)
         {
            return;
         }
         if(!var_3071)
         {
            var_3071 = createCounter("rentables");
         }
         updateCounter(var_3071,param1);
         var_319.furniModel.updateView();
      }
      
      public function updateUnseenPetsCount(param1:int) : void
      {
         if(!var_1641)
         {
            return;
         }
         if(!var_3183)
         {
            var_3183 = createCounter("pets");
         }
         updateCounter(var_3183,param1);
         var_319.petsModel.updateView();
      }
      
      public function updateUnseenBadgeCount(param1:int) : void
      {
         if(!var_1641)
         {
            return;
         }
         if(!var_3043)
         {
            var_3043 = createCounter("badges");
         }
         updateCounter(var_3043,param1);
         var_319.badgesModel.updateView();
      }
      
      public function updateUnseenBotCount(param1:int) : void
      {
         if(!var_1641)
         {
            return;
         }
         if(!var_3054)
         {
            var_3054 = createCounter("bots");
         }
         updateCounter(var_3054,param1);
         var_319.botsModel.updateView();
      }
      
      public function getView(param1:String) : IWindowContainer
      {
         return var_4018[param1] as IWindowContainer;
      }
      
      private function extractWindow(param1:String) : void
      {
         var _loc2_:IWindow = mainContainer.getChildByName(param1);
         if(_loc2_)
         {
            var_4018[param1] = mainContainer.removeChild(_loc2_);
         }
      }
      
      private function resetUnseenCounters(param1:String) : void
      {
         switch(param1)
         {
            case "furni":
               var_319.furniModel.resetUnseenItems();
               break;
            case "rentables":
               var_319.furniModel.resetUnseenItems();
               break;
            case "pets":
               var_319.petsModel.resetUnseenItems();
               break;
            case "badges":
               var_319.badgesModel.resetUnseenItems();
               break;
            case "bots":
               var_319.botsModel.resetUnseenItems();
         }
      }
      
      private function setViewToCategory(param1:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1 == "")
         {
            return;
         }
         if(emptyContainer)
         {
            emptyContainer.visible = false;
         }
         if(loadingContainer)
         {
            loadingContainer.visible = false;
         }
         var_319.checkCategoryInitilization(param1);
         if(mainContainer == null)
         {
            return;
         }
         mainContainer.removeChild(var_3607);
         mainContainer.invalidate();
         var _loc2_:IWindowContainer = var_319.getCategoryWindowContainer(param1);
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.visible = true;
         mainContainer.addChild(_loc2_);
         _loc2_.height = mainContainer.height;
         var_319.updateView(param1);
         var_3607 = _loc2_;
         var_2006 = param1;
         var _loc3_:ITabContextWindow = var_1641.findChildByName("tabs") as ITabContextWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.selector.setSelected(_loc3_.selector.getSelectableByName(param1));
      }
      
      private function enableScaling() : void
      {
         var_1641.height = var_1641.limits.minHeight;
         var_1641.setParamFlag(65536,true);
         var_1641.findChildByName("top_content").setParamFlag(2048,true);
      }
      
      private function disableScaling() : void
      {
         var_1641.height = var_1641.limits.minHeight;
         var_1641.setParamFlag(65536,false);
         var_1641.findChildByName("top_content").setParamFlag(2048,false);
      }
      
      private function setSubViewToCategory(param1:String) : void
      {
         if(param1 == null || param1 == "")
         {
            return;
         }
         var_319.checkCategoryInitilization(param1);
         var _loc2_:IWindowContainer = var_1641.findChildByName("subContentArea") as IWindowContainer;
         while(_loc2_.numChildren > 0)
         {
            _loc2_.removeChildAt(0);
         }
         var _loc3_:IWindowContainer = var_319.getCategorySubWindowContainer(param1);
         if(_loc3_ != null)
         {
            disableScaling();
            _loc2_.visible = true;
            _loc3_.visible = true;
            _loc2_.addChild(_loc3_);
         }
         else
         {
            enableScaling();
            _loc2_.visible = false;
         }
         _loc2_.y = var_1641.findChildByName("top_content").rectangle.bottom + 5;
         resizeToFitContents();
         if(var_1641.parent != null)
         {
            if(var_1641.x + var_1641.width > var_1641.parent.width)
            {
               var_1641.x = var_1641.parent.width - var_1641.width;
            }
            if(var_1641.y + var_1641.height > var_1641.parent.height)
            {
               var_1641.y = (var_1641.parent.height - var_1641.height) * 0.5;
            }
            if(var_1641.y < 0)
            {
               var_1641.y = 0;
            }
         }
         var_4008 = _loc3_;
         var_2463 = param1;
      }
      
      public function resizeToFitContents() : void
      {
         var _loc1_:IWindowContainer = var_1641.findChildByName("subContentArea") as IWindowContainer;
         if(_loc1_.visible)
         {
            _loc1_.height = Util.getLowestPoint(_loc1_);
         }
         else
         {
            _loc1_.height = 0;
         }
         var_1641.resizeToFitContent();
      }
      
      private function createCounter(param1:String) : IWindowContainer
      {
         var _loc3_:IWindowContainer = _windowManager.createUnseenItemCounter();
         var _loc2_:IWindowContainer = var_1641.findChildByName(param1) as IWindowContainer;
         if(_loc2_)
         {
            _loc2_.addChild(_loc3_);
            _loc3_.x = _loc2_.width - _loc3_.width - 3;
            _loc3_.y = 3;
         }
         return _loc3_;
      }
      
      private function updateCounter(param1:IWindowContainer, param2:int) : void
      {
         var _loc5_:ILabelWindow = null;
         param1.findChildByName("count").caption = param2.toString();
         param1.visible = param2 > 0;
         var _loc3_:String = "";
         switch(param1)
         {
            case var_3054:
               _loc3_ = "bots";
               break;
            case var_3183:
               _loc3_ = "pets";
               break;
            case var_3043:
               _loc3_ = "badges";
               break;
            case var_3033:
               _loc3_ = "furni";
               break;
            case var_3071:
               _loc3_ = "rentables";
         }
         var _loc4_:IWindowContainer;
         if(_loc4_ = var_1641.findChildByName(_loc3_) as IWindowContainer)
         {
            if(_loc5_ = _loc4_.getChildByTag("TITLE") as ILabelWindow)
            {
               if(param1.visible)
               {
                  _loc5_.margins.right = param1.width + 2 * 3;
               }
               else
               {
                  _loc5_.margins.right = _loc5_.margins.left;
               }
               _loc4_.width = _loc5_.width;
               param1.x = _loc4_.width - param1.width - 3;
            }
         }
      }
      
      public function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.iconId != "HTIE_ICON_INVENTORY")
         {
            return;
         }
         if(param1.type == "HTE_TOOLBAR_CLICK")
         {
            if(var_2006 == "pets")
            {
               toggleCategoryView("pets");
            }
            else if(var_2006 == "furni")
            {
               toggleCategoryView("furni");
            }
            else if(var_2006 == "rentables")
            {
               toggleCategoryView("rentables");
            }
            else if(var_2006 == "badges")
            {
               toggleCategoryView("badges");
            }
            else if(var_2006 == "bots")
            {
               toggleCategoryView("bots");
            }
            else if(var_319 != null)
            {
               var_319.toggleInventoryPage("furni");
            }
         }
      }
   }
}
