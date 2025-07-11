package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.wired_setup.conditions.class_3698;
   
   public class class_3693 extends DefaultAddonType
   {
      
      private static var _compareTypeOffset:int = 4;
      
      private static var var_4952:int = 3;
       
      
      private var _cont:IWindowContainer;
      
      public function class_3693()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_3833.CONDITION_EVALUATION;
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         _cont = cont;
         _loc3_ = 0;
         while(_loc3_ < var_4952)
         {
            getInputValue(_loc3_).text = "0";
            _loc3_++;
         }
         var _loc4_:int;
         if((_loc4_ = int(param1.intParams[0])) == -1)
         {
            _loc2_ = int(param1.intParams[1]);
            _loc5_ = int(param1.intParams[2]);
            _loc4_ = _compareTypeOffset + _loc2_;
            getInputValue(_loc2_).text = _loc5_.toString();
         }
         getEvalSelector().setSelected(getEvalRadio(_loc4_));
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         var _loc3_:int = int(getEvalSelector().getSelected().id);
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(_loc3_ >= _compareTypeOffset)
         {
            _loc2_ = _loc3_ - _compareTypeOffset;
            _loc4_ = class_3698.getIntFromInput(getInputValue(_loc2_),0);
            _loc3_ = -1;
         }
         _loc1_.push(_loc3_);
         _loc1_.push(_loc2_);
         _loc1_.push(_loc4_);
         return _loc1_;
      }
      
      private function getEvalSelector() : ISelectorWindow
      {
         return ISelectorWindow(_cont.findChildByName("eval_selector"));
      }
      
      private function getEvalRadio(param1:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("eval_" + param1 + "_radio"));
      }
      
      private function getInputValue(param1:int) : ITextFieldWindow
      {
         return ITextFieldWindow(_cont.findChildByName("cmp_" + param1 + "_value"));
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
   }
}
