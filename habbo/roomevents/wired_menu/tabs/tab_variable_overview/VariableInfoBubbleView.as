package com.sulake.habbo.roomevents.wired_menu.tabs.tab_variable_overview
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3460;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.ui.IRoomDesktop;
   import com.sulake.habbo.utils.FixedSizeStack;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class VariableInfoBubbleView implements IDisposable, IUpdateReceiver
   {
      
      private static const const_786:int = 18;
      
      public static const const_461:int = 3;
      
      private static var STATE_IDLE:int = 0;
      
      private static var STATE_AWAIT_TARGET_RECT:int = 1;
      
      private static var STATE_ACTIVE:int = 1;
       
      
      private var _disposed:Boolean;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_149:int;
      
      private var var_455:int;
      
      private var var_638:int;
      
      private var var_4471:Boolean;
      
      private var _window:IWindowContainer;
      
      private var var_3364:int = 0;
      
      protected var var_3107:FixedSizeStack;
      
      public function VariableInfoBubbleView(param1:HabboUserDefinedRoomEvents)
      {
         var_149 = STATE_IDLE;
         var_3107 = new FixedSizeStack(18);
         super();
         _roomEvents = param1;
         var _loc2_:XmlAsset = _roomEvents.assets.getAssetByName("variable_value_info_bubble_xml") as XmlAsset;
         _window = _roomEvents.windowManager.buildFromXML(_loc2_.content as XML,0) as IWindowContainer;
         _window.ignoreMouseEvents = true;
      }
      
      public function updateValue(param1:String) : void
      {
         if(var_149 == STATE_IDLE)
         {
            return;
         }
         valueText.text = param1;
      }
      
      public function setActive(param1:String, param2:int, param3:int, param4:Boolean) : void
      {
         if(var_149 != STATE_IDLE)
         {
            return;
         }
         valueText.text = param1;
         var_455 = param2;
         var_638 = param3;
         var_4471 = param4;
         var_149 = STATE_AWAIT_TARGET_RECT;
      }
      
      public function setInactive() : void
      {
         valueText.text = "";
         var_455 = 0;
         var_638 = 0;
         var_3364 = 0;
         var_3107.reset();
         var_149 = STATE_IDLE;
         hide();
      }
      
      private function show() : void
      {
         var _loc1_:class_3460 = null;
         _window.visible = true;
         if(_window.parent == null)
         {
            _loc1_ = _roomEvents.windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.addChild(_window);
            }
         }
         else
         {
            _window.activate();
         }
      }
      
      private function hide() : void
      {
         var _loc1_:class_3460 = null;
         _window.visible = false;
         if(_window.parent != null)
         {
            _loc1_ = _roomEvents.windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
         }
      }
      
      private function get valueText() : ITextWindow
      {
         return _window.findChildByName("value") as ITextWindow;
      }
      
      public function update(param1:uint) : void
      {
         if(var_149 == STATE_IDLE)
         {
            return;
         }
         var _loc10_:IRoomEngine = _roomEvents.roomEngine;
         var _loc3_:IRoomDesktop = _roomEvents.roomDesktop;
         var _loc4_:Rectangle = _loc10_.getRoomObjectBoundingRectangle(_loc10_.activeRoomId,var_455,var_638,_loc3_.getFirstCanvasId());
         var _loc5_:Point = _loc10_.getRoomObjectScreenLocation(_loc10_.activeRoomId,var_455,var_638,_loc3_.getFirstCanvasId());
         var _loc6_:Rectangle = _loc3_.getRoomViewRect();
         if(_loc4_ && _loc5_ && _loc6_)
         {
            _loc4_.offset(_loc6_.x,_loc6_.y);
            _loc5_.offset(_loc6_.x,_loc6_.y);
         }
         if(!_loc4_ || !_loc5_)
         {
            return;
         }
         var _loc2_:int = getOffset(_loc4_);
         var _loc7_:int = _loc5_.y - _loc4_.top;
         var_3107.addValue(_loc7_);
         var _loc8_:int;
         if((_loc8_ = var_3107.getMax()) < var_3364 - 3)
         {
            _loc8_ = var_3364 - 3;
         }
         var _loc9_:int = _loc5_.y - _loc8_;
         var_3364 = _loc8_;
         _window.x = _loc5_.x - _window.width / 2;
         _window.y = _loc9_ + _loc2_;
         if(var_149 == STATE_AWAIT_TARGET_RECT)
         {
            var_149 = STATE_ACTIVE;
            show();
         }
      }
      
      private function getOffset(param1:Rectangle) : int
      {
         var _loc2_:int = -_window.height;
         if(var_4471)
         {
            _loc2_ += param1.height > 50 ? 25 : 0;
         }
         else
         {
            _loc2_ -= 4;
         }
         return _loc2_;
      }
      
      public function get objectId() : int
      {
         return var_455;
      }
      
      public function get category() : int
      {
         return var_638;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         hide();
         _window.dispose();
         _window = null;
         _roomEvents = null;
         var_3107 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}
