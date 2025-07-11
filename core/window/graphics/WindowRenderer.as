package com.sulake.core.window.graphics
{
   import com.sulake.core.utils.profiler.tracking.TrackedBitmapData;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.class_3400;
   import com.sulake.core.window.components.class_3460;
   import com.sulake.core.window.events.WindowDisposeEvent;
   import com.sulake.core.window.utils.class_3402;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class WindowRenderer implements class_3354
   {
      
      protected static const RECT:Rectangle = new Rectangle();
      
      protected static const MAX_DIRTY_REGIONS_PER_WINDOW:int = 3;
      
      protected static const MAX_DISTANCE_BEFORE_COMBINE:int = 10;
      
      private static const POINT_ZERO:Point = new Point();
       
      
      protected var var_154:Boolean = false;
      
      protected var _disposed:Boolean;
      
      protected var var_2226:ISkinContainer;
      
      protected var var_1957:Dictionary;
      
      protected var var_2389:Vector.<IWindow>;
      
      protected var var_2523:Vector.<Array>;
      
      protected var var_3560:Point;
      
      protected var var_3939:Rectangle;
      
      protected var var_1686:Rectangle;
      
      protected var var_3103:Rectangle;
      
      public function WindowRenderer(param1:ISkinContainer)
      {
         super();
         _disposed = false;
         var_2226 = param1;
         var_1957 = new Dictionary(false);
         var_2389 = new Vector.<IWindow>();
         var_2523 = new Vector.<Array>();
         var_3560 = new Point();
         var_3939 = new Rectangle();
         var_1686 = new Rectangle();
         var_3103 = new Rectangle();
      }
      
      private static function areRectanglesCloseEnough(param1:Rectangle, param2:Rectangle, param3:uint) : Boolean
      {
         if(param1.intersects(param2))
         {
            return true;
         }
         return (param1.left > param2.left ? param1.left - param2.right : param2.left - param1.right) <= param3 && (param1.top > param2.top ? param1.top - param2.bottom : param2.top - param1.bottom) <= param3;
      }
      
      private static function getDrawLocationAndClipRegion(param1:IWindow, param2:Rectangle, param3:Point, param4:Rectangle) : Boolean
      {
         var _loc6_:int = 0;
         var _loc5_:Boolean = true;
         param4.x = 0;
         param4.y = 0;
         param4.width = param1.renderingWidth;
         param4.height = param1.renderingHeight;
         if(!param1.testParamFlag(16))
         {
            if(param1.parent && param1.testParamFlag(1073741824))
            {
               _loc5_ = childRectToClippedDrawRegion(param1.parent,param3,param4);
               param3.x = param4.x;
               param3.y = param4.y;
            }
            else
            {
               param3.x = 0;
               param3.y = 0;
            }
         }
         else if(param1.parent)
         {
            _loc5_ = childRectToClippedDrawRegion(param1.parent,param3,param4);
         }
         else
         {
            param3.x = 0;
            param3.y = 0;
         }
         if(param2.x > param4.x)
         {
            _loc6_ = param2.x - param4.x;
            param3.x += _loc6_;
            param4.x += _loc6_;
            param4.width -= _loc6_;
         }
         if(param2.y > param4.y)
         {
            _loc6_ = param2.y - param4.y;
            param3.y += _loc6_;
            param4.y += _loc6_;
            param4.height -= _loc6_;
         }
         if(param2.right < param4.right)
         {
            _loc6_ = param4.right - param2.right;
            param4.width -= _loc6_;
         }
         if(param2.bottom < param4.bottom)
         {
            _loc6_ = param4.bottom - param2.bottom;
            param4.height -= _loc6_;
         }
         return _loc5_ && param4.width > 0 && param4.height > 0;
      }
      
      private static function childRectToClippedDrawRegion(param1:IWindow, param2:Point, param3:Rectangle) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(param1.testParamFlag(16))
         {
            _loc5_ = param1.renderingX;
            _loc6_ = param1.renderingY;
            param2.offset(_loc5_,_loc6_);
            if(param1.clipping)
            {
               if(param2.x < _loc5_)
               {
                  _loc4_ = _loc5_ - param2.x;
                  param3.x += _loc4_;
                  param3.width -= _loc4_;
                  param2.x = _loc5_;
               }
               if(param2.x < 0)
               {
                  param3.x -= param2.x;
                  param3.width += param2.x;
                  param2.x = 0;
               }
               if(param2.y < _loc6_)
               {
                  _loc4_ = _loc6_ - param2.y;
                  param3.y += _loc4_;
                  param3.height -= _loc4_;
                  param2.y = _loc6_;
               }
               if(param2.y < 0)
               {
                  param3.y -= param2.y;
                  param3.height += param2.y;
                  param2.y = 0;
               }
               if(param2.x + param3.width > _loc5_ + param1.renderingWidth)
               {
                  param3.width -= param2.x + param3.width - (_loc5_ + param1.renderingWidth);
               }
               if(param2.y + param3.height > _loc6_ + param1.renderingHeight)
               {
                  param3.height -= param2.y + param3.height - (_loc6_ + param1.renderingHeight);
               }
            }
            if(param1.parent)
            {
               childRectToClippedDrawRegion(param1.parent,param2,param3);
            }
         }
         else if(param1.clipping)
         {
            if(param2.x < 0)
            {
               _loc4_ = param2.x;
               param3.x -= _loc4_;
               param3.width += _loc4_;
               param2.x = 0;
            }
            if(param2.y < 0)
            {
               _loc4_ = param2.y;
               param3.y -= _loc4_;
               param3.height += _loc4_;
               param2.y = 0;
            }
         }
         return param3.width > 0 && param3.height > 0;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set debug(param1:Boolean) : void
      {
         var_154 = param1;
      }
      
      public function get debug() : Boolean
      {
         return var_154;
      }
      
      public function dispose() : void
      {
         var _loc1_:WindowRendererItem = null;
         if(!_disposed)
         {
            _disposed = true;
            for(var _loc2_ in var_1957)
            {
               _loc1_ = var_1957[_loc2_] as WindowRendererItem;
               _loc1_.dispose();
               delete var_1957[_loc2_];
            }
            var_1957 = null;
            var_2389 = null;
            var_2523 = null;
         }
      }
      
      public function purge(param1:IWindow = null, param2:Boolean = true) : void
      {
         var _loc3_:WindowRendererItem = null;
         var _loc5_:class_3402 = null;
         var _loc4_:* = undefined;
         if(param1)
         {
            if(!param1.visible || !param2)
            {
               _loc3_ = var_1957[param1];
               if(_loc3_)
               {
                  _loc3_.dispose();
                  delete var_1957[param1];
               }
               param2 = false;
            }
            if(_loc5_ = param1 as class_3402)
            {
               for each(param1 in _loc5_.children)
               {
                  purge(param1,param2);
               }
            }
         }
         else
         {
            _loc4_ = new Vector.<IWindow>();
            for(var _loc6_ in var_1957)
            {
               param1 = _loc6_ as IWindow;
               if(!param1.visible || !param2 || param1.parent == null && !(param1 is class_3460))
               {
                  _loc4_.push(param1);
               }
            }
            while(_loc4_.length)
            {
               purge(_loc4_.pop(),param2);
            }
         }
      }
      
      public function addToRenderQueue(param1:IWindow, param2:Rectangle, param3:uint) : void
      {
         var _loc8_:int = 0;
         var _loc12_:int = 0;
         var _loc4_:IWindow = null;
         var _loc5_:Array = null;
         var _loc10_:int = 0;
         var _loc6_:Rectangle = null;
         var _loc11_:Rectangle = null;
         if(!param2)
         {
            param2 = var_1686;
            var_1686.x = 0;
            var_1686.y = 0;
            var_1686.width = param1.renderingWidth;
            var_1686.height = param1.renderingHeight;
         }
         else
         {
            var_1686.x = param2.x;
            var_1686.y = param2.y;
            var_1686.width = param2.width;
            var_1686.height = param2.height;
         }
         if(param2.isEmpty())
         {
            return;
         }
         if(getWindowRendererItem(param1).invalidate(param1,param3))
         {
            if(param1.testParamFlag(16) || param1.testParamFlag(1073741824))
            {
               var _loc7_:class_3460 = param1.context.getDesktopWindow();
               do
               {
                  if((_loc4_ = param1.parent) == null)
                  {
                     return;
                  }
                  if(_loc4_ == _loc7_)
                  {
                     break;
                  }
                  if(!_loc4_.visible)
                  {
                     return;
                  }
                  _loc8_ = _loc4_.renderingWidth;
                  _loc12_ = _loc4_.renderingHeight;
                  var_1686.offset(param1.renderingX,param1.renderingY);
                  if(_loc4_.clipping)
                  {
                     if(var_1686.x > _loc8_ || var_1686.y > _loc12_ || var_1686.right < 0 || var_1686.bottom < 0)
                     {
                        return;
                     }
                     if(var_1686.x < 0)
                     {
                        var_1686.width += var_1686.x;
                        var_1686.x = 0;
                     }
                     if(var_1686.y < 0)
                     {
                        var_1686.height += var_1686.y;
                        var_1686.y = 0;
                     }
                     if(var_1686.right > _loc8_)
                     {
                        var_1686.right = _loc8_;
                     }
                     if(var_1686.bottom > _loc12_)
                     {
                        var_1686.bottom = _loc12_;
                     }
                  }
                  if(var_1686.isEmpty())
                  {
                     return;
                  }
                  param1 = _loc4_;
               }
               while(!(!param1.testParamFlag(16) && !param1.testParamFlag(1073741824)));
               
            }
            getWindowRendererItem(param1).invalidate(param1,32);
            if((_loc10_ = var_2389.indexOf(param1)) > -1)
            {
               _loc5_ = var_2523[_loc10_];
               _loc11_ = var_1686;
               var _loc9_:int;
               if((_loc9_ = int(_loc5_.length)) > 3)
               {
                  _loc11_ = _loc11_.union(_loc5_.pop());
                  _loc9_--;
               }
               _loc10_ = 0;
               while(_loc10_ < _loc9_)
               {
                  if(((_loc6_ = _loc5_[_loc10_++]).left > _loc11_.left ? _loc6_.left - _loc11_.right : _loc11_.left - _loc6_.right) <= 10 && (_loc6_.top > _loc11_.top ? _loc6_.top - _loc11_.bottom : _loc11_.top - _loc6_.bottom) <= 10)
                  {
                     _loc5_.splice(_loc10_ - 1,1);
                     _loc11_ = _loc11_.union(_loc6_);
                     _loc9_--;
                     _loc10_ = 0;
                  }
               }
               _loc5_.push(_loc11_ == var_1686 ? _loc11_.clone() : _loc11_);
            }
            else
            {
               var_2389.push(param1);
               var_2523.push([var_1686.clone()]);
            }
         }
      }
      
      public function flushRenderQueue() : void
      {
         if(var_2389.length || var_2523.length)
         {
            var_2389.splice(0,var_2389.length);
            var_2523.splice(0,var_2523.length);
         }
      }
      
      public function invalidate(param1:class_3400, param2:Rectangle) : void
      {
         var _loc5_:IWindow = null;
         var _loc4_:class_3460 = null;
         var _loc3_:uint = uint((_loc4_ = param1.getDesktopWindow()).numChildren);
         while(_loc3_-- > 0)
         {
            _loc5_ = _loc4_.getChildAt(_loc3_);
            addToRenderQueue(_loc5_,null,1);
         }
      }
      
      protected function getWindowRendererItem(param1:IWindow) : WindowRendererItem
      {
         var _loc2_:WindowRendererItem = var_1957[param1] as WindowRendererItem;
         if(_loc2_ == null)
         {
            _loc2_ = registerRenderable(param1);
         }
         return _loc2_;
      }
      
      public function registerRenderable(param1:IWindow) : WindowRendererItem
      {
         var _loc2_:WindowRendererItem = var_1957[param1] as WindowRendererItem;
         if(_loc2_ == null)
         {
            _loc2_ = new WindowRendererItem(var_2226);
            var_1957[param1] = _loc2_;
            _loc2_.invalidate(param1,8);
         }
         if(!param1.hasEventListener("WINDOW_DISPOSE_EVENT"))
         {
            param1.addEventListener("WINDOW_DISPOSE_EVENT",windowDisposedCallback);
         }
         return _loc2_;
      }
      
      public function removeRenderable(param1:IWindow) : void
      {
         param1.removeEventListener("WINDOW_DISPOSE_EVENT",windowDisposedCallback);
         var _loc2_:WindowRendererItem = var_1957[param1] as WindowRendererItem;
         if(_loc2_ != null)
         {
            _loc2_.dispose();
            delete var_1957[param1];
         }
      }
      
      protected function windowDisposedCallback(param1:WindowDisposeEvent) : void
      {
         removeRenderable(param1.window);
      }
      
      public function getDrawBufferForRenderable(param1:IWindow) : BitmapData
      {
         var _loc2_:Rectangle = null;
         var _loc4_:TrackedBitmapData = null;
         var _loc3_:WindowRendererItem = var_1957[param1] as WindowRendererItem;
         if(!_loc3_)
         {
            _loc2_ = new Rectangle(0,0,param1.renderingWidth,param1.renderingHeight);
            _loc4_ = new TrackedBitmapData(this,param1.renderingWidth,param1.renderingHeight);
            _loc3_ = registerRenderable(param1);
            _loc3_.invalidate(param1,1);
            _loc3_.render(param1,POINT_ZERO,_loc2_,param1.renderingRectangle,_loc4_);
            _loc4_.dispose();
         }
         return _loc3_ != null ? _loc3_.buffer : null;
      }
      
      public function render() : void
      {
         var _loc1_:* = null;
         var _loc2_:Array = null;
         var _loc4_:BitmapData = null;
         var _loc5_:IWindow = null;
         var _loc3_:uint = var_2389.length;
         while(_loc3_-- > 0)
         {
            _loc5_ = var_2389.pop();
            _loc2_ = var_2523.pop();
            if(!_loc5_.disposed)
            {
               _loc4_ = _loc5_.fetchDrawBuffer() as BitmapData;
               for each(_loc1_ in _loc2_)
               {
                  var_3103.x = _loc5_.renderingX;
                  var_3103.y = _loc5_.renderingY;
                  var_3103.width = _loc5_.renderingWidth;
                  var_3103.height = _loc5_.renderingHeight;
                  renderWindowBranch(_loc5_,_loc1_,var_3103,_loc4_);
               }
            }
         }
      }
      
      private function renderWindowBranch(param1:IWindow, param2:Rectangle, param3:Rectangle, param4:BitmapData) : void
      {
         var _loc8_:* = null;
         var _loc6_:IGraphicContextHost = null;
         var _loc5_:* = undefined;
         var _loc7_:IGraphicContext;
         if(_loc7_ = IGraphicContextHost(param1).getGraphicContext(false))
         {
            _loc7_.visible = param1.visible;
         }
         if(param1.visible)
         {
            var_3560.x = param1.renderingX;
            var_3560.y = param1.renderingY;
            if(getDrawLocationAndClipRegion(param1,param2,var_3560,var_3939))
            {
               if(param1.clipping)
               {
                  param3 = param3.intersection(param1.renderingRectangle);
               }
               param3.offset(-param1.x,-param1.y);
               param4 = getWindowRendererItem(param1).render(param1,var_3560,var_3939,param3,param4);
               if(!(param1 is class_3402))
               {
                  return;
               }
               if(!(_loc5_ = class_3402(param1).children))
               {
                  return;
               }
               if(param1.clipping)
               {
                  param2 = param2.clone();
                  if(param2.x < 0)
                  {
                     param2.width += param2.x;
                     param2.x = 0;
                  }
                  if(param2.y < 0)
                  {
                     param2.height += param2.y;
                     param2.y = 0;
                  }
                  if(param2.width > param1.width)
                  {
                     param2.width = param1.renderingWidth;
                  }
                  if(param2.height > param1.height)
                  {
                     param2.height = param1.renderingHeight;
                  }
               }
               for each(_loc8_ in _loc5_)
               {
                  RECT.x = _loc8_.x;
                  RECT.y = _loc8_.y;
                  RECT.width = _loc8_.width;
                  RECT.height = _loc8_.height;
                  if(RECT.intersects(param2))
                  {
                     if(_loc8_.testParamFlag(16))
                     {
                        param2.offset(-_loc8_.x,-_loc8_.y);
                        renderWindowBranch(_loc8_,param2,param3,param4);
                        param2.offset(_loc8_.x,_loc8_.y);
                     }
                     else if(_loc8_.testParamFlag(1073741824))
                     {
                        param2.offset(-_loc8_.x,-_loc8_.y);
                        renderWindowBranch(_loc8_,param2,param3,_loc8_.fetchDrawBuffer() as BitmapData);
                        param2.offset(_loc8_.x,_loc8_.y);
                     }
                     else if(_loc8_.visible)
                     {
                        if((_loc6_ = IGraphicContextHost(_loc8_)).hasGraphicsContext())
                        {
                           _loc6_.getGraphicContext(true).visible = true;
                        }
                     }
                  }
                  else if(!RECT.intersects(param3))
                  {
                     if((_loc6_ = IGraphicContextHost(_loc8_)).hasGraphicsContext())
                     {
                        _loc6_.getGraphicContext(true).visible = false;
                     }
                  }
               }
               param3.offset(param1.renderingX,param1.renderingY);
            }
            else if(!param1.testParamFlag(16))
            {
               if(param1.testParamFlag(1073741824))
               {
                  if(!_loc7_)
                  {
                     _loc7_ = IGraphicContextHost(param1).getGraphicContext(true);
                  }
                  _loc7_.setDrawRegion(param1.renderingRectangle,false,var_3939);
                  _loc7_.visible = false;
               }
            }
         }
      }
   }
}
