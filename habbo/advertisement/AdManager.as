package com.sulake.habbo.advertisement
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.advertisement.events.AdEvent;
   import com.sulake.habbo.advertisement.events.InterstitialEvent;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.system.Security;
   import com.sulake.habbo.communication.messages.parser.advertisement.class_1485;
   import com.sulake.habbo.communication.messages.outgoing.advertisement.class_703;
   import com.sulake.habbo.communication.messages.incoming.advertisement.InterstitialMessageEvent;
   
   public class AdManager extends Component implements class_1811
   {
      
      private static const INTERSTITIAL_COMPLETE_CALLBACK:String = "interstitialCompleted";
       
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _catalog:IHabboCatalog;
      
      private var var_3302:BitmapData = null;
      
      private var var_3577:BitmapData = null;
      
      private var _billboardImageLoaders:Map;
      
      private var var_3844:IMessageEvent;
      
      public function AdManager(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         super(param1,param2,param3);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         }),new ComponentDependency(new IIDHabboConfigurationManager(),null),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         },false),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         },false)]);
      }
      
      override protected function initComponent() : void
      {
         var _loc1_:URLRequest = null;
         var _loc2_:AssetLoaderStruct = null;
         _billboardImageLoaders = new Map();
         var_3844 = _communicationManager.addHabboConnectionMessageEvent(new InterstitialMessageEvent(onInterstitial));
         var _loc6_:String;
         if((_loc6_ = getProperty("ads.domain")) != "")
         {
            Security.loadPolicyFile("http://" + _loc6_ + "/crossdomain.xml");
         }
         var _loc3_:String = getProperty("billboard.adwarning.left.url");
         var _loc4_:String = getProperty("billboard.adwarning.right.url");
         var _loc5_:String = getProperty("image.library.url");
         if(_loc3_ != "" && _loc4_ != "")
         {
            _loc3_ = _loc5_ + _loc3_;
            _loc4_ = _loc5_ + _loc4_;
            _loc1_ = new URLRequest(_loc3_);
            _loc2_ = assets.loadAssetFromFile("adWarningL",_loc1_,"image/png");
            _loc2_.addEventListener("AssetLoaderEventComplete",adWarningLeftReady);
            _loc1_ = new URLRequest(_loc4_);
            _loc2_ = assets.loadAssetFromFile("adWarningRight",_loc1_,"image/png");
            _loc2_.addEventListener("AssetLoaderEventComplete",adWarningRightReady);
         }
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("interstitialCompleted",interstitialCompleteCallback);
         }
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(_billboardImageLoaders != null)
         {
            _billboardImageLoaders.dispose();
            _billboardImageLoaders = null;
         }
         if(_communicationManager != null)
         {
            _communicationManager.removeHabboConnectionMessageEvent(var_3844);
            var_3844 = null;
         }
         if(var_3302)
         {
            var_3302.dispose();
            var_3302 = null;
         }
         if(var_3577)
         {
            var_3577.dispose();
            var_3577 = null;
         }
         super.dispose();
      }
      
      public function showInterstitial() : void
      {
         if(!getBoolean("interstitials.2016.enabled"))
         {
            noInterstitialAvailable();
            return;
         }
         _communicationManager.connection.send(new class_703());
      }
      
      private function onInterstitial(param1:InterstitialMessageEvent) : void
      {
         var _loc2_:class_1485 = param1.getParser();
         if(_loc2_ && _loc2_.canShowInterstitial)
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("FlashExternalInterface.showInterstitial");
               events.dispatchEvent(new InterstitialEvent("AE_INTERSTITIAL_SHOW"));
            }
            else
            {
               noInterstitialAvailable();
            }
         }
         else
         {
            noInterstitialAvailable();
         }
      }
      
      private function noInterstitialAvailable() : void
      {
         if(events != null)
         {
            events.dispatchEvent(new InterstitialEvent("AE_INTERSTITIAL_NOT_SHOWN"));
         }
      }
      
      public function interstitialCompleteCallback(param1:String) : void
      {
         events.dispatchEvent(new InterstitialEvent("AE_INTERSTITIAL_COMPLETE",param1));
      }
      
      private function adWarningLeftReady(param1:AssetLoaderEvent) : void
      {
         var _loc3_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         var _loc2_:Bitmap = _loc3_.assetLoader.content as Bitmap;
         if(_loc2_ != null)
         {
            var_3302 = emulateBackgroundTransparency(_loc2_.bitmapData);
         }
      }
      
      private function adWarningRightReady(param1:AssetLoaderEvent) : void
      {
         var _loc3_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         var _loc2_:Bitmap = _loc3_.assetLoader.content as Bitmap;
         if(_loc2_ != null)
         {
            var_3577 = emulateBackgroundTransparency(_loc2_.bitmapData);
         }
      }
      
      private function emulateBackgroundTransparency(param1:BitmapData) : BitmapData
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:* = 0;
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:BitmapData = new BitmapData(param1.width,param1.height,true,0);
         _loc4_ = 0;
         while(_loc4_ < _loc2_.height)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc2_.width)
            {
               _loc3_ = param1.getPixel32(_loc5_,_loc4_);
               if(_loc3_ != 4294967295)
               {
                  _loc2_.setPixel32(_loc5_,_loc4_,_loc3_);
               }
               _loc5_++;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function isValidAdImage(param1:Bitmap) : Boolean
      {
         if(param1 != null && param1.bitmapData != null && (param1.width > 1 || param1.height > 1))
         {
            return true;
         }
         return false;
      }
      
      public function loadRoomAdImage(param1:int, param2:int, param3:int, param4:String, param5:String) : void
      {
         var _loc10_:IAsset = null;
         var _loc11_:BitmapData = null;
         if(param4 == null || param4.length == 0)
         {
            return;
         }
         if(assets.hasAsset(param4))
         {
            if((_loc10_ = assets.getAssetByName(param4)) != null)
            {
               if((_loc11_ = _loc10_.content as BitmapData) != null)
               {
                  dispatchImageAsset(_loc11_.clone(),param1,param2,param3,param4,param5);
               }
            }
            return;
         }
         var _loc9_:Array;
         if((_loc9_ = _billboardImageLoaders.getValue(param4)) == null)
         {
            _loc9_ = [];
            _billboardImageLoaders.add(param4,_loc9_);
         }
         if(_loc9_.length > 0)
         {
            for each(var _loc7_ in _loc9_)
            {
               if(_loc7_.roomId == param1 && _loc7_.objectId == param2 && _loc7_.objectCategory == param3)
               {
                  return;
               }
            }
         }
         _loc9_.push(new AdImageRequest(param1,param4,param5,param2,param3));
         var _loc6_:URLRequest = new URLRequest(param4);
         var _loc8_:AssetLoaderStruct;
         (_loc8_ = assets.loadAssetFromFile(param4,_loc6_,"image/png")).addEventListener("AssetLoaderEventComplete",onBillboardImageReady);
         _loc8_.addEventListener("AssetLoaderEventError",onBillboardImageLoadError);
      }
      
      private function onBillboardImageReady(param1:AssetLoaderEvent) : void
      {
         var _loc4_:BitmapData = null;
         var _loc5_:AssetLoaderStruct;
         var _loc2_:Bitmap = (_loc5_ = param1.target as AssetLoaderStruct).assetLoader.content as Bitmap;
         var _loc6_:Array;
         if((_loc6_ = _billboardImageLoaders.remove(_loc5_.assetName)) == null || _loc6_.length == 0)
         {
            return;
         }
         if(isValidAdImage(_loc2_))
         {
            if((_loc4_ = _loc2_.bitmapData) != null)
            {
               for each(var _loc3_ in _loc6_)
               {
                  dispatchImageAsset(_loc4_.clone(),_loc3_.roomId,_loc3_.objectId,_loc3_.objectCategory,_loc3_.imageURL,_loc3_.clickURL);
               }
            }
         }
      }
      
      private function dispatchImageAsset(param1:BitmapData, param2:int, param3:int, param4:int, param5:String, param6:String) : void
      {
         if(events != null)
         {
            events.dispatchEvent(new AdEvent("AE_ROOM_AD_IMAGE_LOADED",param2,param1,param5,param6,null,null,param3,param4));
         }
      }
      
      private function onBillboardImageLoadError(param1:AssetLoaderEvent) : void
      {
         var _loc3_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         var _loc4_:Array;
         if((_loc4_ = _billboardImageLoaders.remove(_loc3_.assetName)) == null || _loc4_.length == 0)
         {
            return;
         }
         for each(var _loc2_ in _loc4_)
         {
            dispatchImageAsset(null,_loc2_.roomId,_loc2_.objectId,_loc2_.objectCategory,_loc2_.imageURL,_loc2_.clickURL);
         }
      }
   }
}
