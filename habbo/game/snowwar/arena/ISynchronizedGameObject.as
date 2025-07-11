package com.sulake.habbo.game.snowwar.arena
{
   import com.sulake.core.runtime.IDisposable;
   
   public interface ISynchronizedGameObject extends IGameObject, IDisposable
   {
       
      
      function get isActive() : Boolean;
      
      function set isActive(param1:Boolean) : void;
      
      function get numberOfVariables() : int;
      
      function getVariable(param1:int) : int;
      
      function subturn(param1:class_3565) : void;
      
      function onRemove() : void;
   }
}
