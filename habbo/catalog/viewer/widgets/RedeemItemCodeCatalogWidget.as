package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3348;
   
   public class RedeemItemCodeCatalogWidget extends CatalogWidget implements class_3558
   {
       
      
      private var var_2980:class_3357;
      
      private var var_2988:ITextFieldWindow;
      
      public function RedeemItemCodeCatalogWidget(param1:IWindowContainer)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(var_2980 != null)
         {
            var_2980.removeEventListener("WME_CLICK",onRedeem);
            var_2980 = null;
         }
         if(var_2988 != null)
         {
            var_2988.removeEventListener("WKE_KEY_DOWN",windowKeyEventProcessor);
            var_2988 = null;
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         var_2980 = _window.findChildByName("redeem") as class_3357;
         if(var_2980 != null)
         {
            var_2980.addEventListener("WME_CLICK",onRedeem);
         }
         var_2988 = _window.findChildByName("voucher_code") as ITextFieldWindow;
         if(var_2988 != null)
         {
            var_2988.addEventListener("WKE_KEY_DOWN",windowKeyEventProcessor);
         }
         return true;
      }
      
      private function onRedeem(param1:WindowMouseEvent) : void
      {
         redeem();
      }
      
      private function windowKeyEventProcessor(param1:WindowEvent = null, param2:IWindow = null) : void
      {
         var _loc3_:WindowKeyboardEvent = param1 as WindowKeyboardEvent;
         if(_loc3_.charCode == 13)
         {
            redeem();
         }
      }
      
      private function redeem() : void
      {
         var voucher:String;
         var input:IWindow = _window.findChildByName("voucher_code");
         if(input != null)
         {
            voucher = input.caption;
            if(voucher.length > 0)
            {
               page.viewer.catalog.redeemVoucher(voucher);
               input.caption = "";
            }
            else
            {
               page.viewer.catalog.windowManager.alert("${catalog.voucher.empty.title}","${catalog.voucher.empty.desc}",0,function(param1:class_3348, param2:WindowEvent):void
               {
                  param1.dispose();
               });
            }
         }
      }
   }
}
