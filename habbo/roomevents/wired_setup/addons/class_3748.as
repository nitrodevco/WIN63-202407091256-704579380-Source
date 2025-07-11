package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   
   public class class_3748 extends class_3690
   {
       
      
      public function class_3748()
      {
         super();
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         getPlaceholderRadio(1).addEventListener("WE_SELECTED",onUseDelimiterSelect);
         getPlaceholderRadio(1).addEventListener("WE_UNSELECTED",onUseDelimiterUnselect);
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         super.onEditStart(param1);
         placeholderType = param1.intParams[0];
         var _loc2_:Array = param1.stringParam.split("\t");
         placeholderName = _loc2_[0];
         delimiterInput.text = _loc2_.length > 1 ? _loc2_[1] : "";
      }
      
      override public function readStringParamFromForm() : String
      {
         if(placeholderType == 0)
         {
            return placeholderNameWindow.text;
         }
         return placeholderNameWindow.text + "\t" + delimiterInput.text;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [placeholderType];
      }
      
      private function onUseDelimiterSelect(param1:WindowEvent) : void
      {
         Util.disableSection(delimiterSelection,false);
      }
      
      private function onUseDelimiterUnselect(param1:WindowEvent) : void
      {
         Util.disableSection(delimiterSelection,true);
      }
      
      protected function get placeholderType() : int
      {
         return placeholderSelector.getSelected().id;
      }
      
      protected function set placeholderType(param1:int) : void
      {
         Util.disableSection(delimiterSelection,param1 != 1);
         placeholderSelector.setSelected(getPlaceholderRadio(param1));
      }
      
      protected function getPlaceholderRadio(param1:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(cont.findChildByName("placeholder_" + param1 + "_radio"));
      }
      
      protected function getPlaceholderText(param1:int) : ITextWindow
      {
         return ITextWindow(cont.findChildByName("placeholder_" + param1 + "_text"));
      }
      
      private function get placeholderSelector() : ISelectorWindow
      {
         return ISelectorWindow(cont.findChildByName("placeholder_selector"));
      }
      
      private function get delimiterSelection() : IItemListWindow
      {
         return IItemListWindow(cont.findChildByName("delimiter_selection"));
      }
      
      private function get delimiterInput() : ITextFieldWindow
      {
         return ITextFieldWindow(cont.findChildByName("value_input"));
      }
   }
}
