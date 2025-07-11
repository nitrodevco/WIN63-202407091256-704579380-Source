package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.SliderWindowController;
   import com.sulake.habbo.roomevents.wired_setup.triggerconfs.class_3612;
   import flash.events.Event;
   
   public class class_3681 extends DefaultConditionType
   {
       
      
      private var _cont:IWindowContainer;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_3345:SliderWindowController;
      
      private var var_3295:SliderWindowController;
      
      public function class_3681()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_3848.CLOCK_TIME_MATCHES;
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _cont = param1;
         _roomEvents = param3;
         var_3345 = new SliderWindowController(param3,getInputSeconds(),param3.assets,0,119,1);
         var_3345.setValue(0);
         var_3345.addEventListener("change",onSliderSecondsChange);
         var_3295 = new SliderWindowController(param3,getInputMinutes(),param3.assets,0,99,1);
         var_3295.setValue(0);
         var_3295.addEventListener("change",onSliderMinutesChange);
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         var _loc3_:int = int(param1.intParams[0]);
         var _loc4_:int = int(param1.intParams[1]);
         var _loc5_:int = int(param1.intParams[2]);
         var_3345.setValue(_loc3_ * 2 + _loc5_);
         var_3295.setValue(_loc4_);
         var _loc2_:int = int(param1.intParams[3]);
         getComparisonSelector().setSelected(getComparisonRadio(_loc2_));
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
         _loc1_.push(getComparisonSelector().getSelected().id);
         return _loc1_;
      }
      
      private function getComparisonRadio(param1:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("comp_" + param1 + "_radio"));
      }
      
      private function getComparisonSelector() : ISelectorWindow
      {
         return ISelectorWindow(_cont.findChildByName("comp_selector"));
      }
      
      private function getInputSeconds() : IWindowContainer
      {
         return _cont.findChildByName("slider_container_seconds") as IWindowContainer;
      }
      
      private function getInputMinutes() : IWindowContainer
      {
         return _cont.findChildByName("slider_container_minutes") as IWindowContainer;
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
