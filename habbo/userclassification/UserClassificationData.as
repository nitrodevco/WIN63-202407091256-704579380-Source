package com.sulake.habbo.userclassification
{
   public class UserClassificationData
   {
      
      public static var var_4996:uint = 1;
      
      public static var var_4994:uint = 2;
      
      public static var var_4983:uint = 3;
      
      public static var PAYING_USER_CLASSIFICATION:uint = 4;
       
      
      private var var_418:int;
      
      private var _username:String;
      
      private var var_4037:String;
      
      public function UserClassificationData(param1:int, param2:String, param3:String)
      {
         super();
         var_418 = param1;
         _username = param2;
         var_4037 = param3;
      }
      
      public function get userId() : int
      {
         return var_418;
      }
      
      public function get username() : String
      {
         return _username;
      }
      
      public function get classType() : String
      {
         return var_4037;
      }
      
      public function toString() : String
      {
         return "[" + var_418 + ", " + _username + "] [" + var_4037 + "]";
      }
   }
}
