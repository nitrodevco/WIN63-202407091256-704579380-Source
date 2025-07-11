package com.sulake.habbo.notifications.feed.view.pane
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3489;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.notifications.feed.NotificationView;
   
   public class InfoPane extends AbstractPane
   {
       
      
      public function InfoPane(param1:String, param2:NotificationView, param3:IWindowContainer)
      {
         super(param1,param2,param3,2);
         (_window.findChildByName("info_ok") as class_3489).addEventListener("WME_CLICK",onOkClick);
      }
      
      override public function dispose() : void
      {
         var _loc1_:class_3489 = null;
         super.dispose();
         if(_window)
         {
            _loc1_ = _window.findChildByName("info_ok") as class_3489;
            if(_loc1_)
            {
               _loc1_.removeEventListener("WME_CLICK",onOkClick);
               _loc1_ = null;
            }
         }
      }
      
      private function onOkClick(param1:WindowMouseEvent) : void
      {
         var_1747.closePaneLevel(2);
      }
   }
}
