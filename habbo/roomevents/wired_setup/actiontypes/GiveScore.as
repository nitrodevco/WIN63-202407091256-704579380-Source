package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.SliderWindowController;
   import flash.events.Event;
   
   public class GiveScore extends DefaultActionType
   {
      
      private static var var_4941:Number = 10;
      
      private static var var_3476:Number = var_4941 + 1;
       
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_2973:SliderWindowController;
      
      private var var_3112:SliderWindowController;
      
      private var _cont:IWindowContainer;
      
      public function GiveScore()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_3849.GIVE_SCORE;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(getScore());
         _loc1_.push(var_3112.getValue() == var_3476 ? 0 : var_3112.getValue());
         return _loc1_;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _roomEvents = param3;
         _cont = param1;
         getTypeSelector().setSelected(getTypeRadio(0));
         var_2973 = new SliderWindowController(param3,getInput(),param3.assets,1,1000,1);
         var_2973.addEventListener("change",onSliderChange);
         var_2973.setValue(1);
         getTypeRadio(0).addEventListener("WE_SELECT",onTypeChange);
         getTypeRadio(1).addEventListener("WE_SELECT",onTypeChange);
         var_3112 = new SliderWindowController(param3,getCounterInput(),param3.assets,1,var_3476,1);
         var_3112.addEventListener("change",onCounterSliderChange);
         var_3112.setValue(1);
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         var _loc2_:int = int(param1.intParams[0]);
         var _loc3_:int = int(param1.intParams[1]);
         var _loc4_:int = 0;
         if(_loc2_ < 0)
         {
            _loc2_ = -_loc2_;
            _loc4_ = 1;
         }
         getTypeSelector().setSelected(getTypeRadio(_loc4_));
         var_2973.setValue(_loc2_);
         var_3112.setValue(_loc3_ == 0 ? var_3476 : _loc3_);
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getInput() : IWindowContainer
      {
         return _cont.findChildByName("slider_container") as IWindowContainer;
      }
      
      private function getCounterInput() : IWindowContainer
      {
         return _cont.findChildByName("counter_slider_container") as IWindowContainer;
      }
      
      private function onSliderChange(param1:Event) : void
      {
         var _loc2_:SliderWindowController = null;
         if(param1.type == "change")
         {
            _loc2_ = param1.target as SliderWindowController;
            if(_loc2_)
            {
               updateSliderText();
            }
         }
      }
      
      private function onTypeChange(param1:WindowEvent) : void
      {
         updateSliderText();
      }
      
      private function updateSliderText() : void
      {
         var _loc1_:int = getScore();
         _roomEvents.localization.registerParameter("wiredfurni.params.setpoints","points","" + _loc1_);
      }
      
      private function getScore() : int
      {
         var _loc1_:int = var_2973.getValue();
         if(getTypeSelector().getSelected().id == 1)
         {
            _loc1_ = -_loc1_;
         }
         return _loc1_;
      }
      
      private function onCounterSliderChange(param1:Event) : void
      {
         var _loc2_:SliderWindowController = null;
         var _loc3_:Number = NaN;
         var _loc4_:String = null;
         if(param1.type == "change")
         {
            _loc2_ = param1.target as SliderWindowController;
            if(_loc2_)
            {
               _loc3_ = _loc2_.getValue();
               _loc4_ = int(_loc3_) == var_3476 ? "∞" : "" + int(_loc3_);
               _roomEvents.localization.registerParameter("wiredfurni.params.settimesingame","times",_loc4_);
            }
         }
      }
      
      private function getTypeRadio(param1:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("type_" + param1 + "_radio"));
      }
      
      private function getTypeSelector() : ISelectorWindow
      {
         return ISelectorWindow(_cont.findChildByName("type_selector"));
      }
   }
}
