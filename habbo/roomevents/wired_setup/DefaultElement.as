package com.sulake.habbo.roomevents.wired_setup
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import com.sulake.habbo.communication.messages.incoming.users.class_596;
   
   public class DefaultElement implements class_3531
   {
      
      public static var INPUTS_TYPE_NONE:int = 0;
      
      public static var INPUTS_TYPE_LEGACY_UI:int = 1;
      
      public static var INPUTS_TYPE_UI_BUILDER:int = 2;
       
      
      private var _cont:IWindowContainer;
      
      private var _advancedCont:IWindowContainer;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      public function DefaultElement()
      {
         super();
      }
      
      public function get code() : int
      {
         return -1;
      }
      
      public function get negativeCode() : int
      {
         return -1;
      }
      
      public function get hasStateSnapshot() : Boolean
      {
         return false;
      }
      
      public function readIntParamsFromForm() : Array
      {
         return [];
      }
      
      public function readVariableIdsFromForm() : Array
      {
         return [];
      }
      
      public function readStringParamFromForm() : String
      {
         return "";
      }
      
      public function setRoomEvents(param1:HabboUserDefinedRoomEvents) : void
      {
         _roomEvents = param1;
      }
      
      public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         _cont = param1;
         _advancedCont = param2;
         _roomEvents = param3;
      }
      
      public function isInitialized() : Boolean
      {
         return _roomEvents != null;
      }
      
      public function onEditStart(param1:class_1659) : void
      {
      }
      
      public function onEditInitialized() : void
      {
      }
      
      public function onEditEnd() : void
      {
         if(roomEvents != null)
         {
            for each(var _loc1_ in roomEvents.userDefinedRoomEventsCtrl.mergedSourcePickers)
            {
               _loc1_.restoreLayout();
            }
         }
      }
      
      public function validate() : String
      {
         return null;
      }
      
      public function onGuildMemberships(param1:class_596) : void
      {
      }
      
      public function furniSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.furni.title";
      }
      
      public function userSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.users.title";
      }
      
      public function get forceFurniSelection() : Boolean
      {
         return hasStateSnapshot;
      }
      
      public function mergedSelections() : Array
      {
         return [];
      }
      
      public function mergedSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.merged.title";
      }
      
      public function setMergedType(param1:int, param2:int) : void
      {
      }
      
      public function getMergedType(param1:int) : int
      {
         return 0;
      }
      
      public function isInputSourceDisabled(param1:int, param2:int) : Boolean
      {
         return false;
      }
      
      public function getCustomSourcesForMergedType(param1:int) : Array
      {
         return [];
      }
      
      public function get forceHidePickFurniInstructions() : Boolean
      {
         return false;
      }
      
      public function advancedAlwaysVisible() : Boolean
      {
         return false;
      }
      
      public function get usingCustomAdvancedSettings() : Boolean
      {
         return false;
      }
      
      public function get requireConfirmation() : Object
      {
         return null;
      }
      
      protected function get legacyInputMode() : Boolean
      {
         return false;
      }
      
      protected function get legacyAdvancedInputMode() : Boolean
      {
         return false;
      }
      
      public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
      }
      
      public function buildAdvancedInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
      }
      
      public function get inputMode() : int
      {
         if(legacyInputMode)
         {
            return INPUTS_TYPE_LEGACY_UI;
         }
         return INPUTS_TYPE_NONE;
      }
      
      public function get advancedInputMode() : int
      {
         if(legacyAdvancedInputMode)
         {
            return INPUTS_TYPE_LEGACY_UI;
         }
         return INPUTS_TYPE_NONE;
      }
      
      protected function get cont() : IWindowContainer
      {
         return _cont;
      }
      
      protected function get advancedCont() : IWindowContainer
      {
         return _advancedCont;
      }
      
      protected function get roomEvents() : HabboUserDefinedRoomEvents
      {
         return _roomEvents;
      }
      
      protected function get roomEventsCtrl() : UserDefinedRoomEventsCtrl
      {
         return _roomEvents.userDefinedRoomEventsCtrl;
      }
      
      protected function loc(param1:String) : String
      {
         return _roomEvents.localization.getLocalization(param1,param1);
      }
   }
}
