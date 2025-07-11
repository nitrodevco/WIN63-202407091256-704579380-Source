package com.sulake.core.window
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.components.class_3460;
   import com.sulake.core.window.dynamicstyle.DynamicStyle;
   import com.sulake.core.window.dynamicstyle.class_3622;
   import com.sulake.core.window.events.WindowDisposeEvent;
   import com.sulake.core.window.events.WindowEventDispatcher;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.graphics.GraphicContext;
   import com.sulake.core.window.graphics.IGraphicContext;
   import com.sulake.core.window.graphics.IGraphicContextHost;
   import com.sulake.core.window.services.IMouseListenerService;
   import com.sulake.core.window.theme.class_3538;
   import com.sulake.core.window.utils.DefaultAttStruct;
   import com.sulake.core.window.utils.IRectLimiter;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.core.window.utils.WindowRectLimits;
   import com.sulake.core.window.utils.class_3402;
   import flash.display.BitmapData;
   import flash.display.IBitmapDrawable;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getQualifiedClassName;
   
   public class WindowController extends WindowModel implements IWindow, IGraphicContextHost, class_3402
   {
      
      private static var var_4548:uint = 0;
      
      private static const const_411:Rectangle = new Rectangle();
      
      public static const TAG_EXCLUDE:String = "_EXCLUDE";
      
      public static const TAG_INTERNAL:String = "_INTERNAL";
      
      public static const TAG_COLORIZE:String = "_COLORIZE";
      
      public static const TAG_IGNORE_INHERITED_STYLE:String = "_IGNORE_INHERITED_STYLE";
      
      private static const _POINT_ZERO:Point = new Point();
       
      
      protected var name_1:WindowEventDispatcher;
      
      protected var var_1650:IGraphicContext;
      
      protected var var_2374:Function;
      
      protected var var_1871:Boolean = true;
      
      protected var _parent:WindowController;
      
      protected var _children:Vector.<IWindow>;
      
      protected var var_154:Boolean = false;
      
      protected var var_2229:WindowRectLimits;
      
      protected var var_3092:Boolean = false;
      
      private var var_3157:DynamicStyle;
      
      private var var_3162:Boolean = false;
      
      private var var_2115:Rectangle;
      
      private var var_4474:uint;
      
      private var var_3375:class_3538;
      
      public function WindowController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0, param12:String = "")
      {
         var _loc13_:* = 0;
         var_4474 = var_4548++;
         var _loc14_:XML = param5.getWindowFactory().getLayoutByTypeAndStyle(param2,param3);
         if(param6 == null)
         {
            param6 = new Rectangle(0,0,!!_loc14_ ? int(_loc14_.attribute("width")) : 10,!!_loc14_ ? int(_loc14_.attribute("height")) : 10);
         }
         var_3375 = param5.getWindowFactory().getThemeManager().getPropertyDefaults(param3);
         super(param11,param1,param2,param3,param4,param5,param6,param10,param12);
         if(!var_1650)
         {
            var_1650 = getGraphicContext(!testParamFlag(16));
         }
         var_2115 = new Rectangle();
         if(_loc14_ != null)
         {
            var_2028 = new Rectangle(0,0,int(_loc14_.attribute("width")),int(_loc14_.attribute("height")));
            var_1663 = var_2028.clone();
            var_31 = var_2028.x;
            var_28 = var_2028.y;
            var_1637 = var_2028.width;
            var_1642 = var_2028.height;
            param5.getWindowParser().parseAndConstruct(_loc14_,this,null);
            _loc13_ = var_837;
            var_837 &= ~12582912;
            setRectangle(param6.x,param6.y,param6.width,param6.height);
            var_837 = _loc13_;
            var_1663.x = param6.x;
            var_1663.y = param6.y;
            var_1663.width = param6.width;
            var_1663.height = param6.height;
         }
         var _loc15_:DefaultAttStruct;
         if(_loc15_ = param5.getWindowFactory().getDefaultsByTypeAndStyle(param2,param3))
         {
            var_2314 = _loc15_.blend;
            var_2521 = _loc15_.threshold;
            if(_background != _loc15_.background)
            {
               background = _loc15_.background;
            }
            if(_fillColor != _loc15_.color)
            {
               color = _loc15_.color;
            }
            if(_loc15_.hasRectLimits())
            {
               WindowRectLimits(limits).assign(_loc15_.width_min,_loc15_.width_max,_loc15_.height_min,_loc15_.height_max);
            }
         }
         if(param9)
         {
            this.properties = param9;
         }
         var_2374 = param8;
         if(param7 != null)
         {
            _parent = param7 as WindowController;
            WindowController(param7).addChild(this);
            if(var_1650)
            {
               _context.invalidate(this,null,1);
            }
         }
      }
      
      private static function calculateMouseRegion(param1:WindowController, param2:Rectangle) : void
      {
         var _loc7_:int = 0;
         var _loc3_:Rectangle = new Rectangle();
         param1.getGlobalRectangle(_loc3_);
         var _loc5_:int = param1.numChildren;
         var _loc4_:int = _loc3_.x;
         var _loc6_:int = _loc3_.y;
         param2.left = _loc4_ < param2.left ? _loc4_ : param2.left;
         param2.top = _loc6_ < param2.top ? _loc6_ : param2.top;
         param2.right = _loc3_.right > param2.right ? _loc3_.right : param2.right;
         param2.bottom = _loc3_.bottom > param2.bottom ? _loc3_.bottom : param2.bottom;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            WindowController.calculateMouseRegion(param1.getChildAt(_loc7_) as WindowController,param2);
            _loc7_++;
         }
      }
      
      public static function expandToAccommodateChild(param1:WindowController, param2:IWindow) : void
      {
         var _loc6_:* = 0;
         var _loc9_:* = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc10_:int = param1.width;
         var _loc5_:int = param1.height;
         var _loc8_:Boolean = false;
         if(param2.x < 0)
         {
            _loc4_ = param2.x;
            _loc10_ -= _loc4_;
            param2.x = 0;
            _loc8_ = true;
         }
         if(param2.right > _loc10_)
         {
            _loc10_ = param2.x + param2.width;
            _loc8_ = true;
         }
         if(param2.y < 0)
         {
            _loc3_ = param2.y;
            _loc5_ -= _loc3_;
            param2.y = 0;
            _loc8_ = true;
         }
         if(param2.bottom > _loc5_)
         {
            _loc5_ = param2.y + param2.height;
            _loc8_ = true;
         }
         if(_loc8_)
         {
            if(_loc6_ = uint(param1.param & (131072 | 147456)))
            {
               param1.setParamFlag(_loc6_,false);
            }
            param1.setRectangle(param1.x + _loc4_,param1.y + _loc3_,_loc10_,_loc5_);
            if(_loc3_ != 0 || _loc4_ != 0)
            {
               var _loc7_:uint = uint(param1.numChildren);
               _loc9_ = 0;
               while(_loc9_ < _loc7_)
               {
                  IWindow(param1.getChildAt(_loc9_)).offset(-_loc4_,-_loc3_);
                  _loc9_++;
               }
            }
            if(_loc6_)
            {
               param1.setParamFlag(_loc6_,true);
            }
         }
      }
      
      public static function resizeToAccommodateChildren(param1:WindowController) : void
      {
         var _loc11_:IWindow = null;
         var _loc9_:* = 0;
         var _loc7_:* = 0;
         var _loc4_:Boolean = false;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:int = -2147483648;
         var _loc10_:int = -2147483648;
         var _loc8_:Boolean = false;
         var _loc6_:uint = uint(param1.numChildren);
         _loc9_ = 0;
         while(_loc9_ < _loc6_)
         {
            if((_loc11_ = param1.getChildAt(_loc9_)).visible && _loc11_.x + _loc11_.width > _loc5_)
            {
               _loc5_ = _loc11_.x + _loc11_.width;
               _loc8_ = true;
            }
            if(_loc11_.visible && _loc11_.y + _loc11_.height > _loc10_)
            {
               _loc10_ = _loc11_.y + _loc11_.height;
               _loc8_ = true;
            }
            _loc9_++;
         }
         if(_loc8_)
         {
            if(_loc7_ = uint(param1.param & (131072 | 147456)))
            {
               param1.setParamFlag(_loc7_,false);
            }
            if(_loc3_ != 0 || _loc2_ != 0)
            {
               _loc9_ = 0;
               while(_loc9_ < _loc6_)
               {
                  if(_loc4_ = (_loc11_ = param1.getChildAt(_loc9_)).testParamFlag(32))
                  {
                     _loc11_.setParamFlag(32,false);
                  }
                  _loc11_.offset(-_loc3_,-_loc2_);
                  if(_loc4_)
                  {
                     _loc11_.setParamFlag(32,true);
                  }
                  _loc9_++;
               }
            }
            param1.width = _loc5_;
            param1.height = _loc10_;
            if(_loc7_)
            {
               param1.setParamFlag(_loc7_,true);
            }
         }
      }
      
      public function get properties() : Array
      {
         return [];
      }
      
      public function get procedure() : Function
      {
         return var_2374 != null ? var_2374 : (_parent != null ? _parent.procedure : nullEventProc);
      }
      
      public function get filters() : Array
      {
         return hasGraphicsContext() ? getGraphicContext(true).filters : [];
      }
      
      public function get parent() : IWindow
      {
         return _parent;
      }
      
      public function get debug() : Boolean
      {
         return var_154;
      }
      
      public function get limits() : IRectLimiter
      {
         return !!var_2229 ? var_2229 : (var_2229 = new WindowRectLimits(this));
      }
      
      public function get immediateClickMode() : Boolean
      {
         return var_3092;
      }
      
      public function set x(param1:int) : void
      {
         if(param1 != var_31)
         {
            setRectangle(param1,var_28,var_1637,var_1642);
         }
      }
      
      public function set y(param1:int) : void
      {
         if(param1 != var_28)
         {
            setRectangle(var_31,param1,var_1637,var_1642);
         }
      }
      
      public function set id(param1:int) : void
      {
         var_280 = param1;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function set width(param1:int) : void
      {
         if(param1 != var_1637)
         {
            setRectangle(var_31,var_28,param1,var_1642);
         }
      }
      
      public function set height(param1:int) : void
      {
         if(param1 != var_1642)
         {
            setRectangle(var_31,var_28,var_1637,param1);
         }
      }
      
      public function set position(param1:Point) : void
      {
         setRectangle(param1.x,param1.y,var_1637,var_1642);
      }
      
      public function set rectangle(param1:Rectangle) : void
      {
         setRectangle(param1.x,param1.y,param1.width,param1.height);
      }
      
      public function set background(param1:Boolean) : void
      {
         _background = param1;
         _fillColor = _background ? _fillColor | _alphaColor : _fillColor & 16777215;
         var_1871 ||= param1;
         _context.invalidate(this,null,1);
      }
      
      public function set color(param1:uint) : void
      {
         _alphaColor = param1 & 4278190080;
         _fillColor = _background ? param1 : param1 & 16777215;
         _context.invalidate(this,null,1);
      }
      
      public function set alpha(param1:uint) : void
      {
         _alphaColor = param1 << 24;
         _fillColor = _background ? _alphaColor | _fillColor : 16777215 & _fillColor;
         _context.invalidate(this,null,1);
      }
      
      public function set blend(param1:Number) : void
      {
         param1 = param1 > 1 ? 1 : (param1 < 0 ? 0 : param1);
         if(param1 != var_2314)
         {
            var_2314 = param1;
            _context.invalidate(this,null,16);
         }
      }
      
      public function set visible(param1:Boolean) : void
      {
         var _loc2_:WindowEvent = null;
         if(param1 != var_848)
         {
            var_848 = param1;
            if(var_1650 && !param1)
            {
               var_1650.visible = false;
            }
            _context.invalidate(this,null,1);
            _loc2_ = WindowEvent.allocate("WE_CHILD_VISIBILITY",this,this);
            update(this,_loc2_);
            _loc2_.recycle();
         }
      }
      
      public function set type(param1:uint) : void
      {
         if(param1 != var_329)
         {
            var_329 = param1;
            _context.invalidate(this,null,1);
         }
      }
      
      public function set caption(param1:String) : void
      {
         param1 = !!param1 ? param1 : "";
         if(param1 != caption)
         {
            _caption = param1;
            _context.invalidate(this,null,1);
         }
      }
      
      public function set tags(param1:Array) : void
      {
         if(param1 != null)
         {
            var_320 = param1;
         }
      }
      
      public function set mouseThreshold(param1:uint) : void
      {
         var_2521 = param1 > 255 ? 255 : param1;
      }
      
      public function set ignoreMouseEvents(param1:Boolean) : void
      {
         _ignoreMouseEvents = param1;
      }
      
      public function set procedure(param1:Function) : void
      {
         var_2374 = param1;
      }
      
      public function set filters(param1:Array) : void
      {
         if(hasGraphicsContext())
         {
            getGraphicContext(true).filters = param1;
         }
      }
      
      public function set debug(param1:Boolean) : void
      {
         var_154 = param1;
      }
      
      public function set properties(param1:Array) : void
      {
      }
      
      public function set offsetX(param1:int) : void
      {
         _offsetX = param1;
      }
      
      public function set offsetY(param1:int) : void
      {
         _offsetY = param1;
      }
      
      public function set etching(param1:Array) : void
      {
      }
      
      public function set state(param1:uint) : void
      {
         if(param1 != var_149)
         {
            var_149 = param1;
            _context.invalidate(this,null,8);
         }
      }
      
      public function set dynamicStyleColor(param1:ColorTransform) : void
      {
         var_4180 = param1;
      }
      
      public function get dynamicStyleColor() : ColorTransform
      {
         return var_4180;
      }
      
      public function set style(param1:uint) : void
      {
         var _loc2_:Array = null;
         var _loc3_:WindowController = null;
         var _loc4_:* = 0;
         if(param1 != _style)
         {
            _style = param1;
            _loc2_ = [];
            groupChildrenWithTag("_INTERNAL",_loc2_);
            _loc4_ = _loc2_.length;
            while(--_loc4_ > -1)
            {
               _loc3_ = _loc2_[_loc4_] as WindowController;
               if(_loc3_.tags.indexOf("_IGNORE_INHERITED_STYLE") == -1)
               {
                  _loc3_.style = _style;
               }
            }
            _context.invalidate(this,null,1);
            var_3375 = _context.getWindowFactory().getThemeManager().getPropertyDefaults(_style);
         }
      }
      
      public function set dynamicStyle(param1:String) : void
      {
         var_2733 = param1;
         _context.invalidate(this,null,1);
      }
      
      public function set clipping(param1:Boolean) : void
      {
         if(param1 != var_3258)
         {
            var_3258 = param1;
            _context.invalidate(this,null,1);
         }
      }
      
      public function get host() : IWindow
      {
         return _parent == desktop ? this : _parent.host;
      }
      
      public function get desktop() : class_3460
      {
         return _context.getDesktopWindow();
      }
      
      public function set parent(param1:IWindow) : void
      {
         var _loc3_:WindowEvent = null;
         if(param1 == this)
         {
            throw new Error("Attempted to assign self as parent!");
         }
         if(param1 != null && param1.context != _context)
         {
            _context = WindowContext(param1.context);
            if(_children)
            {
               for each(var _loc4_ in _children)
               {
                  _loc4_.parent = this;
               }
            }
         }
         var _loc2_:IWindow = _parent;
         if(_parent != param1)
         {
            if(_parent != null)
            {
               _parent.removeChild(this);
            }
            _parent = WindowController(param1);
            if(_parent != null)
            {
               var_2115 = _parent.rectangle;
               var_1663.x = var_31;
               var_1663.y = var_28;
               var_1663.width = var_1637;
               var_1663.height = var_1642;
               _loc3_ = WindowEvent.allocate("WE_PARENT_ADDED",this,_parent);
               update(this,_loc3_);
            }
            else
            {
               var_2115.x = 0;
               var_2115.y = 0;
               var_2115.width = 0;
               var_2115.height = 0;
               _loc3_ = WindowEvent.allocate("WE_PARENT_REMOVED",this,_loc2_);
               update(this,_loc3_);
            }
            _loc3_.recycle();
         }
      }
      
      public function hasGraphicsContext() : Boolean
      {
         return var_1650 != null || !testParamFlag(16);
      }
      
      public function getGraphicContext(param1:Boolean) : IGraphicContext
      {
         if(param1 && !var_1650)
         {
            var_1650 = new GraphicContext("GC {" + _name + "}",1,new Rectangle(var_31,var_28,var_1637,var_1642));
            var_1650.visible = var_848;
         }
         return var_1650;
      }
      
      public function setupGraphicsContext() : IGraphicContext
      {
         var _loc1_:int = 0;
         var_1650 = getGraphicContext(true);
         if(_parent)
         {
            _parent.setupGraphicsContext();
         }
         if(_children && _children.length > 0)
         {
            if(var_1650.numChildContexts != numChildren)
            {
               _loc1_ = 0;
               for each(var _loc2_ in _children)
               {
                  var_1650.addChildContextAt(_loc2_.getGraphicContext(true),_loc1_++);
               }
            }
         }
         var_3162 = true;
         return var_1650;
      }
      
      public function releaseGraphicsContext() : void
      {
         var_3162 = false;
         if(!var_1650)
         {
         }
      }
      
      public function clone() : IWindow
      {
         var _loc2_:Class = Object(this).constructor;
         var _loc1_:WindowController = new _loc2_(_name,var_329,_style,var_837,_context,new Rectangle(var_31,var_28,var_1637,var_1642),null,var_2374,properties,!!var_320 ? var_320.concat() : null,var_280) as WindowController;
         _loc1_.dynamicStyle = var_2733;
         _loc1_.var_2521 = var_2521;
         _loc1_._ignoreMouseEvents = _ignoreMouseEvents;
         _loc1_.var_1871 = var_1871;
         _loc1_.var_154 = var_154;
         _loc1_.var_2115 = var_2115.clone();
         _loc1_.var_31 = var_31;
         _loc1_.var_28 = var_28;
         _loc1_.var_1637 = var_1637;
         _loc1_.var_1642 = var_1642;
         _loc1_.var_2028 = var_2028.clone();
         _loc1_.var_1663 = var_1663.clone();
         _loc1_.var_1841 = !!var_1841 ? var_1841.clone() : null;
         _loc1_.var_1825 = !!var_1825 ? var_1825.clone() : null;
         _loc1_.var_2229 = !!var_2229 ? var_2229.clone(_loc1_) : null;
         _loc1_._context = _context;
         _loc1_._fillColor = _fillColor;
         _loc1_._alphaColor = _alphaColor;
         _loc1_.clipping = var_3258;
         _loc1_.var_848 = var_848;
         _loc1_.var_2314 = var_2314;
         _loc1_.var_837 = var_837;
         _loc1_.var_149 = var_149;
         _loc1_._name = _name;
         _loc1_.var_280 = var_280;
         _loc1_.caption = _caption;
         _loc1_.background = _background;
         cloneChildWindows(_loc1_);
         return _loc1_;
      }
      
      protected function cloneChildWindows(param1:WindowController) : void
      {
         var _loc2_:* = null;
         if(_children)
         {
            for each(_loc2_ in _children)
            {
               if(_loc2_.tags.indexOf("_EXCLUDE") == -1)
               {
                  param1.addChild(_loc2_.clone());
               }
            }
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:WindowDisposeEvent = null;
         if(!_disposed)
         {
            immediateClickMode = false;
            var_2374 = null;
            if(!_context.disposed)
            {
               if(!isChildWindow())
               {
                  if(getStateFlag(1))
                  {
                     deactivate();
                  }
               }
            }
            if(_children)
            {
               while(_children.length > 0)
               {
                  IDisposable(_children.pop()).dispose();
               }
            }
            _children = null;
            if(parent)
            {
               parent = null;
            }
            if(name_1)
            {
               _loc1_ = WindowDisposeEvent.allocate(this);
               name_1.dispatchEvent(_loc1_);
               _loc1_.recycle();
               if(name_1 is IDisposable)
               {
                  IDisposable(name_1).dispose();
                  name_1 = null;
               }
            }
            if(var_1650 != null)
            {
               var_1650.dispose();
               var_1650 = null;
            }
            super.dispose();
         }
      }
      
      public function toString() : String
      {
         return "[Window " + getQualifiedClassName(this) + " " + _name + " " + var_4474 + "]";
      }
      
      override public function invalidate(param1:Rectangle = null) : void
      {
         _context.invalidate(this,param1,1);
      }
      
      public function resolve() : uint
      {
         return 0;
      }
      
      public function center() : void
      {
         if(_parent != null)
         {
            x = _parent.width / 2 - var_1637 / 2;
            y = _parent.height / 2 - var_1642 / 2;
         }
      }
      
      public function setRectangle(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc7_:* = 0;
         var _loc8_:WindowEvent = null;
         if(var_2229)
         {
            param4 = Math.max(var_2229.minHeight,param4);
            param4 = Math.min(var_2229.maxHeight,param4);
            param3 = Math.max(var_2229.minWidth,param3);
            param3 = Math.min(var_2229.maxWidth,param3);
         }
         var _loc5_:Boolean = param1 != var_31 || param2 != var_28;
         var _loc6_:Boolean;
         if((_loc6_ = param3 != var_1637 || param4 != var_1642) && !_loc5_)
         {
            if((_loc7_ = uint(var_837 & 786432)) == 786432)
            {
               param1 -= (param3 - var_1637) / 2;
               _loc5_ = true;
            }
            else if(_loc7_ == 262144)
            {
               param1 -= param3 - var_1637;
               _loc5_ = true;
            }
            if((_loc7_ = uint(var_837 & 3145728)) == 3145728)
            {
               param2 -= (param4 - var_1642) / 2;
               _loc5_ = true;
            }
            else if(_loc7_ == 1048576)
            {
               param2 -= param4 - var_1642;
               _loc5_ = true;
            }
         }
         if(testParamFlag(32))
         {
            if(_parent != null)
            {
               param1 = int(param1 < 0 ? 0 : param1);
               param2 = int(param2 < 0 ? 0 : param2);
               if(_loc5_)
               {
                  param1 -= param1 + param3 > _parent.width ? param1 + param3 - _parent.width : 0;
                  param2 -= param2 + param4 > _parent.height ? param2 + param4 - _parent.height : 0;
                  _loc5_ = param1 != var_31 || param2 != var_28;
               }
               else
               {
                  param3 -= param1 + param3 > _parent.width ? param1 + param3 - _parent.width : 0;
                  param4 -= param2 + param4 > _parent.height ? param2 + param4 - _parent.height : 0;
                  _loc6_ = param3 != var_1637 || param4 != var_1642;
               }
            }
         }
         if(_loc5_ || _loc6_)
         {
            if(_loc5_)
            {
               _loc8_ = WindowEvent.allocate("WE_RELOCATE",this,null,true);
               update(this,_loc8_);
               if(_loc8_.isWindowOperationPrevented())
               {
                  _loc5_ = false;
               }
               _loc8_.recycle();
            }
            if(_loc6_)
            {
               _loc8_ = WindowEvent.allocate("WE_RESIZE",this,null,true);
               update(this,_loc8_);
               if(_loc8_.isWindowOperationPrevented())
               {
                  _loc6_ = false;
               }
               _loc8_.recycle();
            }
            if(_loc5_)
            {
               var_1663.x = var_31;
               var_1663.y = var_28;
               var_1663.width = var_1637;
               var_1663.height = var_1642;
               var_31 = param1;
               var_28 = param2;
            }
            if(_loc6_)
            {
               var_1663.width = var_1637;
               var_1663.height = var_1642;
               var_1637 = param3;
               var_1642 = param4;
            }
            if(_loc5_)
            {
               _loc8_ = WindowEvent.allocate("WE_RELOCATED",this,null);
               update(this,_loc8_);
               _loc8_.recycle();
            }
            if(_loc6_)
            {
               _loc8_ = WindowEvent.allocate("WE_RESIZED",this,null);
               update(this,_loc8_);
               _loc8_.recycle();
            }
         }
      }
      
      public function getRegionProperties(param1:Rectangle = null, param2:Rectangle = null, param3:Rectangle = null, param4:Rectangle = null) : void
      {
         if(param1 != null)
         {
            param1.x = var_31;
            param1.y = var_28;
            param1.width = var_1637;
            param1.height = var_1642;
         }
         if(param2 != null)
         {
            param2.x = var_1663.x;
            param2.y = var_1663.y;
            param2.width = var_1663.width;
            param2.height = var_1663.height;
         }
         if(param3 != null && var_1841 != null)
         {
            param3.x = var_1841.x;
            param3.y = var_1841.y;
            param3.width = var_1841.width;
            param3.height = var_1841.height;
         }
         if(param4 != null && var_1825 != null)
         {
            param4.x = var_1825.x;
            param4.y = var_1825.y;
            param4.width = var_1825.width;
            param4.height = var_1825.height;
         }
      }
      
      public function setRegionProperties(param1:Rectangle = null, param2:Rectangle = null, param3:Rectangle = null) : void
      {
         if(param3 != null)
         {
            if(param3.width < 0 || param3.height < 0)
            {
               throw new Error("Invalid rectangle; maximized size can\'t be less than zero!");
            }
            if(var_1825 == null)
            {
               var_1825 = new Rectangle();
            }
            var_1825.x = param3.x;
            var_1825.y = param3.y;
            var_1825.width = param3.width;
            var_1825.height = param3.height;
         }
         if(param2 != null)
         {
            if(param2.width < 0 || param2.height < 0)
            {
               throw new Error("Invalid rectangle; minimized size can\'t be less than zero!");
            }
            if(var_1841 == null)
            {
               var_1841 = new Rectangle();
            }
            var_1841.x = param2.x;
            var_1841.y = param2.y;
            var_1841.width = param2.width;
            var_1841.height = param2.height;
         }
         if(param3.width < param2.width || param3.height < param2.height)
         {
            param3.width = param2.width;
            param3.height = param2.height;
            throw new Error("Maximized rectangle can\'t be smaller than minimized rectangle!");
         }
         if(param1 != null)
         {
            setRectangle(param1.x,param1.y,param1.width,param1.height);
         }
      }
      
      public function buildFromXML(param1:XML, param2:Map = null) : Boolean
      {
         return _context.getWindowParser().parseAndConstruct(param1,this,param2) != null;
      }
      
      public function fetchDrawBuffer() : IBitmapDrawable
      {
         return !testParamFlag(16) ? getGraphicContext(true).fetchDrawBuffer() : (_parent != null ? _parent.fetchDrawBuffer() : null);
      }
      
      public function getDrawRegion(param1:Rectangle) : void
      {
         if(!testParamFlag(16))
         {
            param1.x = 0;
            param1.y = 0;
            param1.width = var_1637;
            param1.height = var_1642;
         }
         else if(_parent != null)
         {
            _parent.getDrawRegion(param1);
            param1.x += var_31;
            param1.y += var_28;
            param1.width = var_1637;
            param1.height = var_1642;
         }
         else
         {
            param1.x = 0;
            param1.y = 0;
            param1.width = 0;
            param1.height = 0;
         }
      }
      
      public function update(param1:WindowController, param2:WindowEvent) : Boolean
      {
         var _loc5_:IMouseListenerService = null;
         var _loc6_:IWindow = null;
         var _loc4_:WindowEvent = null;
         var _loc3_:* = 0;
         if(!testParamFlag(9))
         {
            procedure(param2,this);
            if(_disposed)
            {
               return true;
            }
            if(!param2.isWindowOperationPrevented())
            {
               if(hasEventListener(param2.type))
               {
                  name_1.dispatchEvent(param2);
                  if(_disposed)
                  {
                     return true;
                  }
               }
            }
            if(param2.cancelable)
            {
               if(param2.isWindowOperationPrevented())
               {
                  return true;
               }
            }
         }
         if(param2 is WindowMouseEvent)
         {
            switch(param2.type)
            {
               case "WME_DOWN":
                  if(activate())
                  {
                     if(param2.cancelable)
                     {
                        param2.preventDefault();
                     }
                  }
                  if(disposed)
                  {
                     return true;
                  }
                  setStateFlag(16,true);
                  (_loc5_ = _context.getWindowServices().getMouseListenerService()).begin(this);
                  _loc5_.eventTypes.push("WME_UP");
                  _loc5_.areaLimit = 3;
                  if(testParamFlag(257))
                  {
                     _loc6_ = this;
                     while(_loc6_ != null)
                     {
                        if(_loc6_.testParamFlag(32768))
                        {
                           _context.getWindowServices().getMouseDraggingService().begin(_loc6_);
                           break;
                        }
                        _loc6_ = _loc6_.parent;
                     }
                  }
                  if((var_837 & 12288) > 0)
                  {
                     _loc6_ = this;
                     while(_loc6_ != null)
                     {
                        if(_loc6_.testParamFlag(65536))
                        {
                           _context.getWindowServices().getMouseScalingService().begin(_loc6_,var_837 & 12288);
                           break;
                        }
                        _loc6_ = _loc6_.parent;
                     }
                  }
                  break;
               case "WME_UP":
                  if(testStateFlag(16))
                  {
                     setStateFlag(16,false);
                  }
                  _context.getWindowServices().getMouseListenerService().end(this);
                  if(testParamFlag(32768))
                  {
                     _context.getWindowServices().getMouseDraggingService().end(this);
                  }
                  if(testParamFlag(65536))
                  {
                     _context.getWindowServices().getMouseScalingService().end(this);
                  }
                  break;
               case "WME_OUT":
                  if(testStateFlag(4))
                  {
                     setStateFlag(4,false);
                  }
                  if(testStateFlag(16))
                  {
                     setStateFlag(16,false);
                  }
                  break;
               case "WME_OVER":
                  if(!testStateFlag(4))
                  {
                     setStateFlag(4,true);
                  }
                  break;
               default:
                  break;
               case "WME_WHEEL":
                  return false;
            }
         }
         else if(param2 is WindowEvent)
         {
            switch(param2.type)
            {
               case "WE_RESIZED":
                  if(param1 == this)
                  {
                     const_411.x = var_31 < var_1663.x ? var_31 : var_1663.x;
                     const_411.y = var_28 < var_1663.y ? var_28 : var_1663.y;
                     const_411.right = var_31 + var_1637 > var_1663.right ? var_31 + var_1637 : var_1663.right;
                     const_411.bottom = var_28 + var_1642 > var_1663.bottom ? var_28 + var_1642 : var_1663.bottom;
                     const_411.offset(-var_31,-var_28);
                     _context.invalidate(this,const_411,2);
                     _loc4_ = WindowEvent.allocate("WE_PARENT_RESIZED",this,null);
                     notifyChildren(_loc4_);
                     _loc4_.recycle();
                     if(testParamFlag(192,192))
                     {
                        updateScaleRelativeToParent();
                     }
                     else if(testParamFlag(3072,3072))
                     {
                        updateScaleRelativeToParent();
                     }
                     if(_parent != null)
                     {
                        _loc3_ = var_837;
                        var_837 &= -3265;
                        if(testParamFlag(4194304))
                        {
                           _parent.width += var_1637 - var_1663.width;
                        }
                        if(testParamFlag(8388608))
                        {
                           _parent.height += var_1642 - var_1663.height;
                        }
                        var_837 = _loc3_;
                        _loc4_ = WindowEvent.allocate("WE_CHILD_RESIZED",_parent,this);
                        _parent.update(this,_loc4_);
                        _loc4_.recycle();
                     }
                  }
                  break;
               case "WE_RELOCATED":
                  if(param1 == this)
                  {
                     const_411.x = var_31 < var_1663.x ? var_31 : var_1663.x;
                     const_411.y = var_28 < var_1663.y ? var_28 : var_1663.y;
                     const_411.right = var_31 + var_1637 > var_1663.right ? var_31 + var_1637 : var_1663.right;
                     const_411.bottom = var_28 + var_1642 > var_1663.bottom ? var_28 + var_1642 : var_1663.bottom;
                     const_411.offset(-var_31,-var_28);
                     _context.invalidate(this,const_411,4);
                     _loc4_ = WindowEvent.allocate("WE_PARENT_RELOCATED",this,null);
                     notifyChildren(_loc4_);
                     _loc4_.recycle();
                     if(_parent != null)
                     {
                        _loc4_ = WindowEvent.allocate("WE_CHILD_RELOCATED",_parent,this);
                        _parent.update(this,_loc4_);
                        _loc4_.recycle();
                     }
                  }
                  break;
               case "WE_ACTIVATED":
                  if(param1 == this)
                  {
                     _loc4_ = WindowEvent.allocate("WE_PARENT_ACTIVATED",this,null);
                     notifyChildren(_loc4_);
                     _loc4_.recycle();
                     if(_parent != null)
                     {
                        _loc4_ = WindowEvent.allocate("WE_CHILD_ACTIVATED",_parent,this);
                        _parent.update(this,_loc4_);
                        _loc4_.recycle();
                     }
                  }
                  break;
               case "WE_PARENT_ADDED":
                  if(testParamFlag(192,192))
                  {
                     updateScaleRelativeToParent();
                  }
                  else if(testParamFlag(3072,3072))
                  {
                     updateScaleRelativeToParent();
                  }
                  _context.invalidate(this,null,1);
                  break;
               case "WE_PARENT_RESIZED":
                  _parent.getRegionProperties(null,var_2115);
                  updateScaleRelativeToParent();
                  break;
               case "WE_CHILD_ADDED":
                  if(testParamFlag(147456))
                  {
                     scaleToAccommodateChildren();
                  }
                  else if(testParamFlag(131072))
                  {
                     expandToAccommodateChild(this,param2.related);
                  }
                  renderDynamicStyle();
                  break;
               case "WE_CHILD_REMOVED":
                  if(testParamFlag(147456))
                  {
                     scaleToAccommodateChildren();
                  }
                  break;
               case "WE_CHILD_ACTIVATED":
                  activate();
                  break;
               case "WE_CHILD_RESIZED":
                  if(testParamFlag(147456))
                  {
                     scaleToAccommodateChildren();
                  }
                  else if(testParamFlag(131072))
                  {
                     expandToAccommodateChild(this,param2.related);
                  }
                  break;
               case "WE_CHILD_RELOCATED":
                  if(testParamFlag(147456))
                  {
                     scaleToAccommodateChildren();
                  }
                  else if(testParamFlag(131072))
                  {
                     expandToAccommodateChild(this,param2.related);
                  }
                  break;
               case "WE_CHILD_VISIBILITY":
                  if(param1 == this)
                  {
                     if(_parent != null)
                     {
                        _loc4_ = WindowEvent.allocate("WE_CHILD_VISIBILITY",_parent,this);
                        _parent.update(this,_loc4_);
                        _loc4_.recycle();
                     }
                  }
            }
         }
         return true;
      }
      
      private function renderDynamicStyle() : void
      {
         var _loc1_:* = 0;
         if(var_2733 == "")
         {
            return;
         }
         if(!var_3157 || var_3157.name != var_2733)
         {
            var_3157 = class_3622.getStyle(var_2733);
         }
         if(getStateFlag(32))
         {
            _loc1_ = 32;
         }
         else if(getStateFlag(16))
         {
            _loc1_ = 16;
         }
         else if(getStateFlag(4))
         {
            _loc1_ = 4;
         }
         else
         {
            _loc1_ = 0;
         }
         applyDynamicStyleByState(this,var_3157,_loc1_);
         if(_children)
         {
            recursivelyUpdateChildrensDynamicStyles(_children,_loc1_);
         }
      }
      
      private function applyDynamicStyleByState(param1:WindowController, param2:DynamicStyle, param3:uint) : void
      {
         var _loc5_:Array = null;
         var _loc4_:Object = param2.getStyleByWindowState(param3);
         param1.offsetX = !!_loc4_.offsetX ? _loc4_.offsetX : 0;
         param1.offsetY = !!_loc4_.offsetY ? _loc4_.offsetY : 0;
         if(param1.hasGraphicsContext())
         {
            param1.var_1650.getDisplayObject().transform.colorTransform = param2.getColorTransform(param3);
         }
         else
         {
            param1.var_4180 = param2.getColorTransform(param3);
            param1.invalidate();
         }
         if(_loc4_.etchingPoint)
         {
            _loc5_ = [_loc4_.etchingColor,_loc4_.etchingPoint[0],_loc4_.etchingPoint[1]];
            param1.etching = _loc5_;
            param1.invalidate();
         }
         else
         {
            param1.etching = [0,0,1];
            param1.invalidate();
         }
      }
      
      private function recursivelyUpdateChildrensDynamicStyles(param1:Vector.<IWindow>, param2:uint) : void
      {
         for each(var _loc3_ in param1)
         {
            if(var_3157.getChildStyle(_loc3_))
            {
               applyDynamicStyleByState(_loc3_,var_3157.getChildStyle(_loc3_),param2);
            }
            if(_loc3_._children)
            {
               recursivelyUpdateChildrensDynamicStyles(_loc3_._children,param2);
            }
         }
      }
      
      protected function notifyEventListeners(param1:WindowEvent) : void
      {
         procedure(param1,this);
         if(!param1.isWindowOperationPrevented())
         {
            if(hasEventListener(param1.type))
            {
               name_1.dispatchEvent(param1);
            }
         }
      }
      
      private function nullEventProc(param1:WindowEvent, param2:IWindow) : void
      {
      }
      
      private function notifyChildren(param1:WindowEvent) : void
      {
         if(_children)
         {
            for each(var _loc2_ in _children)
            {
               _loc2_.update(this,param1);
            }
         }
      }
      
      public function convertPointFromGlobalToLocalSpace(param1:Point) : void
      {
         var _loc2_:Number = param1.x;
         var _loc3_:Number = param1.y;
         if(_parent == null)
         {
            param1.x = var_31;
            param1.y = var_28;
         }
         else
         {
            _parent.getGlobalPosition(param1);
            param1.x += var_31;
            param1.y += var_28;
         }
         param1.x = _loc2_ - param1.x;
         param1.y = _loc3_ - param1.y;
      }
      
      public function convertPointFromLocalToGlobalSpace(param1:Point) : void
      {
         var _loc2_:Number = param1.x;
         var _loc3_:Number = param1.y;
         if(_parent == null)
         {
            param1.x = var_31;
            param1.y = var_28;
         }
         else
         {
            _parent.getGlobalPosition(param1);
            param1.x += var_31;
            param1.y += var_28;
         }
         param1.x += _loc2_;
         param1.y += _loc3_;
      }
      
      public function getRelativeMousePosition(param1:Point) : void
      {
         getGlobalPosition(param1);
         param1.x = _context.getDesktopWindow().mouseX - param1.x;
         param1.y = _context.getDesktopWindow().mouseY - param1.y;
      }
      
      public function getAbsoluteMousePosition(param1:Point) : void
      {
         param1.x = _context.getDesktopWindow().mouseX;
         param1.y = _context.getDesktopWindow().mouseY;
      }
      
      public function getLocalPosition(param1:Point) : void
      {
         param1.x = var_31;
         param1.y = var_28;
      }
      
      public function getLocalRectangle(param1:Rectangle) : void
      {
         param1.x = var_31;
         param1.y = var_28;
         param1.width = var_1637;
         param1.height = var_1642;
      }
      
      public function hitTestLocalPoint(param1:Point) : Boolean
      {
         return param1.x >= var_31 && param1.x < var_31 + var_1637 && param1.y >= var_28 && param1.y < var_28 + var_1642;
      }
      
      public function hitTestLocalRectangle(param1:Rectangle) : Boolean
      {
         return rectangle.intersects(param1);
      }
      
      public function validateLocalPointIntersection(param1:Point, param2:BitmapData) : Boolean
      {
         return testLocalPointHitAgainstAlpha(param1,param2,var_2521);
      }
      
      public function get ignoreMouseEvents() : Boolean
      {
         return _ignoreMouseEvents;
      }
      
      public function getGlobalPosition(param1:Point) : void
      {
         if(_parent != null)
         {
            _parent.getGlobalPosition(param1);
            param1.x += var_31;
            param1.y += var_28;
         }
         else
         {
            param1.x = var_31;
            param1.y = var_28;
         }
      }
      
      public function setGlobalPosition(param1:Point) : void
      {
         var _loc2_:Point = new Point();
         if(_parent != null)
         {
            _parent.getGlobalPosition(_loc2_);
            _loc2_.x += var_31;
            _loc2_.y += var_28;
         }
         else
         {
            _loc2_.x = var_31;
            _loc2_.y = var_28;
         }
         x += param1.x - _loc2_.x;
         y += param1.y - _loc2_.y;
      }
      
      public function getGlobalRectangle(param1:Rectangle) : void
      {
         if(_parent != null)
         {
            _parent.getGlobalRectangle(param1);
            param1.x += var_31;
            param1.y += var_28;
         }
         else
         {
            param1.x = var_31;
            param1.y = var_28;
         }
         param1.width = var_1637;
         param1.height = var_1642;
      }
      
      public function setGlobalRectangle(param1:Rectangle) : void
      {
         var _loc2_:Point = new Point();
         if(_parent != null)
         {
            _parent.getGlobalPosition(_loc2_);
            _loc2_.x += var_31;
            _loc2_.y += var_28;
         }
         else
         {
            _loc2_.x = var_31;
            _loc2_.y = var_28;
         }
         setRectangle(x + (param1.x - _loc2_.x),y + (param1.y - _loc2_.y),param1.width,param1.height);
      }
      
      public function hitTestGlobalPoint(param1:Point) : Boolean
      {
         var _loc2_:Rectangle = new Rectangle();
         getGlobalRectangle(_loc2_);
         return _loc2_.containsPoint(param1);
      }
      
      public function hitTestGlobalRectangle(param1:Rectangle) : Boolean
      {
         var _loc2_:Rectangle = new Rectangle();
         getGlobalRectangle(_loc2_);
         return _loc2_.intersects(param1);
      }
      
      public function validateGlobalPointIntersection(param1:Point, param2:BitmapData) : Boolean
      {
         var _loc3_:Point = new Point();
         getGlobalPosition(_loc3_);
         _loc3_.x = param1.x - _loc3_.x;
         _loc3_.y = param1.y - _loc3_.y;
         return testLocalPointHitAgainstAlpha(_loc3_,param2,var_2521);
      }
      
      public function getMouseRegion(param1:Rectangle) : void
      {
         var _loc2_:Rectangle = null;
         getGlobalRectangle(param1);
         if(param1.width < 0)
         {
            param1.width = 0;
         }
         if(param1.height < 0)
         {
            param1.height = 0;
         }
         if(testParamFlag(16))
         {
            _loc2_ = new Rectangle();
            IWindow(_parent).getMouseRegion(_loc2_);
            if(param1.left < _loc2_.left)
            {
               param1.left = _loc2_.left;
            }
            if(param1.top < _loc2_.top)
            {
               param1.top = _loc2_.top;
            }
            if(param1.right > _loc2_.right)
            {
               param1.right = _loc2_.right;
            }
            if(param1.bottom > _loc2_.bottom)
            {
               param1.bottom = _loc2_.bottom;
            }
         }
      }
      
      protected function testLocalPointHitAgainstAlpha(param1:Point, param2:BitmapData, param3:uint) : Boolean
      {
         var _loc4_:BitmapData = null;
         var _loc5_:Boolean = false;
         if(var_1637 < 1 || var_1642 < 1)
         {
            return false;
         }
         if(var_1871 && var_2521 > 0)
         {
            if(!testParamFlag(16))
            {
               if(param1.x <= var_1637 && param1.y <= var_1642)
               {
                  if((_loc4_ = getGraphicContext(true).fetchDrawBuffer() as BitmapData) != null)
                  {
                     _loc5_ = _loc4_.hitTest(_POINT_ZERO,param3,param1);
                  }
               }
            }
            else
            {
               _loc5_ = param2 != null ? param2.hitTest(_POINT_ZERO,param3,param1) : false;
            }
            return _loc5_;
         }
         return isInWindowBounds(param1);
      }
      
      public function isInWindowBounds(param1:Point) : Boolean
      {
         return param1.x >= 0 && param1.x < var_1637 && param1.y >= 0 && param1.y < var_1642;
      }
      
      public function isCapableOfUsingSharedGraphicContext() : Boolean
      {
         return true;
      }
      
      public function resolveVerticalScale() : Number
      {
         return var_1642 / var_2028.height;
      }
      
      public function resolveHorizontalScale() : Number
      {
         return var_1637 / var_2028.width;
      }
      
      public function offset(param1:Number, param2:Number) : void
      {
         setRectangle(var_31 + param1,var_28 + param2,var_1637,var_1642);
      }
      
      public function scale(param1:Number, param2:Number) : void
      {
         setRectangle(var_31,var_28,var_1637 + param1,var_1642 + param2);
      }
      
      public function scaleToAccommodateChildren() : void
      {
         var _loc9_:* = null;
         var _loc8_:Array = null;
         var _loc6_:* = 0;
         if(!_children)
         {
            return;
         }
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:Boolean = false;
         var _loc4_:uint = uint(param & (131072 | 147456));
         for each(_loc9_ in _children)
         {
            if(_loc9_.visible && _loc9_.x < _loc2_)
            {
               _loc7_ -= _loc9_.x - _loc2_;
               _loc2_ = _loc9_.x;
               _loc5_ = true;
            }
            if(_loc9_.visible && _loc9_.x + _loc9_.width > _loc7_)
            {
               _loc7_ = _loc9_.x + _loc9_.width;
               _loc5_ = true;
            }
            if(_loc9_.visible && _loc9_.y < _loc1_)
            {
               _loc3_ -= _loc9_.y - _loc1_;
               _loc1_ = _loc9_.y;
               _loc5_ = true;
            }
            if(_loc9_.visible && _loc9_.y + _loc9_.height > _loc3_)
            {
               _loc3_ = _loc9_.y + _loc9_.height;
               _loc5_ = true;
            }
         }
         if(_loc5_)
         {
            _loc8_ = [];
            for each(_loc9_ in _children)
            {
               _loc6_ = uint(_loc9_.param & (192 | 3072));
               _loc9_.setParamFlag(_loc6_,false);
               _loc8_.push(_loc6_);
            }
            if(_loc4_)
            {
               setParamFlag(_loc4_,false);
            }
            setRectangle(var_31 + _loc2_,var_28 + _loc1_,_loc7_,_loc3_);
            for each(_loc9_ in _children)
            {
               _loc9_.offset(-_loc2_,-_loc1_);
               _loc9_.setParamFlag(_loc8_.shift(),true);
            }
            if(_loc4_)
            {
               setParamFlag(_loc4_,true);
            }
         }
      }
      
      public function getStateFlag(param1:uint) : Boolean
      {
         return (var_149 & param1) != 0;
      }
      
      public function setStateFlag(param1:uint, param2:Boolean = true) : void
      {
         var _loc3_:uint = var_149;
         var_149 = param2 ? (var_149 = var_149 | param1) : (uint(var_149 = var_149 & ~param1));
         if(var_149 != _loc3_)
         {
            renderDynamicStyle();
            _context.invalidate(this,null,8);
         }
      }
      
      public function getStyleFlag(param1:uint) : Boolean
      {
         return (_style & param1) != 0;
      }
      
      public function setStyleFlag(param1:uint, param2:Boolean = true) : void
      {
         var _loc3_:Array = null;
         var _loc4_:WindowController = null;
         var _loc6_:* = 0;
         var _loc5_:uint = _style;
         _style = param2 ? (_style = _style | param1) : (uint(_style = _style & ~param1));
         if(_style != _loc5_)
         {
            _loc3_ = [];
            groupChildrenWithTag("_INTERNAL",_loc3_);
            _loc6_ = _loc3_.length;
            while(--_loc6_ > -1)
            {
               if((_loc4_ = _loc3_[_loc6_] as WindowController).tags.indexOf("_IGNORE_INHERITED_STYLE") == -1)
               {
                  _loc4_.style = _style;
               }
            }
            _context.invalidate(this,null,1);
         }
      }
      
      public function getParamFlag(param1:uint) : Boolean
      {
         return (var_837 & param1) != 0;
      }
      
      public function setParamFlag(param1:uint, param2:Boolean = true) : void
      {
         var _loc3_:uint = var_837;
         var_837 = param2 ? (var_837 = var_837 | param1) : (uint(var_837 = var_837 & ~param1));
         if(var_837 != _loc3_)
         {
            if(!(var_837 & 16))
            {
               if(!var_1650)
               {
                  setupGraphicsContext();
                  _context.invalidate(this,null,1);
               }
            }
            else if(var_837 & 16)
            {
               if(var_1650)
               {
                  _context.invalidate(this,null,1);
               }
            }
         }
      }
      
      protected function updateScaleRelativeToParent() : void
      {
         var _loc9_:* = 0;
         var _loc2_:* = 0;
         var _loc6_:int = 0;
         if(_parent == null)
         {
            return;
         }
         var _loc1_:* = !testParamFlag(0,192);
         var _loc8_:* = !testParamFlag(0,3072);
         var _loc4_:int = var_31;
         var _loc7_:int = var_28;
         var _loc3_:int = var_1637;
         var _loc5_:int = var_1642;
         if(_loc1_ || _loc8_)
         {
            if(_loc1_)
            {
               _loc6_ = _parent.width - var_2115.width;
               if((_loc9_ = uint(var_837 & 192)) == 128)
               {
                  _loc3_ += _loc6_;
               }
               else if(_loc9_ == 64)
               {
                  _loc4_ += _loc6_;
               }
               else if(_loc9_ == 192)
               {
                  if(_parent.width < _loc3_ && getParamFlag(16))
                  {
                     _loc4_ = 0;
                  }
                  else
                  {
                     _loc4_ = Math.floor(_parent.width / 2) - Math.floor(_loc3_ / 2);
                  }
               }
            }
            if(_loc8_)
            {
               _loc6_ = _parent.height - var_2115.height;
               if((_loc9_ = uint(var_837 & 3072)) == 2048)
               {
                  _loc5_ += _loc6_;
               }
               else if(_loc9_ == 1024)
               {
                  _loc7_ += _loc6_;
               }
               else if(_loc9_ == 3072)
               {
                  if(_parent.height < _loc5_ && getParamFlag(16))
                  {
                     _loc7_ = 0;
                  }
                  else
                  {
                     _loc7_ = Math.floor(_parent.height / 2) - Math.floor(_loc5_ / 2);
                  }
               }
            }
            _loc2_ = var_837;
            var_837 &= -12586177;
            setRectangle(_loc4_,_loc7_,_loc3_,_loc5_);
            var_837 = _loc2_;
         }
         else if(testParamFlag(32))
         {
            if(_parent != null)
            {
               _loc4_ = int(_loc4_ < 0 ? 0 : _loc4_);
               _loc7_ = int(_loc7_ < 0 ? 0 : _loc7_);
               _loc4_ -= _loc4_ + _loc3_ > _parent.width ? _loc4_ + _loc3_ - _parent.width : 0;
               _loc7_ -= _loc7_ + _loc5_ > _parent.height ? _loc7_ + _loc5_ - _parent.height : 0;
               _loc3_ -= _loc4_ + _loc3_ > _parent.width ? _loc4_ + _loc3_ - _parent.width : 0;
               _loc5_ -= _loc7_ + _loc5_ > _parent.height ? _loc7_ + _loc5_ - _parent.height : 0;
               if(_loc4_ != var_31 || _loc7_ != var_28 || _loc3_ != var_1637 || _loc5_ != var_1642)
               {
                  _loc2_ = var_837;
                  var_837 &= -12586177;
                  setRectangle(_loc4_,_loc7_,_loc3_,_loc5_);
                  var_837 = _loc2_;
               }
            }
         }
      }
      
      protected function isChildWindow() : Boolean
      {
         return _parent != context.getDesktopWindow();
      }
      
      public function destroy() : Boolean
      {
         if(var_149 == 1073741824)
         {
            return true;
         }
         var_149 = 1073741824;
         var _loc1_:WindowEvent = WindowEvent.allocate("WE_DESTROY",this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            _loc1_.recycle();
            return false;
         }
         _loc1_.recycle();
         _loc1_ = WindowEvent.allocate("WE_DESTROYED",this,null);
         update(this,_loc1_);
         _loc1_.recycle();
         dispose();
         return true;
      }
      
      public function minimize() : Boolean
      {
         if(var_149 & 64)
         {
            return false;
         }
         var _loc1_:WindowEvent = WindowEvent.allocate("WE_MINIMIZE",this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            _loc1_.recycle();
            return false;
         }
         _loc1_.recycle();
         setStateFlag(64,true);
         _loc1_ = WindowEvent.allocate("WE_MINIMIZED",this,null);
         update(this,_loc1_);
         _loc1_.recycle();
         return true;
      }
      
      public function maximize() : Boolean
      {
         if(var_149 & 64)
         {
            return false;
         }
         var _loc1_:WindowEvent = WindowEvent.allocate("WE_MAXIMIZE",this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            _loc1_.recycle();
            return false;
         }
         _loc1_.recycle();
         setStateFlag(64,true);
         _loc1_ = WindowEvent.allocate("WE_MAXIMIZED",this,null);
         update(this,_loc1_);
         _loc1_.recycle();
         return true;
      }
      
      public function restore() : Boolean
      {
         var _loc1_:WindowEvent = WindowEvent.allocate("WE_RESTORE",this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            _loc1_.recycle();
            return false;
         }
         _loc1_.recycle();
         setStateFlag(64,false);
         _loc1_ = WindowEvent.allocate("WE_RESTORED",this,null);
         update(this,_loc1_);
         _loc1_.recycle();
         return true;
      }
      
      public function activate() : Boolean
      {
         var _loc1_:WindowEvent = WindowEvent.allocate("WE_ACTIVATE",this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            _loc1_.recycle();
            return false;
         }
         _loc1_.recycle();
         setStateFlag(1,true);
         _loc1_ = WindowEvent.allocate("WE_ACTIVATED",this,null);
         update(this,_loc1_);
         _loc1_.recycle();
         return true;
      }
      
      public function deactivate() : Boolean
      {
         if(!getStateFlag(1))
         {
            return true;
         }
         var _loc1_:WindowEvent = WindowEvent.allocate("WE_DEACTIVATE",this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            _loc1_.recycle();
            return false;
         }
         _loc1_.recycle();
         setStateFlag(1,false);
         _loc1_ = WindowEvent.allocate("WE_DEACTIVATED",this,null);
         update(this,_loc1_);
         _loc1_.recycle();
         return true;
      }
      
      public function lock() : Boolean
      {
         if(getStateFlag(64))
         {
            return true;
         }
         var _loc1_:WindowEvent = WindowEvent.allocate("WE_LOCK",this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            _loc1_.recycle();
            return false;
         }
         _loc1_.recycle();
         setStateFlag(64,true);
         _loc1_ = WindowEvent.allocate("WE_LOCKED",this,null);
         update(this,_loc1_);
         _loc1_.recycle();
         return true;
      }
      
      public function unlock() : Boolean
      {
         if(!getStateFlag(64))
         {
            return true;
         }
         var _loc1_:WindowEvent = WindowEvent.allocate("WE_UNLOCK",this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            _loc1_.recycle();
            return false;
         }
         _loc1_.recycle();
         setStateFlag(64,false);
         _loc1_ = WindowEvent.allocate("WE_UNLOCKED",this,null);
         update(this,_loc1_);
         _loc1_.recycle();
         return true;
      }
      
      public function enable() : Boolean
      {
         if(!getStateFlag(32))
         {
            return true;
         }
         var _loc1_:WindowEvent = WindowEvent.allocate("WE_ENABLE",this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            _loc1_.recycle();
            return false;
         }
         _loc1_.recycle();
         setStateFlag(32,false);
         _loc1_ = WindowEvent.allocate("WE_ENABLED",this,null);
         update(this,_loc1_);
         _loc1_.recycle();
         return true;
      }
      
      public function disable() : Boolean
      {
         if(getStateFlag(32))
         {
            return true;
         }
         var _loc1_:WindowEvent = WindowEvent.allocate("WE_DISABLE",this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            _loc1_.recycle();
            return false;
         }
         _loc1_.recycle();
         setStateFlag(32,true);
         _loc1_ = WindowEvent.allocate("WE_DISABLED",this,null);
         update(this,_loc1_);
         _loc1_.recycle();
         return true;
      }
      
      public function focus() : Boolean
      {
         if(getStateFlag(2))
         {
            return true;
         }
         var _loc1_:WindowEvent = WindowEvent.allocate("WE_FOCUS",this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            _loc1_.recycle();
            return false;
         }
         _loc1_.recycle();
         setStateFlag(2,true);
         _loc1_ = WindowEvent.allocate("WE_FOCUSED",this,null);
         update(this,_loc1_);
         _loc1_.recycle();
         return true;
      }
      
      public function unfocus() : Boolean
      {
         if(!getStateFlag(2))
         {
            return true;
         }
         var _loc1_:WindowEvent = WindowEvent.allocate("WE_UNFOCUS",this,null);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            _loc1_.recycle();
            return false;
         }
         _loc1_.recycle();
         setStateFlag(2,false);
         _loc1_ = WindowEvent.allocate("WE_UNFOCUSED",this,null);
         update(this,_loc1_);
         _loc1_.recycle();
         return true;
      }
      
      public function getChildUnderPoint(param1:Point) : IWindow
      {
         var _loc3_:Rectangle = null;
         var _loc5_:IWindow = null;
         var _loc4_:Boolean = false;
         if(var_848)
         {
            _loc3_ = new Rectangle();
            getMouseRegion(_loc3_);
            _loc4_ = _loc3_.containsPoint(param1);
            var _loc2_:uint = uint(numChildren);
            if(_loc4_)
            {
               while(_loc2_ > 0)
               {
                  if((_loc5_ = WindowController(_children[_loc2_ - 1]).getChildUnderPoint(param1)) != null)
                  {
                     return _loc5_;
                  }
                  _loc2_--;
               }
            }
            if(validateGlobalPointIntersection(param1,null))
            {
               return this;
            }
         }
         return null;
      }
      
      public function groupChildrenUnderPoint(param1:Point, param2:Array) : void
      {
         var _loc3_:* = null;
         if(var_848)
         {
            if(param1.x >= var_31 && param1.x < var_31 + var_1637 && param1.y >= var_28 && param1.y < var_28 + var_1642)
            {
               param2.push(this);
               if(_children)
               {
                  param1.offset(-var_31,-var_28);
                  for each(_loc3_ in _children)
                  {
                     _loc3_.groupChildrenUnderPoint(param1,param2);
                  }
                  param1.offset(var_31,var_28);
               }
            }
            else if(!var_3258)
            {
               if(_children)
               {
                  param1.offset(-var_31,-var_28);
                  for each(_loc3_ in _children)
                  {
                     _loc3_.groupChildrenUnderPoint(param1,param2);
                  }
                  param1.offset(var_31,var_28);
               }
            }
         }
      }
      
      public function groupParameterFilteredChildrenUnderPoint(param1:Point, param2:Array, param3:uint = 0) : void
      {
         var _loc4_:* = null;
         if(var_848)
         {
            if(param1.x >= var_31 && param1.x < var_31 + var_1637 && param1.y >= var_28 && param1.y < var_28 + var_1642)
            {
               if((var_837 & param3) == param3)
               {
                  param2.push(this);
               }
               if(_children)
               {
                  param1.offset(-var_31,-var_28);
                  for each(_loc4_ in _children)
                  {
                     _loc4_.groupParameterFilteredChildrenUnderPoint(param1,param2,param3);
                  }
                  param1.offset(var_31,var_28);
               }
            }
            else if(!var_3258)
            {
               if(_children)
               {
                  param1.offset(-var_31,-var_28);
                  for each(_loc4_ in _children)
                  {
                     _loc4_.groupParameterFilteredChildrenUnderPoint(param1,param2,param3);
                  }
                  param1.offset(var_31,var_28);
               }
            }
         }
      }
      
      public function addEventListener(param1:String, param2:Function, param3:int = 0) : void
      {
         if(!_disposed)
         {
            if(!name_1)
            {
               name_1 = new WindowEventDispatcher(this);
            }
            name_1.addEventListener(param1,param2,param3);
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return _disposed || !name_1 ? false : name_1.hasEventListener(param1);
      }
      
      public function removeEventListener(param1:String, param2:Function) : void
      {
         if(!_disposed && name_1)
         {
            name_1.removeEventListener(param1,param2);
         }
      }
      
      public function get children() : Vector.<IWindow>
      {
         return _children;
      }
      
      public function get numChildren() : int
      {
         return !!_children ? _children.length : 0;
      }
      
      public function populate(param1:Array) : void
      {
         var _loc2_:Boolean = false;
         if(!_children)
         {
            _children = new Vector.<IWindow>();
         }
         for each(var _loc3_ in param1)
         {
            if(_loc3_ && _loc3_.parent != this)
            {
               _children.push(_loc3_);
               _loc3_.parent = this;
               _loc2_ ||= _loc3_.hasGraphicsContext();
            }
         }
         if(var_3162 || _loc2_)
         {
            setupGraphicsContext();
         }
      }
      
      public function addChild(param1:IWindow) : IWindow
      {
         var _loc2_:WindowController = WindowController(param1);
         if(_loc2_.parent != null)
         {
            WindowController(_loc2_.parent).removeChild(_loc2_);
         }
         if(!_children)
         {
            _children = new Vector.<IWindow>();
         }
         _children.push(_loc2_);
         _loc2_.parent = this;
         if(var_3162 || _loc2_.hasGraphicsContext())
         {
            setupGraphicsContext();
            if(_loc2_.getGraphicContext(true).parent != var_1650)
            {
               var_1650.addChildContext(_loc2_.getGraphicContext(true));
            }
         }
         var _loc3_:WindowEvent = WindowEvent.allocate("WE_CHILD_ADDED",this,param1);
         update(this,_loc3_);
         _loc3_.recycle();
         return param1;
      }
      
      public function addChildAt(param1:IWindow, param2:int) : IWindow
      {
         var _loc3_:WindowController = WindowController(param1);
         if(_loc3_.parent != null)
         {
            WindowController(_loc3_.parent).removeChild(_loc3_);
         }
         if(!_children)
         {
            _children = new Vector.<IWindow>();
         }
         _children.splice(param2,0,_loc3_);
         _loc3_.parent = this;
         if(var_3162 || _loc3_.hasGraphicsContext())
         {
            setupGraphicsContext();
            if(_loc3_.getGraphicContext(true).parent != var_1650)
            {
               var_1650.addChildContextAt(_loc3_.getGraphicContext(true),param2);
            }
         }
         var _loc4_:WindowEvent = WindowEvent.allocate("WE_CHILD_ADDED",this,param1);
         update(this,_loc4_);
         _loc4_.recycle();
         return param1;
      }
      
      public function getChildAt(param1:int) : IWindow
      {
         return !!_children ? (param1 < _children.length && param1 > -1 ? _children[param1] : null) : null;
      }
      
      public function getChildByID(param1:int) : IWindow
      {
         if(_children)
         {
            for each(var _loc2_ in _children)
            {
               if(_loc2_.id == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function getChildByName(param1:String) : IWindow
      {
         if(_children)
         {
            for each(var _loc2_ in _children)
            {
               if(_loc2_.name == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function findChildByName(param1:String) : IWindow
      {
         var _loc2_:WindowController = null;
         if(_children)
         {
            for each(_loc2_ in _children)
            {
               if(_loc2_.name == param1)
               {
                  return _loc2_;
               }
            }
            for each(_loc2_ in _children)
            {
               _loc2_ = _loc2_.findChildByName(param1) as WindowController;
               if(_loc2_)
               {
                  return _loc2_ as IWindow;
               }
            }
         }
         return null;
      }
      
      public function getChildByTag(param1:String) : IWindow
      {
         if(_children)
         {
            for each(var _loc2_ in _children)
            {
               if(_loc2_.tags.indexOf(param1) > -1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function findChildByTag(param1:String) : IWindow
      {
         if(var_320 && var_320.indexOf(param1) > -1)
         {
            return this;
         }
         var _loc2_:WindowController = WindowController(getChildByTag(param1));
         if(_loc2_ == null && _children)
         {
            for each(_loc2_ in _children)
            {
               _loc2_ = _loc2_.findChildByTag(param1) as WindowController;
               if(_loc2_ != null)
               {
                  break;
               }
            }
         }
         return _loc2_ as IWindow;
      }
      
      public function getChildIndex(param1:IWindow) : int
      {
         return !!_children ? _children.indexOf(param1) : -1;
      }
      
      public function removeChild(param1:IWindow) : IWindow
      {
         if(!_children)
         {
            return null;
         }
         var _loc3_:int = _children.indexOf(param1);
         if(_loc3_ < 0)
         {
            return null;
         }
         _children.splice(_loc3_,1);
         param1.parent = null;
         var _loc2_:IGraphicContextHost = param1 as IGraphicContextHost;
         if(_loc2_ && _loc2_.hasGraphicsContext())
         {
            var_1650.removeChildContext(_loc2_.getGraphicContext(true));
         }
         var _loc4_:WindowEvent = WindowEvent.allocate("WE_CHILD_REMOVED",this,param1);
         update(this,_loc4_);
         _loc4_.recycle();
         return param1;
      }
      
      public function removeChildAt(param1:int) : IWindow
      {
         return removeChild(getChildAt(param1));
      }
      
      public function setChildIndex(param1:IWindow, param2:int) : void
      {
         var _loc4_:WindowController = null;
         if(!_children)
         {
            return;
         }
         var _loc3_:int = _children.indexOf(param1);
         if(_loc3_ > -1 && param2 != _loc3_)
         {
            _children.splice(_loc3_,1);
            _children.splice(param2,0,param1);
            if((_loc4_ = WindowController(param1)).hasGraphicsContext())
            {
               var_1650.setChildContextIndex(_loc4_.getGraphicContext(true),getChildIndex(_loc4_));
            }
         }
      }
      
      public function swapChildren(param1:IWindow, param2:IWindow) : void
      {
         var _loc3_:* = 0;
         var _loc6_:* = 0;
         var _loc5_:* = null;
         var _loc4_:* = 0;
         if(!_children)
         {
            return;
         }
         if(param1 != null && param2 != null && param1 != param2)
         {
            _loc3_ = _children.indexOf(param1);
            if(_loc3_ < 0)
            {
               return;
            }
            if((_loc6_ = _children.indexOf(param2)) < 0)
            {
               return;
            }
            if(_loc6_ < _loc3_)
            {
               _loc5_ = param1;
               param1 = param2;
               param2 = _loc5_;
               _loc4_ = _loc3_;
               _loc3_ = _loc6_;
               _loc6_ = _loc4_;
            }
            _children.splice(_loc6_,1);
            _children.splice(_loc3_,1);
            _children.splice(_loc3_,0,param2);
            _children.splice(_loc6_,0,param1);
            if(WindowController(param1).hasGraphicsContext() || Boolean(WindowController(param2).hasGraphicsContext()))
            {
               var_1650.swapChildContexts(WindowController(param1).getGraphicContext(true),WindowController(param2).getGraphicContext(true));
            }
         }
      }
      
      public function swapChildrenAt(param1:int, param2:int) : void
      {
         if(!_children)
         {
            return;
         }
         swapChildren(_children[param1],_children[param2]);
         var_1650.swapChildContextsAt(param1,param2);
      }
      
      public function groupChildrenWithID(param1:uint, param2:Array, param3:int = 0) : uint
      {
         var _loc5_:* = null;
         if(!_children)
         {
            return 0;
         }
         var _loc4_:uint = 0;
         for each(_loc5_ in _children)
         {
            if(_loc5_.id == param1)
            {
               param2.push(_loc5_);
               _loc4_++;
            }
            if(param3 > 0 || param3 < 0)
            {
               param3--;
               _loc4_ += _loc5_.groupChildrenWithID(param1,param2,param3);
            }
         }
         return _loc4_;
      }
      
      public function groupChildrenWithTag(param1:String, param2:Array, param3:int = 0) : uint
      {
         var _loc5_:* = null;
         if(!_children)
         {
            return 0;
         }
         var _loc4_:uint = 0;
         for each(_loc5_ in _children)
         {
            if(_loc5_.tags.indexOf(param1) > -1)
            {
               param2.push(_loc5_);
               _loc4_++;
            }
            if(param3 > 0 || param3 < 0)
            {
               _loc4_ += _loc5_.groupChildrenWithTag(param1,param2,param3 - 1);
            }
         }
         return _loc4_;
      }
      
      public function findParentByName(param1:String) : IWindow
      {
         if(_name == param1)
         {
            return this;
         }
         if(_parent != null)
         {
            if(_parent.name == param1)
            {
               return _parent;
            }
            return _parent.findParentByName(param1);
         }
         return null;
      }
      
      protected function requiresOwnGraphicContext() : Boolean
      {
         var _loc1_:* = null;
         if(testParamFlag(16))
         {
            if(_children)
            {
               for each(_loc1_ in _children)
               {
                  if(_loc1_.requiresOwnGraphicContext())
                  {
                     return true;
                  }
               }
            }
            return false;
         }
         return true;
      }
      
      public function createProperty(param1:String, param2:Object) : PropertyStruct
      {
         return var_3375.method_20(param1).withValue(param2);
      }
      
      public function getDefaultProperty(param1:String) : PropertyStruct
      {
         return var_3375.method_20(param1);
      }
      
      public function isEnabled() : Boolean
      {
         return !getStateFlag(32);
      }
      
      public function enableChildren(param1:Boolean, param2:Array) : void
      {
         var _loc4_:IWindow = null;
         for each(var _loc3_ in param2)
         {
            if((_loc4_ = this.findChildByName(_loc3_)) != null)
            {
               if(param1)
               {
                  _loc4_.enable();
               }
               else
               {
                  _loc4_.disable();
               }
            }
         }
      }
      
      public function activateChildren(param1:Boolean, param2:Array) : void
      {
         var _loc4_:IWindow = null;
         for each(var _loc3_ in param2)
         {
            if((_loc4_ = this.findChildByName(_loc3_)) != null)
            {
               if(param1)
               {
                  _loc4_.activate();
               }
               else
               {
                  _loc4_.deactivate();
               }
            }
         }
      }
      
      public function setVisibleChildren(param1:Boolean, param2:Array) : void
      {
         var _loc4_:IWindow = null;
         for each(var _loc3_ in param2)
         {
            if((_loc4_ = this.findChildByName(_loc3_)) != null)
            {
               _loc4_.visible = param1;
            }
         }
      }
      
      public function set immediateClickMode(param1:Boolean) : void
      {
         var _loc2_:IGraphicContext = null;
         if(param1 != var_3092)
         {
            var_3092 = param1;
            _loc2_ = getGraphicContext(false);
            if(_loc2_)
            {
               if(var_3092)
               {
                  _loc2_.mouse = true;
                  _loc2_.addEventListener("click",immediateClickHandler);
               }
               else
               {
                  _loc2_.mouse = false;
                  _loc2_.removeEventListener("click",immediateClickHandler);
               }
            }
         }
      }
      
      protected function immediateClickHandler(param1:Event) : void
      {
         var _loc5_:IWindow = null;
         var _loc2_:MouseEvent = param1 as MouseEvent;
         var _loc6_:Point = new Point(_loc2_.stageX,_loc2_.stageY);
         var _loc3_:Array = [];
         desktop.groupChildrenUnderPoint(_loc6_,_loc3_);
         while(_loc3_.length > 0)
         {
            if((_loc5_ = _loc3_.pop()) == this)
            {
               break;
            }
            if(_loc5_.getParamFlag(1))
            {
               return;
            }
         }
         getRelativeMousePosition(_loc6_);
         var _loc4_:WindowEvent = WindowMouseEvent.allocate("WME_CLICK",this,null,_loc6_.x,_loc6_.y,_loc2_.stageX,_loc2_.stageY,_loc2_.altKey,_loc2_.ctrlKey,_loc2_.shiftKey,_loc2_.buttonDown,_loc2_.delta);
         if(name_1)
         {
            name_1.dispatchEvent(_loc4_);
         }
         if(!_loc4_.isWindowOperationPrevented())
         {
            if(procedure != null)
            {
               procedure(_loc4_,this);
            }
         }
         param1.stopImmediatePropagation();
         _loc4_.recycle();
      }
   }
}
