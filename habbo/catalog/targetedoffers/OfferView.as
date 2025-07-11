package com.sulake.habbo.catalog.targetedoffers
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.catalog.targetedoffers.data.TargetedOffer;
   import com.sulake.habbo.catalog.targetedoffers.util.class_3667;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class OfferView implements IDisposable
   {
       
      
      protected var _window:IWindowContainer;
      
      protected var var_319:OfferController;
      
      protected var _offer:TargetedOffer;
      
      protected var var_1794:Timer;
      
      protected var _disposed:Boolean;
      
      protected var var_2349:String;
      
      public function OfferView(param1:OfferController, param2:TargetedOffer)
      {
         super();
         var_319 = param1;
         _offer = param2;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(var_1794 != null)
         {
            var_1794.stop();
            var_1794 = null;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      protected function startUpdateTimer() : void
      {
         var_1794 = new Timer(1000);
         var_1794.addEventListener("timer",onUpdateTimer);
         var_1794.start();
         updateRemainingTime();
      }
      
      protected function onUpdateTimer(param1:TimerEvent) : void
      {
         updateRemainingTime();
      }
      
      protected function updateRemainingTime() : void
      {
         setTimeLeft(class_3667.getStringFromSeconds(var_319.catalog.localization,_offer.getSecondsRemaining()));
         if(_offer.getSecondsRemaining() == 0)
         {
            var_319.destroyView();
         }
      }
      
      protected function setTimeLeft(param1:String) : void
      {
         var _loc2_:ITextWindow = ITextWindow(_window.findChildByName("txt_time_left"));
         if(!_loc2_)
         {
            return;
         }
         _loc2_.text = var_2349 != "" ? var_2349.replace("%timeleft%",param1) : param1;
      }
      
      protected function getLocalization(param1:String, param2:String = null) : String
      {
         var _loc3_:String = String(var_319.catalog.localization.getLocalization(param1,param2 || param1));
         if(!_loc3_)
         {
            return null;
         }
         if(_offer)
         {
            _loc3_ = _loc3_.replace("%itemsleft%",_offer.purchaseLimit);
         }
         return _loc3_;
      }
   }
}
