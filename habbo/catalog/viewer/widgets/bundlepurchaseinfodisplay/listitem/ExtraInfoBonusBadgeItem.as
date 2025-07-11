package com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.listitem
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoItemData;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoListItem;
   import com.sulake.habbo.room.IGetImageListener;
   import flash.display.BitmapData;
   
   public class ExtraInfoBonusBadgeItem extends ExtraInfoListItem implements IGetImageListener
   {
       
      
      private var _catalog:HabboCatalog;
      
      public function ExtraInfoBonusBadgeItem(param1:int, param2:ExtraInfoItemData, param3:HabboCatalog)
      {
         super(null,param1,param2,0);
         _catalog = param3;
      }
      
      override public function getRenderedWindow() : IWindowContainer
      {
         return null;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
      }
      
      public function imageFailed(param1:int) : void
      {
      }
   }
}
