package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   
   public class SimplePriceCatalogWidget extends CatalogWidget implements class_3558
   {
       
      
      private var _catalog:HabboCatalog;
      
      private var var_2248:IWindow;
      
      public function SimplePriceCatalogWidget(param1:IWindowContainer, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         events.addEventListener("SELECT_PRODUCT",onSelectProduct);
         return true;
      }
      
      private function onSelectProduct(param1:SelectProductEvent) : void
      {
         var_2248 = _catalog.utils.showPriceOnProduct(param1.offer,_window as IWindowContainer,var_2248,_window.findChildByName("fake_productimage"),0,true,0);
      }
   }
}
