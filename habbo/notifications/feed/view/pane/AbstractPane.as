package com.sulake.habbo.notifications.feed.view.pane
{
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.notifications.feed.NotificationView;
   
   public class AbstractPane implements class_3674
   {
      
      public static const PANE_VIEW_LEVEL_BASE:int = 0;
      
      public static const PANE_VIEW_LEVEL_FEED:int = 1;
      
      public static const PANE_VIEW_LEVEL_MODAL:int = 2;
       
      
      protected var var_318:Boolean;
      
      protected var var_2553:Boolean;
      
      private var var_4823:int;
      
      protected var _window:IWindowContainer;
      
      protected var var_1747:NotificationView;
      
      protected var _name:String;
      
      public function AbstractPane(param1:String, param2:NotificationView, param3:IWindowContainer, param4:int)
      {
         super();
         if(param3 == null)
         {
            throw new Exception("Window was null for feed pane: " + param1);
         }
         _name = param1;
         var_1747 = param2;
         var_4823 = param4;
         _window = param3;
      }
      
      public function dispose() : void
      {
         var_318 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get paneLevel() : int
      {
         return var_4823;
      }
      
      public function set isVisible(param1:Boolean) : void
      {
         var_2553 = param1;
         _window.visible = var_2553;
      }
      
      public function get isVisible() : Boolean
      {
         return var_2553;
      }
   }
}
