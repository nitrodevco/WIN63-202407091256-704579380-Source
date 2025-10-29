package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.IWindow;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   import com.sulake.habbo.communication.messages.outgoing.competition.GetSecondsUntilMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.competition.SecondsUntilMessageEvent;
   
   public class class_3887 extends class_3886
   {
       
      
      private var var_1191:String;
      
      public function class_3887()
      {
         super();
      }
      
      override public function initialize(param1:HabboLandingView, param2:IWindow, param3:Array, param4:GenericWidget) : void
      {
         super.initialize(param1,param2,param3,param4);
         var_1191 = param3[6];
         param1.communicationManager.addHabboConnectionMessageEvent(new SecondsUntilMessageEvent(onTime));
      }
      
      override public function refresh() : void
      {
         landingView.send(new GetSecondsUntilMessageComposer(var_1191));
      }
      
      private function onTime(param1:SecondsUntilMessageEvent) : void
      {
         if(param1.getParser().timeStr == var_1191)
         {
            setTimer(param1.getParser().secondsUntil);
         }
      }
   }
}
