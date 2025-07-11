package com.sulake.habbo.window.utils
{
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.habbo.communication.messages.incoming.notifications.class_800;
   
   public class ElementPointerHandler
   {
       
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_4013:class_800;
      
      public function ElementPointerHandler(param1:HabboWindowManagerComponent)
      {
         super();
         _windowManager = param1;
         if(_windowManager.communication != null)
         {
            var_4013 = new class_800(onElementPointerMessage);
            _windowManager.communication.addHabboConnectionMessageEvent(var_4013);
         }
      }
      
      private function onElementPointerMessage(param1:class_800) : void
      {
         var _loc2_:String = param1.getParser().key;
         if(_loc2_ == null || _loc2_ == "")
         {
            _windowManager.hideHint();
         }
         else
         {
            _windowManager.showHint(_loc2_);
         }
      }
      
      public function dispose() : void
      {
         if(_windowManager.communication != null)
         {
            _windowManager.communication.removeHabboConnectionMessageEvent(var_4013);
         }
         _windowManager = null;
      }
   }
}
