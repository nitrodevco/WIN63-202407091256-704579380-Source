package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.core.window.utils.class_3501;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class PixelLimitWidget implements class_3530
   {
      
      public static const TYPE:String = "pixel_limit";
      
      private static const LIMIT_KEY:String = "pixel_limit:limit";
      
      private static const LIMIT_DEFAULT:PropertyStruct = new PropertyStruct("pixel_limit:limit",0,"String",false,null);
       
      
      private var _disposed:Boolean;
      
      private var var_1759:IWidgetWindow;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_3089:Boolean;
      
      private var var_509:IWindowContainer;
      
      private var _bitmap:IStaticBitmapWrapperWindow;
      
      private var var_1819:IRegionWindow;
      
      private var var_1452:int;
      
      public function PixelLimitWidget(param1:IWidgetWindow, param2:HabboWindowManagerComponent)
      {
         var_1452 = int(LIMIT_DEFAULT.value);
         super();
         var_1759 = param1;
         _windowManager = param2;
         var_509 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("badge_image_xml").content as XML) as IWindowContainer;
         _bitmap = var_509.findChildByName("bitmap") as IStaticBitmapWrapperWindow;
         var_1759.rootWindow = var_509;
         var_509.width = var_1759.width;
         var_509.height = var_1759.height;
      }
      
      public function get limit() : int
      {
         return var_1452;
      }
      
      public function set limit(param1:int) : void
      {
         var_1452 = Math.max(0,Math.min(100,param1));
         refresh();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_1819 != null)
            {
               var_1819.removeEventListener("WME_CLICK",onClick);
               var_1819.dispose();
               var_1819 = null;
            }
            _bitmap = null;
            if(var_509 != null)
            {
               var_509.dispose();
               var_509 = null;
            }
            if(var_1759 != null)
            {
               var_1759.rootWindow = null;
               var_1759 = null;
            }
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
      
      public function get properties() : Array
      {
         var _loc2_:Array = [];
         if(_disposed)
         {
            return _loc2_;
         }
         _loc2_.push(LIMIT_DEFAULT.withValue(var_1452));
         for each(var _loc1_ in _bitmap.properties)
         {
            if(_loc1_.key != "asset_uri")
            {
               _loc2_.push(_loc1_.withNameSpace("pixel_limit"));
            }
         }
         return _loc2_;
      }
      
      public function set properties(param1:Array) : void
      {
         var_3089 = true;
         var _loc3_:Array = [];
         for each(var _loc2_ in param1)
         {
            var _loc4_:* = _loc2_.key;
            if("pixel_limit:limit" === _loc4_)
            {
               limit = int(_loc2_.value);
            }
            if(_loc2_.key != "pixel_limit:asset_uri")
            {
               _loc3_.push(_loc2_.withoutNameSpace());
            }
         }
         _bitmap.properties = _loc3_;
         var_3089 = false;
         refresh();
      }
      
      private function refresh() : void
      {
         if(var_3089)
         {
            return;
         }
         _bitmap.assetUri = assetUri;
         _bitmap.invalidate();
      }
      
      private function get assetUri() : String
      {
         var _loc2_:String = null;
         var _loc1_:int = Math.floor(var_1452 / 20) * 20;
         _loc1_ = Math.max(_loc1_,20);
         _loc2_ = "${image.library.url}reception/challenge_meter_%amount%.png";
         return _loc2_.replace("%amount%",_loc1_.toString());
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
      }
      
      public function get bitmapData() : BitmapData
      {
         return class_3501(_bitmap).bitmapData;
      }
      
      public function get pivotPoint() : uint
      {
         return _bitmap.pivotPoint;
      }
      
      public function set pivotPoint(param1:uint) : void
      {
         _bitmap.pivotPoint = param1;
         _bitmap.invalidate();
      }
      
      public function get stretchedX() : Boolean
      {
         return _bitmap.stretchedX;
      }
      
      public function set stretchedX(param1:Boolean) : void
      {
         _bitmap.stretchedX = param1;
         _bitmap.invalidate();
      }
      
      public function get stretchedY() : Boolean
      {
         return _bitmap.stretchedY;
      }
      
      public function set stretchedY(param1:Boolean) : void
      {
         _bitmap.stretchedY = param1;
         _bitmap.invalidate();
      }
      
      public function get zoomX() : Number
      {
         return _bitmap.zoomX;
      }
      
      public function set zoomX(param1:Number) : void
      {
         _bitmap.zoomX = param1;
         _bitmap.invalidate();
      }
      
      public function get zoomY() : Number
      {
         return _bitmap.zoomY;
      }
      
      public function set zoomY(param1:Number) : void
      {
         _bitmap.zoomY = param1;
         _bitmap.invalidate();
      }
      
      public function get greyscale() : Boolean
      {
         return _bitmap.greyscale;
      }
      
      public function set greyscale(param1:Boolean) : void
      {
         _bitmap.greyscale = param1;
         _bitmap.invalidate();
      }
      
      public function get etchingColor() : uint
      {
         return _bitmap.etchingColor;
      }
      
      public function set etchingColor(param1:uint) : void
      {
         _bitmap.etchingColor = param1;
         _bitmap.invalidate();
      }
      
      public function get fitSizeToContents() : Boolean
      {
         return _bitmap.fitSizeToContents;
      }
      
      public function set fitSizeToContents(param1:Boolean) : void
      {
         _bitmap.fitSizeToContents = param1;
         _bitmap.invalidate();
      }
      
      public function get etchingPoint() : Point
      {
         return new Point(0,1);
      }
      
      public function get wrapX() : Boolean
      {
         return false;
      }
      
      public function set wrapX(param1:Boolean) : void
      {
      }
      
      public function get wrapY() : Boolean
      {
         return false;
      }
      
      public function set wrapY(param1:Boolean) : void
      {
      }
      
      public function get rotation() : Number
      {
         return 0;
      }
      
      public function set rotation(param1:Number) : void
      {
      }
   }
}
