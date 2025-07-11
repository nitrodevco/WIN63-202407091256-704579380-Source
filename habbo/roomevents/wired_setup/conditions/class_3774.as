package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.SliderWindowController;
   import com.sulake.habbo.roomevents.wired_setup.triggerconfs.*;
   import flash.events.Event;
   
   public class class_3774 extends DefaultConditionType
   {
       
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_2973:SliderWindowController;
      
      public function class_3774()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_3848.TIME_ELAPSED_MORE;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:int = var_2973.getValue();
         _loc1_.push(_loc2_ + 1);
         return _loc1_;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _roomEvents = param3;
         var_2973 = new SliderWindowController(param3,getInput(param1),param3.assets,1,1200,1);
         var_2973.setValue(1);
         var_2973.addEventListener("change",onSliderChange);
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         var _loc2_:int = param1.intParams[0] - 1;
         var_2973.setValue(_loc2_);
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getInput(param1:IWindowContainer) : IWindowContainer
      {
         return param1.findChildByName("slider_container") as IWindowContainer;
      }
      
      private function onSliderChange(param1:Event) : void
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
               _roomEvents.localization.registerParameter("wiredfurni.params.allowafter","seconds",_loc3_);
            }
         }
      }
   }
}
