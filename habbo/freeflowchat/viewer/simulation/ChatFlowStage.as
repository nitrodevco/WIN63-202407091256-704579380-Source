package com.sulake.habbo.freeflowchat.viewer.simulation
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.viewer.visualization.PooledChatBubble;
   import flash.geom.Point;
   
   public class ChatFlowStage implements IDisposable, IUpdateReceiver
   {
      
      public static const MOVE_UP_AMOUNT_PIXELS:int = 19;
      
      private static const CLEANUP_TIMER_DELAY:int = 5000;
      
      private static const MOVE_UP_TIMER_DEFAULT:int = 10000;
      
      private static const MAX_ITERATIONS:int = 20;
      
      private static const MAX_COLLISION_SIDEWAYS_IMPULSE:int = 15;
      
      private static const MOVE_UP_IMPULSE_LIMIT:Number = 8;
       
      
      private const MINIMUM_COLLIDER_WIDTH:int = 240;
      
      private var var_1660:HabboFreeFlowChat;
      
      private var _simulationTime:uint = 0;
      
      private var var_3790:uint = 0;
      
      private var var_4592:uint = 0;
      
      private var var_3242:class_3628;
      
      private var var_1774:Vector.<ChatBubbleSimulationEntity>;
      
      private var _toRemove:Vector.<ChatBubbleSimulationEntity>;
      
      private var var_2632:Boolean = false;
      
      private var var_3016:int = 10000;
      
      private var var_4255:Boolean = true;
      
      private var var_4997:Boolean = false;
      
      private var var_2686:int = 0;
      
      public function ChatFlowStage(param1:HabboFreeFlowChat)
      {
         var_3242 = new class_3628();
         var_1774 = new Vector.<ChatBubbleSimulationEntity>(0);
         _toRemove = new Vector.<ChatBubbleSimulationEntity>(0);
         super();
         var_1660 = param1;
         var_1660.registerUpdateReceiver(this,2);
         refreshSettings();
      }
      
      public function refreshSettings() : void
      {
         if(var_1660.roomChatSettings)
         {
            var_2632 = var_1660.roomChatSettings.mode == 1;
            var_4255 = !var_2632;
            switch(var_1660.roomChatSettings.scrollSpeed)
            {
               case 0:
                  var_3016 = 3000;
                  break;
               case 1:
                  var_3016 = 6000;
                  break;
               case 2:
                  var_3016 = 12000;
            }
         }
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(var_1660)
            {
               var_1660.removeUpdateReceiver(this);
               var_1660 = null;
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_1660 == null;
      }
      
      public function insertBubble(param1:PooledChatBubble) : Point
      {
         var _loc11_:ChatBubbleSimulationEntity = null;
         var _loc6_:int = 0;
         var _loc3_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc2_:ChatBubbleSimulationWithLimitedWideRect = null;
         var _loc10_:int = 0;
         if(var_2686 == 0)
         {
            var_2686 = var_1660.chatFlowViewer.viewBottom;
         }
         if(!var_2632 && param1.width < 240)
         {
            _loc11_ = new ChatBubbleSimulationWithLimitedWideRect(param1);
         }
         else
         {
            _loc11_ = new ChatBubbleSimulationEntity(param1,var_2632);
         }
         var _loc9_:Point = new Point(param1.userScreenPos.x - _loc11_.visualRect.width / 2,var_1660.chatFlowViewer.viewBottom);
         var _loc4_:Point;
         if((_loc4_ = var_1660.roomEngine.getRoomCanvasScreenOffset(param1.roomId)) != null)
         {
            _loc9_.x -= _loc4_.x;
         }
         _loc9_.y -= !!param1.overlap ? param1.overlap.y : 0;
         _loc9_.x -= !!param1.overlap ? param1.overlap.x : 0;
         _loc11_.initializePosition(_loc9_.x,_loc9_.y);
         if(var_4255 && !var_2632)
         {
            _loc6_ = 0;
            while(_loc6_ < 20 / 2)
            {
               _loc3_ = 0;
               for each(var _loc7_ in var_1774)
               {
                  _loc3_ += var_3242.getAttraction(_loc11_,_loc7_,60,40);
               }
               _loc11_.x += _loc3_;
               _loc6_++;
            }
            _loc5_ = _loc11_.x;
            _loc10_ = param1.userScreenPos.x - (_loc4_ != null ? _loc4_.x : 0);
            if(_loc11_.x > _loc10_ - 15)
            {
               _loc5_ = _loc10_ - 15;
               if(_loc11_.hasWideRect)
               {
                  _loc2_ = ChatBubbleSimulationWithLimitedWideRect(_loc11_);
                  _loc8_ = _loc11_.x - _loc5_;
                  _loc2_.wideRectOffset += _loc8_;
                  _loc2_.wideRectOffset = Math.min(0,_loc2_.wideRectOffset);
               }
            }
            else if(_loc11_.x + _loc11_.visualRect.width < _loc10_ + 15)
            {
               _loc5_ = _loc10_ - _loc11_.visualRect.width + 15;
               if(_loc11_.hasWideRect)
               {
                  _loc2_ = ChatBubbleSimulationWithLimitedWideRect(_loc11_);
                  _loc8_ = _loc11_.x - _loc5_;
                  _loc2_.wideRectOffset += _loc8_;
                  _loc2_.wideRectOffset = Math.max(-(_loc2_.wideRect.width - _loc2_.visualRect.width),_loc2_.wideRectOffset);
               }
            }
            _loc11_.x = _loc9_.x = _loc5_;
         }
         var_1774.push(_loc11_);
         _loc9_.x -= !!param1.overlap ? param1.overlap.x : 0;
         if(var_2632)
         {
            var_3790 = _simulationTime;
         }
         return _loc9_;
      }
      
      public function update(param1:uint) : void
      {
         var _loc3_:int = 0;
         var _loc2_:ChatBubbleSimulationEntity = null;
         _simulationTime += param1;
         simulate();
         if(var_3790 + var_3016 < _simulationTime)
         {
            scrollUp();
            var_3790 = _simulationTime;
         }
         _loc3_ = 0;
         while(_loc3_ < var_1774.length)
         {
            _loc2_ = var_1774[_loc3_];
            _loc2_.syncToVisualization();
            if(!_loc2_.isSpacer)
            {
               _loc2_.fullHeightCollision = false;
               if(_loc3_ > 0 && _loc2_.visualizationHasHitMargin)
               {
                  _loc2_.fullHeightCollision = true;
                  var_1774[_loc3_ - 1].fullHeightCollision = true;
               }
            }
            _loc3_++;
         }
         if(var_4592 + 5000 < _simulationTime)
         {
            cleanup();
            var_4592 = _simulationTime;
         }
      }
      
      public function clear() : void
      {
         for each(var _loc1_ in var_1774)
         {
            _loc1_.readyToRecycle = true;
         }
         update(0);
         var_1660.chatFlowViewer.update(0);
      }
      
      private function simulate() : void
      {
         var _loc7_:* = undefined;
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc11_:* = null;
         var _loc4_:* = null;
         var _loc9_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc8_:Number = NaN;
         _loc9_ = 0;
         while(_loc9_ < 20)
         {
            _loc7_ = new Vector.<ChatBubbleCollisionEvent>(0);
            for each(_loc11_ in var_1774)
            {
               _loc11_.resetSimulationStep();
               for each(_loc4_ in var_1774)
               {
                  if(_loc11_ != _loc4_ && _loc11_.intersectsWith(_loc4_))
                  {
                     _loc7_.push(new ChatBubbleCollisionEvent(_loc11_,_loc4_));
                  }
               }
            }
            if(_loc7_.length == 0)
            {
               break;
            }
            if(var_2632)
            {
               for each(_loc2_ in _loc7_)
               {
                  if(!_loc2_.first.hasCollidedWith(_loc2_.second) && !_loc2_.second.hasCollidedWith(_loc2_.first))
                  {
                     if(_loc2_.areSameY)
                     {
                        _loc2_.older.addVerticalImpulse(-_loc2_.older.wideRect.height);
                     }
                     else
                     {
                        _loc6_ = _loc2_.first.visualIntertersectsWith(_loc2_.second) ? _loc2_.top.visualRect.bottom : _loc2_.top.wideRect.bottom;
                        _loc2_.top.addVerticalImpulse(-(_loc6_ - _loc2_.bottom.y + 1));
                     }
                  }
                  _loc2_.first.addCollisionHandled(_loc2_.second);
                  _loc2_.second.addCollisionHandled(_loc2_.first);
               }
            }
            else
            {
               for each(_loc2_ in _loc7_)
               {
                  if(!_loc2_.first.hasCollidedWith(_loc2_.second) && !_loc2_.second.hasCollidedWith(_loc2_.first))
                  {
                     _loc1_ = _loc2_.left is ChatBubbleSimulationWithLimitedWideRect ? ChatBubbleSimulationWithLimitedWideRect(_loc2_.left).wideRectOffset + _loc2_.left.x : _loc2_.left.x;
                     _loc10_ = _loc2_.right is ChatBubbleSimulationWithLimitedWideRect ? ChatBubbleSimulationWithLimitedWideRect(_loc2_.right).wideRectOffset + _loc2_.right.x : _loc2_.right.x;
                     _loc3_ = _loc2_.left is ChatBubbleSimulationWithLimitedWideRect ? _loc2_.left.wideRect.width : _loc2_.left.visualRect.width;
                     if((_loc8_ = Math.abs(_loc1_ + _loc3_ - _loc10_) / 2) <= 15)
                     {
                        _loc2_.left.addHorizontalImpulse(-_loc8_);
                        _loc2_.right.addHorizontalImpulse(_loc8_ + 1);
                     }
                     else if(_loc2_.areSameY)
                     {
                        _loc2_.older.addVerticalImpulse(-_loc2_.older.visualRect.height);
                     }
                     else
                     {
                        _loc2_.top.addVerticalImpulse(-(_loc2_.top.visualRect.bottom - _loc2_.bottom.y + 1));
                     }
                     _loc2_.first.addCollisionHandled(_loc2_.second);
                     _loc2_.second.addCollisionHandled(_loc2_.first);
                  }
               }
            }
            for each(_loc5_ in var_1774)
            {
               _loc5_.applyImpulseForces(8);
            }
            _loc9_++;
         }
      }
      
      private function scrollUp() : void
      {
         if(var_1660.chatFlowViewer == null)
         {
            return;
         }
         for each(var _loc1_ in var_1774)
         {
            if(var_4255)
            {
               for each(var _loc2_ in var_1774)
               {
                  if(_loc1_ != _loc2_)
                  {
                     _loc1_.x += var_3242.getAttraction(_loc1_,_loc2_);
                  }
               }
            }
            _loc1_.y -= 19;
         }
         if(var_2632)
         {
            insertBubble(var_1660.chatBubbleFactory.getNewEmptySpace(19));
            var_1774[var_1774.length - 1].fullHeightCollision = true;
            var_1774[var_1774.length - 1].isSpacer = true;
         }
         simulate();
      }
      
      private function cleanup() : void
      {
         var _loc3_:int = 0;
         for each(var _loc1_ in var_1774)
         {
            if(_loc1_.visualRect.bottom < -10 || _loc1_.readyToRecycle)
            {
               _loc1_.readyToRecycle = true;
               if(_toRemove.indexOf(_loc1_) == -1)
               {
                  _toRemove.push(_loc1_);
               }
            }
         }
         if(_toRemove.length > 0)
         {
            for each(var _loc2_ in _toRemove)
            {
               _loc3_ = var_1774.indexOf(_loc2_);
               _loc2_.dispose();
               var_1774.splice(_loc3_,1);
            }
            _toRemove = new Vector.<ChatBubbleSimulationEntity>(0);
         }
      }
      
      public function resize(param1:int, param2:int) : void
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         if(!var_1660)
         {
            return;
         }
         if(!var_1660.chatFlowViewer)
         {
            return;
         }
         var _loc5_:int = var_1660.chatFlowViewer.viewBottom;
         if(var_2686 != _loc5_)
         {
            if(var_2686 < _loc5_)
            {
               _loc4_ = _loc5_ - var_2686;
               for each(_loc3_ in var_1774)
               {
                  _loc3_.y += _loc4_;
                  _loc3_.syncToVisualization(true);
               }
            }
            else
            {
               _loc6_ = var_2686 - _loc5_;
               for each(_loc3_ in var_1774)
               {
                  _loc3_.y -= _loc6_;
                  _loc3_.syncToVisualization(true);
               }
            }
         }
         var_2686 = _loc5_;
      }
   }
}
