package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.SliderWindowController;
   import flash.events.Event;
   
   public class class_3799 extends DefaultAddonType
   {
       
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_3322:SliderWindowController;
      
      private var var_3351:SliderWindowController;
      
      public function class_3799()
      {
         super();
      }
      
      private static function getInputPicks(param1:IWindowContainer) : IWindowContainer
      {
         return param1.findChildByName("slider_container_picks") as IWindowContainer;
      }
      
      private static function getInputSkips(param1:IWindowContainer) : IWindowContainer
      {
         return param1.findChildByName("slider_container_skips") as IWindowContainer;
      }
      
      override public function get code() : int
      {
         return class_3833.var_4949;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(var_3351.getValue());
         _loc1_.push(var_3322.getValue());
         return _loc1_;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _roomEvents = param3;
         var_3322 = new SliderWindowController(param3,getInputPicks(param1),param3.assets,1,50,1);
         var_3322.setValue(0);
         var_3322.addEventListener("change",onSliderPicksChange);
         var_3351 = new SliderWindowController(param3,getInputSkips(param1),param3.assets,0,50,1);
         var_3351.setValue(0);
         var_3351.addEventListener("change",onSliderSkipsChange);
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         var _loc2_:int = int(param1.intParams[0]);
         var _loc3_:int = int(param1.intParams[1]);
         var_3351.setValue(_loc2_);
         var_3322.setValue(_loc3_);
      }
      
      private function onSliderPicksChange(param1:Event) : void
      {
         var _loc2_:SliderWindowController = null;
         var _loc4_:Number = NaN;
         var _loc3_:int = 0;
         if(param1.type == "change")
         {
            _loc2_ = param1.target as SliderWindowController;
            if(_loc2_)
            {
               _loc3_ = _loc4_ = _loc2_.getValue();
               _roomEvents.localization.registerParameter("wiredfurni.params.pickamount","picks","" + _loc3_);
            }
         }
      }
      
      private function onSliderSkipsChange(param1:Event) : void
      {
         var _loc2_:SliderWindowController = null;
         var _loc4_:Number = NaN;
         var _loc3_:int = 0;
         if(param1.type == "change")
         {
            _loc2_ = param1.target as SliderWindowController;
            if(_loc2_)
            {
               _loc3_ = _loc4_ = _loc2_.getValue();
               _roomEvents.localization.registerParameter("wiredfurni.params.skipactions","skips","" + _loc3_);
            }
         }
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
   }
}
