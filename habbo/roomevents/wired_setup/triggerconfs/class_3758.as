package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   
   public class class_3758 extends DefaultTriggerConf
   {
       
      
      public function class_3758()
      {
         super();
      }
      
      private static function getTriggererRadio(param1:IWindowContainer, param2:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(param1.findChildByName("triggerer_" + param2 + "_radio"));
      }
      
      private static function getTriggererSelector(param1:IWindowContainer) : ISelectorWindow
      {
         return ISelectorWindow(param1.findChildByName("triggerer_radio"));
      }
      
      override public function get code() : int
      {
         return class_3782.BOT_AVATAR_REACHED;
      }
      
      override public function readStringParamFromForm() : String
      {
         return getInput(cont).text;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(getTriggererSelector(cont).getSelected().id);
         return _loc1_;
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         getInput(cont).text = param1.stringParam;
         var _loc2_:int = int(param1.intParams[0]);
         getTriggererSelector(cont).setSelected(getTriggererRadio(cont,_loc2_));
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getInput(param1:IWindowContainer) : ITextFieldWindow
      {
         return ITextFieldWindow(param1.findChildByName("bot_name"));
      }
      
      override public function userSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.users.title.bots";
      }
   }
}
