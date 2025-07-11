package com.sulake.habbo.ui.widget.furniture.dimmer
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetDimmerStateUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetDimmerUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetDimmerUpdateEventPresetItem;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetDimmerChangeStateMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetDimmerPreviewMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetDimmerSavePresetMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.IEventDispatcher;
   
   public class DimmerFurniWidget extends RoomWidgetBase
   {
      
      private static const AVAILABLE_COLORS:Array = new Array(7665141,21495,15161822,15353138,15923281,8581961,0);
      
      private static const const_424:Array = new Array(76,76);
       
      
      private var var_1631:DimmerView;
      
      private var var_216:Array;
      
      private var var_3255:int;
      
      private var var_4267:int;
      
      private var var_580:int;
      
      private var _color:uint = 16777215;
      
      private var var_3376:uint = 255;
      
      private var var_517:int;
      
      private var var_1149:Boolean;
      
      public function DimmerFurniWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary = null, param4:IHabboLocalizationManager = null)
      {
         super(param1,param2,param3,param4);
      }
      
      public function get isOn() : Boolean
      {
         return var_1149;
      }
      
      public function get presets() : Array
      {
         return var_216;
      }
      
      public function get colors() : Array
      {
         return AVAILABLE_COLORS;
      }
      
      public function get minLights() : Array
      {
         return const_424;
      }
      
      public function get selectedPresetIndex() : int
      {
         return var_3255;
      }
      
      public function set selectedPresetIndex(param1:int) : void
      {
         var_3255 = param1;
      }
      
      override public function dispose() : void
      {
         disposeInterface();
         var_216 = null;
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWDUE_PRESETS",onPresets);
         param1.addEventListener("RWDUE_HIDE",onHide);
         param1.addEventListener("RWDSUE_DIMMER_STATE",onDimmerState);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWDUE_PRESETS",onPresets);
         param1.removeEventListener("RWDUE_HIDE",onHide);
         param1.removeEventListener("RWDSUE_DIMMER_STATE",onDimmerState);
      }
      
      private function onPresets(param1:RoomWidgetDimmerUpdateEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:RoomWidgetDimmerUpdateEventPresetItem = null;
         var _loc2_:DimmerFurniWidgetPresetItem = null;
         var_517 = param1.itemId;
         var_1149 = param1.isOn;
         var_3255 = param1.selectedPresetId - 1;
         var_216 = [];
         _loc3_ = 0;
         while(_loc3_ < param1.presets.length)
         {
            _loc4_ = param1.presets[_loc3_];
            _loc2_ = new DimmerFurniWidgetPresetItem(_loc4_.id,_loc4_.type,_loc4_.color,_loc4_.light);
            var_216.push(_loc2_);
            _loc3_++;
         }
         showInterface();
      }
      
      private function onHide(param1:RoomWidgetDimmerUpdateEvent) : void
      {
         if(var_517 == param1.itemId)
         {
            disposeInterface();
         }
      }
      
      private function disposeInterface() : void
      {
         if(var_1631 != null)
         {
            var_1631.dispose();
            var_1631 = null;
         }
      }
      
      private function onDimmerState(param1:RoomWidgetDimmerStateUpdateEvent) : void
      {
         var _loc2_:RoomWidgetDimmerPreviewMessage = null;
         if(param1 == null)
         {
            return;
         }
         if(param1.state > 0)
         {
            var_4267 = param1.objectId;
         }
         if(var_4267 == param1.objectId)
         {
            var_580 = param1.effectId;
            _color = param1.color;
            var_3376 = param1.brightness;
         }
         if(var_517 == param1.objectId)
         {
            var_1149 = param1.state > 0;
         }
         if(var_1631 != null)
         {
            var_1631.update();
         }
         if(!validateBrightness(var_3376,var_580))
         {
            return;
         }
         _loc2_ = new RoomWidgetDimmerPreviewMessage(_color,var_3376,var_580 == 2);
         messageListener.processWidgetMessage(_loc2_);
      }
      
      private function showInterface() : void
      {
         if(var_1631 == null)
         {
            var_1631 = new DimmerView(this);
         }
         if(var_1631 != null)
         {
            var_1631.showInterface();
         }
      }
      
      public function storeCurrentSetting(param1:Boolean) : void
      {
         var _loc6_:RoomWidgetDimmerSavePresetMessage = null;
         if(!var_1149)
         {
            return;
         }
         if(messageListener == null)
         {
            return;
         }
         var _loc7_:int = var_3255 + 1;
         if(var_216 == null || _loc7_ < 0 || _loc7_ > var_216.length)
         {
            return;
         }
         var _loc5_:int = var_1631.selectedType;
         var _loc4_:uint = uint(colors[var_1631.selectedColorIndex]);
         var _loc3_:int = var_1631.selectedBrightness;
         var _loc2_:DimmerFurniWidgetPresetItem = var_216[var_3255] as DimmerFurniWidgetPresetItem;
         if(_loc2_ != null && _loc2_.type == _loc5_ && _loc2_.color == _loc4_ && _loc2_.light == _loc3_ && !param1)
         {
            return;
         }
         _loc2_.type = _loc5_;
         _loc2_.color = _loc4_;
         _loc2_.light = _loc3_;
         if(!validateBrightness(_loc3_,_loc5_))
         {
            return;
         }
         _loc6_ = new RoomWidgetDimmerSavePresetMessage(_loc7_,_loc5_,_loc4_,_loc3_,param1,var_517);
         messageListener.processWidgetMessage(_loc6_);
      }
      
      public function previewCurrentSetting() : void
      {
         var _loc1_:RoomWidgetDimmerPreviewMessage = null;
         if(!var_1149)
         {
            return;
         }
         if(messageListener == null)
         {
            return;
         }
         if(!validateBrightness(var_1631.selectedBrightness,var_1631.selectedType))
         {
            return;
         }
         _loc1_ = new RoomWidgetDimmerPreviewMessage(colors[var_1631.selectedColorIndex],var_1631.selectedBrightness,var_1631.selectedType == 2);
         messageListener.processWidgetMessage(_loc1_);
      }
      
      public function changeRoomDimmerState() : void
      {
         var _loc1_:RoomWidgetDimmerChangeStateMessage = null;
         if(messageListener != null)
         {
            _loc1_ = new RoomWidgetDimmerChangeStateMessage(var_517);
            messageListener.processWidgetMessage(_loc1_);
         }
      }
      
      public function removePreview() : void
      {
         var _loc1_:RoomWidgetDimmerPreviewMessage = null;
         if(messageListener == null)
         {
            return;
         }
         if(!validateBrightness(var_3376,var_580))
         {
            return;
         }
         _loc1_ = new RoomWidgetDimmerPreviewMessage(_color,var_3376,var_580 == 2);
         messageListener.processWidgetMessage(_loc1_);
      }
      
      private function validateBrightness(param1:uint, param2:int) : Boolean
      {
         return true;
      }
   }
}
