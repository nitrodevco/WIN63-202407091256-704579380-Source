package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   
   public class class_3734 extends DefaultActionType
   {
       
      
      public function class_3734()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_3849.MOVE_FURNI;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         param3.refreshButton(param1,"move_0",true,null,0);
         param3.refreshButton(param1,"move_2",true,null,0);
         param3.refreshButton(param1,"move_4",true,null,0);
         param3.refreshButton(param1,"move_6",true,null,0);
         param3.refreshButton(param1,"move_diag",true,null,0);
         param3.refreshButton(param1,"move_rnd",true,null,0);
         param3.refreshButton(param1,"move_vrt",true,null,0);
         param3.refreshButton(param1,"rotate_ccw",true,null,0);
         param3.refreshButton(param1,"rotate_cw",true,null,0);
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         var _loc2_:int = int(param1.intParams[0]);
         var _loc3_:int = int(param1.intParams[1]);
         getMoveSelector(cont).setSelected(getMoveRadio(cont,_loc2_));
         getRotateSelector(cont).setSelected(getRotateRadio(cont,_loc3_));
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         var _loc3_:int = int(getMoveSelector(cont).getSelected().id);
         var _loc2_:int = int(getRotateSelector(cont).getSelected().id);
         _loc1_.push(_loc3_);
         _loc1_.push(_loc2_);
         return _loc1_;
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getMoveRadio(param1:IWindowContainer, param2:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(param1.findChildByName("move_" + param2 + "_radio"));
      }
      
      private function getRotateRadio(param1:IWindowContainer, param2:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(param1.findChildByName("rotate_" + param2 + "_radio"));
      }
      
      private function getMoveSelector(param1:IWindowContainer) : ISelectorWindow
      {
         return ISelectorWindow(param1.findChildByName("move_selector"));
      }
      
      private function getRotateSelector(param1:IWindowContainer) : ISelectorWindow
      {
         return ISelectorWindow(param1.findChildByName("rotate_selector"));
      }
   }
}
