package com.sulake.habbo.inventory.badges
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   
   public class BadgesView implements IInventoryView
   {
      
      private static const GRID_UPDATE_DELAY_MS:int = 100;
      
      private static const GRID_ITEMS_PER_UPDATE:int = 25;
       
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_1631:IWindowContainer;
      
      private var var_1644:BadgesModel;
      
      private var var_3543:IItemGridWindow;
      
      private var _disposed:Boolean = false;
      
      private var var_1618:Boolean = false;
      
      private var var_2176:BadgeGridView;
      
      public function BadgesView(param1:BadgesModel, param2:IHabboWindowManager, param3:IAssetLibrary)
      {
         super();
         var_1644 = param1;
         _windowManager = param2;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get isVisible() : Boolean
      {
         return var_1631 && var_1631.parent != null && var_1631.visible;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         _windowManager = null;
         var_1644 = null;
         if(var_2176 != null)
         {
            var_2176.dispose();
            var_2176 = null;
         }
         var_3543 = null;
         if(var_1631)
         {
            var_1631.dispose();
            var_1631 = null;
         }
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         if(!var_1618)
         {
            init();
         }
         if(var_1631 == null || Boolean(var_1631.disposed))
         {
            return null;
         }
         return var_1631;
      }
      
      public function updateAll(param1:String) : void
      {
         updateListViews(param1);
         updateActionView();
      }
      
      public function updateActionView() : void
      {
         var _loc2_:* = undefined;
         if(!var_1618)
         {
            return;
         }
         if(var_1631 == null || Boolean(var_1631.disposed))
         {
            return;
         }
         var _loc3_:class_3357 = var_1631.findChildByName("wearBadge_button") as class_3357;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc1_:Badge = var_1644.getSelectedBadge();
         if(_loc1_ == null)
         {
            _loc3_.disable();
            setBadgeName(null);
            var_1631.findChildByName("badge_image").visible = false;
         }
         else
         {
            if(_loc1_.isInUse)
            {
               _loc3_.caption = "${inventory.badges.clearbadge}";
            }
            else
            {
               _loc3_.caption = "${inventory.badges.wearbadge}";
            }
            setBadgeName(_loc1_.badgeName);
            IBadgeImageWidget(IWidgetWindow(var_1631.findChildByName("badge_image")).widget).badgeId = _loc1_.badgeId;
            var_1631.findChildByName("badge_image").visible = true;
            _loc2_ = var_1644.getBadges(1);
            if(_loc2_ != null && _loc2_.length >= var_1644.getMaxActiveCount() && !_loc1_.isInUse)
            {
               _loc3_.disable();
            }
            else
            {
               _loc3_.enable();
            }
         }
      }
      
      private function init() : void
      {
         var_1631 = var_1644.controller.view.getView("badges");
         var_1631.procedure = windowEventProc;
         var_1631.visible = false;
         var _loc3_:IWindow = var_1631.findChildByName("wearBadge_button");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",onWearBadgeClick);
         }
         var _loc1_:IItemGridWindow = var_1631.findChildByName("inactive_items") as IItemGridWindow;
         var _loc2_:IItemListWindow = var_1631.findChildByName("item_grid_pages") as IItemListWindow;
         var_2176 = new BadgeGridView(this,_loc1_,_loc2_);
         var_3543 = var_1631.findChildByName("active_items") as IItemGridWindow;
         var_1631.findChildByName("filter").caption = "";
         var_1631.findChildByName("clear_filter_button").visible = false;
         var_1618 = true;
      }
      
      private function updateListViews(param1:String) : void
      {
         var _loc2_:Badge = null;
         var _loc3_:int = 0;
         if(!var_1618)
         {
            return;
         }
         if(var_1631 == null || Boolean(var_1631.disposed))
         {
            return;
         }
         var_3543.removeGridItems();
         var_2176.setFilter(0,param1,param1);
         var_2176.setItems(var_1644.getBadges(0));
         var _loc4_:Vector.<Badge> = var_1644.getBadges(1);
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _loc2_ = _loc4_[_loc3_] as Badge;
            var_3543.addGridItem(_loc2_.window);
            _loc3_++;
         }
      }
      
      private function setBadgeName(param1:String) : void
      {
         if(var_1631 == null || Boolean(var_1631.disposed))
         {
            return;
         }
         var _loc2_:ITextWindow = var_1631.findChildByName("badgeName") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         if(param1 == null)
         {
            _loc2_.text = "";
         }
         else
         {
            _loc2_.text = "";
            _loc2_.text = param1;
         }
      }
      
      private function windowEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:WindowKeyboardEvent = null;
         if(param1.type == "WME_CLICK")
         {
            var _loc4_:* = param2.name;
            if("clear_filter_button" === _loc4_)
            {
               var_1631.findChildByName("filter").caption = "";
               param2.visible = false;
               updateAll(null);
            }
         }
         else if(param1.type == "WKE_KEY_UP")
         {
            _loc3_ = param1 as WindowKeyboardEvent;
            _loc4_ = param2.name;
            if("filter" === _loc4_)
            {
               var_1631.findChildByName("clear_filter_button").visible = param2.caption.length > 0;
               if(_loc3_.keyCode == 13)
               {
                  updateAll(param2.caption);
               }
            }
         }
      }
      
      private function onWearBadgeClick(param1:WindowEvent) : void
      {
         var _loc2_:Badge = var_1644.getSelectedBadge();
         if(_loc2_ != null)
         {
            var_1644.toggleBadgeWearing(_loc2_.badgeId);
         }
      }
   }
}
