package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.components.class_3514;
   
   public interface ITrackedWindow extends IDisposable
   {
       
      
      function getType() : int;
      
      function getId() : String;
      
      function getFrame() : class_3514;
      
      function show() : void;
   }
}
