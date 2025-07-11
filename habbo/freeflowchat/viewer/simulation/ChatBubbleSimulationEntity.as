package com.sulake.habbo.freeflowchat.viewer.simulation
{
   import com.sulake.habbo.freeflowchat.viewer.visualization.PooledChatBubble;
   import flash.geom.Rectangle;
   
   public class ChatBubbleSimulationEntity
   {
      
      public static const VISUALIZATION_OVERLAP_VERTICAL:int = 10;
       
      
      protected const MOVE_NEGATIVE_FEEDBACK:Number = 0.1;
      
      protected var _visualization:PooledChatBubble;
      
      protected var var_31:Number;
      
      protected var var_28:Number;
      
      protected var var_1661:Rectangle;
      
      protected var var_1681:Rectangle = null;
      
      protected var var_3304:Number;
      
      protected var var_3373:Number;
      
      private const const_672:int = 2500;
      
      private var var_2844:Vector.<ChatBubbleSimulationEntity>;
      
      private var var_4441:Boolean = false;
      
      public function ChatBubbleSimulationEntity(param1:PooledChatBubble, param2:Boolean = false)
      {
         var_1661 = new Rectangle();
         var_2844 = new Vector.<ChatBubbleSimulationEntity>(0);
         super();
         _visualization = param1;
         var _loc3_:Rectangle = param1.overlap;
         var_31 = param1.x + (!!_loc3_ ? _loc3_.x : 0);
         var_28 = param1.y + (!!_loc3_ ? _loc3_.y : 0);
         var_1661.x = var_31;
         var_1661.y = var_28;
         var_1661.width = _visualization.width - (!!_loc3_ ? _loc3_.x + _loc3_.width : 0);
         var_1661.height = _visualization.displayedHeight - 10 - (!!_loc3_ ? _loc3_.y + _loc3_.height : 0);
         if(_visualization.minHeight != -1)
         {
            var_1661.height = _visualization.minHeight;
         }
         if(param2)
         {
            var_1681 = new Rectangle();
            var_1681.width = var_1661.width + 2 * 2500;
            var_1681.height = _visualization.minHeight != -1 ? _visualization.minHeight : var_1661.height / 2;
            var_1681.x = var_1661.x - 2500;
            var_1681.y = var_1661.y;
         }
      }
      
      public function dispose() : void
      {
         if(_visualization)
         {
            _visualization.readyToRecycle = true;
         }
         _visualization = null;
         var_1661 = null;
         var_2844 = null;
         var_1681 = null;
      }
      
      public function get y() : Number
      {
         return var_28;
      }
      
      public function set y(param1:Number) : void
      {
         var_28 = param1;
         var_1661.y = var_28;
         if(var_1681)
         {
            var_1681.y = var_1661.y;
         }
      }
      
      public function get x() : Number
      {
         return var_31;
      }
      
      public function set x(param1:Number) : void
      {
         var_31 += (param1 - var_31) * (1 - 0.1);
         var_1661.x = var_31;
         if(var_1681)
         {
            var_1681.x = var_1661.x - 2500;
         }
      }
      
      public function get visualRect() : Rectangle
      {
         return var_1661;
      }
      
      public function get wideRect() : Rectangle
      {
         return !!var_1681 ? var_1681 : var_1661;
      }
      
      public function get hasWideRect() : Boolean
      {
         return var_1681 != null;
      }
      
      public function get centerX() : Number
      {
         return var_31 + var_1661.width / 2;
      }
      
      public function initializePosition(param1:Number, param2:Number) : void
      {
         var _loc3_:Rectangle = _visualization.overlap;
         var_31 = param1 + (!!_loc3_ ? _loc3_.x : 0);
         var_28 = param2 + (!!_loc3_ ? _loc3_.y : 0);
         var_1661.x = var_31;
         var_1661.y = var_28;
         if(var_1681)
         {
            var_1681.x = var_1661.x - 2500;
            var_1681.y = var_1661.y;
         }
      }
      
      public function addHorizontalImpulse(param1:Number) : void
      {
         var_3304 += param1;
      }
      
      public function addCollisionHandled(param1:ChatBubbleSimulationEntity) : void
      {
         var_2844.push(param1);
      }
      
      public function hasCollidedWith(param1:ChatBubbleSimulationEntity) : Boolean
      {
         return var_2844.indexOf(param1) != -1;
      }
      
      public function addVerticalImpulse(param1:Number) : void
      {
         var_3373 += param1;
      }
      
      public function applyImpulseForces(param1:int) : void
      {
         x += var_3304;
         y += Math.max(var_3373,-param1);
      }
      
      public function resetSimulationStep() : void
      {
         var_3304 = 0;
         var_3373 = 0;
         var_2844 = new Vector.<ChatBubbleSimulationEntity>(0);
      }
      
      public function syncToVisualization(param1:Boolean = false) : void
      {
         var _loc2_:Rectangle = _visualization.overlap;
         if(!param1)
         {
            _visualization.moveTo(int(var_31 - (!!_loc2_ ? _loc2_.x : 0)),int(var_28 - (!!_loc2_ ? _loc2_.y : 0)));
         }
         else
         {
            _visualization.warpTo(int(var_31 - (!!_loc2_ ? _loc2_.x : 0)),int(var_28 - (!!_loc2_ ? _loc2_.y : 0)));
         }
      }
      
      public function set fullHeightCollision(param1:Boolean) : void
      {
         if(var_1681)
         {
            var_1681.height = param1 ? var_1661.height : var_1661.height / 2;
         }
      }
      
      public function get visualizationHasHitMargin() : Boolean
      {
         return _visualization.hasHitDesktopMargin;
      }
      
      public function set readyToRecycle(param1:Boolean) : void
      {
         _visualization.readyToRecycle = param1;
      }
      
      public function get readyToRecycle() : Boolean
      {
         return _visualization.readyToRecycle;
      }
      
      public function get timeStamp() : uint
      {
         return _visualization.timeStamp;
      }
      
      public function get isSpacer() : Boolean
      {
         return var_4441;
      }
      
      public function set isSpacer(param1:Boolean) : void
      {
         var_4441 = param1;
      }
      
      public function intersectsWith(param1:ChatBubbleSimulationEntity) : Boolean
      {
         if(var_1681)
         {
            return var_1661.intersects(param1.var_1661) || var_1681.intersects(param1.wideRect);
         }
         if(param1.var_1681)
         {
            return var_1661.intersects(param1.var_1661) || var_1661.intersects(param1.var_1681);
         }
         return var_1661.intersects(param1.var_1661);
      }
      
      public function visualIntertersectsWith(param1:ChatBubbleSimulationEntity) : Boolean
      {
         return var_1661.intersects(param1.var_1661);
      }
   }
}
