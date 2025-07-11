package com.sulake.habbo.catalog.viewer.widgets.utils
{
   import com.sulake.core.window.IWindow;
   import com.sulake.habbo.catalog.class_3377;
   
   public class RentUtils
   {
       
      
      public function RentUtils()
      {
         super();
      }
      
      public static function updateBuyCaption(param1:class_3377, param2:IWindow) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         param2.caption = param1.isRentOffer ? "${catalog.purchase_confirmation.rent}" : "${catalog.purchase_confirmation.buy}";
      }
   }
}
