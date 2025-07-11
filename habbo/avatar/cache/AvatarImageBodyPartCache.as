package com.sulake.habbo.avatar.cache
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.actions.class_3544;
   
   public class AvatarImageBodyPartCache
   {
       
      
      private var _cache:Map;
      
      private var var_2657:class_3544;
      
      private var var_3893:int;
      
      private var _disposed:Boolean;
      
      public function AvatarImageBodyPartCache()
      {
         super();
         _cache = new Map();
      }
      
      public function setAction(param1:class_3544, param2:int) : void
      {
         if(var_2657 == null)
         {
            var_2657 = param1;
         }
         var _loc3_:AvatarImageActionCache = getActionCache(var_2657);
         if(_loc3_ != null)
         {
            _loc3_.setLastAccessTime(param2);
         }
         var_2657 = param1;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_cache == null)
            {
               return;
            }
            if(_cache)
            {
               disposeActions(0,2147483647);
               _cache.dispose();
               _cache = null;
            }
            _disposed = true;
         }
      }
      
      public function disposeActions(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc5_:AvatarImageActionCache = null;
         var _loc6_:* = null;
         if(_cache == null || _disposed)
         {
            return;
         }
         var _loc4_:Array = _cache.getKeys();
         for each(_loc6_ in _loc4_)
         {
            if((_loc5_ = _cache.getValue(_loc6_) as AvatarImageActionCache) != null)
            {
               _loc3_ = _loc5_.getLastAccessTime();
               if(param2 - _loc3_ >= param1)
               {
                  _loc5_.dispose();
                  _cache.remove(_loc6_);
               }
            }
         }
      }
      
      public function getAction() : class_3544
      {
         return var_2657;
      }
      
      public function setDirection(param1:int) : void
      {
         var_3893 = param1;
      }
      
      public function getDirection() : int
      {
         return var_3893;
      }
      
      public function getActionCache(param1:class_3544 = null) : AvatarImageActionCache
      {
         if(!var_2657)
         {
            return null;
         }
         if(param1 == null)
         {
            param1 = var_2657;
         }
         if(param1.overridingAction != null)
         {
            return _cache.getValue(param1.overridingAction) as AvatarImageActionCache;
         }
         return _cache.getValue(param1.id) as AvatarImageActionCache;
      }
      
      public function updateActionCache(param1:class_3544, param2:AvatarImageActionCache) : void
      {
         if(param1.overridingAction != null)
         {
            _cache.add(param1.overridingAction,param2);
         }
         else
         {
            _cache.add(param1.id,param2);
         }
      }
      
      private function debugInfo(param1:String) : void
      {
      }
   }
}
