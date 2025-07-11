package com.sulake.habbo.roomevents.wired_setup.selectors
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3520;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   
   public class class_3689 extends DefaultSelectorType
   {
       
      
      private var var_1660:HabboUserDefinedRoomEvents;
      
      private var _cont:IWindowContainer;
      
      private var initialHandItems:Array;
      
      public function class_3689()
      {
         super();
      }
      
      private static function getCodeInHandItemLoc(param1:String) : int
      {
         return parseInt(param1.substr(10,param1.length - 11));
      }
      
      override public function get code() : int
      {
         return SelectorCodes.USERS_WITH_HANDITEM;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         var_1660 = param3;
         _cont = param1;
         initialHandItems = getHandItemMenu().enumerateSelection();
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(getSelectedHandItemCode(cont));
         return _loc1_;
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         setSelectedHandItemByCode(param1.intParams[0]);
         cont.findChildByName("capture_handitem").procedure = captureHanditem;
      }
      
      private function getSelectedHandItemCode(param1:IWindowContainer) : int
      {
         var _loc3_:Array = getHandItemMenu().enumerateSelection();
         var _loc2_:int = getHandItemMenu().selection;
         if(_loc2_ == -1)
         {
            return 0;
         }
         return getCodeInHandItemLoc(_loc3_[_loc2_]);
      }
      
      private function setSelectedHandItemByCode(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Array = null;
         var _loc5_:class_3520;
         (_loc5_ = getHandItemMenu()).populate(initialHandItems);
         var _loc3_:Array = _loc5_.enumerateSelection();
         var _loc6_:* = -1;
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(getCodeInHandItemLoc(_loc3_[_loc4_]) == param1)
            {
               _loc6_ = _loc4_;
            }
            _loc4_++;
         }
         if(_loc6_ == -1 && param1 >= 0)
         {
            _loc2_ = initialHandItems.concat();
            _loc2_.push("${handitem" + param1 + "}");
            _loc5_.populate(_loc2_);
            _loc6_ = _loc5_.numMenuItems - 1;
         }
         _loc5_.selection = _loc6_;
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getHandItemMenu() : class_3520
      {
         return class_3520(_cont.findChildByName("menu_handitem"));
      }
      
      private function captureHanditem(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:int = 0;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = int(var_1660.roomEngine.getRoomObject(this.var_1660.roomSession.roomId,this.var_1660.roomSession.ownUserRoomId,100).getModel().getNumber("figure_carry_object"));
            setSelectedHandItemByCode(_loc3_);
         }
      }
   }
}
