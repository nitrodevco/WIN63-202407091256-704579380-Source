package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.catalog.viewer.class_3455;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   
   public class CatalogWidget implements class_3558
   {
       
      
      protected var _window:IWindowContainer;
      
      protected var name_1:IEventDispatcher;
      
      private var var_1768:class_3455;
      
      private var var_318:Boolean;
      
      protected var _isEmbedded:Boolean = false;
      
      public function CatalogWidget(param1:IWindowContainer)
      {
         super();
         _window = param1;
         _isEmbedded = param1.tags.indexOf("EMBEDDED") > -1;
      }
      
      public function set page(param1:class_3455) : void
      {
         var_1768 = param1;
      }
      
      public function set events(param1:IEventDispatcher) : void
      {
         name_1 = param1;
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      public function get events() : IEventDispatcher
      {
         return name_1;
      }
      
      public function get page() : class_3455
      {
         return var_1768;
      }
      
      public function dispose() : void
      {
         name_1 = null;
         var_1768 = null;
         _window = null;
         var_318 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      public function init() : Boolean
      {
         return true;
      }
      
      public function closed() : void
      {
      }
      
      protected function getAssetXML(param1:String) : XML
      {
         if(!page || !page.viewer || !page.viewer.catalog || !page.viewer.catalog.assets)
         {
            return null;
         }
         var _loc2_:XmlAsset = page.viewer.catalog.assets.getAssetByName(param1) as XmlAsset;
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.content as XML;
      }
      
      protected function attachWidgetView(param1:String) : void
      {
         if(_isEmbedded)
         {
            return;
         }
         var _loc2_:XML = getAssetXML(param1);
         if(_loc2_ == null)
         {
            return;
         }
         window.removeChildAt(0);
         if(!window || !page || !page.viewer || !page.viewer.catalog)
         {
            return;
         }
         window.addChild(page.viewer.catalog.windowManager.buildFromXML(_loc2_));
      }
      
      protected function getAssetBitmapData(param1:String) : BitmapData
      {
         var _loc2_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.content as BitmapData;
      }
   }
}
