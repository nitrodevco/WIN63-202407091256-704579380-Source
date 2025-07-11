package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3398;
   import com.sulake.core.window.components.class_3520;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   
   public class class_3761 extends DefaultActionType
   {
       
      
      private var _cont:IWindowContainer;
      
      public function class_3761()
      {
         super();
      }
      
      private static function getFreezeEffectId(param1:String) : int
      {
         var _loc2_:Array = param1.split(".");
         return parseInt(_loc2_[4]);
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
         return class_3849.FREEZE_USER;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _cont = param1;
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         setSelectedFreezeEffectByCode(param1.intParams[0]);
         select(getTeleportCancelInput(),param1.getBoolean(1));
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(getSelectedFreezeEffectId());
         _loc1_.push(!!getTeleportCancelInput().isSelected ? 1 : 0);
         return _loc1_;
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getFreezeEffectMenu() : class_3520
      {
         return class_3520(_cont.findChildByName("menu_freezeeffect"));
      }
      
      private function getSelectedFreezeEffectId() : int
      {
         var _loc2_:Array = getFreezeEffectMenu().enumerateSelection();
         var _loc1_:int = getFreezeEffectMenu().selection;
         if(_loc1_ == -1)
         {
            return 0;
         }
         return getFreezeEffectId(_loc2_[_loc1_]);
      }
      
      private function setSelectedFreezeEffectByCode(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:class_3520;
         var _loc2_:Array = (_loc4_ = getFreezeEffectMenu()).enumerateSelection();
         var _loc5_:* = -1;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(getFreezeEffectId(_loc2_[_loc3_]) == param1)
            {
               _loc5_ = _loc3_;
            }
            _loc3_++;
         }
         _loc4_.selection = _loc5_;
      }
      
      private function getTeleportCancelInput() : class_3398
      {
         return class_3398(_cont.findChildByName("cancel_on_teleport_checkbox"));
      }
   }
}
