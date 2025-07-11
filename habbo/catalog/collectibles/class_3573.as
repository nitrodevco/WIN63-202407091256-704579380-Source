package com.sulake.habbo.catalog.collectibles
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.class_3499;
   
   public interface class_3573 extends IGetImageListener, IDisposable
   {
       
      
      function clearPreviewer() : void;
      
      function set imageResult(param1:class_3499) : void;
      
      function set avatarResult(param1:String) : void;
      
      function set badgeResult(param1:String) : void;
      
      function set petResult(param1:String) : void;
      
      function setEffectResult(param1:String, param2:int) : void;
      
      function setUnknownImage() : void;
   }
}
