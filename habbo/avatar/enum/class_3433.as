package com.sulake.habbo.avatar.enum
{
   public class class_3433
   {
      
      public static const const_880:uint = 0;
      
      public static const const_737:uint = 1;
      
      public static const BOT_EDITOR:uint = 2;
      
      public static const DEV_TOOL_EDITOR:uint = 3;
       
      
      public function class_3433()
      {
         super();
      }
      
      public static function isDevelopmentEditor(param1:int) : Boolean
      {
         return param1 == 2 || param1 == 2 || param1 == 3;
      }
   }
}
