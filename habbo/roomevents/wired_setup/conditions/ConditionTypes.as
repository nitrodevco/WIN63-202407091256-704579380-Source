package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1660;
   import com.sulake.habbo.roomevents.wired_setup.class_3531;
   import com.sulake.habbo.roomevents.wired_setup.class_3547;
   
   public class ConditionTypes implements class_3547
   {
       
      
      private var var_1664:Array;
      
      public function ConditionTypes()
      {
         var_1664 = [];
         super();
         this.var_1664.push(new class_3744());
         this.var_1664.push(new FurnisHaveAvatars());
         this.var_1664.push(new FurnisHaveNoAvatars());
         this.var_1664.push(new class_3687());
         this.var_1664.push(new class_3774());
         this.var_1664.push(new class_3732());
         this.var_1664.push(new class_3682());
         this.var_1664.push(new class_3731());
         this.var_1664.push(new HasStackedFurnis());
         this.var_1664.push(new class_3803());
         this.var_1664.push(new class_3721());
         this.var_1664.push(new class_3754());
         this.var_1664.push(new class_3696());
         this.var_1664.push(new class_3742());
         this.var_1664.push(new DontHaveStackedFurnis());
         this.var_1664.push(new class_3792());
         this.var_1664.push(new class_3703());
         this.var_1664.push(new class_3706());
         this.var_1664.push(new class_3699());
         this.var_1664.push(new class_3811());
         this.var_1664.push(new class_3765());
         this.var_1664.push(new ActorIsPerformingAction());
         this.var_1664.push(new TeamHasScore());
         this.var_1664.push(new class_3681());
         this.var_1664.push(new class_3701());
         this.var_1664.push(new class_3729());
         this.var_1664.push(new class_3804());
         this.var_1664.push(new class_3794());
         this.var_1664.push(new class_3778());
         this.var_1664.push(new class_3737());
         this.var_1664.push(new class_3766());
         this.var_1664.push(new class_3824());
      }
      
      public function get types() : Array
      {
         return var_1664;
      }
      
      public function getByCode(param1:int) : class_3680
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
         return param1 as class_1660 != null;
      }
      
      public function getKey() : String
      {
         return "condition";
      }
   }
}
