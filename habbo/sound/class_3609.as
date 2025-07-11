package com.sulake.habbo.sound
{
   import com.sulake.core.runtime.IDisposable;
   
   public interface class_3609 extends IDisposable
   {
       
      
      function get priority() : int;
      
      function get length() : int;
      
      function get playPosition() : int;
      
      function get nowPlayingSongId() : int;
      
      function get isPlaying() : Boolean;
      
      function getEntry(param1:int) : ISongInfo;
      
      function requestPlayList() : void;
   }
}
