package com.sulake.habbo.roomevents.wired_setup.selectors
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   
   public class class_3816 extends DefaultSelectorType
   {
       
      
      private var _cont:IWindowContainer;
      
      public function class_3816()
      {
         super();
      }
      
      override public function get code() : int
      {
         return SelectorCodes.USERS_BY_TYPE;
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _cont = param1;
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         var _loc2_:int = int(param1.intParams[0]);
         getUserTypeSelector().setSelected(getUserTypeRadio(_loc2_));
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(getUserTypeSelector().getSelected().id);
         return _loc1_;
      }
      
      private function getUserTypeRadio(param1:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("usertype_" + param1 + "_radio"));
      }
      
      private function getUserTypeSelector() : ISelectorWindow
      {
         return ISelectorWindow(_cont.findChildByName("usertype_selector"));
      }
   }
}
