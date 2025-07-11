package com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.catalog.viewer.widgets.BundlePurchaseExtraInfoWidget;
   
   public class ExtraInfoListItem implements IDisposable
   {
      
      public static const ALIGN_TOP:int = 0;
      
      public static const ALIGN_BOTTOM:int = 1;
      
      public static const ALIGN_OVERLAY:int = 2;
       
      
      private var var_280:int;
      
      private var var_47:ExtraInfoItemData;
      
      private var var_3819:int;
      
      private var var_4819:Boolean;
      
      private var _disposed:Boolean = false;
      
      private var var_4838:Number;
      
      private var var_4297:Number;
      
      private var var_4791:Boolean = false;
      
      public function ExtraInfoListItem(param1:BundlePurchaseExtraInfoWidget, param2:int, param3:ExtraInfoItemData, param4:int = 0, param5:Boolean = false)
      {
         super();
         var_280 = param2;
         var_47 = param3;
         var_3819 = param4;
         var_4819 = param5;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         var_47 = null;
         _disposed = true;
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function set id(param1:int) : void
      {
         var_280 = param1;
      }
      
      public function get data() : ExtraInfoItemData
      {
         return var_47;
      }
      
      public function set data(param1:ExtraInfoItemData) : void
      {
         var_47 = param1;
      }
      
      public function get alignment() : int
      {
         return var_3819;
      }
      
      public function get alwaysOnTop() : Boolean
      {
         return var_4819;
      }
      
      public function get creationSeconds() : Number
      {
         return var_4838;
      }
      
      public function set creationSeconds(param1:Number) : void
      {
         var_4838 = param1;
      }
      
      public function get isItemRemoved() : Boolean
      {
         return var_4791;
      }
      
      public function get removalSeconds() : Number
      {
         return var_4297;
      }
      
      public function set removalSeconds(param1:Number) : void
      {
         var_4297 = param1;
         var_4791 = true;
      }
      
      public function getRenderedWindow() : IWindowContainer
      {
         return null;
      }
   }
}
