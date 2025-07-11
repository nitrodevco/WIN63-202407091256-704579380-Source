package com.sulake.habbo.groups.badge
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IResourceManager;
   import com.sulake.core.assets.class_3607;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.habbo.groups.HabboGroupsManager;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import com.sulake.habbo.communication.messages.incoming.users.class_1684;
   import com.sulake.habbo.communication.messages.incoming.users.class_1688;
   
   public class BadgeEditorPartItem implements IDisposable, class_3607
   {
      
      public static var BASE_PART:int = 0;
      
      public static var LAYER_PART:int = 1;
      
      public static var IMAGE_WIDTH:Number = 39;
      
      public static var IMAGE_HEIGHT:Number = 39;
      
      public static var CELL_WIDTH:Number = 13;
      
      public static var CELL_HEIGHT:Number = 13;
       
      
      private var var_480:HabboGroupsManager;
      
      private var var_1823:BadgeSelectPartCtrl;
      
      private var var_3856:int;
      
      private var var_329:int;
      
      private var var_4220:String;
      
      private var _disposed:Boolean;
      
      private var _fileName:String;
      
      private var _maskFileName:String;
      
      private var var_859:BitmapData;
      
      private var var_1877:BitmapData;
      
      private var _composite:BitmapData;
      
      private var var_2205:ColorTransform;
      
      private var var_3967:Boolean = false;
      
      private var _isLoaded:Boolean = false;
      
      private var var_3639:Boolean = false;
      
      public function BadgeEditorPartItem(param1:HabboGroupsManager, param2:BadgeSelectPartCtrl, param3:int, param4:int, param5:class_1684 = null)
      {
         var_2205 = new ColorTransform(1,1,1);
         super();
         var_3856 = param3;
         var_480 = param1;
         var_1823 = param2;
         var_329 = param4;
         var_4220 = var_480.getProperty("image.library.badgepart.url");
         _composite = new BitmapData(IMAGE_WIDTH,IMAGE_HEIGHT);
         if(param5 == null)
         {
            _isLoaded = true;
            var_3639 = true;
            var_859 = var_480.getButtonImage("badge_part_empty");
         }
         else
         {
            _fileName = param5.fileName.replace(".gif","").replace(".png","");
            _maskFileName = param5.maskFileName.replace(".gif","").replace(".png","");
            var_3967 = _maskFileName.length > 0;
            _composite = new BitmapData(IMAGE_WIDTH,IMAGE_HEIGHT);
            _fileName = var_4220 + "badgepart_" + _fileName + ".png";
            _maskFileName = var_4220 + "badgepart_" + _maskFileName + ".png";
            var_480.windowManager.resourceManager.retrieveAsset(_fileName,this);
            var_480.windowManager.resourceManager.retrieveAsset(_maskFileName,this);
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get partIndex() : int
      {
         return var_3856;
      }
      
      public function receiveAsset(param1:IAsset, param2:String) : void
      {
         var _loc3_:IResourceManager = var_480.windowManager.resourceManager;
         if(_loc3_.isSameAsset(_fileName,param2))
         {
            var_859 = param1.content as BitmapData;
         }
         if(_loc3_.isSameAsset(_maskFileName,param2))
         {
            var_1877 = param1.content as BitmapData;
         }
         checkIsImageLoaded();
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(var_859)
            {
               var_859.dispose();
               var_859 = null;
            }
            if(var_1877)
            {
               var_1877.dispose();
               var_1877 = null;
            }
            if(_composite)
            {
               _composite.dispose();
               _composite = null;
            }
            _fileName = null;
            _maskFileName = null;
            var_2205 = null;
            var_1823 = null;
            var_480 = null;
            _disposed = true;
         }
      }
      
      private function checkIsImageLoaded() : void
      {
         if(var_859 == null)
         {
            return;
         }
         if(var_3967 && var_1877 == null)
         {
            return;
         }
         _isLoaded = true;
         if(var_329 == BASE_PART)
         {
            var_1823.onBaseImageLoaded(this);
         }
         else
         {
            var_1823.onLayerImageLoaded(this);
         }
      }
      
      public function getComposite(param1:BadgeLayerOptions) : BitmapData
      {
         if(!_isLoaded)
         {
            return null;
         }
         if(var_3639)
         {
            return var_859;
         }
         var _loc2_:class_1688 = var_480.guildEditorData.badgeColors[param1.colorIndex] as class_1688;
         var_2205.redMultiplier = _loc2_.red / 255;
         var_2205.greenMultiplier = _loc2_.green / 255;
         var_2205.blueMultiplier = _loc2_.blue / 255;
         var _loc3_:Point = getPosition(param1);
         _composite.dispose();
         _composite = new BitmapData(IMAGE_WIDTH,IMAGE_HEIGHT,true,0);
         _composite.copyPixels(var_859,var_859.rect,_loc3_);
         _composite.colorTransform(_composite.rect,var_2205);
         if(var_3967)
         {
            _composite.copyPixels(var_1877,var_1877.rect,_loc3_,null,null,true);
         }
         return _composite;
      }
      
      private function getPosition(param1:BadgeLayerOptions) : Point
      {
         var _loc2_:Number = CELL_WIDTH * param1.gridX + CELL_WIDTH / 2 - var_859.width / 2;
         var _loc3_:Number = CELL_HEIGHT * param1.gridY + CELL_HEIGHT / 2 - var_859.height / 2;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         if(_loc2_ + var_859.width > IMAGE_WIDTH)
         {
            _loc2_ = IMAGE_WIDTH - var_859.width;
         }
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         if(_loc3_ + var_859.height > IMAGE_HEIGHT)
         {
            _loc3_ = IMAGE_HEIGHT - var_859.height;
         }
         return new Point(Math.floor(_loc2_),Math.floor(_loc3_));
      }
   }
}
