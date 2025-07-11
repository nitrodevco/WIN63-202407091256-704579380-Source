package com.sulake.core.window.motion
{
   import com.sulake.core.window.IWindow;
   
   use namespace friend;
   
   public class Motion
   {
       
      
      protected var var_294:IWindow;
      
      protected var var_92:Boolean;
      
      protected var var_1808:Boolean = true;
      
      protected var var_881:String;
      
      public function Motion(param1:IWindow)
      {
         super();
         var_294 = param1;
      }
      
      public function get running() : Boolean
      {
         return var_92 && var_294 && !var_294.disposed;
      }
      
      public function get complete() : Boolean
      {
         return var_1808;
      }
      
      public function set target(param1:IWindow) : void
      {
         var_294 = param1;
      }
      
      public function get target() : IWindow
      {
         return var_294;
      }
      
      public function set tag(param1:String) : void
      {
         var_881 = param1;
      }
      
      public function get tag() : String
      {
         return var_881;
      }
      
      friend function start() : void
      {
         var_92 = true;
      }
      
      friend function update(param1:Number) : void
      {
      }
      
      friend function stop() : void
      {
         var_294 = null;
         var_92 = false;
      }
      
      friend function tick(param1:int) : void
      {
      }
   }
}
