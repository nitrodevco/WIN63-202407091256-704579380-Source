package com.sulake.habbo.avatar
{
   import com.sulake.core.assets.AssetLibraryCollection;
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.alias.AssetAliasCollection;
   import com.sulake.habbo.avatar.animation.class_3372;
   import com.sulake.habbo.avatar.events.LibraryLoadedEvent;
   import com.sulake.habbo.avatar.structure.AvatarStructureDownload;
   import com.sulake.habbo.avatar.structure.IStructureData;
   import com.sulake.habbo.avatar.structure.class_3360;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import com.sulake.habbo.avatar.structure.figure.ISetType;
   import com.sulake.habbo.avatar.structure.figure.class_3418;
   import com.sulake.habbo.avatar.structure.figure.class_3445;
   import com.sulake.habbo.utils.FigureDataContainer;
   import com.sulake.iid.*;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   
   [SecureSWF(rename="true")]
   public class class_1808 extends Component implements IAvatarRenderManager
   {
       
      
      private const AVATAR_PLACEHOLDER_FIGURE:String = "hd-99999-99999";
      
      private var var_2140:AssetAliasCollection;
      
      private var var_1671:AvatarStructure;
      
      private var var_1263:String;
      
      private var _petImageListeners:Map;
      
      private var var_1815:AvatarAssetDownloadManager;
      
      private var var_2144:EffectAssetDownloadManager;
      
      private var var_4095:AvatarFigureContainer;
      
      private var var_4762:Boolean = false;
      
      private var var_4393:Boolean = false;
      
      private var var_109:Boolean = false;
      
      private var _inNuxFlow:Boolean;
      
      private var var_4683:Boolean;
      
      private var var_4069:Boolean;
      
      private var var_2311:Array;
      
      public function class_1808(param1:IContext, param2:uint, param3:IAssetLibrary, param4:Boolean = false)
      {
         var_2311 = [];
         _inNuxFlow = param4;
         param2 |= 4;
         super(param1,param2,param3);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return _inNuxFlow ? super.dependencies : super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboConfigurationManager(),null,true,[{
            "type":"complete",
            "callback":onConfigurationComplete
         }])]);
      }
      
      override protected function initComponent() : void
      {
         var_1263 = "component";
         _petImageListeners = new Map();
         var _loc1_:XML = <actions><action  id="Default" precedence="1000" state="std" main="1" isdefault="1" geometrytype="vertical" activepartset="figure" assetpartdefinition="std"/>	<!-- baked in actions for snowwar -->
				<action  id="SnowWarRun" state="swrun" precedence="104" main="1" geometrytype="vertical" activepartset="snowwarrun" assetpartdefinition="swrun" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.136,fx.137,fx.138,fx.139,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx174,fx175,fx176,dance"/>
				<action  id="SnowWarDieFront" state="swdiefront" precedence="105" main="1" geometrytype="swhorizontal" activepartset="snowwardiefront" assetpartdefinition="swdie" startfromframezero="true" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.105,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.136,fx.137,fx.138,fx.139,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx174,fx175,fx176,dance"/>
				<action  id="SnowWarDieBack" state="swdieback" precedence="106" main="1" geometrytype="swhorizontal" activepartset="snowwardieback" assetpartdefinition="swdie" startfromframezero="true" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.105,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx174,fx175,fx176,dance"/>
				<action  id="SnowWarPick" state="swpick" precedence="107" main="1" geometrytype="vertical" activepartset="snowwarpick" assetpartdefinition="swpick" startfromframezero="true" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.105,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.136,fx.137,fx.138,fx.139,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx174,fx175,fx176,dance"/>
				<action  id="SnowWarThrow" state="swthrow" precedence="108" main="1" geometrytype="vertical" activepartset="snowwarthrow" assetpartdefinition="swthrow" startfromframezero="true" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.105,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.136,fx.137,fx.138,fx.139,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx.174,fx175,fx176,dance"/>
			</actions>;
         var_1671 = new AvatarStructure(this);
         var_1671.initGeometry(!!assets.hasAsset("HabboAvatarGeometry") ? assets.getAssetByName("HabboAvatarGeometry").content as XML : null);
         var_1671.initPartSets(!!assets.hasAsset("HabboAvatarPartSets") ? assets.getAssetByName("HabboAvatarPartSets").content as XML : null);
         var_1671.initActions(assets,_loc1_);
         var_1671.initAnimation(!!assets.hasAsset("HabboAvatarAnimation") ? assets.getAssetByName("HabboAvatarAnimation").content as XML : null);
         var_1671.initFigureData(!!assets.hasAsset("HabboAvatarFigure") ? assets.getAssetByName("HabboAvatarFigure").content as XML : null);
         var_2140 = new AssetAliasCollection(this,context.assets as AssetLibraryCollection);
         var_2140.init();
         checkIfReady();
      }
      
      private function requestActions() : void
      {
         var _loc3_:String = getProperty("flash.dynamic.avatar.download.url") + "HabboAvatarActions.xml";
         var _loc1_:URLRequest = new URLRequest(_loc3_);
         var _loc2_:AssetLoaderStruct = assets.loadAssetFromFile("HabboAvatarActions",_loc1_,"text/xml");
         _loc2_.addEventListener("AssetLoaderEventComplete",onAvatarActionsLoaded);
      }
      
      private function onAvatarActionsLoaded(param1:Event = null) : void
      {
         if(var_1671 == null)
         {
            return;
         }
         var _loc2_:XML = <actions><action  id="Default" precedence="1000" state="std" main="1" isdefault="1" geometrytype="vertical" activepartset="figure" assetpartdefinition="std"/>	<!-- baked in actions for snowwar -->
				<action  id="SnowWarRun" state="swrun" precedence="104" main="1" geometrytype="vertical" activepartset="snowwarrun" assetpartdefinition="swrun" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.136,fx.137,fx.138,fx.139,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx174,fx175,fx176,dance"/>
				<action  id="SnowWarDieFront" state="swdiefront" precedence="105" main="1" geometrytype="swhorizontal" activepartset="snowwardiefront" assetpartdefinition="swdie" startfromframezero="true" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.105,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.136,fx.137,fx.138,fx.139,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx174,fx175,fx176,dance"/>
				<action  id="SnowWarDieBack" state="swdieback" precedence="106" main="1" geometrytype="swhorizontal" activepartset="snowwardieback" assetpartdefinition="swdie" startfromframezero="true" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.105,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx174,fx175,fx176,dance"/>
				<action  id="SnowWarPick" state="swpick" precedence="107" main="1" geometrytype="vertical" activepartset="snowwarpick" assetpartdefinition="swpick" startfromframezero="true" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.105,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.136,fx.137,fx.138,fx.139,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx174,fx175,fx176,dance"/>
				<action  id="SnowWarThrow" state="swthrow" precedence="108" main="1" geometrytype="vertical" activepartset="snowwarthrow" assetpartdefinition="swthrow" startfromframezero="true" prevents="fx.2,fx.3,fx.6,fx.14,fx.15,fx.17,fx.18,fx.19,fx.20,fx.21,fx.22,fx.33,fx.34,fx.35,fx.36,fx.38,fx.39,fx.45,fx.46,fx.48,fx.54,fx.55,fx.56,fx.57,fx.58,fx.69,fx.71,fx.72,fx.89,fx.90,fx.91,fx.92,fx.94,fx.97,fx.100,fx.104,fx.105,fx.107,fx.108,fx.115,fx.116,fx.117,fx.118,fx.119,fx.120,fx.121,fx.122,fx.123,fx.124,fx.125,fx.127,fx.129,fx.130,fx.131,fx.132,fx.134,fx.135,fx.136,fx.137,fx.138,fx.139,fx.140,fx.141,fx.142,fx.143,fx.144,fx.145,fx.146,fx.147,fx.148,fx.149,fx.150,fx.151,fx.152,fx.153,fx.154,fx.155,fx.156,fx.157,fx.158,fx.159,fx.160,fx.161,fx.162,fx.164,fx.165,fx.166,fx167,fx168,fx169,fx170,fx171,fx172,fx173,fx.174,fx175,fx176,dance"/>
			</actions>;
         var_1671.updateActions(!!assets.hasAsset("HabboAvatarActions") ? assets.getAssetByName("HabboAvatarActions").content as XML : _loc2_);
         var_4683 = true;
         checkIfReady();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(var_1671 != null)
         {
            var_1671.dispose();
            var_1671 = null;
         }
         if(var_2140 != null)
         {
            var_2140.dispose();
            var_2140 = null;
         }
         if(_petImageListeners)
         {
            _petImageListeners.dispose();
            _petImageListeners = null;
         }
         if(var_1815)
         {
            var_1815.removeEventListener("complete",onAvatarAssetsDownloadManagerReady);
            var_1815.dispose();
            var_1815 = null;
         }
         if(var_2144)
         {
            var_2144.removeEventListener("complete",onAvatarAssetsDownloadManagerReady);
            var_2144.dispose();
            var_2144 = null;
         }
         var_2311 = null;
      }
      
      private function onConfigurationComplete(param1:Event) : void
      {
         var _loc5_:String = null;
         var _loc7_:String = null;
         var _loc6_:String = null;
         var _loc2_:String = null;
         var _loc4_:String = null;
         var _loc3_:AvatarStructureDownload = null;
         requestActions();
         if(var_1671 != null)
         {
            _loc4_ = getProperty("external.figurepartlist.txt");
            if(assets.hasAsset(_loc4_))
            {
               assets.removeAsset(assets.getAssetByName(_loc4_));
            }
            _loc3_ = new AvatarStructureDownload(assets,_loc4_,var_1671.figureData as IStructureData);
            _loc3_.addEventListener("AVATAR_STRUCTURE_DONE",onFigureDataDownloadDone);
            if(var_1815 == null)
            {
               _loc2_ = getProperty("flash.dynamic.avatar.download.configuration");
               _loc6_ = getProperty("flash.dynamic.avatar.download.url");
               _loc7_ = getProperty("flash.dynamic.avatar.download.name.template");
               var_1815 = new AvatarAssetDownloadManager(this,context.assets,_loc2_,_loc6_,var_1671,_loc7_);
               var_1815.addEventListener("complete",onAvatarAssetsDownloadManagerReady);
               var_1815.addEventListener("LIBRARY_LOADED",onAvatarAssetsLibraryReady);
            }
            if(var_2144 == null)
            {
               _loc5_ = getProperty("flash.dynamic.avatar.download.url") + "effectmap.xml";
               _loc6_ = getProperty("flash.dynamic.avatar.download.url");
               _loc7_ = getProperty("flash.dynamic.avatar.download.name.template");
               var_2144 = new EffectAssetDownloadManager(context.assets,_loc5_,_loc6_,var_1671,_loc7_);
               var_2144.addEventListener("complete",onEffectAssetsDownloadManagerReady);
               var_2144.addEventListener("LIBRARY_LOADED",onEffectAssetsLibraryReady);
            }
         }
      }
      
      public function onMandatoryLibrariesReady() : void
      {
         checkIfReady();
      }
      
      private function onAvatarAssetsLibraryReady(param1:LibraryLoadedEvent) : void
      {
         var_2140.onAvatarAssetsLibraryReady(param1.library);
      }
      
      private function onEffectAssetsLibraryReady(param1:LibraryLoadedEvent) : void
      {
         var_2140.onAvatarAssetsLibraryReady(param1.library);
      }
      
      private function onFigureDataDownloadDone(param1:Event = null) : void
      {
         var _loc2_:IAsset = assets.getAssetByName(getProperty("external.figurepartlist.txt"));
         if(_loc2_)
         {
            assets.removeAsset(_loc2_).dispose();
         }
         var_4393 = true;
         var_1671.init();
         checkIfReady();
      }
      
      private function onAvatarAssetsDownloadManagerReady(param1:Event = null) : void
      {
         var_4762 = true;
         checkIfReady();
      }
      
      private function onEffectAssetsDownloadManagerReady(param1:Event = null) : void
      {
         var_4069 = true;
         checkIfReady();
      }
      
      public function get effectMap() : Dictionary
      {
         if(var_4069)
         {
            return var_2144.map;
         }
         return null;
      }
      
      private function checkIfReady() : void
      {
         if(!var_109)
         {
            if(var_4762 && var_4393 && var_4683 && var_4069)
            {
               var_109 = true;
               this.events.dispatchEvent(new Event("AVATAR_RENDER_READY"));
               purgeInitDownloadBuffer();
            }
         }
      }
      
      private function purgeInitDownloadBuffer() : void
      {
         var _loc1_:IAvatarImageListener = null;
         if(var_2311)
         {
            for each(var _loc2_ in var_2311)
            {
               _loc1_ = _loc2_[1];
               if(_loc1_ != null && !_loc1_.disposed)
               {
                  var_1815.loadFigureSetData(_loc2_[0] as class_3405,_loc1_);
               }
            }
            var_2311 = [];
         }
      }
      
      public function createFigureContainer(param1:String) : class_3405
      {
         return new AvatarFigureContainer(param1);
      }
      
      public function isFigureReady(param1:class_3405) : Boolean
      {
         if(!var_1815)
         {
            return false;
         }
         return var_1815.isReady(param1);
      }
      
      public function downloadFigure(param1:class_3405, param2:IAvatarImageListener) : void
      {
         if(!var_1815)
         {
            var_2311.push([param1,param2]);
            return;
         }
         var_1815.loadFigureSetData(param1,param2);
      }
      
      public function createAvatarImage(param1:String, param2:String, param3:String = null, param4:IAvatarImageListener = null, param5:class_3375 = null) : class_3374
      {
         var _loc6_:PlaceholderAvatarImage = null;
         var _loc7_:AvatarFigureContainer = new AvatarFigureContainer(param1);
         if(var_1671 == null)
         {
            var_2311.push([_loc7_,param4]);
            return null;
         }
         if(!var_1815 && var_1263 != "local_only")
         {
            var_2311.push([_loc7_,param4]);
            return null;
         }
         if(param3)
         {
            validateAvatarFigure(_loc7_,param3);
         }
         if(var_1263 == "local_only" || var_1815.isReady(_loc7_))
         {
            return new AvatarImage(var_1671,var_2140,_loc7_,param2,var_2144,param5);
         }
         if(!var_4095)
         {
            var_4095 = new AvatarFigureContainer("hd-99999-99999");
         }
         _loc6_ = new PlaceholderAvatarImage(var_1671,var_2140,var_4095,param2,var_2144);
         var_1815.loadFigureSetData(_loc7_,param4);
         return _loc6_;
      }
      
      public function getFigureData() : class_3360
      {
         if(var_1671)
         {
            return var_1671.figureData;
         }
         return null;
      }
      
      public function isValidFigureSetForGender(param1:int, param2:String) : Boolean
      {
         var _loc3_:class_3360 = getFigureData();
         var _loc4_:class_3418;
         if((_loc4_ = _loc3_.getFigurePartSet(param1)) != null)
         {
            if(_loc4_.gender.toUpperCase() == "U" || _loc4_.gender.toUpperCase() == param2.toUpperCase())
            {
               return true;
            }
         }
         return false;
      }
      
      public function getFigureStringWithFigureIds(param1:String, param2:String, param3:Vector.<int>) : String
      {
         var _loc6_:FigureDataContainer;
         (_loc6_ = new FigureDataContainer()).loadAvatarData(param1,param2);
         var _loc4_:Vector.<class_3418> = resolveFigureSets(param3);
         for each(var _loc5_ in _loc4_)
         {
            _loc6_.savePartData(_loc5_.type,_loc5_.id,_loc6_.getColourIds(_loc5_.type));
         }
         return _loc6_.getFigureString();
      }
      
      private function resolveFigureSets(param1:Vector.<int>) : Vector.<class_3418>
      {
         var _loc4_:class_3418 = null;
         var _loc2_:class_3360 = getFigureData();
         var _loc3_:Vector.<class_3418> = new Vector.<class_3418>(0);
         for each(var _loc5_ in param1)
         {
            if((_loc4_ = _loc2_.getFigurePartSet(_loc5_)) != null)
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
      
      public function getItemIds() : Array
      {
         return var_1671.getItemIds();
      }
      
      public function getAnimationManager() : class_3372
      {
         if(var_1671)
         {
            return var_1671.animationManager;
         }
         return null;
      }
      
      public function getMandatoryAvatarPartSetIds(param1:String, param2:int) : Array
      {
         if(var_1671)
         {
            return var_1671.getMandatorySetTypeIds(param1,param2);
         }
         return null;
      }
      
      public function getAssetByName(param1:String) : IAsset
      {
         return var_2140.getAssetByName(param1);
      }
      
      public function get mode() : String
      {
         return var_1263;
      }
      
      public function set mode(param1:String) : void
      {
         var_1263 = param1;
      }
      
      public function injectFigureData(param1:XML) : void
      {
         if(var_1671 != null)
         {
            var_1671.injectFigureData(param1);
         }
      }
      
      private function validateAvatarFigure(param1:AvatarFigureContainer, param2:String) : Boolean
      {
         var _loc5_:Boolean = false;
         var _loc3_:class_3360 = null;
         var _loc7_:class_3418 = null;
         var _loc11_:ISetType = null;
         var _loc4_:class_3418 = null;
         var _loc9_:class_3418 = null;
         if(!var_1671)
         {
            ErrorReportStorage.addDebugData("AvatarRenderManager","validateAvatarFigure: structure is null!");
         }
         var _loc10_:int = 2;
         var _loc6_:Array;
         if(_loc6_ = var_1671.getMandatorySetTypeIds(param2,_loc10_))
         {
            _loc3_ = var_1671.figureData;
            if(!_loc3_)
            {
               ErrorReportStorage.addDebugData("AvatarRenderManager","validateAvatarFigure: figureData is null!");
            }
            for each(var _loc8_ in _loc6_)
            {
               if(!param1.hasPartType(_loc8_))
               {
                  if(_loc7_ = var_1671.getDefaultPartSet(_loc8_,param2))
                  {
                     param1.updatePart(_loc8_,_loc7_.id,[0]);
                     _loc5_ = true;
                  }
               }
               else
               {
                  if(!(_loc11_ = _loc3_.getSetType(_loc8_)))
                  {
                     ErrorReportStorage.addDebugData("AvatarRenderManager","validateAvatarFigure: setType is null!");
                  }
                  if(!(_loc4_ = _loc11_.getPartSet(param1.getPartSetId(_loc8_))))
                  {
                     if(_loc9_ = var_1671.getDefaultPartSet(_loc8_,param2))
                     {
                        param1.updatePart(_loc8_,_loc9_.id,[0]);
                        _loc5_ = true;
                     }
                  }
               }
            }
         }
         return !_loc5_;
      }
      
      public function resolveClubLevel(param1:class_3405, param2:String, param3:Array = null) : int
      {
         var _loc15_:* = null;
         var _loc9_:ISetType = null;
         var _loc13_:int = 0;
         var _loc12_:class_3418 = null;
         var _loc14_:class_3445 = null;
         var _loc11_:Array = null;
         var _loc5_:IPartColor = null;
         var _loc6_:int = 0;
         if(!var_1671)
         {
            return 0;
         }
         var _loc10_:class_3360 = var_1671.figureData;
         var _loc4_:Array = param1.getPartTypeIds();
         for each(_loc15_ in _loc4_)
         {
            _loc9_ = _loc10_.getSetType(_loc15_);
            _loc13_ = param1.getPartSetId(_loc15_);
            if((_loc12_ = _loc9_.getPartSet(_loc13_)) != null)
            {
               _loc6_ = Math.max(_loc12_.clubLevel,_loc6_);
               _loc14_ = _loc10_.getPalette(_loc9_.paletteID);
               _loc11_ = param1.getPartColorIds(_loc15_);
               for each(var _loc7_ in _loc11_)
               {
                  _loc5_ = _loc14_.getColor(_loc7_);
                  _loc6_ = Math.max(_loc5_.clubLevel,_loc6_);
               }
            }
         }
         if(param3 == null)
         {
            param3 = var_1671.getBodyPartsUnordered("full");
         }
         for each(var _loc8_ in param3)
         {
            _loc9_ = _loc10_.getSetType(_loc8_);
            if(_loc4_.indexOf(_loc8_) == -1)
            {
               _loc6_ = Math.max(_loc9_.optionalFromClubLevel(param2),_loc6_);
            }
         }
         return _loc6_;
      }
      
      public function resetAssetManager() : void
      {
         var_2140.reset();
      }
      
      public function purgeAssets() : void
      {
         if(var_1815)
         {
            var_1815.purge();
         }
      }
      
      public function get isReady() : Boolean
      {
         return var_109;
      }
   }
}
