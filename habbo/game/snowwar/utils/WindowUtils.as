package com.sulake.habbo.game.snowwar.utils
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3431;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class WindowUtils
   {
      
      private static var _assets:IAssetLibrary;
      
      private static var _windowManager:IHabboWindowManager;
       
      
      public function WindowUtils()
      {
         super();
      }
      
      public static function setCaption(param1:IWindow, param2:String) : void
      {
         var _loc3_:IWindow = null;
         param1.caption = param2;
         if(param1.parent is IWindowContainer)
         {
            _loc3_ = (param1.parent as IWindowContainer).findChildByName(param1.name + "_stroke");
         }
         if(param1.parent is IItemListWindow)
         {
            _loc3_ = (param1.parent as IItemListWindow).getListItemByName(param1.name + "_stroke");
         }
         if(param1.parent is IItemGridWindow)
         {
            _loc3_ = (param1.parent as IItemGridWindow).getGridItemByName(param1.name + "_stroke");
         }
         if(_loc3_)
         {
            if(_loc3_.caption != param2)
            {
               _loc3_.caption = param2;
            }
         }
      }
      
      public static function init(param1:IAssetLibrary, param2:IHabboWindowManager) : void
      {
         _assets = param1;
         _windowManager = param2;
      }
      
      public static function setElementImage(param1:IWindow, param2:BitmapData, param3:int = 0, param4:int = 0, param5:int = 0) : void
      {
         var _loc9_:IBitmapWrapperWindow = null;
         var _loc6_:class_3431 = null;
         if(param2 == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         if(param1.disposed)
         {
            return;
         }
         var _loc10_:int = param3 > 0 ? param3 : param1.height;
         var _loc7_:int = (param1.width - param2.width) / 2 + param4;
         var _loc8_:int = (_loc10_ - param2.height) / 2 + param5;
         if(param1 as IBitmapWrapperWindow != null)
         {
            if((_loc9_ = IBitmapWrapperWindow(param1)).bitmap == null || param3 > 0)
            {
               _loc9_.bitmap = new BitmapData(param1.width,_loc10_,true,16777215);
            }
            _loc9_.bitmap.fillRect(_loc9_.bitmap.rect,16777215);
            _loc9_.bitmap.copyPixels(param2,param2.rect,new Point(_loc7_,_loc8_),null,null,false);
            param1.invalidate();
         }
         else if(param1 as class_3431 != null)
         {
            (_loc6_ = class_3431(param1)).setDisplayObject(new Bitmap(param2));
         }
      }
      
      public static function createWindow(param1:String, param2:int = 2) : IWindow
      {
         HabboGamesCom.log("CreateWindow: " + param1);
         if(!_assets || !_windowManager)
         {
            return null;
         }
         var _loc4_:XmlAsset;
         if((_loc4_ = _assets.getAssetByName(param1) as XmlAsset) == null)
         {
            HabboGamesCom.log("CreateWindow() could not find the asset for window: " + param1);
            return null;
         }
         var _loc5_:IWindow = _windowManager.buildFromXML(_loc4_.content as XML,param2);
         var _loc3_:Array = [];
         if(_loc5_ is IWindowContainer)
         {
            (_loc5_ as IWindowContainer).groupChildrenWithTag("bitmap",_loc3_,-1);
         }
         else if(_loc5_ is IItemListWindow)
         {
            (_loc5_ as IItemListWindow).groupListItemsWithTag("bitmap",_loc3_,-1);
         }
         else if(_loc5_ is IItemGridWindow)
         {
         }
         for each(var _loc7_ in _loc3_)
         {
            HabboGamesCom.log("Found child: " + _loc7_.name);
         }
         for each(var _loc6_ in _loc3_)
         {
            if(_loc6_ != null)
            {
               setDefaultElementImage(_loc6_,false);
            }
         }
         return _loc5_;
      }
      
      private static function setDefaultElementImage(param1:IBitmapWrapperWindow, param2:Boolean) : void
      {
         var asset:IAsset;
         var result:Array;
         var offset:Point;
         var assetName:String;
         var src:BitmapData;
         var bmpWindow:IBitmapWrapperWindow = param1;
         var active:Boolean = param2;
         if(!_assets)
         {
            return;
         }
         if(bmpWindow == null)
         {
            return;
         }
         result = bmpWindow.properties.filter(function(param1:*, param2:int, param3:Array):Boolean
         {
            return PropertyStruct(param1).key == "bitmap_asset_name";
         });
         offset = new Point();
         if(result && result.length)
         {
            assetName = PropertyStruct(result[0]).value as String;
            HabboGamesCom.log("Found Image: " + bmpWindow.name + " : " + assetName);
            if(active)
            {
               assetName = assetName.replace("_on","");
            }
            asset = _assets.getAssetByName(assetName);
            if(asset && asset is BitmapDataAsset)
            {
               bmpWindow.bitmap = new BitmapData(bmpWindow.width,bmpWindow.height,true,0);
               src = asset.content as BitmapData;
               offset.x = (bmpWindow.width - src.width) / 2;
               offset.y = (bmpWindow.height - src.height) / 2;
               bmpWindow.bitmap.copyPixels(src,src.rect,offset);
            }
         }
      }
      
      public static function hideElement(param1:IWindowContainer, param2:String) : void
      {
         var _loc4_:IWindow;
         if(_loc4_ = param1.findChildByName(param2))
         {
            _loc4_.visible = false;
         }
         var _loc3_:IWindow = param1.findChildByName(param2 + "_stroke");
         if(_loc3_)
         {
            _loc3_.visible = false;
         }
      }
      
      public static function colorStrokes(param1:IWindow, param2:uint) : void
      {
         var _loc3_:Array = [];
         if(param1 is IWindowContainer)
         {
            (param1 as IWindowContainer).groupChildrenWithTag("stroke",_loc3_,10);
         }
         else if(param1 is IItemListWindow)
         {
            (param1 as IItemListWindow).groupListItemsWithTag("stroke",_loc3_,10);
         }
         else if(param1 is IItemGridWindow)
         {
         }
         for each(var _loc4_ in _loc3_)
         {
            if(_loc4_ != null)
            {
               _loc4_.textColor = param2;
            }
         }
      }
      
      public static function showElement(param1:IWindowContainer, param2:String) : void
      {
         var _loc4_:IWindow;
         if(_loc4_ = param1.findChildByName(param2))
         {
            _loc4_.visible = true;
         }
         var _loc3_:IWindow = param1.findChildByName(param2 + "_stroke");
         if(_loc3_)
         {
            _loc3_.visible = true;
         }
      }
   }
}
