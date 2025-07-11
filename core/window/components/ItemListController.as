package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.iterators.ItemListIterator;
   import com.sulake.core.window.theme.IThemeManager;
   import com.sulake.core.window.utils.IInputProcessorRoot;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class ItemListController extends WindowController implements IItemListWindow, IInputProcessorRoot
   {
       
      
      private var var_4362:Boolean = false;
      
      private var var_4017:Boolean = false;
      
      protected var var_2233:Number;
      
      protected var var_2216:Number;
      
      protected var _scrollAreaWidth:Number;
      
      protected var var_1727:Number;
      
      protected var _container:IWindowContainer;
      
      protected var var_3805:Boolean = false;
      
      protected var var_1896:Boolean = false;
      
      protected var var_2036:int;
      
      protected var var_1851:Boolean = false;
      
      protected var _arrangeListItems:Boolean;
      
      protected var _scaleToFitItems:Boolean;
      
      protected var _resizeOnItemUpdate:Boolean;
      
      protected var var_4529:Number;
      
      protected var var_4197:Number;
      
      protected var var_4599:Number;
      
      protected var var_4568:Number;
      
      protected var var_2957:Boolean;
      
      protected var _scrollWheelStartTime:Number;
      
      protected var var_2152:Number;
      
      protected var var_4368:Number = 200;
      
      protected var var_3291:Number = 25;
      
      protected var var_3536:Number = 25;
      
      protected var var_2717:Number = 0;
      
      protected var var_2528:Timer;
      
      public function ItemListController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         var_2233 = 0;
         var_2216 = 0;
         _scrollAreaWidth = 0;
         var_1727 = 0;
         var_1851 = param2 == 51;
         var _loc13_:IThemeManager;
         var_2036 = int((_loc13_ = param5.getWindowFactory().getThemeManager()).getPropertyDefaults(param3).method_20("spacing").value);
         _arrangeListItems = _loc13_.getPropertyDefaults(param3).method_20("auto_arrange_items").value;
         _scaleToFitItems = _loc13_.getPropertyDefaults(param3).method_20("scale_to_fit_items").value;
         _resizeOnItemUpdate = _loc13_.getPropertyDefaults(param3).method_20("resize_on_item_update").value;
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         var_1871 = _background || !testParamFlag(16);
         _container = _context.create("_CONTAINER","",4,0,16 | 0 | 0,new Rectangle(0,0,width,height),null,this,0,null,"",["_INTERNAL","_EXCLUDE"]) as IWindowContainer;
         _container.addEventListener("WE_RESIZED",containerEventHandler);
         _container.addEventListener("WE_CHILD_REMOVED",containerEventHandler);
         _container.addEventListener("WE_CHILD_RESIZED",containerEventHandler);
         _container.addEventListener("WE_CHILD_RELOCATED",containerEventHandler);
         _container.clipping = clipping;
         resizeOnItemUpdate = _resizeOnItemUpdate;
         var _loc14_:int = 60;
         var _loc12_:int = 1000 / _loc14_;
         var _loc15_:int = var_4368 / _loc12_ + 10;
         var_2528 = new Timer(_loc12_,_loc15_);
         var_2528.addEventListener("timer",updateScrolling);
         var_2528.addEventListener("timerComplete",endScrollWheel);
      }
      
      private static function smoothInterpolation(param1:Number, param2:Number, param3:Number) : Number
      {
         if(param3 > 1)
         {
            param3 = 1;
         }
         if(param3 < 0)
         {
            param3 = 0;
         }
         return param1 + (param2 - param1) * param3;
      }
      
      public function get spacing() : int
      {
         return var_2036;
      }
      
      public function set spacing(param1:int) : void
      {
         if(param1 != var_2036)
         {
            var_2036 = param1;
            updateScrollAreaRegion();
         }
      }
      
      public function get scrollH() : Number
      {
         return var_2233;
      }
      
      public function get scrollV() : Number
      {
         return var_2216;
      }
      
      public function get maxScrollH() : int
      {
         return Math.max(0,_scrollAreaWidth - width);
      }
      
      public function get maxScrollV() : int
      {
         return Math.max(0,var_1727 - height);
      }
      
      public function get isPartOfGridWindow() : Boolean
      {
         return var_4017;
      }
      
      public function set isPartOfGridWindow(param1:Boolean) : void
      {
         var_4017 = param1;
      }
      
      public function get scrollableWindow() : IWindow
      {
         return this;
      }
      
      public function get visibleRegion() : Rectangle
      {
         return new Rectangle(var_2233 * maxScrollH,var_2216 * maxScrollV,width,height);
      }
      
      public function get scrollableRegion() : Rectangle
      {
         return _container.rectangle;
      }
      
      public function set scrollH(param1:Number) : void
      {
         setScrollH(param1,false);
      }
      
      private function setScrollH(param1:Number, param2:Boolean) : void
      {
         var _loc4_:WindowEvent = null;
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 > 1)
         {
            param1 = 1;
         }
         var _loc3_:Number = param1 - var_2233;
         if(param1 != var_2233)
         {
            var_2233 = param1;
            _container.x = -var_2233 * maxScrollH;
            _context.invalidate(_container,visibleRegion,1);
            if(name_1)
            {
               _loc4_ = WindowEvent.allocate("WE_SCROLL",this,null);
               name_1.dispatchEvent(_loc4_);
               _loc4_.recycle();
            }
         }
         if(!param2 && isScrollingWithWheel)
         {
            var_2152 += _loc3_;
         }
      }
      
      public function set scrollV(param1:Number) : void
      {
         setScrollV(param1,false);
      }
      
      private function setScrollV(param1:Number, param2:Boolean) : void
      {
         var _loc4_:WindowEvent = null;
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 > 1)
         {
            param1 = 1;
         }
         var _loc3_:Number = param1 - var_2216;
         if(param1 != var_2216)
         {
            var_2216 = param1;
            _container.y = -var_2216 * maxScrollV;
            _context.invalidate(_container,visibleRegion,1);
            if(name_1)
            {
               _loc4_ = WindowEvent.allocate("WE_SCROLL",this,null);
               name_1.dispatchEvent(_loc4_);
               _loc4_.recycle();
            }
         }
         if(!param2 && isScrollingWithWheel)
         {
            var_2152 += _loc3_;
         }
      }
      
      public function get scrollStepH() : Number
      {
         return var_3291;
      }
      
      public function get scrollStepV() : Number
      {
         return var_3536;
      }
      
      public function set scrollStepH(param1:Number) : void
      {
         var_3291 = param1;
      }
      
      public function set scrollStepV(param1:Number) : void
      {
         var_3536 = param1;
      }
      
      public function set scaleToFitItems(param1:Boolean) : void
      {
         if(_scaleToFitItems != param1)
         {
            _scaleToFitItems = param1;
            updateScrollAreaRegion();
         }
      }
      
      public function get scaleToFitItems() : Boolean
      {
         return _scaleToFitItems;
      }
      
      public function set autoArrangeItems(param1:Boolean) : void
      {
         _arrangeListItems = param1;
         updateScrollAreaRegion();
      }
      
      public function get autoArrangeItems() : Boolean
      {
         return _arrangeListItems;
      }
      
      public function set resizeOnItemUpdate(param1:Boolean) : void
      {
         _resizeOnItemUpdate = param1;
         if(_container)
         {
            if(var_1851)
            {
               _container.setParamFlag(4194304,param1);
            }
            else
            {
               _container.setParamFlag(8388608,param1);
            }
         }
      }
      
      public function get resizeOnItemUpdate() : Boolean
      {
         return _resizeOnItemUpdate;
      }
      
      public function get iterator() : IIterator
      {
         return new ItemListIterator(this);
      }
      
      public function get firstListItem() : IWindow
      {
         return numListItems > 0 ? getListItemAt(0) : null;
      }
      
      public function get lastListItem() : IWindow
      {
         return numListItems > 0 ? getListItemAt(numListItems - 1) : null;
      }
      
      override public function set clipping(param1:Boolean) : void
      {
         super.clipping = param1;
         if(_container)
         {
            _container.clipping = param1;
         }
      }
      
      override public function dispose() : void
      {
         if(!_disposed)
         {
            _container.removeEventListener("WE_RESIZED",containerEventHandler);
            _container.removeEventListener("WE_CHILD_REMOVED",containerEventHandler);
            _container.removeEventListener("WE_CHILD_RESIZED",containerEventHandler);
            _container.removeEventListener("WE_CHILD_RELOCATED",containerEventHandler);
            var_2528.removeEventListener("timer",updateScrolling);
            var_2528.removeEventListener("timerComplete",endScrollWheel);
            super.dispose();
         }
      }
      
      override protected function cloneChildWindows(param1:WindowController) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < numListItems)
         {
            IItemListWindow(param1).addListItem(getListItemAt(_loc2_).clone());
            _loc2_++;
         }
      }
      
      public function get numListItems() : int
      {
         return _container != null ? _container.numChildren : 0;
      }
      
      public function addListItem(param1:IWindow) : IWindow
      {
         var_1896 = true;
         if(var_1851)
         {
            param1.x = _scrollAreaWidth + (numListItems > 0 ? var_2036 : 0);
            _scrollAreaWidth = param1.right;
            _container.width = _scrollAreaWidth;
         }
         else
         {
            if(autoArrangeItems)
            {
               param1.y = var_1727 + (numListItems > 0 ? var_2036 : 0);
               var_1727 = param1.bottom;
            }
            else
            {
               var_1727 = Math.max(var_1727,param1.bottom);
            }
            _container.height = var_1727;
         }
         param1 = _container.addChild(param1);
         var_1896 = false;
         return param1;
      }
      
      public function addListItemAt(param1:IWindow, param2:uint) : IWindow
      {
         param1 = _container.addChildAt(param1,param2);
         updateScrollAreaRegion();
         return param1;
      }
      
      public function getListItemAt(param1:uint) : IWindow
      {
         return _container.getChildAt(param1);
      }
      
      public function getListItemByID(param1:uint) : IWindow
      {
         return _container.getChildByID(param1);
      }
      
      public function getListItemByName(param1:String) : IWindow
      {
         return _container.getChildByName(param1);
      }
      
      public function getListItemByTag(param1:String) : IWindow
      {
         return _container.getChildByTag(param1);
      }
      
      public function getListItemIndex(param1:IWindow) : int
      {
         return _container.getChildIndex(param1);
      }
      
      public function removeListItem(param1:IWindow) : IWindow
      {
         param1 = _container.removeChild(param1);
         if(param1)
         {
            updateScrollAreaRegion();
         }
         return param1;
      }
      
      public function removeListItemAt(param1:int) : IWindow
      {
         return _container.removeChildAt(param1);
      }
      
      public function setListItemIndex(param1:IWindow, param2:int) : void
      {
         _container.setChildIndex(param1,param2);
      }
      
      public function swapListItems(param1:IWindow, param2:IWindow) : void
      {
         _container.swapChildren(param1,param2);
         updateScrollAreaRegion();
      }
      
      public function swapListItemsAt(param1:int, param2:int) : void
      {
         _container.swapChildrenAt(param1,param2);
         updateScrollAreaRegion();
      }
      
      public function groupListItemsWithID(param1:uint, param2:Array, param3:int = 0) : uint
      {
         return _container.groupChildrenWithID(param1,param2,param3);
      }
      
      public function groupListItemsWithTag(param1:String, param2:Array, param3:int = 0) : uint
      {
         return _container.groupChildrenWithTag(param1,param2,param3);
      }
      
      public function removeListItems() : void
      {
         var_1896 = true;
         while(numListItems > 0)
         {
            _container.removeChildAt(0);
         }
         var_1896 = false;
         updateScrollAreaRegion();
      }
      
      public function destroyListItems() : void
      {
         var_1896 = true;
         while(numListItems > 0)
         {
            _container.removeChildAt(0).destroy();
         }
         var_1896 = false;
         updateScrollAreaRegion();
      }
      
      public function arrangeListItems() : void
      {
         updateScrollAreaRegion();
      }
      
      override public function populate(param1:Array) : void
      {
         WindowController(_container).populate(param1);
         updateScrollAreaRegion();
      }
      
      override public function update(param1:WindowController, param2:WindowEvent) : Boolean
      {
         var _loc3_:Boolean = super.update(param1,param2);
         switch(param2.type)
         {
            case "WE_RESIZE":
               var_3805 = true;
               break;
            case "WE_RESIZED":
               if(!_scaleToFitItems)
               {
                  if(var_1851)
                  {
                     _container.height = var_1642;
                  }
                  else
                  {
                     _container.width = var_1637;
                  }
               }
               updateScrollAreaRegion();
               var_3805 = false;
               break;
            default:
               if(param2 is WindowEvent)
               {
                  _loc3_ = process(param2 as WindowEvent);
               }
         }
         return _loc3_;
      }
      
      override public function validateLocalPointIntersection(param1:Point, param2:BitmapData) : Boolean
      {
         return isInWindowBounds(param1);
      }
      
      public function process(param1:WindowEvent) : Boolean
      {
         var _loc5_:* = false;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         if(param1 is WindowMouseEvent)
         {
            _loc3_ = int(WindowMouseEvent(param1).localX);
            _loc4_ = int(WindowMouseEvent(param1).localY);
         }
         switch(param1.type)
         {
            case "WME_WHEEL":
               handleScrollWheelEvent(param1);
               _loc5_ = !var_4017;
               break;
            case "WME_DOWN":
               var_4529 = _loc3_;
               var_4197 = _loc4_;
               var_4599 = var_2233 * maxScrollH;
               var_4568 = var_2216 * maxScrollV;
               var_2957 = true;
               _loc5_ = true;
               break;
            case "WME_MOVE":
               if(var_2957 && !var_4362)
               {
                  if(var_1851)
                  {
                     scrollH = (var_4599 + var_4529 - _loc3_) / maxScrollH;
                  }
                  else
                  {
                     scrollV = (var_4568 + var_4197 - _loc4_) / maxScrollV;
                  }
                  _loc5_ = true;
               }
               break;
            case "WME_UP":
            case "WME_UP_OUTSIDE":
               if(var_2957)
               {
                  var_2957 = false;
                  _loc5_ = true;
               }
         }
         return _loc5_;
      }
      
      protected function get isScrollHorizontal() : Boolean
      {
         return var_1851;
      }
      
      protected function updateScrolling(param1:TimerEvent) : void
      {
         var _loc2_:Number = getTimer();
         var _loc5_:Number = (_loc2_ - _scrollWheelStartTime + 16.6) / var_4368;
         var _loc3_:* = _loc2_ + 16.6 >= _scrollWheelStartTime + var_4368;
         var _loc4_:Number = smoothInterpolation(var_2152,scrollWheelTargetPos,_loc5_);
         if(isScrollHorizontal)
         {
            setScrollH(_loc4_,true);
         }
         else
         {
            setScrollV(_loc4_,true);
         }
         if(_loc3_)
         {
            endScrollWheel();
         }
      }
      
      private function endScrollWheel(param1:TimerEvent = null) : void
      {
         if(!isScrollingWithWheel)
         {
            return;
         }
         _scrollWheelStartTime = 0;
         var_2152 = 0;
         var_2717 = 0;
         var_2528.reset();
      }
      
      private function get isScrollingWithWheel() : Boolean
      {
         return var_2528.running;
      }
      
      private function get scrollWheelTargetPos() : Number
      {
         if(isScrollHorizontal)
         {
            return var_2152 - var_2717 * scrollStepH / maxScrollH;
         }
         return var_2152 - var_2717 * scrollStepV / maxScrollV;
      }
      
      public function scrollWithWheel(param1:int) : void
      {
         if(isScrollingWithWheel && (var_2717 > 0 && param1 < 0 || var_2717 < 0 && param1 > 0))
         {
            endScrollWheel();
         }
         _scrollWheelStartTime = getTimer();
         var_2152 = isScrollHorizontal ? scrollH : scrollV;
         var_2717 += param1;
         var_2528.reset();
         var_2528.start();
         updateScrolling(null);
      }
      
      protected function handleScrollWheelEvent(param1:WindowEvent) : void
      {
         scrollWithWheel(WindowMouseEvent(param1).delta);
      }
      
      private function containerEventHandler(param1:WindowEvent) : void
      {
         var _loc2_:WindowEvent = null;
         switch(param1.type)
         {
            case "WE_CHILD_REMOVED":
               updateScrollAreaRegion();
               break;
            case "WE_CHILD_RESIZED":
               if(!var_3805)
               {
                  updateScrollAreaRegion();
               }
               break;
            case "WE_CHILD_RELOCATED":
               updateScrollAreaRegion();
               break;
            case "WE_RESIZED":
               if(name_1)
               {
                  _loc2_ = WindowEvent.allocate("WE_RESIZED",this,null);
                  name_1.dispatchEvent(_loc2_);
                  _loc2_.recycle();
               }
         }
      }
      
      protected function updateScrollAreaRegion() : void
      {
         var _loc4_:IWindow = null;
         var _loc1_:int = 0;
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(_arrangeListItems && !var_1896 && _container)
         {
            var_1896 = true;
            _loc2_ = uint(_container.numChildren);
            if(var_1851)
            {
               _scrollAreaWidth = 0;
               var_1727 = var_1642;
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  if((_loc4_ = _container.getChildAt(_loc3_)).visible)
                  {
                     _loc4_.x = _scrollAreaWidth;
                     _scrollAreaWidth += _loc4_.width + var_2036;
                     if(_scaleToFitItems)
                     {
                        _loc1_ = _loc4_.height + _loc4_.y;
                        var_1727 = _loc1_ > var_1727 ? _loc1_ : var_1727;
                     }
                  }
                  _loc3_++;
               }
               if(_loc2_ > 0)
               {
                  _scrollAreaWidth -= var_2036;
               }
            }
            else
            {
               _scrollAreaWidth = var_1637;
               var_1727 = 0;
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  if((_loc4_ = _container.getChildAt(_loc3_)).visible)
                  {
                     _loc4_.y = var_1727;
                     var_1727 += _loc4_.height + var_2036;
                     if(_scaleToFitItems)
                     {
                        _loc1_ = _loc4_.width + _loc4_.x;
                        _scrollAreaWidth = _loc1_ > _scrollAreaWidth ? _loc1_ : _scrollAreaWidth;
                     }
                  }
                  _loc3_++;
               }
               if(_loc2_ > 0)
               {
                  var_1727 -= var_2036;
               }
            }
            if(var_2233 > 0)
            {
               if(_scrollAreaWidth <= var_1637)
               {
                  scrollH = 0;
               }
               else
               {
                  _container.x = -(var_2233 * maxScrollH);
               }
            }
            if(var_2216 > 0)
            {
               if(var_1727 <= var_1642)
               {
                  scrollV = 0;
               }
               else
               {
                  _container.y = -(var_2216 * maxScrollV);
               }
            }
            _container.height = var_1727;
            _container.width = _scrollAreaWidth;
            var_1896 = false;
         }
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.push(createProperty("spacing",var_2036));
         _loc1_.push(createProperty("auto_arrange_items",_arrangeListItems));
         _loc1_.push(createProperty("scale_to_fit_items",_scaleToFitItems));
         _loc1_.push(createProperty("resize_on_item_update",_resizeOnItemUpdate));
         _loc1_.push(createProperty("scroll_step_h",var_3291));
         _loc1_.push(createProperty("scroll_step_v",var_3536));
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "spacing":
                  spacing = _loc2_.value as int;
                  break;
               case "scale_to_fit_items":
                  scaleToFitItems = _loc2_.value as Boolean;
                  break;
               case "resize_on_item_update":
                  resizeOnItemUpdate = _loc2_.value as Boolean;
                  break;
               case "auto_arrange_items":
                  _arrangeListItems = _loc2_.value as Boolean;
                  break;
               case "scroll_step_h":
                  var_3291 = _loc2_.value as Number;
                  break;
               case "scroll_step_v":
                  var_3536 = _loc2_.value as Number;
                  break;
            }
         }
         super.properties = param1;
      }
      
      public function stopDragging() : void
      {
         var_2957 = false;
      }
      
      public function set disableAutodrag(param1:Boolean) : void
      {
         var_4362 = param1;
      }
   }
}
