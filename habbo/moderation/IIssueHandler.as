package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.IDisposable;
   
   public interface IIssueHandler extends IDisposable
   {
       
      
      function updateIssuesAndMessages() : void;
      
      function showDefaultSanction(param1:int, param2:String) : void;
   }
}
