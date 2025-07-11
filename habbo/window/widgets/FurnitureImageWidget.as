package com.sulake.habbo.window.widgets
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.class_3499;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   
   public class FurnitureImageWidget implements class_3618, IGetImageListener
   {
      
      public static const TYPE:String = "furniture_image";
      
      private static const const_887:String = "furniture_image:furnitureType";
      
      private static const SCALE_KEY:String = "furniture_image:scale";
      
      private static const const_513:String = "furniture_image:direction";
      
      private static const const_417:Array = ["northeast","east","southeast","south","southwest","west","northwest","north"];
      
      private static const SCALES:Array = [32,64];
      
      private static const FURNITURE_TYPE_DEFAULT:PropertyStruct = new PropertyStruct("furniture_image:furnitureType","table_plasto_square","String",false);
      
      private static const SCALE_DEFAULT:PropertyStruct = new PropertyStruct("furniture_image:scale",64,"int",false,SCALES);
      
      private static const DIRECTION_DEFAULT:PropertyStruct = new PropertyStruct("furniture_image:direction",const_417[2],"String",false,const_417);
      
      private static const ITEM_TYPE_FLOOR:int = 0;
      
      private static const ITEM_TYPE_WALL:int = 1;
       
      
      private var _disposed:Boolean;
      
      private var var_1759:IWidgetWindow;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_509:IWindowContainer;
      
      private var _bitmap:IBitmapWrapperWindow;
      
      private var var_1819:IRegionWindow;
      
      private var var_3138:String = "table_plasto_square";
      
      private var var_911:int;
      
      private var var_1210:int;
      
      private var var_2787:Map;
      
      private var var_724:String;
      
      private var var_125:int = 0;
      
      private var var_1091:IStuffData = null;
      
      public function FurnitureImageWidget(param1:IWidgetWindow, param2:HabboWindowManagerComponent)
      {
         var_911 = int(SCALE_DEFAULT.value);
         var_1210 = const_417.indexOf(String(DIRECTION_DEFAULT.value));
         super();
         var_1759 = param1;
         _windowManager = param2;
         var_2787 = new Map();
         var_509 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("furniture_image_xml").content as XML) as IWindowContainer;
         _bitmap = var_509.findChildByName("bitmap") as IBitmapWrapperWindow;
         var_1819 = var_509.findChildByName("region") as IRegionWindow;
         var_1819.addEventListener("WME_CLICK",onClick);
         refresh();
         var_1759.rootWindow = var_509;
         var_509.width = var_1759.width;
         var_509.height = var_1759.height;
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
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(FURNITURE_TYPE_DEFAULT.withValue(var_3138));
         _loc1_.push(SCALE_DEFAULT.withValue(var_911));
         _loc1_.push(DIRECTION_DEFAULT.withValue(const_417[var_1210]));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "furniture_image:furnitureType":
                  furnitureType = String(_loc2_.value);
                  break;
               case "furniture_image:scale":
                  scale = int(_loc2_.value);
                  break;
               case "furniture_image:direction":
                  direction = const_417.indexOf(String(_loc2_.value));
                  break;
            }
         }
      }
      
      public function get furnitureType() : String
      {
         return var_3138;
      }
      
      public function set furnitureType(param1:String) : void
      {
         var_3138 = param1;
         refresh();
      }
      
      public function get scale() : int
      {
         return var_911;
      }
      
      public function set scale(param1:int) : void
      {
         var_911 = param1;
         refresh();
      }
      
      public function get direction() : int
      {
         return var_1210;
      }
      
      public function set direction(param1:int) : void
      {
         var_1210 = param1;
         refresh();
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         var _loc3_:String = var_2787.getValue(param1);
         if(_loc3_ == var_3138)
         {
            refresh();
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function refresh() : void
      {
         var _loc1_:class_3499 = null;
         var _loc2_:String = null;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:String = null;
         _bitmap.bitmap = null;
         if(_windowManager.roomEngine != null)
         {
            _loc2_ = "std";
            _loc5_ = _windowManager.roomEngine.getFurnitureTypeId(var_3138);
            if(var_125 == 0)
            {
               _loc1_ = _windowManager.roomEngine.getFurnitureImage(_loc5_,new Vector3d(var_1210 * 45,0,0),var_911,this,0,var_724,-1,-1,var_1091);
            }
            else
            {
               _loc1_ = _windowManager.roomEngine.getWallItemImage(_loc5_,new Vector3d(var_1210 * 45,0,0),var_911,this,0,!!var_1091 ? var_1091.getLegacyString() : "");
            }
            if(_loc1_ != null)
            {
               _loc4_ = _loc1_.id;
               var_2787.remove(_loc4_);
               if(_loc4_ > 0)
               {
                  var_2787.add(_loc4_,var_3138);
               }
               _bitmap.bitmap = _loc1_.data;
               _bitmap.disposesBitmap = true;
            }
         }
         if(_bitmap.bitmap == null || _bitmap.bitmap.width < 2)
         {
            _loc3_ = "placeholder_furni" + (var_911 == 32 ? "_small" : "") + "_png";
            _bitmap.bitmap = _windowManager.assets.getAssetByName(_loc3_).content as BitmapData;
            _bitmap.disposesBitmap = false;
         }
         _bitmap.invalidate();
         var_1759.width = _bitmap.bitmap.width;
         var_1759.height = _bitmap.bitmap.height;
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
      }
   }
}
