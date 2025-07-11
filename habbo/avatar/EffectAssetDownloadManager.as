package com.sulake.habbo.avatar
{
    import assets.class_14

    import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.habbo.avatar.events.LibraryLoadedEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class EffectAssetDownloadManager extends EventDispatcherWrapper
   {
      
      public static const LIBRARY_LOADED:String = "LIBRARY_LOADED";
       
      
      private var var_3008:Array;
      
      private var var_3019:Dictionary;
      
      private var var_3453:int = 3;
      
      private var var_2132:AssetLoaderStruct;
      
      private var _assets:IAssetLibrary;
      
      private var var_3996:Boolean;
      
      private var var_3228:String;
      
      private var var_4273:String;
      
      private var var_4343:String;
      
      private var var_1671:AvatarStructure;
      
      private var _listeners:Dictionary;
      
      private var var_3517:Dictionary;
      
      private var _downloadShiftTimer:Timer;
      
      private var var_2311:Array;
      
      private var var_2855:Array;
      
      private var var_2765:Array;
      
      private const DOWNLOAD_TIMEOUT:int = 100;
      
      private const MAX_SIMULTANEOUS_DOWNLOADS:int = 2;
      
      public function EffectAssetDownloadManager(param1:IAssetLibrary, param2:String, param3:String, param4:AvatarStructure, param5:String)
      {
         var _loc9_:XmlAsset = null;
         var _loc7_:XML = null;
         var_3008 = ["dance.1","dance.2","dance.3","dance.4"];
         super();
         var_3019 = new Dictionary();
         _assets = param1;
         var_1671 = param4;
         var_3228 = param2;
         var_4273 = param3;
         var_4343 = param5;
         _listeners = new Dictionary();
         var_3517 = new Dictionary();
         var_2311 = [];
         var_2855 = [];
         var_2765 = [];
         var _loc6_:URLRequest = new URLRequest(var_3228);
         var _loc8_:IAsset;
         if((_loc8_ = _assets.getAssetByName("effectmap")) == null)
         {
            var_2132 = _assets.loadAssetFromFile("effectmap",_loc6_,"text/xml");
            addMapLoaderEventListeners();
         }
         else
         {
            _loc7_ = ((_loc9_ = _assets.getAssetByName("effectmap") as XmlAsset).content as XML).copy();
            loadEffectMapData(_loc7_);
         }
         _downloadShiftTimer = new Timer(100,1);
         _downloadShiftTimer.addEventListener("timerComplete",onNextDownloadTimeout);
         var_1671.renderManager.events.addEventListener("AVATAR_RENDER_READY",purgeInitDownloadBuffer);
      }
      
      public function loadMandatoryLibs() : void
      {
         var _loc4_:Array = null;
         var _loc1_:Array = var_3008.slice();
         for each(var _loc3_ in _loc1_)
         {
            if((_loc4_ = var_3019[_loc3_]) != null)
            {
               for each(var _loc2_ in _loc4_)
               {
                  addToQueue(_loc2_);
               }
            }
         }
      }
      
      private function addMapLoaderEventListeners() : void
      {
         if(var_2132)
         {
            var_2132.addEventListener("AssetLoaderEventComplete",onConfigurationComplete);
            var_2132.addEventListener("AssetLoaderEventError",onConfigurationError);
         }
      }
      
      private function removeMapLoaderEventListeners() : void
      {
         if(var_2132)
         {
            var_2132.removeEventListener("AssetLoaderEventComplete",onConfigurationComplete);
            var_2132.removeEventListener("AssetLoaderEventError",onConfigurationError);
         }
      }
      
      private function onConfigurationComplete(param1:Event) : void
      {
         var _loc2_:XML = null;
         if(disposed)
         {
            return;
         }
         var _loc3_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc3_ == null)
         {
            return;
         }
         try
         {
            _loc2_ = new XML(_loc3_.assetLoader.content as String);
         }
         catch(e:Error)
         {
            return;
         }
         loadEffectMapData(_loc2_);
      }
      
      private function onConfigurationError(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:URLRequest = null;
         if(disposed)
         {
            return;
         }
         var_3453--;
         if(var_3453 <= 0)
         {
            HabboWebTools.logEventLog("Effect download error " + var_3228);
         }
         else
         {
            if(var_3228.indexOf("?") > 0)
            {
               _loc2_ = var_3228 + "&retry=" + var_3453;
            }
            else
            {
               _loc2_ = var_3228 + "?retry=" + var_3453;
            }
            removeMapLoaderEventListeners();
            _loc3_ = new URLRequest(_loc2_);
            var_2132 = _assets.loadAssetFromFile("effectmap",_loc3_,"text/xml");
            addMapLoaderEventListeners();
         }
      }
      
      private function loadEffectMapData(param1:XML) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.toString() == "")
         {
            return;
         }
         generateMap(param1);
         loadMandatoryLibs();
         var_3996 = true;
         dispatchEvent(new Event("complete"));
      }
      
      private function generateMap(param1:XML) : void
      {
         var _loc2_:EffectAssetDownloadLibrary = null;
         var _loc3_:String = null;
         var _loc5_:Array = null;
         for each(var _loc4_ in param1.effect)
         {
            _loc2_ = new EffectAssetDownloadLibrary(_loc4_.@lib,"0",var_4273,_assets,var_4343);
            _loc2_.addEventListener("complete",libraryComplete);
            _loc3_ = _loc4_.@id;
            if((_loc5_ = var_3019[_loc3_]) == null)
            {
               _loc5_ = [];
            }
            _loc5_.push(_loc2_);
            var_3019[_loc3_] = _loc5_;
         }
      }
      
      private function libraryComplete(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc11_:Array = null;
         var _loc10_:Boolean = false;
         var _loc5_:Array = null;
         var _loc7_:EffectAssetDownloadLibrary = null;
         var _loc8_:int = 0;
         if(disposed)
         {
            return;
         }
         var _loc4_:Array = [];
         var _loc9_:EffectAssetDownloadLibrary = param1.target as EffectAssetDownloadLibrary;
         var_1671.registerAnimation(_loc9_.animation);
         for(_loc2_ in var_3517)
         {
            _loc10_ = true;
            _loc11_ = var_3517[_loc2_];
            for each(var _loc3_ in _loc11_)
            {
               if(!_loc3_.isReady)
               {
                  _loc10_ = false;
                  break;
               }
            }
            if(_loc10_)
            {
               _loc4_.push(_loc2_);
               _loc5_ = _listeners[_loc2_];
               for each(var _loc6_ in _loc5_)
               {
                  if(_loc6_ != null && !_loc6_.disposed)
                  {
                     _loc6_.avatarEffectReady(parseInt(_loc2_));
                  }
               }
               delete _listeners[_loc2_];
            }
         }
         for each(_loc2_ in _loc4_)
         {
            delete var_3517[_loc2_];
         }
         while(_loc8_ < var_2765.length)
         {
            if((_loc7_ = var_2765[_loc8_]).name == _loc9_.name)
            {
               var_2765.splice(_loc8_,1);
            }
            _loc8_++;
         }
         if(_loc4_.length > 0)
         {
            dispatchEvent(new LibraryLoadedEvent("LIBRARY_LOADED",_loc9_.name));
         }
         _downloadShiftTimer.start();
      }
      
      public function isReady(param1:int) : Boolean
      {
         if(!var_3996 || !var_1671.renderManager.isReady)
         {
            return false;
         }
         var _loc2_:Array = getLibsToDownload(param1);
         return _loc2_.length == 0;
      }
      
      public function loadEffectData(param1:int, param2:class_3375) : void
      {
         var _loc5_:Array = null;
         if(!var_3996 || !var_1671.renderManager.isReady)
         {
            var_2311.push([param1,param2]);
            return;
         }
         var _loc4_:Array;
         if((_loc4_ = getLibsToDownload(param1)).length > 0)
         {
            if(param2 && !param2.disposed)
            {
               if((_loc5_ = _listeners[String(param1)]) == null)
               {
                  _loc5_ = [];
               }
               _loc5_.push(param2);
               _listeners[String(param1)] = _loc5_;
            }
            var_3517[String(param1)] = _loc4_;
            for each(var _loc3_ in _loc4_)
            {
               addToQueue(_loc3_);
            }
         }
         else if(param2 != null && !param2.disposed)
         {
            param2.avatarEffectReady(param1);
            class_14.log("Effect ready to use: " + param1);
         }
      }
      
      private function getLibsToDownload(param1:int) : Array
      {
         var _loc3_:Array = [];
         if(!var_1671)
         {
            return _loc3_;
         }
         var _loc4_:Array;
         if((_loc4_ = var_3019[String(param1)]) != null)
         {
            for each(var _loc2_ in _loc4_)
            {
               if(_loc2_ != null)
               {
                  if(!_loc2_.isReady)
                  {
                     if(_loc3_.indexOf(_loc2_) == -1)
                     {
                        _loc3_.push(_loc2_);
                     }
                  }
               }
            }
         }
         return _loc3_;
      }
      
      private function processPending() : void
      {
         var _loc1_:EffectAssetDownloadLibrary = null;
         while(var_2855.length > 0 && var_2765.length < 2)
         {
            _loc1_ = var_2855.shift();
            _loc1_.startDownloading();
            var_2765.push(_loc1_);
         }
      }
      
      private function addToQueue(param1:EffectAssetDownloadLibrary) : void
      {
         if(!param1.isReady && var_2855.indexOf(param1) == -1 && var_2765.indexOf(param1) == -1)
         {
            var_2855.push(param1);
            processPending();
         }
      }
      
      private function onNextDownloadTimeout(param1:Event = null) : void
      {
         processPending();
      }
      
      private function purgeInitDownloadBuffer(param1:Event) : void
      {
         var _loc2_:* = null;
         for each(_loc2_ in var_2311)
         {
            loadEffectData(_loc2_[0],_loc2_[1]);
         }
         var_2311 = [];
      }
      
      public function get map() : Dictionary
      {
         return var_3019;
      }
   }
}
