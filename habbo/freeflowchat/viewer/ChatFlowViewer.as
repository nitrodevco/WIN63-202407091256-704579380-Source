package com.sulake.habbo.freeflowchat.viewer
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.viewer.simulation.ChatFlowStage;
   import com.sulake.habbo.freeflowchat.viewer.visualization.PooledChatBubble;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class ChatFlowViewer implements IDisposable, IUpdateReceiver
   {
       
      
      private const VIEW_BOTTOM_DEFAULT:int = 230;
      
      private var var_1660:HabboFreeFlowChat;
      
      private var var_1992:ChatFlowStage;
      
      private var _rootDisplayObject:DisplayObjectContainer;
      
      private var var_4616:int;
      
      private var var_4168:int = 0;
      
      private var _runTime:uint = 0;
      
      private var var_4932:Number = 0.25;
      
      private var var_1774:Vector.<PooledChatBubble>;
      
      private var _toRemove:Vector.<PooledChatBubble>;
      
      public function ChatFlowViewer(param1:HabboFreeFlowChat, param2:ChatFlowStage)
      {
         var_1774 = new Vector.<PooledChatBubble>(0);
         _toRemove = new Vector.<PooledChatBubble>(0);
         super();
         _rootDisplayObject = new Sprite();
         var_1660 = param1;
         var_1660.registerUpdateReceiver(this,1);
         var_1992 = param2;
      }
      
      public function dispose() : void
      {
         if(var_1660)
         {
            var_1660.removeUpdateReceiver(this);
            var_1660 = null;
         }
         var_1992 = null;
         _rootDisplayObject = null;
      }
      
      public function get disposed() : Boolean
      {
         return _rootDisplayObject == null && var_1660 == null;
      }
      
      public function insertBubble(param1:PooledChatBubble, param2:Point) : void
      {
         param1.roomPanOffsetX = var_4168;
         var_1774.push(param1);
         _rootDisplayObject.addChild(param1);
         param1.warpTo(param2.x,param2.y);
         param1.repositionPointer();
         var_4616 = param1.roomId;
      }
      
      public function update(param1:uint) : void
      {
         var _loc6_:int = 0;
         _runTime += param1;
         var _loc3_:Point = var_1660.roomEngine.getRoomCanvasScreenOffset(var_4616);
         if(_loc3_ != null)
         {
            if(_loc3_.x != var_4168 && var_1774.length > 0)
            {
               for each(var _loc2_ in var_1774)
               {
                  _loc2_.roomPanOffsetX = _loc3_.x;
               }
            }
            var_4168 = _loc3_.x;
         }
         for each(var _loc4_ in var_1774)
         {
            _loc4_.update(param1);
            if(_loc4_.readyToRecycle)
            {
               _toRemove.push(_loc4_);
            }
         }
         if(_toRemove.length > 0)
         {
            for each(var _loc5_ in _toRemove)
            {
               _rootDisplayObject.removeChild(_loc5_);
               _loc6_ = var_1774.indexOf(_loc5_);
               var_1774.splice(_loc6_,1);
               _loc5_.unregister();
               var_1660.chatBubbleFactory.recycle(_loc5_);
            }
            _toRemove = new Vector.<PooledChatBubble>(0);
         }
      }
      
      public function get rootDisplayObject() : DisplayObjectContainer
      {
         return _rootDisplayObject;
      }
      
      public function get viewBottom() : int
      {
         if(!_rootDisplayObject.stage)
         {
            return 230;
         }
         return _rootDisplayObject.stage.stageHeight * var_4932;
      }
      
      public function resize(param1:int, param2:int) : void
      {
         if(var_1992)
         {
            var_1992.resize(param1,param2);
         }
      }
   }
}
