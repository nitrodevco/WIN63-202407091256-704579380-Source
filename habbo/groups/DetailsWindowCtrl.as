package com.sulake.habbo.groups
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.users.class_1199;
   
   public class DetailsWindowCtrl implements IDisposable
   {
       
      
      private var var_480:HabboGroupsManager;
      
      private var _window:class_3514;
      
      private var var_3145:GroupDetailsCtrl;
      
      private var _groupId:int;
      
      public function DetailsWindowCtrl(param1:HabboGroupsManager)
      {
         super();
         var_480 = param1;
         var_3145 = new GroupDetailsCtrl(param1,true);
      }
      
      public function dispose() : void
      {
         var_480 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_3145)
         {
            var_3145.dispose();
            var_3145 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_480 == null;
      }
      
      public function isDisplayingGroup(param1:int) : Boolean
      {
         return _window != null && Boolean(_window.visible) && param1 == _groupId;
      }
      
      public function onGroupDetails(param1:class_1199) : void
      {
         if(_window != null && Boolean(_window.visible) && param1.groupId == _groupId || param1.openDetails)
         {
            _groupId = param1.groupId;
            prepareWindow();
            var_3145.onGroupDetails(IWindowContainer(_window.findChildByName("group_cont")),param1);
            if(param1.openDetails)
            {
               _window.visible = true;
               _window.activate();
            }
         }
      }
      
      private function prepareWindow() : void
      {
         if(_window != null)
         {
            return;
         }
         _window = class_3514(var_480.getXmlWindow("group_info_window"));
         _window.findChildByTag("close").procedure = onClose;
         _window.center();
      }
      
      private function onClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         close();
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            _groupId = 0;
            _window.visible = false;
         }
      }
      
      public function onGroupDeactivated(param1:int) : void
      {
         if(_groupId == param1)
         {
            close();
         }
      }
   }
}
