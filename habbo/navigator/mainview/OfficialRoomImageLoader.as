package com.sulake.habbo.navigator.mainview
{
    import assets.class_14

    import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.habbo.navigator.IHabboTransitionalNavigator;
   import flash.display.BitmapData;
   import flash.net.URLRequest;
   
   public class OfficialRoomImageLoader implements IDisposable
   {
       
      
      private var _navigator:IHabboTransitionalNavigator;
      
      private var var_1145:String;
      
      private var var_96:String;
      
      private var var_2336:IBitmapWrapperWindow;
      
      private var _disposed:Boolean;
      
      public function OfficialRoomImageLoader(param1:IHabboTransitionalNavigator, param2:String, param3:IBitmapWrapperWindow)
      {
         super();
         _navigator = param1;
         var_1145 = param2;
         var_2336 = param3;
         var _loc4_:String;
         var_96 = (_loc4_ = _navigator.getProperty("image.library.url")) + var_1145;
         class_14.log("[OFFICIAL ROOM ICON IMAGE DOWNLOADER] : " + var_96);
      }
      
      public function startLoad() : void
      {
         var _loc1_:URLRequest = null;
         var _loc2_:AssetLoaderStruct = null;
         if(_navigator.assets.hasAsset(var_1145))
         {
            setImage();
         }
         else
         {
            _loc1_ = new URLRequest(var_96);
            _loc2_ = _navigator.assets.loadAssetFromFile(var_1145,_loc1_,"image/gif");
            _loc2_.addEventListener("AssetLoaderEventComplete",onImageReady);
            _loc2_.addEventListener("AssetLoaderEventError",onLoadError);
         }
      }
      
      private function onImageReady(param1:AssetLoaderEvent) : void
      {
         if(_disposed)
         {
            return;
         }
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc2_ == null)
         {
            class_14.log("Loading pic from url: " + var_96 + " failed. loaderStruct == null");
            return;
         }
         setImage();
      }
      
      private function setImage() : void
      {
         var _loc1_:BitmapData = null;
         if(_navigator && !_navigator.disposed && var_2336 && !var_2336.disposed)
         {
            _loc1_ = _navigator.getButtonImage(var_1145,"");
            if(_loc1_)
            {
               var_2336.disposesBitmap = false;
               var_2336.bitmap = _loc1_;
               var_2336.width = _loc1_.width;
               var_2336.height = _loc1_.height;
               var_2336.visible = true;
            }
            else
            {
               class_14.log("OfficialRoomImageLoader - Image not found: " + var_1145);
            }
         }
         dispose();
      }
      
      private function onLoadError(param1:AssetLoaderEvent) : void
      {
         class_14.log("Error loading image: " + var_96 + ", " + param1);
         dispose();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         var_2336 = null;
         _navigator = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}
