package com.sulake.habbo.catalog.offers
{
   import com.sulake.core.runtime.IDisposable;
   
   public interface IOfferProvider extends IDisposable
   {
       
      
      function get enabled() : Boolean;
      
      function load() : void;
      
      function showVideo() : void;
      
      function get videoAvailable() : Boolean;
      
      function get showingPopup() : Boolean;
   }
}
