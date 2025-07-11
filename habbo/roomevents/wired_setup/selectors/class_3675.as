package com.sulake.habbo.roomevents.wired_setup.selectors
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3398;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   
   public class class_3675 extends DefaultSelectorType
   {
       
      
      private var _cont:IWindowContainer;
      
      public function class_3675()
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
         return SelectorCodes.FURNI_BY_TYPE;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _cont = param1;
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         select(getStateInput(),param1.getBoolean(0));
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(!!getStateInput().isSelected ? 1 : 0);
         return _loc1_;
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getStateInput() : class_3398
      {
         return class_3398(_cont.findChildByName("state_checkbox"));
      }
   }
}
