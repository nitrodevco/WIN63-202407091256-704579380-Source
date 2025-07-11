package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   
   public class AchievementResolutionCompletedView implements IDisposable
   {
      
      private static const const_533:String = "header_button_close";
      
      private static const const_525:String = "cancel_button";
       
      
      private var var_319:AchievementsResolutionController;
      
      private var _window:class_3514;
      
      private var var_413:String;
      
      private var var_633:String;
      
      public function AchievementResolutionCompletedView(param1:AchievementsResolutionController)
      {
         super();
         var_319 = param1;
      }
      
      public function dispose() : void
      {
         var_319 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_319 != null;
      }
      
      public function get visible() : Boolean
      {
         if(!_window)
         {
            return false;
         }
         return _window.visible;
      }
      
      public function show(param1:String, param2:String) : void
      {
         if(_window == null)
         {
            createWindow();
         }
         initializeWindow();
         var_633 = param1;
         var_413 = param2;
         setBadge(var_413);
         _window.visible = true;
      }
      
      private function createWindow() : void
      {
         _window = class_3514(var_319.questEngine.getXmlWindow("AchievementResolutionCompleted"));
         addClickListener("header_button_close");
         addClickListener("cancel_button");
      }
      
      private function addClickListener(param1:String) : void
      {
         var _loc2_:IWindow = _window.findChildByName(param1);
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onMouseClick);
         }
      }
      
      private function onMouseClick(param1:WindowMouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "header_button_close":
            case "cancel_button":
               close();
         }
      }
      
      private function initializeWindow() : void
      {
         _window.center();
      }
      
      private function setBadge(param1:String) : void
      {
         var _loc3_:IWidgetWindow = _window.findChildByName("achievement_badge") as IWidgetWindow;
         var _loc2_:IBadgeImageWidget = _loc3_.widget as IBadgeImageWidget;
         IStaticBitmapWrapperWindow(IWindowContainer(_loc3_.rootWindow).findChildByName("bitmap")).assetUri = "common_loading_icon";
         _loc2_.badgeId = param1;
         _loc3_.visible = true;
      }
      
      public function close() : void
      {
         if(_window)
         {
            _window.visible = false;
         }
      }
   }
}
