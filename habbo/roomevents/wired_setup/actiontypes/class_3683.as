package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   
   public class class_3683 extends DefaultActionType
   {
       
      
      public function class_3683()
      {
         super();
      }
      
      private static function getModeRadio(param1:IWindowContainer, param2:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(param1.findChildByName("mode_" + param2 + "_radio"));
      }
      
      private static function getModeSelector(param1:IWindowContainer) : ISelectorWindow
      {
         return ISelectorWindow(param1.findChildByName("mode_selector"));
      }
      
      override public function get code() : int
      {
         return class_3849.MOVE_USER_TO_FURNI;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(getModeSelector(cont).getSelected().id);
         return _loc1_;
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         var _loc2_:int = int(param1.intParams[0]);
         getModeSelector(cont).setSelected(getModeRadio(cont,_loc2_));
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      override public function furniSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.furni.title.mv.1";
      }
      
      override public function userSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.furni.title.mv_user2";
      }
      
      override public function advancedAlwaysVisible() : Boolean
      {
         return true;
      }
   }
}
