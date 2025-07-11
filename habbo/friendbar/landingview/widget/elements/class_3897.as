package com.sulake.habbo.friendbar.landingview.widget.elements
{
    import assets.class_14

    import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.class_3863;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   import com.sulake.habbo.communication.messages.incoming.quest.class_836;
   
   public class class_3897 implements IElementHandler, class_3863
   {
       
      
      private var var_859:IStaticBitmapWrapperWindow;
      
      private var var_149:int;
      
      private var var_554:int;
      
      private var var_608:int;
      
      public function class_3897()
      {
         super();
      }
      
      public function initialize(param1:HabboLandingView, param2:IWindow, param3:Array, param4:GenericWidget) : void
      {
         var_859 = IStaticBitmapWrapperWindow(param2);
         var _loc5_:String = String(param3[1]);
         var_859.assetUri = _loc5_;
         var_859.x = param3.length > 2 ? int(param3[2]) : 0;
         var_859.y = param3.length > 3 ? int(param3[3]) : 0;
         class_14.log("Init Concurrent users meter: " + _loc5_);
         param1.communicationManager.addHabboConnectionMessageEvent(new class_836(onConcurrentUsersGoalProgress));
      }
      
      public function refresh() : void
      {
      }
      
      public function isFloating(param1:Boolean) : Boolean
      {
         return true;
      }
      
      private function onConcurrentUsersGoalProgress(param1:class_836) : void
      {
         var_149 = param1.getParser().state;
         var_554 = param1.getParser().userCount;
         var_608 = param1.getParser().userCountGoal;
         var _loc3_:int = var_554 / var_608 * 100;
         _loc3_ = Math.max(20,Math.min(100,_loc3_));
         _loc3_ = Math.floor(_loc3_ / 10) * 10;
         var _loc2_:String = "challenge_meter_" + _loc3_;
         var_859.assetUri = "${image.library.url}reception/" + _loc2_ + ".png";
         class_14.log("Updating meter: " + _loc2_);
      }
   }
}
