package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.SliderWindowController;
   import flash.events.Event;
   
   public class class_3824 extends DefaultConditionType
   {
       
      
      private var _cont:IWindowContainer;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_3325:SliderWindowController;
      
      public function class_3824()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_3848.USER_LEVEL;
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
         var_3325 = new SliderWindowController(param3,getInputLevel(),param3.assets,1,30,1);
         var_3325.setValue(0);
         var_3325.addEventListener("change",onSliderLevelChange);
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         var _loc3_:int = int(param1.intParams[0]);
         var_3325.setValue(_loc3_);
         var _loc2_:int = int(param1.intParams[1]);
         getComparisonSelector().setSelected(getComparisonRadio(_loc2_));
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(var_3325.getValue());
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
      
      private function getInputLevel() : IWindowContainer
      {
         return _cont.findChildByName("slider_container_level") as IWindowContainer;
      }
      
      private function onSliderLevelChange(param1:Event) : void
      {
         var _loc2_:SliderWindowController = null;
         var _loc3_:Number = NaN;
         if(param1.type == "change")
         {
            _loc2_ = param1.target as SliderWindowController;
            if(_loc2_)
            {
               _loc3_ = _loc2_.getValue();
               _roomEvents.localization.registerParameter("wiredfurni.params.level_selection","level","" + _loc3_);
            }
         }
      }
   }
}
