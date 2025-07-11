package com.sulake.habbo.friendbar.groupforums
{
   import flash.utils.Dictionary;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_1740;
   
   public class ThreadsListData
   {
      
      public static const PAGE_SIZE:int = 20;
       
      
      private var var_150:int;
      
      private var var_373:int;
      
      private var var_658:Array;
      
      private var var_4019:Dictionary;
      
      public function ThreadsListData(param1:int, param2:int, param3:Array)
      {
         var _loc4_:int = 0;
         var _loc5_:class_1740 = null;
         super();
         var_150 = param1;
         var_373 = param2;
         var_658 = param3;
         var_4019 = new Dictionary();
         _loc4_ = 0;
         while(_loc4_ < param3.length)
         {
            _loc5_ = param3[_loc4_];
            var_4019[_loc5_.threadId] = _loc5_;
            _loc4_++;
         }
      }
      
      public function get totalThreads() : int
      {
         return var_150;
      }
      
      public function get startIndex() : int
      {
         return var_373;
      }
      
      public function get threads() : Array
      {
         return var_658;
      }
      
      public function get threadsById() : Dictionary
      {
         return var_4019;
      }
      
      public function get size() : int
      {
         return var_658.length;
      }
      
      public function updateThread(param1:class_1740) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:class_1740 = null;
         threadsById[param1.threadId] = param1;
         _loc3_ = 0;
         while(_loc3_ < threads.length)
         {
            _loc2_ = threads[_loc3_];
            if(_loc2_.threadId == param1.threadId)
            {
               threads[_loc3_] = param1;
               return true;
            }
            _loc3_++;
         }
         return false;
      }
   }
}
