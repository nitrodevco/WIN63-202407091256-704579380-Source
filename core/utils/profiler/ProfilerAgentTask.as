package com.sulake.core.utils.profiler
{
   import com.sulake.core.runtime.IDisposable;
   import flash.utils.getTimer;
   
   public class ProfilerAgentTask implements IDisposable
   {
       
      
      private var _name:String;
      
      private var var_220:uint;
      
      private var var_543:int;
      
      private var var_762:int;
      
      private var var_511:Number;
      
      private var _caption:String;
      
      private var var_92:Boolean;
      
      private var _disposed:Boolean = false;
      
      private var _children:Array;
      
      private var _startTime:uint;
      
      private var var_144:Boolean = false;
      
      public function ProfilerAgentTask(param1:String, param2:String = "")
      {
         super();
         _name = param1;
         var_220 = 0;
         var_511 = 0;
         var_92 = false;
         _children = [];
         _caption = param2;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _disposed = true;
         }
      }
      
      public function start() : void
      {
         if(!var_92)
         {
            _startTime = getTimer();
            var_92 = true;
         }
      }
      
      public function stop() : void
      {
         if(var_92)
         {
            var_762 = getTimer() - _startTime;
            var_220++;
            var_543 += var_762;
            var_511 = var_543 / var_220;
            var_92 = false;
         }
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get rounds() : uint
      {
         return var_220;
      }
      
      public function get total() : int
      {
         return var_543;
      }
      
      public function get latest() : int
      {
         return var_762;
      }
      
      public function get average() : Number
      {
         return var_511;
      }
      
      public function get caption() : String
      {
         return _caption;
      }
      
      public function set caption(param1:String) : void
      {
         _caption = caption;
      }
      
      public function get running() : Boolean
      {
         return var_92;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get paused() : Boolean
      {
         return var_144;
      }
      
      public function set paused(param1:Boolean) : void
      {
         var_144 = param1;
      }
      
      public function get numSubTasks() : uint
      {
         return _children.length;
      }
      
      public function addSubTask(param1:ProfilerAgentTask) : void
      {
         if(getSubTaskByName(param1.name) != null)
         {
            throw new Error("Component profiler task with name \"" + param1.name + "\" already exists!");
         }
         _children.push(param1);
      }
      
      public function removeSubTask(param1:ProfilerAgentTask) : ProfilerAgentTask
      {
         var _loc2_:int = _children.indexOf(param1);
         if(_loc2_ > -1)
         {
            _children.splice(_loc2_,1);
         }
         return param1;
      }
      
      public function getSubTaskAt(param1:uint) : ProfilerAgentTask
      {
         return _children[param1] as ProfilerAgentTask;
      }
      
      public function getSubTaskByName(param1:String) : ProfilerAgentTask
      {
         var _loc2_:ProfilerAgentTask = null;
         var _loc3_:uint = _children.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _children[_loc4_++] as ProfilerAgentTask;
            if(_loc2_.name == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}
