package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   
   public class FurnisHaveAvatars extends DefaultConditionType
   {
       
      
      public function FurnisHaveAvatars()
      {
         super();
      }
      
      private static function getEvalRadio(param1:IWindowContainer, param2:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(param1.findChildByName("eval_" + param2 + "_radio"));
      }
      
      private static function getEvalSelector(param1:IWindowContainer) : ISelectorWindow
      {
         return ISelectorWindow(param1.findChildByName("eval_selector"));
      }
      
      override public function get code() : int
      {
         return class_3848.FURNIS_HAVE_AVATARS;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(getEvalSelector(cont).getSelected().id);
         return _loc1_;
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         var _loc2_:int = int(param1.intParams[0]);
         getEvalSelector(cont).setSelected(getEvalRadio(cont,_loc2_));
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
   }
}
