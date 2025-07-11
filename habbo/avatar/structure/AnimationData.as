package com.sulake.habbo.avatar.structure
{
   import com.sulake.habbo.avatar.actions.class_3576;
   import com.sulake.habbo.avatar.structure.animation.*;
   import flash.utils.Dictionary;
   
   public class AnimationData implements IStructureData
   {
       
      
      private var var_531:Dictionary;
      
      public function AnimationData()
      {
         super();
         var_531 = new Dictionary();
      }
      
      public function parse(param1:XML) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         for each(var _loc2_ in param1.action)
         {
            var_531[String(_loc2_.@id)] = new AnimationAction(_loc2_);
         }
         return true;
      }
      
      public function appendXML(param1:XML) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         for each(var _loc2_ in param1.action)
         {
            var_531[String(_loc2_.@id)] = new AnimationAction(_loc2_);
         }
         return true;
      }
      
      public function getAction(param1:class_3576) : AnimationAction
      {
         return var_531[param1.id];
      }
      
      public function getFrameCount(param1:class_3576) : int
      {
         var _loc2_:AnimationAction = getAction(param1);
         if(!_loc2_)
         {
            return 0;
         }
         return _loc2_.frameCount;
      }
   }
}
