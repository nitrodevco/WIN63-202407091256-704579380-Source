package com.sulake.habbo.avatar.cache
{
   import com.sulake.habbo.avatar.AvatarImageBodyPartContainer;
   import com.sulake.habbo.avatar.AvatarImagePartContainer;
   import flash.utils.Dictionary;
   
   public class AvatarImageDirectionCache
   {
      
      private static const KEY_SEPARATOR:String = "/";
      
      private static const NO_FRAMES_KEY:String = "-";
       
      
      private var var_2409:Vector.<AvatarImagePartContainer>;
      
      private var var_709:Dictionary;
      
      private var _keyCache:Dictionary;
      
      public function AvatarImageDirectionCache(param1:Vector.<AvatarImagePartContainer>)
      {
         super();
         var_709 = new Dictionary();
         var_2409 = param1;
         _keyCache = new Dictionary();
      }
      
      public function dispose() : void
      {
         for each(var _loc1_ in var_709)
         {
            if(_loc1_)
            {
               _loc1_.dispose();
            }
         }
         var_709 = null;
         var_2409 = null;
         _keyCache = null;
      }
      
      public function getPartList() : Vector.<AvatarImagePartContainer>
      {
         return var_2409;
      }
      
      public function getImageContainer(param1:int) : AvatarImageBodyPartContainer
      {
         var _loc2_:String = getCacheKey(param1);
         return var_709[_loc2_];
      }
      
      public function updateImageContainer(param1:AvatarImageBodyPartContainer, param2:int) : void
      {
         var _loc4_:AvatarImageBodyPartContainer = null;
         var _loc3_:String = getCacheKey(param2);
         if(var_709[_loc3_])
         {
            if(_loc4_ = var_709[_loc3_] as AvatarImageBodyPartContainer)
            {
               _loc4_.dispose();
            }
         }
         var_709[_loc3_] = param1;
      }
      
      private function getCacheKey(param1:int) : String
      {
         var _loc4_:int = 0;
         if(var_2409 == null || var_2409.length == 0)
         {
            return "-";
         }
         var _loc2_:String = String(_keyCache[param1]);
         if(_loc2_)
         {
            return _loc2_;
         }
         var _loc5_:AvatarImagePartContainer;
         _loc2_ = (_loc5_ = var_2409[0] as AvatarImagePartContainer).getCacheableKey(param1);
         var _loc3_:int = int(var_2409.length);
         _loc4_ = 1;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = var_2409[_loc4_] as AvatarImagePartContainer;
            _loc2_ += "/" + _loc5_.getCacheableKey(param1);
            _loc4_++;
         }
         _keyCache[param1] = _loc2_;
         return _loc2_;
      }
   }
}
