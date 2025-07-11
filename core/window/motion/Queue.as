package com.sulake.core.window.motion
{
   use namespace friend;
   
   public class Queue extends Motion
   {
       
      
      private var var_1911:Motion;
      
      private var var_81:Vector.<Motion>;
      
      public function Queue(... rest)
      {
         var_81 = new Vector.<Motion>();
         super(!!rest ? Motion(rest[0]).target : null);
         for each(var _loc2_ in rest)
         {
            var_81.push(_loc2_);
         }
         var_1911 = rest[0];
         var_1808 = var_1911 == null;
      }
      
      override public function get running() : Boolean
      {
         return var_92 && var_1911 ? var_1911.running : false;
      }
      
      override friend function start() : void
      {
         super.friend::start();
         var_1911.friend::start();
      }
      
      override friend function update(param1:Number) : void
      {
         super.friend::update(param1);
         if(var_1911.running)
         {
            var_1911.friend::update(param1);
         }
      }
      
      override friend function stop() : void
      {
         super.friend::stop();
         var_1911.friend::stop();
      }
      
      override friend function tick(param1:int) : void
      {
         var _loc2_:int = 0;
         super.friend::tick(param1);
         var_1911.friend::tick(param1);
         if(var_1911.complete)
         {
            var_1911.friend::stop();
            _loc2_ = var_81.indexOf(var_1911);
            if(_loc2_ < var_81.length - 1)
            {
               var_1911 = var_81[_loc2_ + 1];
               var_294 = var_1911.target;
               var_1911.friend::start();
            }
            else
            {
               var_1808 = true;
            }
         }
      }
   }
}
