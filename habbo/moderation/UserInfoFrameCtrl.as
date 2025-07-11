package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.parser.moderation.class_1722;
   
   public class UserInfoFrameCtrl implements IDisposable, ITrackedWindow
   {
       
      
      private var _main:ModerationManager;
      
      private var var_418:int;
      
      private var _frame:class_3514;
      
      private var _disposed:Boolean;
      
      private var var_3048:UserInfoCtrl;
      
      private var var_3769:class_1722;
      
      public function UserInfoFrameCtrl(param1:ModerationManager, param2:int, param3:class_1722 = null)
      {
         super();
         _main = param1;
         var_418 = param2;
         var_3769 = param3;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function show() : void
      {
         _frame = class_3514(_main.getXmlWindow("user_info_frame"));
         _frame.caption = "User Info";
         var _loc1_:IWindow = _frame.findChildByTag("close");
         _loc1_.procedure = onClose;
         var_3048 = new UserInfoCtrl(_frame,_main,var_3769,null,true);
         var_3048.load(_frame.content,var_418);
         _frame.visible = true;
      }
      
      public function getType() : int
      {
         return 1;
      }
      
      public function getId() : String
      {
         return "" + var_418;
      }
      
      public function getFrame() : class_3514
      {
         return _frame;
      }
      
      private function onClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         dispose();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(_frame != null)
         {
            _frame.destroy();
            _frame = null;
         }
         if(var_3048 != null)
         {
            var_3048.dispose();
            var_3048 = null;
         }
         var_3769 = null;
         _main = null;
      }
   }
}
