package com.sulake.habbo.groups
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.outgoing.users.class_201;
   
   public class GroupCreatedWindowCtrl implements IDisposable
   {
       
      
      private var var_480:HabboGroupsManager;
      
      private var _window:class_3514;
      
      private var _groupId:int;
      
      public function GroupCreatedWindowCtrl(param1:HabboGroupsManager)
      {
         super();
         var_480 = param1;
      }
      
      public function dispose() : void
      {
         var_480 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_480 == null;
      }
      
      public function show(param1:int) : void
      {
         _groupId = param1;
         prepareWindow();
         _window.visible = true;
         _window.activate();
      }
      
      private function prepareWindow() : void
      {
         if(_window != null)
         {
            return;
         }
         _window = class_3514(var_480.getXmlWindow("group_created_window"));
         _window.findChildByTag("close").procedure = onClose;
         _window.findChildByName("ok_button").procedure = onClose;
         _window.center();
      }
      
      private function onClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            close();
            var_480.send(new class_201(_groupId,false));
         }
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            _window.visible = false;
         }
      }
   }
}
