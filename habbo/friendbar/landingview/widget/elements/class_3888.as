package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.IWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredRewardResultMessageEvent;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.class_3863;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   import com.sulake.habbo.communication.messages.incoming.inventory.badges.IsBadgeRequestFulfilledEvent;
   import com.sulake.habbo.communication.messages.outgoing.inventory.badges.GetIsBadgeRequestFulfilledComposer;
   
   public class class_3888 extends class_3879 implements class_3863
   {
       
      
      private var var_3083:String;
      
      private var var_4485:Boolean = true;
      
      public function class_3888()
      {
         super();
      }
      
      override public function initialize(param1:HabboLandingView, param2:IWindow, param3:Array, param4:GenericWidget) : void
      {
         super.initialize(param1,param2,param3,param4);
         var_3083 = param3[2];
         param2.x = int(param3[3]);
         param2.y = int(param3[4]);
         if(param3.length > 5)
         {
            var_4485 = param3[5] == "true";
         }
         param1.communicationManager.addHabboConnectionMessageEvent(new IsBadgeRequestFulfilledEvent(onInfo));
         param1.communicationManager.addHabboConnectionMessageEvent(new WiredRewardResultMessageEvent(onReward));
      }
      
      override protected function onClick() : void
      {
         landingView.requestBadge(var_3083);
         landingView.tracking.trackGoogle("landingView","click_requestbadge_" + var_3083);
      }
      
      override public function refresh() : void
      {
         super.refresh();
         landingView.send(new GetIsBadgeRequestFulfilledComposer(var_3083));
      }
      
      public function isFloating(param1:Boolean) : Boolean
      {
         return var_4485;
      }
      
      private function onInfo(param1:IsBadgeRequestFulfilledEvent) : void
      {
         if(param1.getParser().requestCode == var_3083)
         {
            window.visible = !param1.getParser().fulfilled;
         }
      }
      
      private function onReward(param1:WiredRewardResultMessageEvent) : void
      {
         if(window)
         {
            landingView.send(new GetIsBadgeRequestFulfilledComposer(var_3083));
         }
      }
   }
}
