package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1701;
   import com.sulake.habbo.roomevents.wired_setup.class_3531;
   import com.sulake.habbo.roomevents.wired_setup.class_3547;
   
   public class TriggerConfs implements class_3547
   {
       
      
      private var var_1721:Array;
      
      public function TriggerConfs()
      {
         var_1721 = [];
         super();
         this.var_1721.push(new class_3743());
         this.var_1721.push(new class_3762());
         this.var_1721.push(new class_3806());
         this.var_1721.push(new class_3612());
         this.var_1721.push(new class_3800());
         this.var_1721.push(new class_3670());
         this.var_1721.push(new AvatarEntersRoom());
         this.var_1721.push(new class_3688());
         this.var_1721.push(new class_3702());
         this.var_1721.push(new ScoreAchieved());
         this.var_1721.push(new class_3697());
         this.var_1721.push(new class_3760());
         this.var_1721.push(new class_3671());
         this.var_1721.push(new class_3798());
         this.var_1721.push(new class_3758());
         this.var_1721.push(new ClockReachTime());
         this.var_1721.push(new PerformAction());
         this.var_1721.push(new class_3733());
         this.var_1721.push(new class_3783());
         this.var_1721.push(new class_3823());
         this.var_1721.push(new class_3820());
         this.var_1721.push(new class_3678());
         this.var_1721.push(new VariableUpdate());
         this.var_1721.push(new AvatarLeavesRoom());
      }
      
      public function get confs() : Array
      {
         return var_1721;
      }
      
      public function getByCode(param1:int) : class_3611
      {
         for each(var _loc2_ in var_1721)
         {
            if(_loc2_.code == param1)
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
         return param1 as class_1701 != null;
      }
      
      public function getKey() : String
      {
         return "trigger";
      }
   }
}
