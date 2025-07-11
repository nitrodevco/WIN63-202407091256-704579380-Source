package com.sulake.habbo.friendbar.groupforums
{
   import flash.utils.Dictionary;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_1666;
   
   public class MessagesListData
   {
       
      
      private var var_345:int;
      
      private var var_373:int;
      
      private var var_105:int;
      
      private var var_693:Array;
      
      private var var_4230:Dictionary;
      
      public function MessagesListData(param1:int, param2:int, param3:int, param4:Array)
      {
         var _loc5_:int = 0;
         var _loc6_:class_1666 = null;
         super();
         var_345 = param1;
         var_373 = param3;
         var_105 = param2;
         var_693 = param4;
         var_4230 = new Dictionary();
         _loc5_ = 0;
         while(_loc5_ < param4.length)
         {
            _loc6_ = param4[_loc5_];
            var_4230[_loc6_.messageId] = _loc6_;
            _loc5_++;
         }
      }
      
      public function get threadId() : int
      {
         return var_345;
      }
      
      public function get startIndex() : int
      {
         return var_373;
      }
      
      public function get totalMessages() : int
      {
         return var_105;
      }
      
      public function get messages() : Array
      {
         return var_693;
      }
      
      public function get messagesById() : Dictionary
      {
         return var_4230;
      }
      
      public function get size() : int
      {
         return var_693.length;
      }
   }
}
