package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.IWindow;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   import com.sulake.habbo.communication.messages.outgoing.competition.ForwardToASubmittableRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.competition.class_463;
   import com.sulake.habbo.communication.messages.incoming.competition.class_659;
   
   public class class_3894 extends class_3879
   {
       
      
      private var _submittedKey:String;
      
      private var var_891:String;
      
      private var var_925:Boolean;
      
      private var var_1458:int;
      
      public function class_3894()
      {
         super();
      }
      
      override public function initialize(param1:HabboLandingView, param2:IWindow, param3:Array, param4:GenericWidget) : void
      {
         super.initialize(param1,param2,param3,param4);
         _submittedKey = param3[2];
         var_891 = param3[3];
         param1.communicationManager.addHabboConnectionMessageEvent(new class_659(onInfo));
      }
      
      override public function refresh() : void
      {
         super.refresh();
         landingView.send(new class_463(var_891));
      }
      
      override protected function onClick() : void
      {
         landingView.questEngine.reenableRoomCompetitionWindow();
         if(var_925)
         {
            landingView.navigator.goToPrivateRoom(var_1458);
            landingView.tracking.trackGoogle("landingView","click_submittedroom");
         }
         else
         {
            landingView.send(new ForwardToASubmittableRoomMessageComposer());
            landingView.tracking.trackGoogle("landingView","click_startsubmit");
         }
      }
      
      private function onInfo(param1:class_659) : void
      {
         var_925 = param1.getParser().isPartOf;
         var_1458 = param1.getParser().targetId;
         if(var_925)
         {
            window.caption = "${" + _submittedKey + "}";
         }
      }
   }
}
