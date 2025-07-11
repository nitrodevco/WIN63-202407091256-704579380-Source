package com.sulake.habbo.avatar.geometry
{
   import flash.utils.Dictionary;
   
   public class AvatarSet
   {
       
      
      private var var_280:String;
      
      private var var_3313:Dictionary;
      
      private var var_4016:Array;
      
      private var var_4622:Array;
      
      private var _isMain:Boolean;
      
      public function AvatarSet(param1:XML)
      {
         var _loc4_:AvatarSet = null;
         super();
         var_280 = String(param1.@id);
         var _loc3_:String = String(param1.@main);
         _isMain = _loc3_ == null ? false : Boolean(parseInt(_loc3_));
         var_3313 = new Dictionary();
         var_4016 = [];
         for each(var _loc6_ in param1.avatarset)
         {
            _loc4_ = new AvatarSet(_loc6_);
            var_3313[String(_loc6_.@id)] = _loc4_;
         }
         for each(var _loc2_ in param1.bodypart)
         {
            var_4016.push(String(_loc2_.@id));
         }
         var _loc5_:Array = var_4016.concat();
         for each(_loc4_ in var_3313)
         {
            _loc5_ = _loc5_.concat(_loc4_.getBodyParts());
         }
         var_4622 = _loc5_;
      }
      
      public function findAvatarSet(param1:String) : AvatarSet
      {
         if(param1 == var_280)
         {
            return this;
         }
         for each(var _loc2_ in var_3313)
         {
            if(_loc2_.findAvatarSet(param1) != null)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getBodyParts() : Array
      {
         return var_4622.concat();
      }
      
      public function get id() : String
      {
         return var_280;
      }
      
      public function get isMain() : Boolean
      {
         if(_isMain)
         {
            return true;
         }
         for each(var _loc1_ in var_3313)
         {
            if(_loc1_.isMain)
            {
               return true;
            }
         }
         return false;
      }
   }
}
