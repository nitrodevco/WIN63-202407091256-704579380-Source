package com.sulake.habbo.roomevents.wired_setup.variables
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1737;
   import com.sulake.habbo.roomevents.wired_setup.class_3531;
   import com.sulake.habbo.roomevents.wired_setup.class_3547;
   
   public class VariableTypes implements class_3547
   {
       
      
      private var var_1664:Array;
      
      public function VariableTypes()
      {
         var_1664 = [];
         super();
         var_1664.push(new class_3791());
         var_1664.push(new class_3668());
         var_1664.push(new class_3722());
         var_1664.push(new class_3747());
         var_1664.push(new ReferenceVariable());
         var_1664.push(new class_3662());
         var_1664.push(new class_3796());
      }
      
      public function getElementByCode(param1:int) : class_3531
      {
         for each(var _loc2_ in var_1664)
         {
            if(_loc2_.code == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getKey() : String
      {
         return "variable";
      }
      
      public function acceptTriggerable(param1:class_1659) : Boolean
      {
         return param1 as class_1737 != null;
      }
   }
}
