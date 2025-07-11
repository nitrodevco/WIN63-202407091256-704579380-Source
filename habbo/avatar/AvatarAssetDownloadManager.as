package com.sulake.habbo.avatar
{
    import assets.class_14

    import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.habbo.avatar.events.LibraryLoadedEvent;
   import com.sulake.habbo.avatar.structure.class_3360;
   import com.sulake.habbo.avatar.structure.figure.FigurePart;
   import com.sulake.habbo.avatar.structure.figure.ISetType;
   import com.sulake.habbo.avatar.structure.figure.class_3418;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class AvatarAssetDownloadManager extends EventDispatcherWrapper
   {
      
      public static const LIBRARY_LOADED:String = "LIBRARY_LOADED";
      
      private static const LIB_BODY:String = "hh_human_body";
      
      private static const LIB_ITEMS:String = "hh_human_item";
      
      private static const LIB_AVATAR_EDITOR:String = "hh_avatar_editor";
       
      
      private var var_480:class_1808;
      
      private var var_2051:Dictionary;
      
      private var var_3179:Dictionary;
      
      private var _assets:IAssetLibrary;
      
      private var var_2889:Dictionary;
      
      private var _listeners:Dictionary;
      
      private var var_1671:AvatarStructure;
      
      private var var_4273:String;
      
      private var var_3228:String;
      
      private var var_3996:Boolean;
      
      private var var_3453:int = 3;
      
      private var var_2132:AssetLoaderStruct;
      
      private var _downloadShiftTimer:Timer;
      
      private var var_2311:Array;
      
      private var var_2855:Array;
      
      private var var_2765:Array;
      
      private const DOWNLOAD_TIMEOUT:int = 100;
      
      private const MAX_SIMULTANEOUS_DOWNLOADS:int = 4;
      
      private var var_4343:String;
      
      private var var_3008:Array;
      
      public function AvatarAssetDownloadManager(param1:class_1808, param2:IAssetLibrary, param3:String, param4:String, param5:AvatarStructure, param6:String)
      {
         var _loc10_:XmlAsset = null;
         var _loc8_:XML = null;
         var_3008 = ["hh_human_body","hh_human_item"];
         super();
         var_480 = param1;
         var_2051 = new Dictionary();
         var_3179 = new Dictionary();
         _assets = param2;
         var_1671 = param5;
         var_2889 = new Dictionary();
         var_4273 = param4;
         var_3228 = param3;
         var_4343 = param6;
         _listeners = new Dictionary();
         var_2311 = [];
         var_2855 = [];
         var_2765 = [];
         var_1671.renderManager.events.addEventListener("AVATAR_RENDER_READY",purgeInitDownloadBuffer);
         var _loc7_:URLRequest = new URLRequest(param3);
         var _loc9_:IAsset;
         if((_loc9_ = _assets.getAssetByName("figuremap")) == null)
         {
            var_2132 = _assets.loadAssetFromFile("figuremap",_loc7_,"text/xml");
            addMapLoaderEventListeners();
         }
         else
         {
            _loc8_ = ((_loc10_ = _assets.getAssetByName("figuremap") as XmlAsset).content as XML).copy();
            loadFigureMapData(_loc8_);
         }
         _downloadShiftTimer = new Timer(100,1);
         _downloadShiftTimer.addEventListener("timerComplete",onNextDownloadTimeout);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_3179 = null;
         _assets = null;
         var_2889 = null;
         _listeners = null;
         if(var_1671.renderManager)
         {
            var_1671.renderManager.events.removeEventListener("AVATAR_RENDER_READY",purgeInitDownloadBuffer);
         }
         var_1671 = null;
         var_2855 = null;
         var_2311 = null;
         if(_downloadShiftTimer)
         {
            _downloadShiftTimer.stop();
            _downloadShiftTimer = null;
         }
         if(var_2132)
         {
            removeMapLoaderEventListeners();
            var_2132 = null;
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
            HabboWebTools.logEventLog("Figuremap download error " + var_3228);
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
            var_2132 = _assets.loadAssetFromFile("figuremap",_loc3_,"text/xml");
            addMapLoaderEventListeners();
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
         loadFigureMapData(_loc2_);
      }
      
      private function loadFigureMapData(param1:XML) : void
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
      
      public function loadMandatoryLibs() : void
      {
         var _loc2_:AvatarAssetDownloadLibrary = null;
         var _loc1_:Array = var_3008.slice();
         for each(var _loc3_ in _loc1_)
         {
            _loc2_ = var_2051[_loc3_];
            if(_loc2_)
            {
               _loc2_.isMandatory = true;
               addToQueue(_loc2_);
            }
            else
            {
               class_14.log("Missing mandatory library: " + _loc3_);
            }
         }
         _downloadShiftTimer.start();
      }
      
      private function purgeInitDownloadBuffer(param1:Event) : void
      {
         var _loc2_:* = null;
         for each(_loc2_ in var_2311)
         {
            loadFigureSetData(_loc2_[0],_loc2_[1]);
         }
         var_2311 = [];
      }
      
      private function generateMap(param1:XML) : void
      {
         var _loc2_:AvatarAssetDownloadLibrary = null;
         var _loc3_:String = null;
         var _loc6_:Array = null;
         for each(var _loc5_ in param1.lib)
         {
            _loc2_ = new AvatarAssetDownloadLibrary(_loc5_.@id,_loc5_.@revision,var_4273,_assets,var_4343);
            _loc2_.addEventListener("complete",libraryComplete);
            var_2051[_loc2_.libraryName] = _loc2_;
            for each(var _loc4_ in _loc5_.part)
            {
               _loc3_ = _loc4_.@type + ":" + _loc4_.@id;
               if((_loc6_ = var_3179[_loc3_]) == null)
               {
                  _loc6_ = [];
               }
               _loc6_.push(_loc2_);
               var_3179[_loc3_] = _loc6_;
            }
         }
      }
      
      public function isReady(param1:class_3405) : Boolean
      {
         if(!var_3996 || !var_1671.renderManager.isReady)
         {
            return false;
         }
         var _loc2_:Array = getLibsToDownload(param1);
         return _loc2_.length == 0;
      }
      
      public function loadFigureSetData(param1:class_3405, param2:IAvatarImageListener) : void
      {
         var _loc5_:Array = null;
         if(!var_3996 || !var_1671.renderManager.isReady)
         {
            var_2311.push([param1,param2]);
            return;
         }
         var _loc6_:String = param1.getFigureString();
         var _loc4_:Array;
         if((_loc4_ = getLibsToDownload(param1)).length > 0)
         {
            if(param2 && !param2.disposed)
            {
               if((_loc5_ = _listeners[_loc6_]) == null)
               {
                  _loc5_ = [];
               }
               _loc5_.push(param2);
               _listeners[_loc6_] = _loc5_;
            }
            var_2889[_loc6_] = _loc4_;
            for each(var _loc3_ in _loc4_)
            {
               addToQueue(_loc3_);
            }
            _downloadShiftTimer.start();
         }
         else if(param2 != null && !param2.disposed)
         {
            param2.avatarImageReady(_loc6_);
         }
      }
      
      private function libraryComplete(param1:Event) : void
      {
         var _loc10_:String = null;
         var _loc4_:Array = null;
         var _loc12_:Boolean = false;
         var _loc5_:Array = null;
         var _loc8_:AvatarAssetDownloadLibrary = null;
         var _loc9_:int = 0;
         if(disposed)
         {
            return;
         }
         var _loc11_:Array = [];
         for(_loc10_ in var_2889)
         {
            _loc12_ = true;
            _loc4_ = var_2889[_loc10_];
            for each(var _loc3_ in _loc4_)
            {
               if(!_loc3_.isReady)
               {
                  _loc12_ = false;
                  break;
               }
            }
            if(_loc12_)
            {
               _loc11_.push(_loc10_);
               _loc5_ = _listeners[_loc10_];
               for each(var _loc7_ in _loc5_)
               {
                  if(_loc7_ != null && !_loc7_.disposed)
                  {
                     _loc7_.avatarImageReady(_loc10_);
                  }
               }
               delete _listeners[_loc10_];
            }
         }
         for each(_loc10_ in _loc11_)
         {
            delete var_2889[_loc10_];
         }
         var _loc6_:String = (param1.target as AvatarAssetDownloadLibrary).libraryName;
         var _loc2_:int = var_3008.indexOf(_loc6_);
         if(_loc2_ != -1)
         {
            var_3008.splice(_loc2_,1);
            if(var_3008.length == 0)
            {
               var_480.onMandatoryLibrariesReady();
            }
         }
         _loc9_ = 0;
         while(_loc9_ < var_2765.length)
         {
            if((_loc8_ = var_2765[_loc9_]).libraryName == _loc6_)
            {
               var_2765.splice(_loc9_,1);
            }
            _loc9_++;
         }
         if(_loc11_.length > 0)
         {
            dispatchEvent(new LibraryLoadedEvent("LIBRARY_LOADED",_loc6_));
         }
         _downloadShiftTimer.start();
      }
      
      public function isMissingMandatoryLibs() : Boolean
      {
         return var_3008.length > 0;
      }
      
      private function getLibsToDownload(param1:class_3405) : Array
      {
         var _loc12_:ISetType = null;
         var _loc7_:int = 0;
         var _loc5_:class_3418 = null;
         var _loc11_:String = null;
         var _loc4_:Array = null;
         var _loc8_:Array = [];
         if(!var_1671)
         {
            return _loc8_;
         }
         if(!param1)
         {
            return _loc8_;
         }
         var _loc2_:class_3360 = var_1671.figureData;
         if(!_loc2_)
         {
            return _loc8_;
         }
         var _loc10_:Array = param1.getPartTypeIds();
         for each(var _loc6_ in _loc10_)
         {
            if(_loc12_ = _loc2_.getSetType(_loc6_))
            {
               _loc7_ = param1.getPartSetId(_loc6_);
               if(_loc5_ = _loc12_.getPartSet(_loc7_))
               {
                  for each(var _loc9_ in _loc5_.parts)
                  {
                     _loc11_ = _loc9_.type + ":" + _loc9_.id;
                     if((_loc4_ = var_3179[_loc11_]) != null)
                     {
                        for each(var _loc3_ in _loc4_)
                        {
                           if(_loc3_ != null)
                           {
                              if(!_loc3_.isReady)
                              {
                                 if(_loc8_.indexOf(_loc3_) == -1)
                                 {
                                    _loc8_.push(_loc3_);
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         return _loc8_;
      }
      
      private function processPending() : void
      {
         var _loc1_:AvatarAssetDownloadLibrary = null;
         while(var_2855.length > 0 && var_2765.length < 4)
         {
            _loc1_ = var_2855.shift();
            var_2765.push(_loc1_);
            _loc1_.startDownloading();
         }
      }
      
      private function addToQueue(param1:AvatarAssetDownloadLibrary) : void
      {
         if(!param1.isReady && var_2855.indexOf(param1) == -1 && var_2765.indexOf(param1) == -1)
         {
            var_2855.push(param1);
         }
      }
      
      private function onNextDownloadTimeout(param1:Event = null) : void
      {
         processPending();
      }
      
      public function purge() : void
      {
         for each(var _loc1_ in var_2051)
         {
            if(_loc1_.isReady && !_loc1_.isMandatory)
            {
               _loc1_.purge();
            }
         }
      }
   }
}
