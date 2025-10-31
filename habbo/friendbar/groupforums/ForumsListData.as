package com.sulake.habbo.friendbar.groupforums
{
   import com.sulake.habbo.communication.messages.parser.groupforums.ForumsListMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_1754;
   
   public class ForumsListData
   {
       
      
      private var var_1282:int;
      
      private var _totalAmount:int;
      
      private var var_373:int;
      
      private var _forums:Array;
      
      public function ForumsListData(param1:ForumsListMessageEventParser)
      {
         super();
         var_1282 = param1.listCode;
         _totalAmount = param1.totalAmount;
         var_373 = param1.startIndex;
         _forums = param1.forums;
      }
      
      public function get listCode() : int
      {
         return var_1282;
      }
      
      public function get totalAmount() : int
      {
         return _totalAmount;
      }
      
      public function get startIndex() : int
      {
         return var_373;
      }
      
      public function get forums() : Array
      {
         return _forums;
      }
      
      public function get unreadForumsCount() : int
      {
         var _loc3_:int = 0;
         var _loc1_:class_1754 = null;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _forums.length)
         {
            _loc1_ = _forums[_loc3_];
            if(_loc1_.unreadMessages > 0)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getForumData(param1:int) : class_1754
      {
         for each(var _loc2_ in _forums)
         {
            if(_loc2_.groupId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function updateUnreadMessages(param1:class_1754, param2:int) : void
      {
         var _loc3_:class_1754 = getForumData(param1.groupId);
         if(_loc3_ != null)
         {
            _loc3_.updateFrom(param1);
            _loc3_.lastReadMessageId = param2;
         }
      }
   }
}
