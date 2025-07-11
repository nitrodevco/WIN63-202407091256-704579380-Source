package com.sulake.core.utils
{
   import flash.system.Capabilities;
   
   public class class_1696
   {
      
      private static var var_1163:int;
      
      private static var var_1076:int;
      
      private static var var_1489:String;
      
      {
         init();
      }
      
      public function class_1696()
      {
         super();
      }
      
      public static function get majorVersion() : int
      {
         return var_1163;
      }
      
      public static function get majorRevision() : int
      {
         return var_1076;
      }
      
      public static function get operatingSystem() : String
      {
         return var_1489;
      }
      
      private static function init() : void
      {
         var _loc1_:String = Capabilities.version;
         var _loc3_:Array = _loc1_.split(" ");
         var _loc2_:Array = _loc3_[1].split(",");
         var_1489 = _loc3_[0];
         var_1163 = parseInt(_loc2_[0]);
         var_1076 = parseInt(_loc2_[1]);
      }
   }
}
