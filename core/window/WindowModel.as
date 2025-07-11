package com.sulake.core.window
{
   import com.sulake.core.runtime.IDisposable;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class WindowModel implements IDisposable
   {
      
      private static var POINT_ZERO:Point = new Point(0,0);
       
      
      protected var _offsetX:int;
      
      protected var _offsetY:int;
      
      protected var var_31:int;
      
      protected var var_28:int;
      
      protected var var_1637:int;
      
      protected var var_1642:int;
      
      protected var var_2028:Rectangle;
      
      protected var var_1663:Rectangle;
      
      protected var var_1841:Rectangle;
      
      protected var var_1825:Rectangle;
      
      protected var _context:WindowContext;
      
      protected var _background:Boolean = false;
      
      protected var _fillColor:uint = 16777215;
      
      protected var var_4180:ColorTransform;
      
      protected var _alphaColor:uint;
      
      protected var var_2521:uint = 10;
      
      protected var _ignoreMouseEvents:Boolean = false;
      
      protected var var_3258:Boolean = true;
      
      protected var var_848:Boolean = true;
      
      protected var var_2314:Number = 1;
      
      protected var var_837:uint;
      
      protected var var_149:uint;
      
      protected var _style:uint;
      
      protected var var_329:uint;
      
      protected var _caption:String = "";
      
      protected var _name:String;
      
      protected var var_280:uint;
      
      protected var var_320:Array;
      
      protected var _disposed:Boolean = false;
      
      protected var var_2733:String = "";
      
      public function WindowModel(param1:uint, param2:String, param3:uint, param4:uint, param5:uint, param6:WindowContext, param7:Rectangle, param8:Array = null, param9:String = "")
      {
         super();
         var_280 = param1;
         _name = param2;
         var_329 = param3;
         var_837 = param5;
         var_149 = 0;
         _style = param4;
         var_320 = param8;
         _context = param6;
         var_2733 = param9;
         var_31 = param7.x;
         var_28 = param7.y;
         var_1637 = param7.width;
         var_1642 = param7.height;
         var_2028 = param7.clone();
         var_1663 = param7.clone();
      }
      
      public function get x() : int
      {
         return var_31;
      }
      
      public function get y() : int
      {
         return var_28;
      }
      
      public function get width() : int
      {
         return var_1637;
      }
      
      public function get height() : int
      {
         return var_1642;
      }
      
      public function get position() : Point
      {
         return new Point(var_31,var_28);
      }
      
      public function get rectangle() : Rectangle
      {
         return new Rectangle(var_31,var_28,var_1637,var_1642);
      }
      
      public function get context() : class_3400
      {
         return _context;
      }
      
      public function get mouseThreshold() : uint
      {
         return var_2521;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get background() : Boolean
      {
         return _background;
      }
      
      public function get clipping() : Boolean
      {
         return var_3258;
      }
      
      public function get visible() : Boolean
      {
         return var_848;
      }
      
      public function get color() : uint
      {
         return _fillColor;
      }
      
      public function get alpha() : uint
      {
         return _alphaColor >>> 24;
      }
      
      public function get blend() : Number
      {
         return var_2314;
      }
      
      public function get param() : uint
      {
         return var_837;
      }
      
      public function get state() : uint
      {
         return var_149;
      }
      
      public function get style() : uint
      {
         return _style;
      }
      
      public function get type() : uint
      {
         return var_329;
      }
      
      public function get caption() : String
      {
         return _caption;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function get tags() : Array
      {
         return !!var_320 ? var_320 : (var_320 = []);
      }
      
      public function get left() : int
      {
         return var_31;
      }
      
      public function get top() : int
      {
         return var_28;
      }
      
      public function get right() : int
      {
         return var_31 + var_1637;
      }
      
      public function get bottom() : int
      {
         return var_28 + var_1642;
      }
      
      public function get renderingX() : int
      {
         return _offsetX + var_31;
      }
      
      public function get renderingY() : int
      {
         return _offsetY + var_28;
      }
      
      public function get renderingWidth() : int
      {
         return var_1637 + Math.abs(etchingPoint.x);
      }
      
      public function get renderingHeight() : int
      {
         return var_1642 + Math.abs(etchingPoint.y);
      }
      
      public function get renderingRectangle() : Rectangle
      {
         return new Rectangle(renderingX,renderingY,renderingWidth,renderingHeight);
      }
      
      public function get etchingPoint() : Point
      {
         return POINT_ZERO;
      }
      
      public function get dynamicStyle() : String
      {
         return var_2733;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _disposed = true;
            _context = null;
            var_149 = 1073741824;
            var_320 = null;
            var_31 = var_28 = var_1637 = var_1642 = 0;
         }
      }
      
      public function invalidate(param1:Rectangle = null) : void
      {
      }
      
      public function getInitialWidth() : int
      {
         return var_2028.width;
      }
      
      public function getInitialHeight() : int
      {
         return var_2028.height;
      }
      
      public function getPreviousWidth() : int
      {
         return var_1663.width;
      }
      
      public function getPreviousHeight() : int
      {
         return var_1663.height;
      }
      
      public function getMinimizedWidth() : int
      {
         return !!var_1841 ? var_1841.width : 0;
      }
      
      public function getMinimizedHeight() : int
      {
         return !!var_1841 ? var_1841.height : 0;
      }
      
      public function getMaximizedWidth() : int
      {
         return !!var_1825 ? var_1825.width : 2147483647;
      }
      
      public function getMaximizedHeight() : int
      {
         return !!var_1825 ? var_1825.height : 2147483647;
      }
      
      public function testTypeFlag(param1:uint, param2:uint = 0) : Boolean
      {
         if(param2 > 0)
         {
            return (var_329 & param2 ^ param1) == 0;
         }
         return (var_329 & param1) == param1;
      }
      
      public function testStateFlag(param1:uint, param2:uint = 0) : Boolean
      {
         if(param2 > 0)
         {
            return (var_149 & param2 ^ param1) == 0;
         }
         return (var_149 & param1) == param1;
      }
      
      public function testStyleFlag(param1:uint, param2:uint = 0) : Boolean
      {
         if(param2 > 0)
         {
            return (_style & param2 ^ param1) == 0;
         }
         return (_style & param1) == param1;
      }
      
      public function testParamFlag(param1:uint, param2:uint = 0) : Boolean
      {
         if(param2 > 0)
         {
            return (var_837 & param2 ^ param1) == 0;
         }
         return (var_837 & param1) == param1;
      }
   }
}
