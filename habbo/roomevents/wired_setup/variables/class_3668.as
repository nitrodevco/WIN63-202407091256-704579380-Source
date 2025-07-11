package com.sulake.habbo.roomevents.wired_setup.variables
{
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.class_3398;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.class_3847;
   
   public class class_3668 extends DefaultVariableType
   {
       
      
      private var var_4532:int = -1;
      
      public function class_3668()
      {
         super();
      }
      
      private static function select(param1:class_3398, param2:Boolean) : void
      {
         if(param2)
         {
            param1.select();
         }
         else
         {
            param1.unselect();
         }
      }
      
      override public function get code() : int
      {
         return class_3838.USER_VARIABLE;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(getAvailabilitySelector().getSelected().id);
         _loc1_.push(!!hasValueCheckbox.isSelected ? 1 : 0);
         return _loc1_;
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         super.onEditStart(param1);
         var _loc2_:int = int(param1.intParams[0]);
         var _loc3_:* = param1.intParams[1] != 0;
         select(hasValueCheckbox,_loc3_);
         var_4532 = _loc2_;
         getAvailabilitySelector().setSelected(getEvalRadio(_loc2_));
         initialVariableName = param1.stringParam;
      }
      
      override public function readStringParamFromForm() : String
      {
         return String(variableNameTxt.text);
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getEvalRadio(param1:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(cont.findChildByName("avail_" + param1 + "_radio"));
      }
      
      private function getAvailabilitySelector() : ISelectorWindow
      {
         return ISelectorWindow(cont.findChildByName("availability_selector"));
      }
      
      private function get hasValueCheckbox() : class_3398
      {
         return class_3398(cont.findChildByName("has_value_checkbox"));
      }
      
      override public function get requireConfirmation() : Object
      {
         var _loc1_:Boolean = isVariableStored(var_4532) && !isVariableStored(getAvailabilitySelector().getSelected().id);
         if(_loc1_)
         {
            return {
               "title":"${wiredfurni.variables.availability_change.title}",
               "body":"${wiredfurni.variables.availability_change.body}"
            };
         }
         return null;
      }
      
      override public function variableType() : int
      {
         return class_3847.USER;
      }
   }
}
