package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.avatar.IAvatarImageListener;
   import com.sulake.habbo.avatar.class_3374;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import com.sulake.habbo.communication.messages.outgoing.users.class_322;
   
   public class AvatarImageWidget implements IAvatarImageWidget, IAvatarImageListener
   {
      
      public static const TYPE:String = "avatar_image";
      
      private static const FIGURE_KEY:String = "avatar_image:figure";
      
      private static const SCALE_KEY:String = "avatar_image:scale";
      
      private static const const_667:String = "avatar_image:only_head";
      
      private static const CROPPED_KEY:String = "avatar_image:cropped";
      
      private static const const_513:String = "avatar_image:direction";
      
      private static const const_417:Array = ["northeast","east","southeast","south","southwest","west","northwest","north"];
      
      private static const FIGURE_DEFAULT:PropertyStruct = new PropertyStruct("avatar_image:figure","hd-180-1.ch-210-66.lg-270-82.sh-290-81","String");
      
      private static const SCALE_DEFAULT:PropertyStruct = new PropertyStruct("avatar_image:scale","h","String",false,["sh","h"]);
      
      private static const ONLY_HEAD_DEFAULT:PropertyStruct = new PropertyStruct("avatar_image:only_head",false,"Boolean");
      
      private static const CROPPED_DEFAULT:PropertyStruct = new PropertyStruct("avatar_image:cropped",false,"Boolean");
      
      private static const DIRECTION_DEFAULT:PropertyStruct = new PropertyStruct("avatar_image:direction",const_417[2],"String",false,const_417);
       
      
      private var _disposed:Boolean;
      
      private var var_1759:IWidgetWindow;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_509:IWindowContainer;
      
      private var _bitmap:IBitmapWrapperWindow;
      
      private var var_1819:IRegionWindow;
      
      private var var_426:String;
      
      private var var_4268:Boolean = false;
      
      private var var_911:String;
      
      private var var_2394:Boolean;
      
      private var _cropped:Boolean;
      
      private var var_1210:int;
      
      private var var_418:int;
      
      private const rc:Number = 0.3333333333333333;
      
      private const gc:Number = 0.3333333333333333;
      
      private const bc:Number = 0.3333333333333333;
      
      public function AvatarImageWidget(param1:IWidgetWindow, param2:HabboWindowManagerComponent)
      {
         var_426 = String(FIGURE_DEFAULT.value);
         var_911 = String(SCALE_DEFAULT.value);
         var_2394 = Boolean(ONLY_HEAD_DEFAULT.value);
         _cropped = Boolean(CROPPED_DEFAULT.value);
         var_1210 = const_417.indexOf(String(DIRECTION_DEFAULT.value));
         super();
         var_1759 = param1;
         _windowManager = param2;
         var_509 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("avatar_image_xml").content as XML) as IWindowContainer;
         _bitmap = var_509.findChildByName("bitmap") as IBitmapWrapperWindow;
         var_1819 = var_509.findChildByName("region") as IRegionWindow;
         var_1819.addEventListener("WME_CLICK",onClick);
         refresh();
         var_1759.rootWindow = var_509;
         var_509.width = var_1759.width;
         var_509.height = var_1759.height;
      }
      
      private static function cleanupAvatarString(param1:String) : String
      {
         return param1 == null || param1.length == 0 ? String(FIGURE_DEFAULT.value) : param1.replace(/NaN/g,"");
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
         _loc1_.push(FIGURE_DEFAULT.withValue(var_426));
         _loc1_.push(SCALE_DEFAULT.withValue(var_911));
         _loc1_.push(ONLY_HEAD_DEFAULT.withValue(var_2394));
         _loc1_.push(CROPPED_DEFAULT.withValue(_cropped));
         _loc1_.push(DIRECTION_DEFAULT.withValue(const_417[var_1210]));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "avatar_image:figure":
                  figure = String(_loc2_.value);
                  break;
               case "avatar_image:scale":
                  scale = String(_loc2_.value);
                  break;
               case "avatar_image:only_head":
                  onlyHead = Boolean(_loc2_.value);
                  break;
               case "avatar_image:cropped":
                  cropped = Boolean(_loc2_.value);
                  break;
               case "avatar_image:direction":
                  direction = const_417.indexOf(String(_loc2_.value));
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
         if(param1 != var_426)
         {
            var_4268 = param1 == null || param1.length == 0;
            var_426 = cleanupAvatarString(param1);
            refresh();
         }
      }
      
      public function get scale() : String
      {
         return var_911;
      }
      
      public function set scale(param1:String) : void
      {
         if(param1 != var_911)
         {
            var_911 = param1;
            refresh();
         }
      }
      
      public function get onlyHead() : Boolean
      {
         return var_2394;
      }
      
      public function set onlyHead(param1:Boolean) : void
      {
         if(param1 != var_2394)
         {
            var_2394 = param1;
            refresh();
         }
      }
      
      public function get cropped() : Boolean
      {
         return _cropped;
      }
      
      public function set cropped(param1:Boolean) : void
      {
         if(param1 != _cropped)
         {
            _cropped = param1;
            refresh();
         }
      }
      
      public function get direction() : int
      {
         return var_1210;
      }
      
      public function set direction(param1:int) : void
      {
         if(param1 != var_1210)
         {
            var_1210 = param1;
            refresh();
         }
      }
      
      public function get userId() : int
      {
         return var_418;
      }
      
      public function set userId(param1:int) : void
      {
         if(var_418 != param1)
         {
            var_418 = param1;
            var_1819.visible = var_418 > 0;
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         if(cleanupAvatarString(param1) == var_426)
         {
            refresh();
         }
      }
      
      private function refresh() : void
      {
         var _loc3_:Number = NaN;
         var _loc1_:class_3374 = null;
         var _loc2_:String = null;
         _bitmap.bitmap = null;
         if(_windowManager.avatarRenderer != null)
         {
            _loc3_ = var_911 == "h" ? 1 : 0.5;
            _loc1_ = _windowManager.avatarRenderer.createAvatarImage(var_426,"h",null,this);
            if(_loc1_ != null)
            {
               _loc1_.setDirection(var_2394 ? "head" : "full",var_1210);
               if(_cropped)
               {
                  _bitmap.bitmap = _loc1_.getCroppedImage(var_2394 ? "head" : "full",_loc3_);
               }
               else
               {
                  _bitmap.bitmap = _loc1_.getImage(var_2394 ? "head" : "full",true,_loc3_);
               }
               if(var_4268)
               {
                  greyBitmap(_bitmap);
               }
               _bitmap.disposesBitmap = true;
               _loc1_.dispose();
            }
         }
         if(_bitmap.bitmap == null || _bitmap.bitmap.width < 2)
         {
            _loc2_ = "placeholder_avatar" + (var_911 == "sh" ? "_small" : "") + (var_2394 ? "_head" : "") + (_cropped ? "_cropped" : "") + "_png";
            _bitmap.bitmap = _windowManager.assets.getAssetByName(_loc2_).content as BitmapData;
            _bitmap.disposesBitmap = false;
            greyBitmap(_bitmap);
         }
         _bitmap.invalidate();
         var_1759.width = _bitmap.bitmap.width;
         var_1759.height = _bitmap.bitmap.height;
      }
      
      private function greyBitmap(param1:IBitmapWrapperWindow) : void
      {
         _bitmap.bitmap.applyFilter(_bitmap.bitmap,_bitmap.bitmap.rect,new Point(),new ColorMatrixFilter([0.3333333333333333,0.3333333333333333,0.3333333333333333,0,0,0.3333333333333333,0.3333333333333333,0.3333333333333333,0,0,0.3333333333333333,0.3333333333333333,0.3333333333333333,0,0,0,0,0,1,0]));
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
         if(var_418 > 0)
         {
            _windowManager.communication.connection.send(new class_322(var_418));
         }
      }
   }
}
