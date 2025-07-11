package com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.listitem
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.widgets.BundlePurchaseExtraInfoWidget;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoItemData;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoListItem;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetBundleDisplayExtraInfoEvent;
   
   public class ExtraInfoBundlesInfoItem extends ExtraInfoListItem
   {
       
      
      private var _catalog:HabboCatalog;
      
      private var _window:IWindowContainer;
      
      private var var_1629:BundlePurchaseExtraInfoWidget;
      
      public function ExtraInfoBundlesInfoItem(param1:BundlePurchaseExtraInfoWidget, param2:int, param3:ExtraInfoItemData, param4:HabboCatalog)
      {
         super(param1,param2,param3,2,true);
         _catalog = param4;
         var_1629 = param1;
      }
      
      override public function getRenderedWindow() : IWindowContainer
      {
         if(_window == null)
         {
            createWindow();
         }
         return _window;
      }
      
      private function createWindow() : void
      {
         _window = IWindowContainer(_catalog.utils.createWindow("bundlesInfoItem"));
         _window.procedure = windowProcedure;
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var_1629.events.dispatchEvent(new CatalogWidgetBundleDisplayExtraInfoEvent("CWPPEIE_ITEM_CLICKED",data,id));
         }
      }
   }
}
