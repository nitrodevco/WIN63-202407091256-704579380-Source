package com.sulake.habbo.catalog.navigation.events
{
   import flash.events.Event;
   
   public class CatalogPageOpenedEvent extends Event
   {
      
      public static const CATALOG_PAGE_OPENED:String = "CATALOG_PAGE_OPENED";
       
      
      private var var_562:int;
      
      private var var_4379:String;
      
      public function CatalogPageOpenedEvent(param1:int, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super("CATALOG_PAGE_OPENED",param3,param4);
         var_562 = param1;
         var_4379 = param2;
      }
      
      public function get pageId() : int
      {
         return var_562;
      }
      
      public function get pageLocalization() : String
      {
         return var_4379;
      }
   }
}
