package com.sulake.habbo.advertisement
{
   public class AdImageRequest
   {
       
      
      private var var_369:int;
      
      private var var_455:int;
      
      private var var_1114:int;
      
      private var var_4396:String;
      
      private var var_4751:String;
      
      public function AdImageRequest(param1:int, param2:String = null, param3:String = null, param4:int = -1, param5:int = -1)
      {
         super();
         var_369 = param1;
         var_455 = param4;
         var_1114 = param5;
         var_4396 = param2;
         var_4751 = param3;
      }
      
      public function get roomId() : int
      {
         return var_369;
      }
      
      public function get objectId() : int
      {
         return var_455;
      }
      
      public function get objectCategory() : int
      {
         return var_1114;
      }
      
      public function get imageURL() : String
      {
         return var_4396;
      }
      
      public function get clickURL() : String
      {
         return var_4751;
      }
   }
}
