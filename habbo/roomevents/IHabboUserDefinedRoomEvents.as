package com.sulake.habbo.roomevents
{
   import com.sulake.core.runtime.IUnknown;
   
   public interface IHabboUserDefinedRoomEvents extends IUnknown
   {
       
      
      function stuffSelected(param1:int) : void;
      
      function userSelected(param1:int) : void;
      
      function showInspectButton() : Boolean;
      
      function showToolbarMenuButton() : Boolean;
   }
}
