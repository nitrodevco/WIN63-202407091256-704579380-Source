package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1702;
   import com.sulake.habbo.roomevents.wired_setup.class_3531;
   import com.sulake.habbo.roomevents.wired_setup.class_3547;
   
   public class ActionTypes implements class_3547
   {
       
      
      private var var_1664:Array;
      
      public function ActionTypes()
      {
         var_1664 = [];
         super();
         this.var_1664.push(new class_3709());
         this.var_1664.push(new Reset());
         this.var_1664.push(new class_3802());
         this.var_1664.push(new class_3734());
         this.var_1664.push(new GiveScore());
         this.var_1664.push(new class_3788());
         this.var_1664.push(new class_3812());
         this.var_1664.push(new class_3776());
         this.var_1664.push(new class_3666());
         this.var_1664.push(new class_3669());
         this.var_1664.push(new class_3738());
         this.var_1664.push(new class_3763());
         this.var_1664.push(new class_3773());
         this.var_1664.push(new class_3809());
         this.var_1664.push(new class_3677());
         this.var_1664.push(new class_3810());
         this.var_1664.push(new class_3779());
         this.var_1664.push(new KickFromRoom());
         this.var_1664.push(new class_3692());
         this.var_1664.push(new class_3825());
         this.var_1664.push(new class_3781());
         this.var_1664.push(new class_3672());
         this.var_1664.push(new class_3710());
         this.var_1664.push(new class_3665());
         this.var_1664.push(new class_3772());
         this.var_1664.push(new class_3784());
         this.var_1664.push(new class_3712());
         this.var_1664.push(new class_3735());
         this.var_1664.push(new class_3717());
         this.var_1664.push(new class_3761());
         this.var_1664.push(new class_3711());
         this.var_1664.push(new class_3785());
         this.var_1664.push(new class_3775());
         this.var_1664.push(new class_3695());
         this.var_1664.push(new class_3679());
         this.var_1664.push(new class_3713());
         this.var_1664.push(new class_3740());
         this.var_1664.push(new class_3700());
         this.var_1664.push(new class_3764());
         this.var_1664.push(new class_3683());
      }
      
      public function get types() : Array
      {
         return var_1664;
      }
      
      public function getByCode(param1:int) : ActionType
      {
         for each(var _loc2_ in var_1664)
         {
            if(_loc2_.code == param1)
            {
               return _loc2_;
            }
            if(_loc2_.negativeCode == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getElementByCode(param1:int) : class_3531
      {
         return getByCode(param1);
      }
      
      public function acceptTriggerable(param1:class_1659) : Boolean
      {
         return param1 as class_1702 != null;
      }
      
      public function getKey() : String
      {
         return "action";
      }
   }
}
