package com.sulake.room.object.visualization.utils
{
    import assets.class_14

    import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.utils.Map;
   import com.sulake.room.utils.class_1781;
   import flash.display.BitmapData;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class GraphicAssetCollection implements class_3367
   {
      
      private static const PALETTE_ASSET_DISPOSE_THRESHOLD:int = 10;
      
      private static const PALETTE_ATTRIBUTES:Array = ["id","source"];
      
      private static const USE_LAZY_ASSETS:Boolean = false;
       
      
      private var _assets:Map;
      
      private var var_2079:IAssetLibrary;
      
      private var var_2002:Map;
      
      private var var_2316:Array;
      
      private var var_3720:Map;
      
      private var var_2403:int = 0;
      
      private var var_3674:int = 0;
      
      private var var_2382:Dictionary;
      
      public function GraphicAssetCollection()
      {
         super();
         _assets = new Map();
         var_2002 = new Map();
         var_3720 = new Map();
         var_2316 = [];
         var_2382 = new Dictionary();
      }
      
      public function dispose() : void
      {
         var _loc1_:GraphicAssetPalette = null;
         var _loc2_:String = null;
         var _loc3_:GraphicAsset = null;
         if(var_2002 != null)
         {
            for(_loc2_ in var_2002)
            {
               _loc1_ = var_2002[_loc2_];
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
            }
            var_2002.reset();
         }
         if(var_3720 != null)
         {
            var_2002.reset();
         }
         if(var_2316 != null)
         {
            disposePaletteAssets();
            var_2316 = null;
         }
         if(_assets != null)
         {
            for(_loc2_ in _assets)
            {
               _loc3_ = _assets[_loc2_];
               if(_loc3_ != null)
               {
                  _loc3_.recycle();
               }
            }
            _assets.reset();
         }
         if(var_2382)
         {
            for(var _loc4_ in var_2382)
            {
               delete var_2382[_loc4_];
            }
         }
         var_2079 = null;
      }
      
      public function set assetLibrary(param1:IAssetLibrary) : void
      {
         var_2079 = param1;
      }
      
      public function addReference() : void
      {
         var_2403++;
         var_3674 = getTimer();
      }
      
      public function removeReference() : void
      {
         var_2403--;
         if(var_2403 <= 0)
         {
            var_2403 = 0;
            var_3674 = getTimer();
            disposePaletteAssets(false);
         }
      }
      
      public function getReferenceCount() : int
      {
         return var_2403;
      }
      
      public function getLastReferenceTimeStamp() : int
      {
         return var_3674;
      }
      
      public function define(param1:XML) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc3_:XMLList = param1.asset;
         if(_loc3_ == null)
         {
            return false;
         }
         var _loc2_:XMLList = param1.palette;
         if(_loc2_ != null)
         {
            definePalettes(_loc2_);
         }
         defineAssets(_loc3_);
         return true;
      }
      
      private function defineAssetsLazy(param1:XMLList) : void
      {
         var _loc3_:String = null;
         var _loc2_:* = null;
         for each(_loc2_ in param1)
         {
            _loc3_ = _loc2_.@name;
            if(_loc3_.length > 0)
            {
               var_2382[_loc3_] = _loc2_;
            }
         }
      }
      
      private function defineAssets(param1:XMLList) : void
      {
         var _loc3_:int = 0;
         var _loc2_:XML = null;
         var _loc10_:String = null;
         var _loc4_:* = null;
         var _loc5_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc6_:* = false;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc13_:IAsset = null;
         var _loc8_:Boolean = false;
         var _loc12_:IGraphicAsset = null;
         var _loc14_:int = param1.length();
         _loc3_ = 0;
         while(_loc3_ < _loc14_)
         {
            _loc2_ = param1[_loc3_];
            if((_loc10_ = _loc2_.@name).length > 0)
            {
               _loc4_ = null;
               _loc5_ = false;
               _loc11_ = false;
               _loc6_ = false;
               _loc7_ = 0;
               _loc9_ = 0;
               _loc7_ = -int(_loc2_.@x);
               _loc9_ = -int(_loc2_.@y);
               _loc4_ = _loc2_.@source;
               if(int(_loc2_.@flipH) > 0)
               {
                  if(_loc4_.length > 0)
                  {
                     _loc5_ = true;
                  }
               }
               if(int(_loc2_.@flipV) > 0)
               {
                  if(_loc4_.length > 0)
                  {
                     _loc11_ = true;
                  }
               }
               _loc6_ = int(_loc2_.@usesPalette) != 0;
               if(_loc4_.length == 0)
               {
                  _loc4_ = _loc10_;
               }
               if((_loc13_ = var_2079.getAssetByName(_loc4_)) != null)
               {
                  if(!(_loc8_ = createAsset(_loc10_,_loc4_,_loc13_,_loc5_,_loc11_,_loc7_,_loc9_,_loc6_)))
                  {
                     if((_loc12_ = getAsset(_loc10_)) != null && _loc12_.assetName != _loc12_.libraryAssetName)
                     {
                        _loc8_ = replaceAsset(_loc10_,_loc4_,_loc13_,_loc5_,_loc11_,_loc7_,_loc9_,_loc6_);
                     }
                  }
               }
            }
            _loc3_++;
         }
      }
      
      private function definePalettes(param1:XMLList) : void
      {
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:IAsset = null;
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc9_:* = 0;
         var _loc10_:String = null;
         var _loc4_:GraphicAssetPalette = null;
         for each(var _loc5_ in param1)
         {
            if(class_1781.checkRequiredAttributes(_loc5_,PALETTE_ATTRIBUTES))
            {
               _loc6_ = _loc5_.@id;
               _loc7_ = _loc5_.@source;
               if(var_2002[_loc6_] == null)
               {
                  if((_loc8_ = var_2079.getAssetByName(_loc7_)).content == null)
                  {
                     class_14.log("Palette asset was null: " + _loc7_);
                  }
                  else
                  {
                     if(_loc8_.content is Class)
                     {
                        _loc2_ = new (_loc8_.content as Class)() as ByteArray;
                     }
                     else
                     {
                        _loc2_ = _loc8_.content as ByteArray;
                     }
                     _loc3_ = 16777215;
                     _loc9_ = 16777215;
                     if((_loc10_ = _loc5_.@color1).length > 0)
                     {
                        _loc3_ = parseInt(_loc10_,16);
                        _loc9_ = _loc3_;
                     }
                     if((_loc10_ = _loc5_.@color2).length > 0)
                     {
                        _loc9_ = parseInt(_loc10_,16);
                     }
                     _loc4_ = new GraphicAssetPalette(_loc2_,_loc3_,_loc9_);
                     var_2002[_loc6_] = _loc4_;
                     var_3720[_loc6_] = _loc5_;
                  }
               }
            }
         }
      }
      
      protected function createAsset(param1:String, param2:String, param3:IAsset, param4:Boolean, param5:Boolean, param6:Number, param7:Number, param8:Boolean) : Boolean
      {
         if(_assets[param1] != null)
         {
            return false;
         }
         if(var_2382[param1])
         {
            return false;
         }
         var _loc9_:GraphicAsset = GraphicAsset.allocate(param1,param2,param3,param4,param5,param6,param7,param8);
         _assets[param1] = _loc9_;
         return true;
      }
      
      protected function replaceAsset(param1:String, param2:String, param3:IAsset, param4:Boolean, param5:Boolean, param6:Number, param7:Number, param8:Boolean) : Boolean
      {
         var _loc9_:GraphicAsset;
         if((_loc9_ = _assets.remove(param1)) != null)
         {
            _loc9_.recycle();
         }
         else
         {
            delete var_2382[param1];
         }
         return createAsset(param1,param2,param3,param4,param5,param6,param7,param8);
      }
      
      public function getAsset(param1:String) : IGraphicAsset
      {
         var _loc7_:* = null;
         var _loc8_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc9_:* = false;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc11_:IAsset = null;
         var _loc10_:IGraphicAsset = null;
         var _loc2_:IGraphicAsset = _assets.getValue(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         var _loc5_:XML;
         if(_loc5_ = var_2382[param1])
         {
            delete var_2382[param1];
            _loc7_ = null;
            _loc8_ = false;
            _loc6_ = false;
            _loc9_ = false;
            _loc3_ = 0;
            _loc4_ = 0;
            _loc3_ = -int(_loc5_.@x);
            _loc4_ = -int(_loc5_.@y);
            _loc7_ = _loc5_.@source;
            if(int(_loc5_.@flipH) > 0)
            {
               if(_loc7_.length > 0)
               {
                  _loc8_ = true;
               }
            }
            if(int(_loc5_.@flipV) > 0)
            {
               if(_loc7_.length > 0)
               {
                  _loc6_ = true;
               }
            }
            _loc9_ = int(_loc5_.@usesPalette) != 0;
            if(_loc7_.length == 0)
            {
               _loc7_ = param1;
            }
            if((_loc11_ = var_2079.getAssetByName(_loc7_)) != null)
            {
               if(createAsset(param1,_loc7_,_loc11_,_loc8_,_loc6_,_loc3_,_loc4_,_loc9_))
               {
                  return _assets[param1];
               }
               if((_loc10_ = getAsset(param1)) != null && _loc10_.assetName != _loc10_.libraryAssetName)
               {
                  if(!replaceAsset(param1,_loc7_,_loc11_,_loc8_,_loc6_,_loc3_,_loc4_,_loc9_))
                  {
                     return null;
                  }
               }
            }
         }
         return null;
      }
      
      public function getAssetWithPalette(param1:String, param2:String) : IGraphicAsset
      {
         var _loc3_:IGraphicAsset = null;
         var _loc6_:String = null;
         var _loc4_:BitmapDataAsset = null;
         var _loc10_:BitmapData = null;
         var _loc7_:GraphicAssetPalette = null;
         var _loc5_:BitmapData = null;
         var _loc8_:String = param1 + "@" + param2;
         var _loc9_:IGraphicAsset;
         if((_loc9_ = getAsset(_loc8_)) == null)
         {
            _loc3_ = getAsset(param1);
            if(_loc3_ == null || !_loc3_.usesPalette)
            {
               return _loc3_;
            }
            _loc6_ = _loc3_.libraryAssetName + "@" + param2;
            if((_loc4_ = getLibraryAsset(_loc6_)) == null)
            {
               if((_loc10_ = _loc3_.asset.content as BitmapData) != null)
               {
                  if((_loc7_ = getPalette(param2)) == null)
                  {
                     return _loc3_;
                  }
                  _loc5_ = _loc10_.clone();
                  _loc7_.colorizeBitmap(_loc5_);
                  if((_loc4_ = addLibraryAsset(_loc6_,_loc5_)) == null)
                  {
                     _loc5_.dispose();
                     return null;
                  }
               }
            }
            var_2316.push(_loc8_);
            createAsset(_loc8_,_loc6_,_loc4_,_loc3_.flipH,_loc3_.flipV,_loc3_.originalOffsetX,_loc3_.originalOffsetY,false);
            _loc9_ = getAsset(_loc8_);
         }
         return _loc9_;
      }
      
      public function getPaletteNames() : Array
      {
         return var_2002.getKeys();
      }
      
      public function getPaletteColors(param1:String) : Array
      {
         var _loc2_:GraphicAssetPalette = getPalette(param1);
         if(_loc2_ != null)
         {
            return [_loc2_.primaryColor,_loc2_.secondaryColor];
         }
         return null;
      }
      
      public function getPaletteXML(param1:String) : XML
      {
         return var_3720[param1];
      }
      
      private function getPalette(param1:String) : GraphicAssetPalette
      {
         return var_2002[param1];
      }
      
      public function addAsset(param1:String, param2:BitmapData, param3:Boolean, param4:int = 0, param5:int = 0, param6:Boolean = false, param7:Boolean = false) : Boolean
      {
         var _loc9_:BitmapData = null;
         if(param1 == null || param2 == null)
         {
            return false;
         }
         if(var_2079 == null)
         {
            return false;
         }
         var _loc8_:BitmapDataAsset;
         if((_loc8_ = getLibraryAsset(param1)) == null)
         {
            _loc8_ = new BitmapDataAsset(var_2079.getAssetTypeDeclarationByClass(BitmapDataAsset));
            var_2079.setAsset(param1,_loc8_);
            _loc8_.setUnknownContent(param2);
            return createAsset(param1,param1,_loc8_,param6,param7,param4,param5,false);
         }
         if(param3)
         {
            if((_loc9_ = _loc8_.content as BitmapData) != null && _loc9_ != param2)
            {
               _loc9_.dispose();
            }
            _loc8_.setUnknownContent(param2);
            return true;
         }
         return false;
      }
      
      public function disposeAsset(param1:String) : void
      {
         var _loc3_:BitmapDataAsset = null;
         var _loc2_:GraphicAsset = _assets.remove(param1);
         if(_loc2_ != null)
         {
            _loc3_ = getLibraryAsset(_loc2_.libraryAssetName);
            if(_loc3_ != null)
            {
               var_2079.removeAsset(_loc3_);
               _loc3_.dispose();
            }
            _loc2_.recycle();
         }
         else
         {
            delete var_2382[param1];
         }
      }
      
      private function getLibraryAsset(param1:String) : BitmapDataAsset
      {
         return var_2079.getAssetByName(param1) as BitmapDataAsset;
      }
      
      private function addLibraryAsset(param1:String, param2:BitmapData) : BitmapDataAsset
      {
         var _loc3_:BitmapDataAsset = getLibraryAsset(param1);
         if(_loc3_ == null)
         {
            _loc3_ = new BitmapDataAsset(var_2079.getAssetTypeDeclarationByClass(BitmapDataAsset));
            var_2079.setAsset(param1,_loc3_);
            _loc3_.setUnknownContent(param2);
            return _loc3_;
         }
         return null;
      }
      
      private function disposePaletteAssets(param1:Boolean = true) : void
      {
         if(var_2316 != null)
         {
            if(param1 || var_2316.length > 10)
            {
               for each(var _loc2_ in var_2316)
               {
                  disposeAsset(_loc2_);
               }
               var_2316 = [];
            }
         }
      }
   }
}
