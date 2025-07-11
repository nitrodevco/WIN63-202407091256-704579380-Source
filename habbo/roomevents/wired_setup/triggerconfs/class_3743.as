package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_3398;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   
   public class class_3743 extends DefaultTriggerConf
   {
       
      
      private var _cont:IWindowContainer;
      
      public function class_3743()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_3782.AVATAR_SAYS_SOMETHING;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _cont = param1;
         allMatchRadio.addEventListener("WE_SELECTED",disableTextInput);
         allMatchRadio.addEventListener("WE_UNSELECTED",enableTextInput);
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(!!onlyOwnerCheckbox.isSelected ? 1 : 0);
         _loc1_.push(triggerTypeSelector.getSelected().id);
         _loc1_.push(!!hideMessageCheckbox.isSelected ? 1 : 0);
         return _loc1_;
      }
      
      override public function readStringParamFromForm() : String
      {
         return input.text;
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         input.text = param1.stringParam;
         var _loc2_:Array = param1.intParams;
         var _loc3_:* = _loc2_[0] != 0;
         var _loc5_:int = int(_loc2_[1]);
         var _loc4_:* = _loc2_[2] != 0;
         Util.select(onlyOwnerCheckbox,_loc3_);
         Util.select(hideMessageCheckbox,_loc4_);
         enableTextInput();
         if(_loc5_ == 0)
         {
            triggerTypeSelector.setSelected(chatContainsRadio);
         }
         else if(_loc5_ == 1)
         {
            triggerTypeSelector.setSelected(exactMatchRadio);
         }
         else
         {
            triggerTypeSelector.setSelected(allMatchRadio);
            disableTextInput();
         }
      }
      
      private function enableTextInput(param1:WindowEvent = null) : void
      {
         Util.disableSection(input,false);
      }
      
      private function disableTextInput(param1:WindowEvent = null) : void
      {
         Util.disableSection(input,true);
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function get input() : ITextFieldWindow
      {
         return ITextFieldWindow(_cont.findChildByName("chat_txt"));
      }
      
      private function get chatContainsRadio() : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("chat_contains_radio"));
      }
      
      private function get exactMatchRadio() : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("exact_match_radio"));
      }
      
      private function get allMatchRadio() : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("all_match_radio"));
      }
      
      private function get triggerTypeSelector() : ISelectorWindow
      {
         return ISelectorWindow(_cont.findChildByName("triggertype_radio"));
      }
      
      private function get onlyOwnerCheckbox() : class_3398
      {
         return class_3398(_cont.findChildByName("only_owner_checkbox"));
      }
      
      private function get hideMessageCheckbox() : class_3398
      {
         return class_3398(_cont.findChildByName("hide_message_checkbox"));
      }
   }
}
