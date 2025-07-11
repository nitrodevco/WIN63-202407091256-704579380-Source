package com.sulake.room.renderer.cache
{
   [SecureSWF(rename="true")]
   public class class_3730
   {
       
      
      private var var_455:int;
      
      private var var_587:class_3686 = null;
      
      private var var_1761:class_3726 = null;
      
      public function class_3730(param1:String)
      {
         super();
         var_587 = new class_3686(param1);
         var_1761 = new class_3726();
      }
      
      public function get location() : class_3686
      {
         return var_587;
      }
      
      public function get sprites() : class_3726
      {
         return var_1761;
      }
      
      public function dispose() : void
      {
         if(var_587 != null)
         {
            var_587.dispose();
            var_587 = null;
         }
         if(var_1761 != null)
         {
            var_1761.dispose();
            var_1761 = null;
         }
      }
      
      public function set objectId(param1:int) : void
      {
         var_455 = param1;
      }
      
      public function get objectId() : int
      {
         return var_455;
      }
   }
}
