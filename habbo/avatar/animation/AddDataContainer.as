package com.sulake.habbo.avatar.animation
{
   public class AddDataContainer
   {
       
      
      private var var_280:String;
      
      private var var_3826:String;
      
      private var var_710:String;
      
      private var var_4150:String;
      
      private var var_2314:Number = 1;
      
      public function AddDataContainer(param1:XML)
      {
         super();
         var_280 = String(param1.@id);
         var_3826 = String(param1.@align);
         var_710 = String(param1.@base);
         var_4150 = String(param1.@ink);
         var _loc2_:String = String(param1.@blend);
         if(_loc2_.length > 0)
         {
            var_2314 = Number(_loc2_);
            if(var_2314 > 1)
            {
               var_2314 /= 100;
            }
         }
      }
      
      public function get id() : String
      {
         return var_280;
      }
      
      public function get align() : String
      {
         return var_3826;
      }
      
      public function get base() : String
      {
         return var_710;
      }
      
      public function get ink() : String
      {
         return var_4150;
      }
      
      public function get blend() : Number
      {
         return var_2314;
      }
      
      public function get isBlended() : Boolean
      {
         return var_2314 != 1;
      }
   }
}
