package com.sulake.habbo.window.widgets
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.avatar.pets.PetFigureData;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.class_3499;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public class PetImageWidget implements class_3654, IGetImageListener
   {
      
      public static const TYPE:String = "pet_image";
      
      private static const FIGURE_KEY:String = "pet_image:figure";
      
      private static const SCALE_KEY:String = "pet_image:scale";
      
      private static const const_513:String = "pet_image:direction";
      
      private static const const_826:String = "pet_image:zoomX";
      
      private static const const_780:String = "pet_image:zoomY";
      
      private static const SHRINK_ON_OVERFLOW_KEY:String = "pet_image:shrink_on_overflow";
      
      private static const const_417:Array = ["northeast","east","southeast","south","southwest","west","northwest","north"];
      
      private static const SCALES:Array = [32,64];
      
      private static const FIGURE_DEFAULT:PropertyStruct = new PropertyStruct("pet_image:figure","1 0 ffffff","String");
      
      private static const SCALE_DEFAULT:PropertyStruct = new PropertyStruct("pet_image:scale",64,"int",false,SCALES);
      
      private static const DIRECTION_DEFAULT:PropertyStruct = new PropertyStruct("pet_image:direction",const_417[2],"String",false,const_417);
      
      private static const ZOOM_X_DEFAULT:PropertyStruct = new PropertyStruct("pet_image:zoomX",1,"Number");
      
      private static const ZOOM_Y_DEFAULT:PropertyStruct = new PropertyStruct("pet_image:zoomY",1,"Number");
      
      private static const SHRINK_ON_OVERFLOW_DEFAULT:PropertyStruct = new PropertyStruct("pet_image:shrink_on_overflow",false,"Boolean");
       
      
      private var _disposed:Boolean;
      
      private var var_1759:IWidgetWindow;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_509:IWindowContainer;
      
      private var _bitmap:IBitmapWrapperWindow;
      
      private var var_1819:IRegionWindow;
      
      private var var_426:String;
      
      private var var_911:int;
      
      private var var_1210:int;
      
      private var var_2571:Number;
      
      private var var_2650:Number;
      
      private var _shrinkOnOverflow:Boolean;
      
      private var var_2787:Map;
      
      private var var_2756:BitmapData;
      
      public function PetImageWidget(param1:IWidgetWindow, param2:HabboWindowManagerComponent)
      {
         var_426 = String(FIGURE_DEFAULT.value);
         var_911 = int(SCALE_DEFAULT.value);
         var_1210 = const_417.indexOf(String(DIRECTION_DEFAULT.value));
         var_2571 = Number(ZOOM_X_DEFAULT.value);
         var_2650 = Number(ZOOM_Y_DEFAULT.value);
         _shrinkOnOverflow = Boolean(SHRINK_ON_OVERFLOW_DEFAULT.value);
         super();
         var_1759 = param1;
         _windowManager = param2;
         var_2787 = new Map();
         var_509 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("pet_image_xml").content as XML) as IWindowContainer;
         _bitmap = var_509.findChildByName("bitmap") as IBitmapWrapperWindow;
         var_1819 = var_509.findChildByName("region") as IRegionWindow;
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
         _loc1_.push(FIGURE_DEFAULT.withValue(var_426));
         _loc1_.push(SCALE_DEFAULT.withValue(var_911));
         _loc1_.push(DIRECTION_DEFAULT.withValue(const_417[var_1210]));
         _loc1_.push(ZOOM_X_DEFAULT.withValue(var_2571));
         _loc1_.push(ZOOM_Y_DEFAULT.withValue(var_2650));
         _loc1_.push(SHRINK_ON_OVERFLOW_DEFAULT.withValue(_shrinkOnOverflow));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "pet_image:figure":
                  figure = String(_loc2_.value);
                  break;
               case "pet_image:scale":
                  scale = int(_loc2_.value);
                  break;
               case "pet_image:direction":
                  direction = const_417.indexOf(String(_loc2_.value));
                  break;
               case "pet_image:zoomX":
                  zoomX = Number(_loc2_.value);
                  break;
               case "pet_image:zoomY":
                  zoomY = Number(_loc2_.value);
                  break;
               case "pet_image:shrink_on_overflow":
                  shrinkOnOverflow = Boolean(_loc2_.value);
                  break;
            }
         }
      }
      
      public function get figure() : String
      {
         return var_426;
      }
      
      public function set figure(param1:String) : void
      {
         var_426 = cleanupAvatarString(param1);
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
      
      public function get shrinkOnOverflow() : Boolean
      {
         return _shrinkOnOverflow;
      }
      
      public function set shrinkOnOverflow(param1:Boolean) : void
      {
         _shrinkOnOverflow = param1;
         refresh();
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         var _loc3_:String = var_2787.getValue(param1);
         if(_loc3_ != null)
         {
            if(cleanupAvatarString(_loc3_) == var_426)
            {
               refresh();
            }
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function refresh() : void
      {
         var _loc4_:String = null;
         var _loc2_:class_3499 = null;
         var _loc6_:int = 0;
         var _loc5_:String = null;
         if(_bitmap == null)
         {
            return;
         }
         _bitmap.bitmap = null;
         var _loc1_:PetFigureData = new PetFigureData(var_426);
         if(_windowManager.roomEngine != null)
         {
            _loc4_ = "std";
            _loc2_ = _windowManager.roomEngine.getPetImage(_loc1_.typeId,_loc1_.paletteId,_loc1_.color,new Vector3d(var_1210 * 45),scale,this,true,0,_loc1_.customParts,_loc4_);
            if(_loc2_ != null)
            {
               _loc6_ = _loc2_.id;
               var_2787.remove(_loc6_);
               if(_loc6_ > 0)
               {
                  var_2787.add(_loc6_,var_426);
               }
               _bitmap.bitmap = _loc2_.data;
               _bitmap.disposesBitmap = true;
            }
         }
         if(_bitmap.bitmap == null || _bitmap.bitmap.width < 2)
         {
            _loc5_ = "placeholder_pet" + (var_911 == 32 ? "_small" : "") + "_png";
            _bitmap.bitmap = _windowManager.assets.getAssetByName(_loc5_).content as BitmapData;
            _bitmap.disposesBitmap = false;
         }
         var _loc7_:Number = zoomX;
         var _loc3_:Number = zoomY;
         var_2756 = _bitmap.bitmap;
         if(_shrinkOnOverflow && (var_2756.width * zoomX > var_1759.width || var_2756.height * zoomY > var_1759.height))
         {
            _loc7_ *= 0.5;
            _loc3_ *= 0.5;
         }
         if(_loc7_ != 1 || _loc3_ != 1)
         {
            _bitmap.bitmap = zoomBitmapData(_bitmap.bitmap,_loc7_,_loc3_);
         }
         _bitmap.invalidate();
      }
      
      private function zoomBitmapData(param1:BitmapData, param2:Number, param3:Number) : BitmapData
      {
         var _loc5_:Number = param1.width * param2;
         var _loc6_:Number = param1.height * param3;
         var _loc4_:BitmapData = new BitmapData(_loc5_,_loc6_,true,0);
         var _loc7_:Matrix;
         (_loc7_ = new Matrix()).scale(param2,param3);
         _loc4_.draw(param1,_loc7_);
         return _loc4_;
      }
      
      private function cleanupAvatarString(param1:String) : String
      {
         return param1 == null ? String(FIGURE_DEFAULT.value) : param1.replace(/NaN/g,"");
      }
      
      public function get zoomX() : Number
      {
         return var_2571;
      }
      
      public function get zoomY() : Number
      {
         return var_2650;
      }
      
      public function set zoomX(param1:Number) : void
      {
         var_2571 = param1;
         refresh();
      }
      
      public function set zoomY(param1:Number) : void
      {
         var_2650 = param1;
         refresh();
      }
      
      public function get petWidth() : int
      {
         if(var_2756 == null)
         {
            return 0;
         }
         return var_2756.width;
      }
      
      public function get petHeight() : int
      {
         if(var_2756 == null)
         {
            return 0;
         }
         return var_2756.height;
      }
   }
}
