package com.sulake.habbo.avatar.structure.parts
{
   public class ActivePartSet
   {
       
      
      private var var_280:String;
      
      private var var_1891:Array;
      
      public function ActivePartSet(param1:XML)
      {
         super();
         var_280 = String(param1.@id);
         var_1891 = [];
         for each(var _loc2_ in param1.activePart)
         {
            var_1891.push(String(_loc2_["set-type"]));
         }
      }
      
      public function get parts() : Array
      {
         return var_1891;
      }
   }
}
