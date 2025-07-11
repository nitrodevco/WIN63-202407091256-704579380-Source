package com.sulake.habbo.roomevents.wired_setup.selectors
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.SelectorDefinition;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.wired_setup.class_3531;
   import com.sulake.habbo.roomevents.wired_setup.class_3547;
   
   public class SelectorTypes implements class_3547
   {
       
      
      private var var_1664:Array;
      
      public function SelectorTypes()
      {
         var_1664 = [];
         super();
         this.var_1664.push(new class_3675());
         this.var_1664.push(new class_3755());
         this.var_1664.push(new class_3816());
         this.var_1664.push(new class_3728());
         this.var_1664.push(new class_3745());
         this.var_1664.push(new class_3780());
         this.var_1664.push(new class_3736());
         this.var_1664.push(new FurniInArea());
         this.var_1664.push(new class_3789());
         this.var_1664.push(new UsersPerformingAction());
         this.var_1664.push(new class_3724());
         this.var_1664.push(new UsersByName());
         this.var_1664.push(new class_3715());
         this.var_1664.push(new UsersInArea());
         this.var_1664.push(new class_3689());
         this.var_1664.push(new UsersInGroup());
         this.var_1664.push(new class_3718());
         this.var_1664.push(new class_3797());
         this.var_1664.push(new class_3808());
         this.var_1664.push(new class_3777());
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
         return "selector";
      }
      
      public function acceptTriggerable(param1:class_1659) : Boolean
      {
         return param1 as SelectorDefinition != null;
      }
   }
}
