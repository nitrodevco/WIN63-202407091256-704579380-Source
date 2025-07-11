package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.window.widgets.class_3570;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   
   public class AchievementResolutionProgressView implements IDisposable
   {
      
      private static const PROGRESSBAR_LEFT:String = "achieved_left";
      
      private static const PROGRESSBAR_MID:String = "achieved_mid";
      
      private static const PROGRESSBAR_RIGHT:String = "achieved_right";
       
      
      private var var_4466:int;
      
      private var var_319:AchievementsResolutionController;
      
      private var _window:class_3514;
      
      private var _stuffId:int;
      
      private var var_435:int;
      
      private var var_413:String;
      
      public function AchievementResolutionProgressView(param1:AchievementsResolutionController)
      {
         super();
         var_319 = param1;
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         var_319 = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_319 == null;
      }
      
      public function get achievementId() : int
      {
         return var_435;
      }
      
      public function get stuffId() : int
      {
         return _stuffId;
      }
      
      public function get visible() : Boolean
      {
         if(!_window)
         {
            return false;
         }
         return _window.visible;
      }
      
      public function show(param1:int, param2:int, param3:String, param4:int, param5:int, param6:int) : void
      {
         if(_window == null)
         {
            createWindow();
         }
         if(param2 != var_435)
         {
            initializeWindow();
            _window.center();
         }
         _stuffId = param1;
         var_435 = param2;
         var_413 = param3;
         setProgress(param4,param5);
         setBadge(var_413);
         setLocalizations();
         setCountdown(param6);
         _window.visible = true;
      }
      
      private function setProgress(param1:int, param2:int) : void
      {
         var _loc3_:Number = Math.min(1,param1 / param2);
         if(_loc3_ > 0)
         {
            _window.setVisibleChildren(true,["achieved_left","achieved_mid"]);
            _window.findChildByName("achieved_right").visible = _loc3_ == 1;
         }
         _window.findChildByName("achieved_mid").width = var_4466 * _loc3_;
         var_319.questEngine.localization.registerParameter("resolution.progress.progress","progress",param1.toString());
         var_319.questEngine.localization.registerParameter("resolution.progress.progress","total",param2.toString());
      }
      
      private function setBadge(param1:String) : void
      {
         var _loc3_:IWidgetWindow = _window.findChildByName("achievement_badge") as IWidgetWindow;
         var _loc2_:IBadgeImageWidget = _loc3_.widget as IBadgeImageWidget;
         IStaticBitmapWrapperWindow(IWindowContainer(_loc3_.rootWindow).findChildByName("bitmap")).assetUri = "common_loading_icon";
         _loc2_.badgeId = param1;
         _loc3_.visible = true;
      }
      
      private function setLocalizations() : void
      {
         _window.findChildByName("achievement.name").caption = var_319.questEngine.localization.getBadgeName(var_413);
         _window.findChildByName("achievement.desc").caption = var_319.questEngine.localization.getBadgeDesc(var_413);
      }
      
      private function setCountdown(param1:int) : void
      {
         var _loc2_:IWidgetWindow = IWidgetWindow(_window.findChildByName("time_left_widget"));
         var _loc3_:class_3570 = class_3570(_loc2_.widget);
         _loc3_.seconds = param1;
         _loc3_.running = true;
      }
      
      private function createWindow() : void
      {
         _window = class_3514(var_319.questEngine.getXmlWindow("AchievementResolutionProgress"));
         _window.findChildByTag("close").procedure = onWindowClose;
         _window.findChildByName("reset_button").procedure = onResetButton;
         var_4466 = _window.findChildByName("achieved_mid").width;
      }
      
      private function initializeWindow() : void
      {
         _window.center();
         _window.setVisibleChildren(false,["achieved_left","achieved_mid","achieved_right"]);
      }
      
      public function close() : void
      {
         if(_window)
         {
            _window.visible = false;
         }
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            close();
         }
      }
      
      private function onResetButton(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var_319.resetResolution(_stuffId);
            close();
         }
      }
   }
}
