package com.sulake.core.utils
{
   import flash.system.Capabilities;
   
   public class class_3484
   {
      
      private static var var_1163:int;
      
      private static var var_4863:int;
      
      private static var var_4327:Boolean;
       
      
      public function class_3484()
      {
         super();
      }
      
      public static function isVersionAtLeast(param1:int, param2:int) : Boolean
      {
         if(param1 < class_3484.majorVersion)
         {
            return true;
         }
         if(param1 == class_3484.majorVersion && param2 <= class_3484.minorVersion)
         {
            return true;
         }
         return false;
      }
      
      public static function get majorVersion() : int
      {
         parseVersion();
         return var_1163;
      }
      
      public static function get minorVersion() : int
      {
         parseVersion();
         return var_4863;
      }
      
      private static function parseVersion() : void
      {
         if(var_4327)
         {
            return;
         }
         var _loc2_:Array = Capabilities.version.split(" ");
         var _loc3_:Array = _loc2_[1].split(",");
         var _loc1_:int = int(_loc3_.length);
         var_1163 = _loc1_ >= 1 ? parseInt(_loc3_[0]) : 0;
         var_4863 = _loc1_ >= 2 ? parseInt(_loc3_[1]) : 0;
         var_4327 = true;
      }
   }
}
