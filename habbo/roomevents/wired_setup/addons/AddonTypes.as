package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1747;
   import com.sulake.habbo.roomevents.wired_setup.class_3531;
   import com.sulake.habbo.roomevents.wired_setup.class_3547;
   
   public class AddonTypes implements class_3547
   {
       
      
      private var var_1664:Array;
      
      public function AddonTypes()
      {
         var_1664 = [];
         super();
         this.var_1664.push(new class_3693());
         this.var_1664.push(new class_3799());
         this.var_1664.push(new class_3753());
         this.var_1664.push(new class_3801());
         this.var_1664.push(new NoMoveAnimation());
         this.var_1664.push(new class_3814());
         this.var_1664.push(new CarryUsers());
         this.var_1664.push(new AnimationTime());
         this.var_1664.push(new class_3663());
         this.var_1664.push(new class_3790());
         this.var_1664.push(new class_3751());
         this.var_1664.push(new class_3705());
         this.var_1664.push(new class_3795());
         this.var_1664.push(new class_3749());
         this.var_1664.push(new class_3691());
         this.var_1664.push(new class_3708());
         this.var_1664.push(new class_3752());
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
         return "addon";
      }
      
      public function acceptTriggerable(param1:class_1659) : Boolean
      {
         return param1 as class_1747 != null;
      }
   }
}
