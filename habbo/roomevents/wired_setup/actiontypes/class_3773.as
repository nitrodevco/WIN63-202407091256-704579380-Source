package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   
   public class class_3773 extends GiveScore
   {
       
      
      public function class_3773()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_3849.GIVE_SCORE_TO_PREDEFINED_TEAM;
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         super.onEditStart(param1);
         var _loc2_:int = int(param1.intParams[2]);
         getTeamSelector(cont).setSelected(getTeamRadio(cont,_loc2_));
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = super.readIntParamsFromForm();
         _loc1_.push(getTeamSelector(cont).getSelected().id);
         return _loc1_;
      }
      
      private function getTeamRadio(param1:IWindowContainer, param2:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(param1.findChildByName("team_" + param2 + "_radio"));
      }
      
      private function getTeamSelector(param1:IWindowContainer) : ISelectorWindow
      {
         return ISelectorWindow(param1.findChildByName("team_selector"));
      }
   }
}
