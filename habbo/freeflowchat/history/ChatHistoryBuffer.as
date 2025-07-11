package com.sulake.habbo.freeflowchat.history
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.data.ChatItem;
   import com.sulake.habbo.freeflowchat.history.visualization.entry.class_3535;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1675;
   
   public class ChatHistoryBuffer implements IDisposable
   {
       
      
      private const MAX_CHAT_ITEMS:int = 1000;
      
      private var var_1660:HabboFreeFlowChat;
      
      private var var_97:Vector.<class_3535>;
      
      public function ChatHistoryBuffer(param1:HabboFreeFlowChat)
      {
         var_97 = new Vector.<class_3535>(0);
         super();
         var_1660 = param1;
      }
      
      public function dispose() : void
      {
         var_97 = null;
         var_1660 = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_1660 == null;
      }
      
      public function insertChat(param1:ChatItem) : void
      {
         var _loc2_:class_3535 = null;
         try
         {
            _loc2_ = var_1660.chatBubbleFactory.getHistoryLineEntry(param1);
         }
         catch(e:Error)
         {
            if(e.errorID == 2015)
            {
               return;
            }
            throw e;
         }
         var_97.push(_loc2_);
         checkBufferOverflowAndSpliceTop(_loc2_);
         if(var_1660.chatHistoryScrollView.isActive)
         {
            var_1660.chatHistoryScrollView.addHistoryEntry(var_97[var_97.length - 1]);
         }
      }
      
      public function insertRoomChange(param1:class_1675) : void
      {
         var _loc2_:class_3535 = var_1660.chatBubbleFactory.getHistoryRoomChangeEntry(param1);
         var_97.push(_loc2_);
         checkBufferOverflowAndSpliceTop(_loc2_);
      }
      
      private function checkBufferOverflowAndSpliceTop(param1:class_3535) : void
      {
         if(var_97.length > 1000)
         {
            var_1660.chatHistoryScrollView.scrollUpAndSpliceTopItem(param1.bitmap.height - param1.overlap.y - 8);
            var_97.splice(0,1);
         }
      }
      
      public function get entries() : Vector.<class_3535>
      {
         return var_97;
      }
      
      public function get totalHeight() : int
      {
         var _loc2_:int = 0;
         for each(var _loc1_ in var_97)
         {
            _loc2_ += _loc1_.bitmap.height - _loc1_.overlap.y - 8;
         }
         return _loc2_;
      }
   }
}
