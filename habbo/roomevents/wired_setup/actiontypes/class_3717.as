package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3398;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   
   public class class_3717 extends DefaultActionType
   {
       
      
      private var _advancedCont:IWindowContainer;
      
      public function class_3717()
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
      
      private static function getIntState(param1:class_3398) : int
      {
         return !!param1.isSelected ? 1 : 0;
      }
      
      override public function get code() : int
      {
         return class_3849.SEND_SIGNAL;
      }
      
      override public function get negativeCode() : int
      {
         return class_3849.NEG_SEND_SIGNAL;
      }
      
      override protected function get legacyAdvancedInputMode() : Boolean
      {
         return true;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _advancedCont = param2;
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         select(getSplitFurniCheckbox(),param1.getBoolean(0));
         select(getSplitUsersCheckbox(),param1.getBoolean(1));
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(getIntState(getSplitFurniCheckbox()));
         _loc1_.push(getIntState(getSplitUsersCheckbox()));
         return _loc1_;
      }
      
      private function getSplitFurniCheckbox() : class_3398
      {
         return class_3398(_advancedCont.findChildByName("split_furni"));
      }
      
      private function getSplitUsersCheckbox() : class_3398
      {
         return class_3398(_advancedCont.findChildByName("split_users"));
      }
      
      override public function get usingCustomAdvancedSettings() : Boolean
      {
         return getSplitFurniCheckbox().isSelected || Boolean(getSplitUsersCheckbox().isSelected);
      }
      
      override public function furniSelectionTitle(param1:int) : String
      {
         if(param1 == 0)
         {
            return "wiredfurni.params.sources.furni.title.signal_antenna";
         }
         return "wiredfurni.params.sources.furni.title.signal_forward";
      }
      
      override public function userSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.users.title.signal_forward";
      }
   }
}
