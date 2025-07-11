package com.sulake.habbo.freeflowchat.viewer.simulation
{
   import com.sulake.habbo.freeflowchat.viewer.visualization.PooledChatBubble;
   import flash.geom.Rectangle;
   
   public class ChatBubbleSimulationWithLimitedWideRect extends ChatBubbleSimulationEntity
   {
      
      public static const WIDERECT_WIDTH:int = 240;
       
      
      private var _wideRectOffset:Number;
      
      public function ChatBubbleSimulationWithLimitedWideRect(param1:PooledChatBubble)
      {
         super(param1,false);
         var_1681 = new Rectangle();
         var_1681.width = 240;
         var_1681.height = var_1661.height / 2;
         _wideRectOffset = -(240 - var_1661.width) / 2;
         var_1681.x = var_1661.x + _wideRectOffset;
         var_1681.y = var_1661.y;
      }
      
      override public function set x(param1:Number) : void
      {
         var_31 += (param1 - var_31) * (1 - 0.1);
         var_1661.x = var_31;
         if(var_1681)
         {
            var_1681.x = var_1661.x + _wideRectOffset;
         }
      }
      
      override public function initializePosition(param1:Number, param2:Number) : void
      {
         var _loc3_:Rectangle = _visualization.overlap;
         var_31 = param1 + (!!_loc3_ ? _loc3_.x : 0);
         var_28 = param2 + (!!_loc3_ ? _loc3_.y : 0);
         var_1661.x = var_31;
         var_1661.y = var_28;
         if(var_1681)
         {
            var_1681.x = var_1661.x + _wideRectOffset;
            var_1681.y = var_1661.y;
         }
      }
      
      public function get wideRectOffset() : Number
      {
         return _wideRectOffset;
      }
      
      public function set wideRectOffset(param1:Number) : void
      {
         _wideRectOffset = param1;
      }
   }
}
