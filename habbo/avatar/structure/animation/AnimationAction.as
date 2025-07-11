package com.sulake.habbo.avatar.structure.animation
{
   import com.sulake.core.utils.Map;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class AnimationAction
   {
      
      public static const DEFAULT_OFFSET:Point = new Point(0,0);
       
      
      private var var_280:String;
      
      private var var_3736:Dictionary;
      
      private var var_4104:Map;
      
      private var var_2225:int;
      
      private var var_2324:Array;
      
      public function AnimationAction(param1:XML)
      {
         var _loc10_:AnimationActionPart = null;
         var _loc5_:int = 0;
         var _loc12_:Map = null;
         var _loc6_:int = 0;
         var _loc4_:Map = null;
         var _loc11_:String = null;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc3_:int = 0;
         var_4104 = new Map();
         super();
         var_280 = String(param1.@id);
         var_3736 = new Dictionary();
         for each(var _loc8_ in param1.part)
         {
            _loc10_ = new AnimationActionPart(_loc8_);
            var_3736[String(_loc8_["set-type"])] = _loc10_;
            var_2225 = Math.max(var_2225,_loc10_.frames.length);
         }
         var_2324 = [];
         for each(var _loc2_ in param1.offsets.frame)
         {
            _loc5_ = parseInt(_loc2_.@id);
            var_2225 = Math.max(var_2225,_loc5_);
            _loc12_ = new Map();
            var_4104[_loc5_] = _loc12_;
            for each(var _loc9_ in _loc2_.directions.direction)
            {
               _loc6_ = parseInt(_loc9_.@id);
               _loc4_ = new Map();
               _loc12_[_loc6_] = _loc4_;
               for each(var _loc7_ in _loc9_.bodypart)
               {
                  _loc11_ = String(_loc7_.@id);
                  _loc13_ = _loc7_.hasOwnProperty("@dx") ? parseInt(_loc7_.@dx) : 0;
                  _loc14_ = _loc7_.hasOwnProperty("@dy") ? parseInt(_loc7_.@dy) : 0;
                  _loc4_[_loc11_] = new Point(_loc13_,_loc14_);
               }
            }
            var_2324.push(_loc5_);
            _loc3_ = parseInt(_loc2_.@repeats);
            if(_loc3_ > 1)
            {
               while(true)
               {
                  _loc3_--;
                  if(_loc3_ <= 0)
                  {
                     break;
                  }
                  var_2324.push(_loc5_);
               }
            }
         }
      }
      
      public function getPart(param1:String) : AnimationActionPart
      {
         return var_3736[param1] as AnimationActionPart;
      }
      
      public function get id() : String
      {
         return var_280;
      }
      
      public function get parts() : Dictionary
      {
         return var_3736;
      }
      
      public function get frameCount() : int
      {
         return var_2225;
      }
      
      public function getFrameBodyPartOffset(param1:int, param2:int, param3:String) : Point
      {
         var _loc8_:Point = null;
         var _loc6_:Map = null;
         var _loc7_:int = param2 % var_2324.length;
         var _loc4_:int = int(var_2324[_loc7_]);
         var _loc5_:Map;
         if(_loc5_ = var_4104[_loc4_])
         {
            if(_loc6_ = _loc5_[param1])
            {
               _loc8_ = _loc6_[param3];
            }
         }
         return _loc8_ != null ? _loc8_ : DEFAULT_OFFSET;
      }
   }
}
