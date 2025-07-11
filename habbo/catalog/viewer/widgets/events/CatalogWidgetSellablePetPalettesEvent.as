package com.sulake.habbo.catalog.viewer.widgets.events
{
   import flash.events.Event;
   
   public class CatalogWidgetSellablePetPalettesEvent extends Event
   {
       
      
      private var var_394:String;
      
      private var var_310:Array;
      
      public function CatalogWidgetSellablePetPalettesEvent(param1:String, param2:Array, param3:Boolean = false, param4:Boolean = false)
      {
         super("SELLABLE_PET_PALETTES",param3,param4);
         var_394 = param1;
         var_310 = param2;
      }
      
      public function get productCode() : String
      {
         return var_394;
      }
      
      public function get sellablePalettes() : Array
      {
         if(var_310 != null)
         {
            return var_310.slice();
         }
         return [];
      }
   }
}
