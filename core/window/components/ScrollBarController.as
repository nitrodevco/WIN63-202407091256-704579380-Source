package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowTouchEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.core.window.utils.tablet.ITouchAwareWindow;
   import flash.geom.Rectangle;
   
   public class ScrollBarController extends InteractiveController implements IScrollbarWindow, ITouchAwareWindow
   {
      
      private static const SCROLL_BUTTON_INCREMENT:String = "increment";
      
      private static const SCROLL_BUTTON_DECREMENT:String = "decrement";
      
      private static const SCROLL_SLIDER_TRACK:String = "slider_track";
      
      private static const SCROLL_SLIDER_BAR:String = "slider_bar";
       
      
      protected var _offset:Number = 0;
      
      protected var var_2835:Number = 0.1;
      
      protected var var_1646:IScrollableWindow;
      
      private var var_1851:Boolean;
      
      private var _targetName:String;
      
      private var var_2575:Boolean = false;
      
      public function ScrollBarController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function, param9:Array = null, param10:Array = null, param11:uint = 0, param12:IScrollableWindow = null)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         var_1871 = false;
         var_1646 = param12;
         var_1851 = param2 == 130;
         var _loc13_:Array = [];
         groupChildrenWithTag("_INTERNAL",_loc13_,-1);
         for each(var _loc14_ in _loc13_)
         {
            _loc14_.procedure = scrollButtonEventProc;
         }
         updateLiftSizeAndPosition();
      }
      
      public function get scrollH() : Number
      {
         return var_1851 ? _offset : 0;
      }
      
      public function get scrollV() : Number
      {
         return var_1851 ? 0 : _offset;
      }
      
      public function get scrollable() : IScrollableWindow
      {
         return var_1646;
      }
      
      public function set scrollH(param1:Number) : void
      {
         if(var_1851)
         {
            if(setScrollPosition(param1,true))
            {
               updateLiftSizeAndPosition();
            }
         }
      }
      
      public function set scrollV(param1:Number) : void
      {
         if(!var_1851)
         {
            if(setScrollPosition(param1,true))
            {
               updateLiftSizeAndPosition();
            }
         }
      }
      
      public function set scrollable(param1:IScrollableWindow) : void
      {
         if(var_1646 != null && !var_1646.disposed)
         {
            var_1646.removeEventListener("WE_RESIZED",onScrollableResized);
            var_1646.removeEventListener("WE_SCROLL",onScrollableScrolled);
         }
         var_1646 = param1;
         if(var_1646 != null && !var_1646.disposed)
         {
            var_1646.addEventListener("WE_RESIZED",onScrollableResized);
            var_1646.addEventListener("WE_SCROLL",onScrollableScrolled);
            updateLiftSizeAndPosition();
         }
      }
      
      public function get horizontal() : Boolean
      {
         return var_1851;
      }
      
      public function get vertical() : Boolean
      {
         return !var_1851;
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         var _loc2_:String = null;
         if(var_1646 is IWindow)
         {
            _loc2_ = String(IWindow(var_1646).name);
         }
         else if(_targetName != null)
         {
            _loc2_ = _targetName;
         }
         if(_loc2_ == null)
         {
            _loc1_.push(getDefaultProperty("scrollable"));
         }
         else
         {
            _loc1_.push(createProperty("scrollable",_loc2_));
         }
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            var _loc3_:* = _loc2_.key;
            if("scrollable" === _loc3_)
            {
               _targetName = _loc2_.value as String;
               var_1646 = null;
            }
         }
         super.properties = param1;
      }
      
      protected function get track() : WindowController
      {
         return findChildByName("slider_track") as WindowController;
      }
      
      protected function get lift() : WindowController
      {
         return track.findChildByName("slider_bar") as WindowController;
      }
      
      override public function dispose() : void
      {
         scrollable = null;
         super.dispose();
      }
      
      override public function enable() : Boolean
      {
         var _loc1_:Array = null;
         var _loc2_:* = 0;
         if(super.enable())
         {
            _loc1_ = [];
            groupChildrenWithTag("_INTERNAL",_loc1_,-1);
            _loc2_ = 0;
            while(_loc2_ < _loc1_.length)
            {
               IWindow(_loc1_[_loc2_]).enable();
               _loc2_++;
            }
            return true;
         }
         return false;
      }
      
      override public function disable() : Boolean
      {
         var _loc1_:Array = null;
         var _loc2_:* = 0;
         if(super.disable())
         {
            _loc1_ = [];
            groupChildrenWithTag("_INTERNAL",_loc1_,-1);
            _loc2_ = 0;
            while(_loc2_ < _loc1_.length)
            {
               IWindow(_loc1_[_loc2_]).disable();
               _loc2_++;
            }
            return true;
         }
         return false;
      }
      
      protected function setScrollPosition(param1:Number, param2:Boolean) : Boolean
      {
         var _loc3_:* = false;
         if(var_1646 == null || Boolean(var_1646.disposed))
         {
            if(!resolveScrollTarget())
            {
               return false;
            }
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 > 1)
         {
            param1 = 1;
         }
         _offset = param1;
         if(param2)
         {
            if(var_1851)
            {
               _loc3_ = var_1646.scrollH != _offset;
               if(_loc3_)
               {
                  var_1646.scrollH = _offset;
               }
            }
            else
            {
               _loc3_ = var_1646.scrollV != _offset;
               if(_loc3_)
               {
                  var_1646.scrollV = _offset;
               }
            }
         }
         return _loc3_;
      }
      
      override public function update(param1:WindowController, param2:WindowEvent) : Boolean
      {
         var _loc3_:ScrollBarLiftController = null;
         var _loc5_:* = param1.name;
         if("slider_bar" === _loc5_)
         {
            if(param2.type == "WE_CHILD_RELOCATED")
            {
               if(!var_2575)
               {
                  _loc3_ = ScrollBarLiftController(param1);
                  if(var_1851)
                  {
                     setScrollPosition(_loc3_.scrollbarOffsetX,true);
                  }
                  else
                  {
                     setScrollPosition(_loc3_.scrollbarOffsetY,true);
                  }
               }
            }
         }
         var _loc4_:Boolean = super.update(param1,param2);
         if(param2.type == "WE_PARENT_ADDED")
         {
            if(var_1646 == null)
            {
               resolveScrollTarget();
            }
         }
         if(param1 == this)
         {
            if(param2.type == "WE_RESIZED")
            {
               updateLiftSizeAndPosition();
            }
            else if(param2.type == "WME_WHEEL")
            {
               if(WindowMouseEvent(param2).delta > 0)
               {
                  if(var_1851)
                  {
                     scrollH -= var_2835;
                  }
                  else
                  {
                     scrollV -= var_2835;
                  }
               }
               else if(var_1851)
               {
                  scrollH += var_2835;
               }
               else
               {
                  scrollV += var_2835;
               }
               _loc4_ = true;
            }
         }
         return _loc4_;
      }
      
      private function updateLiftSizeAndPosition() : void
      {
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         if(var_1646 == null || Boolean(var_1646.disposed))
         {
            if(_disposed || !resolveScrollTarget())
            {
               return;
            }
         }
         var _loc2_:WindowController = track;
         var _loc1_:WindowController = lift;
         if(_loc1_ != null)
         {
            if(var_1851)
            {
               if((_loc4_ = var_1646.visibleRegion.width / var_1646.scrollableRegion.width) > 1)
               {
                  _loc4_ = 1;
               }
               _loc3_ = _loc4_ * _loc2_.width;
               _loc1_.width = _loc3_;
               _loc1_.x = Math.round(var_1646.scrollH * (_loc2_.width - _loc3_));
            }
            else
            {
               if((_loc4_ = var_1646.visibleRegion.height / var_1646.scrollableRegion.height) > 1)
               {
                  _loc4_ = 1;
               }
               _loc3_ = _loc4_ * _loc2_.height;
               _loc1_.height = _loc3_;
               _loc1_.y = Math.round(var_1646.scrollV * (_loc2_.height - _loc1_.height));
            }
         }
         if(_loc4_ == 1)
         {
            disable();
         }
         else
         {
            enable();
         }
      }
      
      private function nullEventProc(param1:WindowEvent, param2:IWindow) : void
      {
      }
      
      private function scrollButtonEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:IWindow = null;
         var _loc6_:Boolean = false;
         if(param1.type == "WME_DOWN" || param1.type == "WTE_TAP")
         {
            if(param2.name == "increment")
            {
               if(var_1646)
               {
                  var_2575 = true;
                  if(var_1851)
                  {
                     scrollH += var_1646.scrollStepH / var_1646.maxScrollH;
                  }
                  else
                  {
                     scrollV += var_1646.scrollStepV / var_1646.maxScrollV;
                  }
                  var_2575 = false;
               }
            }
            else if(param2.name == "decrement")
            {
               if(var_1646)
               {
                  var_2575 = true;
                  if(var_1851)
                  {
                     scrollH -= var_1646.scrollStepH / var_1646.maxScrollH;
                  }
                  else
                  {
                     scrollV -= var_1646.scrollStepV / var_1646.maxScrollV;
                  }
                  var_2575 = false;
               }
            }
            else if(param2.name == "slider_track")
            {
               if(param1 is WindowMouseEvent)
               {
                  _loc5_ = int(WindowMouseEvent(param1).localX);
                  _loc4_ = int(WindowMouseEvent(param1).localY);
               }
               else if(param1 is WindowTouchEvent)
               {
                  _loc5_ = int(WindowTouchEvent(param1).localX);
                  _loc4_ = int(WindowTouchEvent(param1).localY);
               }
               _loc3_ = WindowController(param2).getChildByName("slider_bar");
               if(var_1851)
               {
                  if(_loc5_ < _loc3_.x)
                  {
                     scrollH -= (var_1646.visibleRegion.width - var_1646.scrollStepH) / var_1646.maxScrollH;
                  }
                  else if(_loc5_ > _loc3_.right)
                  {
                     scrollH += (var_1646.visibleRegion.width - var_1646.scrollStepH) / var_1646.maxScrollH;
                  }
               }
               else if(_loc4_ < _loc3_.y)
               {
                  scrollV -= (var_1646.visibleRegion.height - var_1646.scrollStepV) / var_1646.maxScrollV;
               }
               else if(_loc4_ > _loc3_.bottom)
               {
                  scrollV += (var_1646.visibleRegion.height - var_1646.scrollStepV) / var_1646.maxScrollV;
               }
               _loc6_ = true;
            }
         }
         if(param1.type == "WME_WHEEL")
         {
            if(WindowMouseEvent(param1).delta > 0)
            {
               if(var_1851)
               {
                  scrollH -= var_2835;
               }
               else
               {
                  scrollV -= var_2835;
               }
            }
            else if(var_1851)
            {
               scrollH += var_2835;
            }
            else
            {
               scrollV += var_2835;
            }
            _loc6_ = true;
         }
         if(_loc6_)
         {
            updateLiftSizeAndPosition();
         }
      }
      
      private function resolveScrollTarget() : Boolean
      {
         var _loc1_:IScrollableWindow = null;
         var _loc4_:IScrollableWindow = null;
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(var_1646 != null)
         {
            if(!var_1646.disposed)
            {
               return true;
            }
         }
         if(_targetName != null)
         {
            _loc1_ = findParentByName(_targetName) as IScrollableWindow;
            if(_loc1_ == null && _parent is IWindowContainer && !(_parent is class_3460))
            {
               _loc1_ = IWindowContainer(_parent).findChildByName(_targetName) as IScrollableWindow;
               if(_loc1_)
               {
                  scrollable = _loc1_;
                  return true;
               }
            }
         }
         if(_parent is IScrollableWindow)
         {
            scrollable = IScrollableWindow(_parent);
            return true;
         }
         if(_parent is IWindowContainer && !(_parent is class_3460))
         {
            _loc2_ = uint(IWindowContainer(_parent).numChildren);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if(_loc4_ = IWindowContainer(_parent).getChildAt(_loc3_) as IScrollableWindow)
               {
                  scrollable = _loc4_;
                  return true;
               }
               _loc3_++;
            }
         }
         return false;
      }
      
      private function onScrollableResized(param1:WindowEvent) : void
      {
         updateLiftSizeAndPosition();
         setScrollPosition(_offset,false);
      }
      
      private function onScrollableScrolled(param1:WindowEvent) : void
      {
         updateLiftSizeAndPosition();
      }
   }
}
