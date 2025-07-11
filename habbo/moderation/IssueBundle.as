package com.sulake.habbo.moderation
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.messages.parser.moderation.class_1722;
   
   public class IssueBundle
   {
       
      
      private var var_280:int;
      
      private var var_314:Map;
      
      private var var_149:int;
      
      private var var_1062:int = 0;
      
      private var _pickerName:String = "";
      
      private var var_874:int;
      
      private var var_1131:int;
      
      private var var_437:int = 0;
      
      private var var_722:int = 0;
      
      private var var_2486:class_1722 = null;
      
      private var _highestPriorityIssue:class_1722 = null;
      
      public function IssueBundle(param1:int, param2:class_1722)
      {
         super();
         var_280 = param1;
         var_314 = new Map();
         var_149 = param2.state;
         var_1062 = param2.pickerUserId;
         _pickerName = param2.pickerUserName;
         var_874 = param2.reportedUserId;
         var_1131 = param2.groupingId;
         addIssue(param2);
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function get issues() : Array
      {
         return var_314.getValues();
      }
      
      public function get state() : int
      {
         return var_149;
      }
      
      public function get pickerUserId() : int
      {
         return var_1062;
      }
      
      public function get pickerName() : String
      {
         return _pickerName;
      }
      
      public function matches(param1:class_1722, param2:Boolean = false) : Boolean
      {
         if(var_1131 == 0 || param1.groupingId == 0)
         {
            return false;
         }
         if(var_1131 != param1.groupingId || var_874 != param1.reportedUserId)
         {
            return false;
         }
         if(!param2)
         {
            if(state != param1.state)
            {
               return false;
            }
            if(pickerUserId != param1.pickerUserId)
            {
               return false;
            }
         }
         return true;
      }
      
      public function contains(param1:int) : Boolean
      {
         if(var_314 == null)
         {
            return false;
         }
         return var_314.getKeys().indexOf(param1) > -1;
      }
      
      public function updateIssue(param1:class_1722) : void
      {
         removeIssue(param1.issueId);
         addIssue(param1);
      }
      
      private function addIssue(param1:class_1722) : void
      {
         var_314.add(param1.issueId,param1);
         var_722 = param1.issueAgeInMilliseconds;
         if(param1.message != null && param1.message != "")
         {
            var_437++;
         }
         if(var_2486 == null || param1.issueAgeInMilliseconds > var_2486.issueAgeInMilliseconds)
         {
            var_2486 = param1;
         }
         _highestPriorityIssue = null;
         getHighestPriorityIssue();
      }
      
      public function removeIssue(param1:int) : class_1722
      {
         var _loc2_:class_1722 = var_314.remove(param1) as class_1722;
         if(_loc2_ != null)
         {
            if(_loc2_.message != null && _loc2_.message != "")
            {
               var_437--;
            }
            if(var_2486 == _loc2_)
            {
               var_2486 = null;
            }
            if(_highestPriorityIssue == _loc2_)
            {
               _highestPriorityIssue = null;
            }
         }
         return _loc2_;
      }
      
      public function get highestPriority() : int
      {
         if(_highestPriorityIssue == null)
         {
            getHighestPriorityIssue();
         }
         if(_highestPriorityIssue != null)
         {
            return _highestPriorityIssue.priority;
         }
         return 0;
      }
      
      public function getHighestPriorityIssue() : class_1722
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:int = 0;
         var _loc1_:class_1722 = null;
         var _loc5_:Boolean = false;
         if(_highestPriorityIssue == null)
         {
            if(var_314 == null || var_314.length < 1)
            {
               return null;
            }
            _loc2_ = 0;
            while(_loc2_ < var_314.length)
            {
               _loc1_ = var_314.getWithIndex(_loc2_);
               if(_loc5_ = _loc1_.reportedCategoryId > 0 && _loc1_.reportedCategoryId < 100)
               {
                  if(_loc4_ == null || _loc4_.priority > _loc1_.priority)
                  {
                     _loc4_ = _loc1_;
                  }
               }
               else if(_loc3_ == null || _loc3_.priority > _loc1_.priority)
               {
                  _loc3_ = _loc1_;
               }
               _loc2_++;
            }
            if(_loc4_ != null)
            {
               _highestPriorityIssue = _loc4_;
            }
            else
            {
               _highestPriorityIssue = _loc3_;
            }
         }
         return _highestPriorityIssue;
      }
      
      public function getIssueCount() : int
      {
         if(var_314 == null)
         {
            return 0;
         }
         return var_314.length;
      }
      
      public function getIssueIds() : Array
      {
         if(var_314 == null)
         {
            return [];
         }
         return var_314.getKeys();
      }
      
      public function get reportedUserId() : int
      {
         return var_874;
      }
      
      public function getMessageCount() : int
      {
         return var_437;
      }
      
      public function get issueAgeInMilliseconds() : int
      {
         return var_722;
      }
      
      public function getOpenTime(param1:int) : String
      {
         var _loc2_:* = null;
         var _loc3_:* = var_2486;
         if(_loc3_ == null)
         {
            for each(_loc2_ in var_314)
            {
               if(_loc3_ == null || _loc2_.issueAgeInMilliseconds > _loc3_.issueAgeInMilliseconds)
               {
                  _loc3_ = _loc2_;
               }
            }
            var_2486 = _loc3_;
         }
         if(_loc3_ != null)
         {
            return _loc3_.getOpenTime(param1);
         }
         return "";
      }
   }
}
