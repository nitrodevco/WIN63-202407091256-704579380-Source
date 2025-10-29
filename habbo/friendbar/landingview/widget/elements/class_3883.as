package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.ILayoutNameProvider;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.class_3860;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.class_3863;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   import com.sulake.habbo.window.widgets.IRunningNumberWidget;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.outgoing.quest.GetCommunityGoalProgressMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.quest.class_1678;
   import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalProgressMessageEvent;
   
   public class class_3883 implements IElementHandler, IDisposable, class_3863, ILayoutNameProvider, class_3860
   {
       
      
      private var _landingView:HabboLandingView;
      
      private var _window:IWindowContainer;
      
      private var var_4033:Boolean;
      
      private var var_2551:Timer;
      
      private var var_3729:Boolean;
      
      public function class_3883()
      {
         super();
      }
      
      public function dispose() : void
      {
         if(_landingView)
         {
            _landingView.communicationManager.removeHabboConnectionMessageEvent(new CommunityGoalProgressMessageEvent(onCommunityGoalProgress));
            _landingView = null;
         }
         if(var_2551)
         {
            var_2551.stop();
            var_2551.removeEventListener("timer",onPollTimer);
            var_2551 = null;
         }
         _window = null;
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      public function initialize(param1:HabboLandingView, param2:IWindow, param3:Array, param4:GenericWidget) : void
      {
         _landingView = param1;
         _window = IWindowContainer(param2);
         var _loc7_:int = int(param3[1]);
         var _loc6_:int = int(param3[2]);
         var _loc8_:int = int(param3[3]);
         var_4033 = param3[4] == "true";
         var _loc5_:IWidgetWindow = IWidgetWindow(_window.findChildByName("running_number_widget"));
         var _loc9_:IRunningNumberWidget;
         (_loc9_ = IRunningNumberWidget(_loc5_.widget)).digits = _loc7_;
         _loc9_.updateFrequency = _loc6_;
         if(var_4033)
         {
            _window.x = int(param3[5]);
            _window.y = int(param3[6]);
         }
         _landingView.communicationManager.addHabboConnectionMessageEvent(new CommunityGoalProgressMessageEvent(onCommunityGoalProgress));
         var_2551 = new Timer(_loc8_);
         var_2551.addEventListener("timer",onPollTimer);
      }
      
      public function disable() : void
      {
         var_2551.stop();
      }
      
      public function refresh() : void
      {
         _landingView.send(new GetCommunityGoalProgressMessageComposer());
         var_3729 = false;
         var_2551.start();
      }
      
      public function isFloating(param1:Boolean) : Boolean
      {
         return var_4033;
      }
      
      public function get layoutName() : String
      {
         return "element_community_goal_score";
      }
      
      private function onCommunityGoalProgress(param1:CommunityGoalProgressMessageEvent) : void
      {
         var _loc4_:class_1678 = null;
         var _loc2_:IWidgetWindow = null;
         var _loc3_:IRunningNumberWidget = null;
         if(_landingView)
         {
            _loc4_ = param1.getParser().data;
            _loc2_ = IWidgetWindow(_window.findChildByName("running_number_widget"));
            _loc3_ = IRunningNumberWidget(_loc2_.widget);
            if(var_3729)
            {
               _loc3_.number = _loc4_.communityTotalScore;
            }
            else
            {
               _loc3_.initialNumber = _loc4_.communityTotalScore;
               var_3729 = true;
            }
         }
      }
      
      private function onPollTimer(param1:TimerEvent) : void
      {
         _landingView.send(new GetCommunityGoalProgressMessageComposer());
      }
   }
}
