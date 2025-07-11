package com.sulake.habbo.friendbar.landingview.layout
{
    import assets.class_14

    import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IScrollbarWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import flash.geom.Rectangle;
   
   public class DynamicLayoutManager implements IDisposable
   {
      
      public static const PLACEHOLDER_NAME:String = "placeholder_dynamic_widget_slots";
      
      public static const CONTENT_AREA_START_X:int = 230;
      
      private static const NUMBER_OF_SLOTS:int = 5;
      
      private static const RESIZE_TOLERANCE_SCROLLBAR_VISIBILITY:int = 6;
      
      private static const ABSOLUTE_MINIMUM_HEIGHT:int = 360;
       
      
      private var _layout:WidgetContainerLayout;
      
      private var var_1751:IItemListWindow;
      
      private var var_2718:IItemListWindow;
      
      private var var_2064:IItemListWindow;
      
      private var var_3634:IWindowContainer;
      
      private var var_2150:IItemListWindow;
      
      private var var_3821:IWindowContainer;
      
      private var var_1699:Vector.<IWindowContainer>;
      
      private var var_4209:IItemListWindow;
      
      private var var_4187:IItemListWindow;
      
      private var var_3532:IWindowContainer;
      
      private var var_4688:IWindow;
      
      private var _fromTopScrollbar:IScrollbarWindow;
      
      private var _window:IWindowContainer;
      
      private var var_4476:Boolean = false;
      
      private var var_2696:CommonWidgetSettings;
      
      private var var_3394:int = 10;
      
      private var var_3268:int = 50;
      
      private var var_3589:int = 10;
      
      private var var_4882:int = 80;
      
      private var var_4918:int = 10;
      
      private var var_4091:int = 60;
      
      private var var_4148:int = -1;
      
      private var _topItemListInitialWidth:int = -1;
      
      private var var_78:Boolean = false;
      
      private var var_3624:IWindow = null;
      
      public function DynamicLayoutManager(param1:WidgetContainerLayout, param2:CommonWidgetSettings)
      {
         var _loc5_:int = 0;
         var_1699 = new Vector.<IWindowContainer>(5);
         super();
         _layout = param1;
         var_2696 = param2;
         _window = IWindowContainer(_layout.landingView.getXmlWindow("dynamic_widget_grid"));
         var _loc6_:IWindow = _layout.window.findChildByName("placeholder_dynamic_widget_slots");
         var _loc3_:IWindowContainer = IWindowContainer(_loc6_.parent);
         _loc3_.addChildAt(_window,_loc3_.getChildIndex(_loc6_));
         _loc3_.removeChild(_loc6_);
         var_1751 = IItemListWindow(_window.findChildByName("widgetlist_fromtop"));
         var_3634 = IWindowContainer(_window.findChildByName("center_slots_container"));
         var_2718 = IItemListWindow(_window.findChildByName("widget_slots_center_scrollable"));
         var_2064 = IItemListWindow(_window.findChildByName("widget_slots_center_left"));
         var_2150 = IItemListWindow(_window.findChildByName("widget_slots_center_right"));
         var_3821 = IWindowContainer(_window.findChildByName("widget_slots_right"));
         var_4209 = IItemListWindow(_window.findChildByName("widget_slot_4_root"));
         var_4187 = IItemListWindow(_window.findChildByName("widget_slot_5_root"));
         var_4688 = _layout.landingView.getXmlWindow("dynamic_widget_grid_separator");
         _loc5_ = 0;
         while(_loc5_ < 6)
         {
            var_1699[_loc5_] = IWindowContainer(_window.findChildByName("widget_slot_" + (_loc5_ + 1)));
            if(var_1699[_loc5_] != null)
            {
               var_1699[_loc5_].addEventListener("WE_RESIZED",contractCenterContainer);
            }
            _loc5_++;
         }
         _fromTopScrollbar = IScrollbarWindow(_window.findChildByName("center_container_scrollbar"));
         var_3532 = IWindowContainer(_window.findChildByName("scroll_extra_space_container"));
         var _loc7_:int = _layout.landingView.dynamicLayoutLeftPaneWidth;
         var _loc4_:int = _layout.landingView.dynamicLayoutRightPaneWidth;
         var_2064.width = _loc7_;
         var_2064.limits.maxWidth = _loc7_;
         var_4209.width = _loc7_;
         var_2150.width = _loc4_;
         var_3821.width = _loc4_;
         var_3821.limits.maxWidth = _loc4_;
         var_4187.width = _loc4_;
         var_2718.arrangeListItems();
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         if(!disposed)
         {
            _loc1_ = 0;
            while(_loc1_ < 6)
            {
               if(var_1699[_loc1_])
               {
                  var_1699[_loc1_].dispose();
               }
               var_1699[_loc1_] = null;
               _loc1_++;
            }
            if(_window)
            {
               _window.dispose();
               _window = null;
            }
            _layout = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _layout == null;
      }
      
      public function getDynamicSlotContainer(param1:int) : IWindowContainer
      {
         return var_1699[param1];
      }
      
      public function enableSeparator(param1:int, param2:String) : void
      {
         var _loc3_:IItemListWindow = null;
         var _loc4_:ITextWindow = null;
         switch(param1 - 4)
         {
            case 0:
               _loc3_ = var_4209;
               break;
            case 1:
               _loc3_ = var_4187;
               break;
            default:
               _loc3_ = null;
         }
         if(_loc3_)
         {
            if(_loc3_.numListItems < 2)
            {
               _loc3_.addListItemAt(var_4688.clone(),0);
            }
            (_loc4_ = ITextWindow(IItemListWindow(_loc3_.getListItemAt(0)).getListItemByName("separator_title"))).caption = "${" + param2 + "}";
            if(var_2696 != null)
            {
               if(var_2696.isTextColorSet)
               {
                  _loc4_.textColor = var_2696.textColor;
               }
               if(var_2696.isEtchingColorSet)
               {
                  _loc4_.etchingColor = var_2696.etchingColor;
               }
               if(var_2696.isEtchingPositionSet)
               {
                  _loc4_.etchingPosition = var_2696.etchingPosition;
               }
            }
         }
      }
      
      private function isSlotOccupied(param1:int) : Boolean
      {
         return var_1699[param1].numChildren > 0;
      }
      
      public function resizeTo(param1:int, param2:int) : void
      {
         var_1751.height = Math.min(param2,topItemListInitialHeight);
         var_1751.height = Math.max(360,var_1751.height);
         var_1751.width = Math.min(param1,topItemListInitialWidth);
         applyVerticalSize();
      }
      
      public function set scrollbarRightEdgeRelativeToScreen(param1:int) : void
      {
         var _loc2_:int = int(_layout.window.width);
         param1 = Math.min(param1,_loc2_) - _window.x;
         _fromTopScrollbar.x = param1 - _fromTopScrollbar.width;
      }
      
      public function get topItemListInitialHeight() : int
      {
         if(var_4148 == -1)
         {
            var_4148 = var_1751.height;
         }
         return var_4148;
      }
      
      public function get topItemListInitialWidth() : int
      {
         if(_topItemListInitialWidth == -1)
         {
            _topItemListInitialWidth = var_1751.width;
         }
         return _topItemListInitialWidth;
      }
      
      private function applyVerticalSize() : void
      {
         var _loc1_:int = 0;
         clearEmptySlotsForSpace();
         alignTopWidgetRow();
         alignBottomWidgetRow();
         resetToMaximumSpacing();
         setVerticalSpacing(topItemListContentHeight - var_1751.height);
         contractCenterContainer();
         adjustScrollbarVisibility();
         setHorizontalSpacing();
         if(!var_78)
         {
            _loc1_ = 0;
            while(_loc1_ < 6)
            {
               if(var_1699[_loc1_] != null)
               {
                  var_1699[_loc1_].addEventListener("WE_RESIZED",updateLayout);
               }
               _loc1_++;
            }
         }
         var_78 = true;
         var_3624 = null;
      }
      
      private function updateLayout(param1:WindowEvent = null) : void
      {
         if(var_3624 == null)
         {
            var_3624 = param1.window;
            applyVerticalSize();
         }
      }
      
      private function clearEmptySlotsForSpace() : void
      {
         var _loc1_:int = 0;
         if(!isSlotOccupied(0))
         {
            var_1699[0].height = 0;
         }
         _loc1_ = 1;
         while(_loc1_ <= 4)
         {
            if(!isSlotOccupied(_loc1_))
            {
               var_1699[_loc1_].height = 1;
            }
            _loc1_++;
         }
      }
      
      private function alignBottomWidgetRow() : void
      {
         var _loc1_:int = 0;
         if(isSlotOccupied(3) || isSlotOccupied(4))
         {
            _loc1_ = Math.max(var_1699[3].height,var_1699[4].height);
            var_1699[3].height = _loc1_;
            var_1699[4].height = _loc1_;
            if(isSlotOccupied(3))
            {
               var_1699[3].getChildAt(0).y = 0;
               var_1699[3].width = _layout.landingView.dynamicLayoutLeftPaneWidth;
            }
            if(isSlotOccupied(4))
            {
               var_1699[4].getChildAt(0).y = 0;
               var_1699[4].width = _layout.landingView.dynamicLayoutRightPaneWidth;
            }
         }
      }
      
      private function alignTopWidgetRow() : int
      {
         var _loc1_:int = 0;
         if(isSlotOccupied(1) || isSlotOccupied(2))
         {
            if(!var_4476)
            {
               _loc1_ = Math.max(var_1699[1].height,var_1699[2].height);
               var_1699[1].height = _loc1_;
               var_1699[2].height = _loc1_;
            }
            if(isSlotOccupied(1))
            {
               var_1699[1].getChildAt(0).y = 0;
               var_1699[1].width = _layout.landingView.dynamicLayoutLeftPaneWidth;
            }
            if(isSlotOccupied(2))
            {
               var_1699[2].getChildAt(0).y = 0;
               var_1699[2].width = _layout.landingView.dynamicLayoutRightPaneWidth;
            }
         }
         return _loc1_;
      }
      
      private function setHorizontalSpacing() : void
      {
         var _loc1_:int = _topItemListInitialWidth - var_1751.width;
         if(_loc1_ > var_4091 - var_4918)
         {
            var_2718.spacing = var_4918;
         }
         else
         {
            var_2718.spacing = Math.min(var_4091,var_4091 - _loc1_);
         }
      }
      
      private function setVerticalSpacing(param1:int) : void
      {
         var _loc2_:int = var_3268 - var_3394;
         var _loc3_:int = var_4882 - var_3589;
         param1 += var_3394 + var_3589;
         if(param1 <= 0)
         {
            var_1751.spacing = var_3589;
            var_2064.spacing = var_3268;
            var_2150.spacing = var_3268;
         }
         else if(param1 < _loc2_)
         {
            var_1751.spacing = var_3589;
            var_2064.spacing = var_3268 - param1;
            var_2150.spacing = var_3268 - param1;
         }
         else if(param1 < _loc2_ + _loc3_)
         {
            var_1751.spacing = var_3589;
            var_2064.spacing = var_3394;
            var_2150.spacing = var_3394;
         }
         else
         {
            var_1751.spacing = var_3589;
            var_2064.spacing = var_3394;
            var_2150.spacing = var_3394;
         }
      }
      
      private function adjustScrollbarVisibility() : void
      {
         var_1751.invalidate();
         if(var_1751.height < topItemListContentHeight - 6)
         {
            _fromTopScrollbar.y = var_1751.y;
            _fromTopScrollbar.height = var_1751.height;
            _fromTopScrollbar.visible = true;
            _fromTopScrollbar.scrollV = 0;
            var_3532.y = topItemListContentHeight;
            var_3532.height = 25;
            _layout.landingView.toolbarExtensionExtraMargin = true;
         }
         else
         {
            var_3532.y = 0;
            var_3532.height = 1;
            _layout.landingView.toolbarExtensionExtraMargin = false;
         }
      }
      
      private function resetToMaximumSpacing() : void
      {
         var_2718.spacing = var_4091;
         var_2064.spacing = var_3268;
         var_2150.spacing = var_3268;
         var_1751.spacing = var_4882;
         _fromTopScrollbar.visible = false;
         var_2064.invalidate();
         var_2150.invalidate();
         var_2718.invalidate();
         var_1751.invalidate();
         var_3634.invalidate();
      }
      
      private function get topItemListContentHeight() : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < var_1751.numListItems)
         {
            _loc2_ = var_1751.getListItemAt(_loc3_).height;
            _loc1_ += _loc2_;
            if(_loc3_ > 0)
            {
               _loc1_ += var_1751.spacing;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function contractCenterContainer(param1:WindowEvent = null) : void
      {
         if(param1 != null && !var_78)
         {
            return;
         }
         var_2064.invalidate();
         var_2150.invalidate();
         var_2718.height = Math.max(var_2064.height,var_2150.height);
         var_3634.height = Math.max(var_2064.height,var_2150.height);
      }
      
      public function set ignoreBottomRightSlot(param1:Boolean) : void
      {
         var_4476 = param1;
      }
      
      private function logFinalPositions() : void
      {
         var _loc2_:int = 0;
         class_14.log("***** Final positions *****");
         var _loc1_:Rectangle = new Rectangle();
         _window.getGlobalRectangle(_loc1_);
         class_14.log("Window rect\t\t\t\t\t\t: " + _loc1_);
         var_1751.getGlobalRectangle(_loc1_);
         class_14.log("All items list rect\t\t\t\t: " + _loc1_);
         var_3634.getGlobalRectangle(_loc1_);
         class_14.log("Center container itemlist rect\t: " + _loc1_);
         var_2718.getGlobalRectangle(_loc1_);
         class_14.log("Center itemlist rect\t\t\t: " + _loc1_);
         var_2064.getGlobalRectangle(_loc1_);
         class_14.log("Left pane itemlist rect\t\t\t: " + _loc1_);
         var_2150.getGlobalRectangle(_loc1_);
         class_14.log("Right pane itemlist rect\t\t: " + _loc1_);
         var_3821.getGlobalRectangle(_loc1_);
         class_14.log("Right pane container rect\t\t: " + _loc1_);
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            var_1699[_loc2_].getGlobalRectangle(_loc1_);
            class_14.log("Slot " + _loc2_ + " rect\t\t\t    : " + _loc1_);
            _loc2_++;
         }
      }
   }
}
