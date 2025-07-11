package com.sulake.habbo.game.snowwar.events
{
   import com.sulake.habbo.game.snowwar.arena.ISynchronizedGameEvent;
   import com.sulake.habbo.game.snowwar.arena.class_3565;
   
   public class class_3587 implements ISynchronizedGameEvent
   {
       
      
      private var var_318:Boolean = false;
      
      public function class_3587()
      {
         super();
      }
      
      public function apply(param1:class_3565) : void
      {
      }
      
      public function dispose() : void
      {
         var_318 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
   }
}
