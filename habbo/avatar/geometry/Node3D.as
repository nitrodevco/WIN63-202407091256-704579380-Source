package com.sulake.habbo.avatar.geometry
{
   public class Node3D
   {
       
      
      private var var_587:Vector3D;
      
      private var var_3793:Vector3D;
      
      private var var_4679:Boolean = false;
      
      public function Node3D(param1:Number, param2:Number, param3:Number)
      {
         var_3793 = new Vector3D();
         super();
         var_587 = new Vector3D(param1,param2,param3);
         if(param1 != 0 || param2 != 0 || param3 != 0)
         {
            var_4679 = true;
         }
      }
      
      public function get location() : Vector3D
      {
         return var_587;
      }
      
      public function get transformedLocation() : Vector3D
      {
         return var_3793;
      }
      
      public function applyTransform(param1:Matrix4x4) : void
      {
         if(var_4679)
         {
            var_3793 = param1.vectorMultiplication(var_587);
         }
      }
   }
}
