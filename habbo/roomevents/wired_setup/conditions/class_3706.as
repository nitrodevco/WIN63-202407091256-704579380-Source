package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   
   public class class_3706 extends DefaultConditionType
   {
       
      
      private var _cont:IWindowContainer;
      
      public function class_3706()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_3848.TRIGGERER_MATCHES;
      }
      
      override public function get negativeCode() : int
      {
         return class_3848.NOT_TRIGGERER_MATCHES;
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _cont = param1;
         getCertainAvatarRadio().addEventListener("WE_SELECT",onCertainAvatarSelect);
         getCertainAvatarRadio().addEventListener("WE_UNSELECT",onCertainAvatarUnselect);
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         var _loc2_:int = int(param1.intParams[0]);
         getUserTypeSelector().setSelected(getUserTypeRadio(_loc2_));
         if(param1.stringParam != "")
         {
            getUserNameSelector().setSelected(getCertainAvatarRadio());
            getUserNameInput().text = param1.stringParam;
            getUserNameInput().visible = true;
         }
         else
         {
            getUserNameSelector().setSelected(getAnyAvatarRadio());
            getUserNameInput().text = "";
            getUserNameInput().visible = false;
         }
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(getUserTypeSelector().getSelected().id);
         return _loc1_;
      }
      
      override public function readStringParamFromForm() : String
      {
         var _loc1_:String = String(getUserNameInput().text);
         return !!getCertainAvatarRadio().isSelected ? _loc1_ : "";
      }
      
      private function getUserTypeRadio(param1:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("usertype_" + param1 + "_radio"));
      }
      
      private function getUserTypeSelector() : ISelectorWindow
      {
         return ISelectorWindow(_cont.findChildByName("usertype_selector"));
      }
      
      private function getUserNameInput() : ITextFieldWindow
      {
         return ITextFieldWindow(_cont.findChildByName("avatar_name_txt"));
      }
      
      private function getCertainAvatarRadio() : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("certain_avatar_radio"));
      }
      
      private function getAnyAvatarRadio() : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("any_avatar_radio"));
      }
      
      private function getUserNameSelector() : ISelectorWindow
      {
         return ISelectorWindow(_cont.findChildByName("avatar_radio"));
      }
      
      private function onCertainAvatarSelect(param1:WindowEvent) : void
      {
         getUserNameInput().visible = true;
      }
      
      private function onCertainAvatarUnselect(param1:WindowEvent) : void
      {
         getUserNameInput().text = "";
         getUserNameInput().visible = false;
      }
      
      override public function userSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.users.title.match." + param1;
      }
   }
}
