package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.SliderWindowController;
   import flash.events.Event;
   
   public class SelectorFilter extends DefaultAddonType
   {
       
      
      private var _cont:IWindowContainer;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_2973:SliderWindowController;
      
      public function SelectorFilter()
      {
         super();
      }
      
      override public function get isFilter() : Boolean
      {
         return true;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(var_2973.getValue());
         return _loc1_;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _cont = param1;
         _roomEvents = param3;
         var_2973 = new SliderWindowController(param3,sliderContainer,param3.assets,1,1000,1);
         var_2973.setValue(10);
         var_2973.addEventListener("change",onSliderChange);
         textInput.text = "10";
         textInput.addEventListener("WE_CHANGE",onTextInputChange);
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         var _loc2_:int = int(param1.intParams[0]);
         var_2973.setValue(_loc2_);
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function get sliderContainer() : IWindowContainer
      {
         return _cont.findChildByName("slider_container") as IWindowContainer;
      }
      
      protected function onSliderChange(param1:Event) : void
      {
         var _loc2_:SliderWindowController = null;
         var _loc3_:Number = NaN;
         if(param1.type == "change")
         {
            _loc2_ = param1.target as SliderWindowController;
            if(_loc2_)
            {
               _loc3_ = _loc2_.getValue();
               textInput.text = int(_loc3_) + "";
            }
         }
      }
      
      private function get textInput() : ITextFieldWindow
      {
         return ITextFieldWindow(_cont.findChildByName("filter_input"));
      }
      
      private function get amountFromTextInput() : int
      {
         var _loc1_:String = String(textInput.text);
         if(isNaN(Number(_loc1_)))
         {
            return -1;
         }
         return Math.round(Number(_loc1_));
      }
      
      private function onTextInputChange(param1:WindowEvent) : void
      {
         var _loc2_:int = amountFromTextInput;
         if(_loc2_ != -1)
         {
            var_2973.setValue(_loc2_,true,false);
         }
      }
      
      public function get slider() : SliderWindowController
      {
         return var_2973;
      }
   }
}
