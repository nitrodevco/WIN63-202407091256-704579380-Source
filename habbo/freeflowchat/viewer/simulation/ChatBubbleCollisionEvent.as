package com.sulake.habbo.freeflowchat.viewer.simulation
{
   public class ChatBubbleCollisionEvent
   {
       
      
      private var var_2048:ChatBubbleSimulationEntity;
      
      private var var_2032:ChatBubbleSimulationEntity;
      
      public function ChatBubbleCollisionEvent(param1:ChatBubbleSimulationEntity, param2:ChatBubbleSimulationEntity)
      {
         super();
         var_2048 = param1;
         var_2032 = param2;
      }
      
      public function get first() : ChatBubbleSimulationEntity
      {
         return var_2048;
      }
      
      public function get second() : ChatBubbleSimulationEntity
      {
         return var_2032;
      }
      
      public function get top() : ChatBubbleSimulationEntity
      {
         return var_2048.y < var_2032.y ? var_2048 : var_2032;
      }
      
      public function get bottom() : ChatBubbleSimulationEntity
      {
         return var_2048.y >= var_2032.y ? var_2048 : var_2032;
      }
      
      public function get left() : ChatBubbleSimulationEntity
      {
         return var_2048.x < var_2032.x ? var_2048 : var_2032;
      }
      
      public function get right() : ChatBubbleSimulationEntity
      {
         return var_2048.x >= var_2032.x ? var_2048 : var_2032;
      }
      
      public function get areSameY() : Boolean
      {
         return int(var_2048.y) == int(var_2032.y);
      }
      
      public function get older() : ChatBubbleSimulationEntity
      {
         return var_2048.timeStamp < var_2032.timeStamp ? var_2048 : var_2032;
      }
   }
}
