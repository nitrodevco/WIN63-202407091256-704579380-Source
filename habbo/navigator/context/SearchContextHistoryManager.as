package com.sulake.habbo.navigator.context
{
   import com.sulake.habbo.navigator.HabboNewNavigator;
   
   public class SearchContextHistoryManager
   {
       
      
      private var var_2171:Vector.<SearchContext>;
      
      private var _browsingOffset:int = -1;
      
      public function SearchContextHistoryManager(param1:HabboNewNavigator)
      {
         var_2171 = new Vector.<SearchContext>(0);
         super();
      }
      
      public function addSearchContextAtCurrentOffset(param1:SearchContext) : int
      {
         if(var_2171.length > _browsingOffset + 1)
         {
            var_2171.splice(_browsingOffset + 1,var_2171.length - _browsingOffset);
         }
         var_2171.push(param1);
         return ++_browsingOffset;
      }
      
      public function getPreviousSearchContextAndGoBack() : SearchContext
      {
         if(hasPrevious)
         {
            return var_2171[--_browsingOffset];
         }
         return null;
      }
      
      public function getNextSearchContextAndMoveForward() : SearchContext
      {
         if(hasNext)
         {
            return var_2171[++_browsingOffset];
         }
         return null;
      }
      
      public function get hasNext() : Boolean
      {
         return _browsingOffset + 1 < var_2171.length;
      }
      
      public function get hasPrevious() : Boolean
      {
         return _browsingOffset > 0 && var_2171.length > 0;
      }
      
      public function toString() : String
      {
         var _loc1_:int = 0;
         var _loc2_:String = "history: [";
         _loc1_ = 0;
         while(_loc1_ < var_2171.length)
         {
            _loc2_ += var_2171[_loc1_].toString();
            if(_loc1_ < var_2171.length - 1)
            {
               _loc2_ = _loc2_ += ",";
            }
            _loc1_++;
         }
         return _loc2_ + "] browsing offset: " + _browsingOffset;
      }
   }
}
