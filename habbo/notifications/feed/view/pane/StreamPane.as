package com.sulake.habbo.notifications.feed.view.pane
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.notifications.feed.NotificationView;
   import com.sulake.habbo.notifications.feed.view.content.class_3603;
   
   public class StreamPane extends AbstractPane
   {
       
      
      private var var_19:IItemListWindow;
      
      public function StreamPane(param1:String, param2:NotificationView, param3:IWindowContainer)
      {
         super(param1,param2,param3,1);
         var_19 = _window.findChildByName("list") as IItemListWindow;
      }
      
      override public function dispose() : void
      {
         var_19 = null;
         super.dispose();
      }
      
      public function addItem(param1:class_3603) : void
      {
         var_19.addListItem(param1.window);
      }
   }
}
