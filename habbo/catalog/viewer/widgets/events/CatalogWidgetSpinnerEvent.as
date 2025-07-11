package com.sulake.habbo.catalog.viewer.widgets.events
{
   import flash.events.Event;
   
   public class CatalogWidgetSpinnerEvent extends Event
   {
      
      public static const VALUE_CHANGED:String = "CWSE_VALUE_CHANGED";
      
      public static const RESET:String = "CWSE_RESET";
      
      public static const SHOW:String = "CWSE_SHOW";
      
      public static const HIDE:String = "CWSE_HIDE";
      
      public static const const_891:String = "CWSE_SET_MAX";
      
      public static const SET_MIN:String = "CWSE_SET_MIN";
       
      
      private var _value:int;
      
      private var var_3445:Array;
      
      public function CatalogWidgetSpinnerEvent(param1:String, param2:int = 1, param3:Array = null)
      {
         super(param1);
         _value = param2;
         var_3445 = param3;
      }
      
      public function get value() : int
      {
         return _value;
      }
      
      public function get skipSteps() : Array
      {
         return var_3445;
      }
   }
}
