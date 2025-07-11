package com.sulake.habbo.roomevents.wired_setup.common.utils
{
   public class ChronoFieldRangeFilter
   {
       
      
      private var _name:String;
      
      private var var_4905:Boolean;
      
      private var _min:int;
      
      private var var_4894:int;
      
      private var var_4889:int;
      
      public function ChronoFieldRangeFilter(param1:String, param2:Boolean, param3:int, param4:int, param5:int = 0)
      {
         super();
         this._name = param1;
         this.var_4905 = param2;
         this._min = param3;
         this.var_4894 = param4;
         this.var_4889 = param5;
      }
      
      public function get defaultValue() : int
      {
         return var_4889;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get useFilter() : Boolean
      {
         return var_4905;
      }
      
      public function get min() : int
      {
         return _min;
      }
      
      public function get max() : int
      {
         return var_4894;
      }
   }
}
