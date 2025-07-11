package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   
   public class class_3765 extends DefaultConditionType
   {
       
      
      private var _cont:IWindowContainer;
      
      public function class_3765()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_3848.TEAM_IS_WINNING;
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         _cont = cont;
         var _loc3_:int = int(param1.intParams[0]);
         var _loc2_:int = int(param1.intParams[1]);
         getTeamSelector().setSelected(getTeamRadio(_loc3_));
         getPlacementSelector().setSelected(getPlacementRadio(_loc2_));
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(getTeamSelector().getSelected().id);
         _loc1_.push(getPlacementSelector().getSelected().id);
         return _loc1_;
      }
      
      private function getTeamRadio(param1:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("team_" + param1 + "_radio"));
      }
      
      private function getTeamSelector() : ISelectorWindow
      {
         return ISelectorWindow(_cont.findChildByName("team_selector"));
      }
      
      private function getPlacementRadio(param1:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("placement_" + param1 + "_radio"));
      }
      
      private function getPlacementSelector() : ISelectorWindow
      {
         return ISelectorWindow(_cont.findChildByName("placement_selector"));
      }
   }
}
