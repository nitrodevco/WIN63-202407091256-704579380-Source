package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.SliderWindowController;
   import flash.events.Event;
   
   public class AnimationTime extends DefaultAddonType
   {
       
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_2973:SliderWindowController;
      
      public function AnimationTime()
      {
         super();
      }
      
      private static function getInput(param1:IWindowContainer) : IWindowContainer
      {
         return param1.findChildByName("slider_container") as IWindowContainer;
      }
      
      override public function get code() : int
      {
         return class_3833.ANIMATION_TIME;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(var_2973.getValue());
         return _loc1_;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _roomEvents = param3;
         var_2973 = new SliderWindowController(param3,getInput(param1),param3.assets,50,2000,50);
         var_2973.setValue(500);
         var_2973.addEventListener("change",onSliderChange);
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         var _loc2_:int = int(param1.intParams[0]);
         var_2973.setValue(_loc2_);
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      protected function onSliderChange(param1:Event) : void
      {
         var _loc2_:SliderWindowController = null;
         var _loc4_:Number = NaN;
         var _loc3_:String = null;
         if(param1.type == "change")
         {
            _loc2_ = param1.target as SliderWindowController;
            if(_loc2_)
            {
               _loc3_ = (int(_loc4_ = _loc2_.getValue())) + "";
               _roomEvents.localization.registerParameter("wiredfurni.params.setanimationtime","ms",_loc3_);
            }
         }
      }
      
      public function get slider() : SliderWindowController
      {
         return var_2973;
      }
   }
}
