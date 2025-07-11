package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.SliderWindowController;
   import flash.events.Event;
   
   public class ClockReachTime extends DefaultTriggerConf
   {
       
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_3345:SliderWindowController;
      
      private var var_3295:SliderWindowController;
      
      public function ClockReachTime()
      {
         super();
      }
      
      private static function getInputSeconds(param1:IWindowContainer) : IWindowContainer
      {
         return param1.findChildByName("slider_container_seconds") as IWindowContainer;
      }
      
      private static function getInputMinutes(param1:IWindowContainer) : IWindowContainer
      {
         return param1.findChildByName("slider_container_minutes") as IWindowContainer;
      }
      
      override public function get code() : int
      {
         return class_3782.CLOCK_REACH_TIME;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         var _loc4_:Number = var_3345.getValue();
         var _loc2_:int = Math.floor(_loc4_ / 2);
         var _loc3_:int = _loc4_ % 2;
         _loc1_.push(_loc2_);
         _loc1_.push(var_3295.getValue());
         _loc1_.push(_loc3_);
         return _loc1_;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _roomEvents = param3;
         var_3345 = new SliderWindowController(param3,getInputSeconds(param1),param3.assets,0,119,1);
         var_3345.setValue(0);
         var_3345.addEventListener("change",onSliderSecondsChange);
         var_3295 = new SliderWindowController(param3,getInputMinutes(param1),param3.assets,0,99,1);
         var_3295.setValue(0);
         var_3295.addEventListener("change",onSliderMinutesChange);
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         var _loc2_:int = int(param1.intParams[0]);
         var _loc3_:int = int(param1.intParams[1]);
         var _loc4_:int = int(param1.intParams[2]);
         var_3345.setValue(_loc2_ * 2 + _loc4_);
         var_3295.setValue(_loc3_);
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function onSliderSecondsChange(param1:Event) : void
      {
         var _loc2_:SliderWindowController = null;
         var _loc5_:Number = NaN;
         var _loc4_:int = 0;
         var _loc3_:String = null;
         if(param1.type == "change")
         {
            _loc2_ = param1.target as SliderWindowController;
            if(_loc2_)
            {
               _loc4_ = _loc5_ = _loc2_.getValue();
               _loc3_ = class_3612.getSecsFromPulses(_loc4_);
               _roomEvents.localization.registerParameter("wiredfurni.params.clock_seconds_elapsed","seconds","" + _loc3_);
            }
         }
      }
      
      private function onSliderMinutesChange(param1:Event) : void
      {
         var _loc2_:SliderWindowController = null;
         var _loc4_:Number = NaN;
         var _loc3_:int = 0;
         if(param1.type == "change")
         {
            _loc2_ = param1.target as SliderWindowController;
            if(_loc2_)
            {
               _loc3_ = _loc4_ = _loc2_.getValue();
               _roomEvents.localization.registerParameter("wiredfurni.params.clock_minutes_elapsed","minutes","" + _loc3_);
            }
         }
      }
   }
}
