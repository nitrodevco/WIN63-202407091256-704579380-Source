package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.SliderWindowController;
   import flash.events.Event;
   
   public class class_3682 extends DefaultConditionType
   {
       
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_3395:SliderWindowController;
      
      private var var_3321:SliderWindowController;
      
      public function class_3682()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_3848.USER_COUNT_IN;
      }
      
      override public function get negativeCode() : int
      {
         return class_3848.NOT_USER_COUNT_IN;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(var_3395.getValue());
         _loc1_.push(var_3321.getValue());
         return _loc1_;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _roomEvents = param3;
         var_3395 = new SliderWindowController(param3,getMinInput(param1),param3.assets,0,125,1);
         var_3395.addEventListener("change",onMinSliderChange);
         var_3395.setValue(1);
         var_3321 = new SliderWindowController(param3,getMaxInput(param1),param3.assets,0,125,1);
         var_3321.addEventListener("change",onMaxSliderChange);
         var_3321.setValue(50);
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         var _loc2_:int = int(param1.intParams[0]);
         var _loc3_:int = int(param1.intParams[1]);
         var_3395.setValue(_loc2_);
         var_3321.setValue(_loc3_);
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getMinInput(param1:IWindowContainer) : IWindowContainer
      {
         return param1.findChildByName("min_slider_container") as IWindowContainer;
      }
      
      private function getMaxInput(param1:IWindowContainer) : IWindowContainer
      {
         return param1.findChildByName("max_slider_container") as IWindowContainer;
      }
      
      private function onMinSliderChange(param1:Event) : void
      {
         var _loc2_:SliderWindowController = null;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         if(param1.type == "change")
         {
            _loc2_ = param1.target as SliderWindowController;
            if(_loc2_)
            {
               _loc3_ = _loc2_.getValue();
               _loc4_ = _loc3_;
               _roomEvents.localization.registerParameter("wiredfurni.params.usercountmin","value","" + _loc4_);
            }
         }
      }
      
      private function onMaxSliderChange(param1:Event) : void
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
               _roomEvents.localization.registerParameter("wiredfurni.params.usercountmax","value","" + _loc3_);
            }
         }
      }
   }
}
