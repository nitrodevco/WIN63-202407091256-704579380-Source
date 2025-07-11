package com.sulake.core.utils
{
   public class class_940
   {
      
      private static var var_473:Map = new Map();
       
      
      public function class_940()
      {
         super();
      }
      
      public static function method_20(param1:String) : Object
      {
         return var_473[param1];
      }
      
      public static function assign(param1:String, param2:Object) : Object
      {
         return var_473[param1] = param2;
      }
      
      public static function remove(param1:String) : Object
      {
         return var_473.remove(param1);
      }
   }
}
