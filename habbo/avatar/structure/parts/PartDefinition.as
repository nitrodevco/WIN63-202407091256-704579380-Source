package com.sulake.habbo.avatar.structure.parts
{
   public class PartDefinition
   {
       
      
      private var var_4596:String;
      
      private var var_3734:String;
      
      private var var_4835:String;
      
      private var var_3831:Boolean;
      
      private var var_4199:int = -1;
      
      public function PartDefinition(param1:XML)
      {
         super();
         var_4596 = String(param1["set-type"]);
         var_3734 = String(param1["flipped-set-type"]);
         var_4835 = String(param1["remove-set-type"]);
         var_3831 = false;
      }
      
      public function hasStaticId() : Boolean
      {
         return var_4199 >= 0;
      }
      
      public function get staticId() : int
      {
         return var_4199;
      }
      
      public function set staticId(param1:int) : void
      {
         var_4199 = param1;
      }
      
      public function get setType() : String
      {
         return var_4596;
      }
      
      public function get flippedSetType() : String
      {
         return var_3734;
      }
      
      public function get removeSetType() : String
      {
         return var_4835;
      }
      
      public function get appendToFigure() : Boolean
      {
         return var_3831;
      }
      
      public function set appendToFigure(param1:Boolean) : void
      {
         var_3831 = param1;
      }
      
      public function set flippedSetType(param1:String) : void
      {
         var_3734 = param1;
      }
   }
}
