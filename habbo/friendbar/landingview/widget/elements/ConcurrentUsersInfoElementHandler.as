package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.outgoing.quest.GetConcurrentUsersGoalProgressMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.quest.GetConcurrentUsersRewardMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.quest.ConcurrentUsersGoalProgressMessageEvent;
   
   public class ConcurrentUsersInfoElementHandler implements IElementHandler, IDisposable
   {
      
      private static const STATE_DISABLED:int = 0;
      
      private static const STATE_ACTIVE:int = 1;
      
      private static const STATE_REDEEM:int = 2;
      
      private static const STATE_REWARDED:int = 3;
      
      private static const UPDATE_INTERVAL_MS:int = 5000;
       
      
      private var _landingView:HabboLandingView;
      
      private var var_1629:GenericWidget;
      
      private var _localizationKey:String;
      
      private var var_149:int = -1;
      
      private var var_554:int = -1;
      
      private var var_608:int = -1;
      
      private var _window:IWindowContainer;
      
      private var var_1794:Timer;
      
      private var var_318:Boolean = false;
      
      public function ConcurrentUsersInfoElementHandler()
      {
         super();
         var_1794 = new Timer(5000);
         var_1794.addEventListener("timer",onUpdateTimer);
      }
      
      private function onUpdateTimer(param1:TimerEvent) : void
      {
         if(_window == null || _window.visible == false || !_landingView.isLandingViewVisible)
         {
            return;
         }
         refresh();
      }
      
      public function dispose() : void
      {
         if(var_1794)
         {
            var_1794.stop();
         }
         var_1794 = null;
         var_318 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      public function initialize(param1:HabboLandingView, param2:IWindow, param3:Array, param4:GenericWidget) : void
      {
         var_1629 = param4;
         _landingView = param1;
         _window = param2 as IWindowContainer;
         _localizationKey = param3[1];
         _window.findChildByName("users_desc").caption = "${" + _localizationKey + "}";
         var _loc5_:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(_window.findChildByName("badge_image"));
         var _loc6_:String = String(param3.length > 2 ? param3[2] : "ConcurrentUsersReward");
         var _loc7_:String = "${image.library.url}album1584/" + _loc6_ + ".png";
         _loc5_.assetUri = _loc7_;
         updateLocalization();
         param2.procedure = onButton;
         param1.communicationManager.addHabboConnectionMessageEvent(new ConcurrentUsersGoalProgressMessageEvent(onConcurrentUsersGoalProgress));
         var_1794.start();
      }
      
      public function refresh() : void
      {
         _landingView.send(new GetConcurrentUsersGoalProgressMessageComposer());
      }
      
      private function updateLocalization() : void
      {
         var _loc4_:String = "landing.view.concurrentusers.caption";
         var _loc3_:String = "landing.view.concurrentusers.bodytext";
         _landingView.windowManager.registerLocalizationParameter(_localizationKey,"userCount",var_554.toString());
         _landingView.windowManager.registerLocalizationParameter(_localizationKey,"userGoal",var_608.toString());
         _landingView.windowManager.registerLocalizationParameter("landing.view.concurrentusers.bodytext","userCount",var_554.toString());
         _landingView.windowManager.registerLocalizationParameter("landing.view.concurrentusers.bodytext","userGoal",var_608.toString());
         _landingView.windowManager.registerLocalizationParameter("landing.view.concurrentusers.bodytext","domain",_landingView.localizationManager.getLocalization("landing.view.hotel.domain","Habbo"));
         switch(var_149)
         {
            case 0:
               _window.findChildByName("state.active").visible = true;
               _window.findChildByName("state.achieved").visible = false;
               break;
            case 1:
               _window.findChildByName("state.active").visible = true;
               _window.findChildByName("state.achieved").visible = false;
               break;
            case 2:
               if(var_1794)
               {
                  var_1794.stop();
               }
               _loc4_ += ".success";
               _loc3_ += ".success";
               _window.findChildByName("state.active").visible = false;
               _window.findChildByName("state.active").enable();
               _window.findChildByName("state.achieved").visible = true;
               _window.findChildByName("action_button").visible = true;
               break;
            case 3:
               if(var_1794)
               {
                  var_1794.stop();
               }
               _loc4_ += ".success";
               _loc3_ += ".success";
               _window.findChildByName("state.active").visible = false;
               _window.findChildByName("state.achieved").visible = true;
               _window.findChildByName("action_button").visible = false;
         }
         var _loc1_:class_3877 = var_1629.getElementByName("bodytext") as class_3877;
         if(_loc1_)
         {
            _loc1_.localizationKey = _loc3_;
         }
         var _loc2_:class_3877 = var_1629.getElementByName("caption") as class_3877;
         if(_loc2_)
         {
            _loc2_.localizationKey = _loc4_;
         }
      }
      
      private function onConcurrentUsersGoalProgress(param1:ConcurrentUsersGoalProgressMessageEvent) : void
      {
         var_149 = param1.getParser().state;
         var_554 = param1.getParser().userCount;
         var_608 = param1.getParser().userCountGoal;
         updateLocalization();
      }
      
      private function onButton(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            onClick();
         }
      }
      
      protected function onClick() : void
      {
         _landingView.send(new GetConcurrentUsersRewardMessageComposer());
         _landingView.send(new GetConcurrentUsersGoalProgressMessageComposer());
         _window.findChildByName("state.active").disable();
      }
   }
}
