package com.sulake.habbo.catalog
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.habbo.catalog.enum.VideoOfferTypeEnum;
   import flash.external.ExternalInterface;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.handshake.class_143;
   
   public class VideoOfferManager implements IVideoOfferManager, IDisposable
   {
      
      private static const CAMPAIGN_READY_CALLBACK:String = "supersaverAdsOnCampaignsReady";
      
      private static const CAMPAIGN_COMPLETE_CALLBACK:String = "supersaverAdsOnCampaignCompleted";
      
      private static const CAMPAIGN_OPEN_CALLBACK:String = "supersaverAdsOnCampaignOpen";
      
      private static const CAMPAIGN_CLOSE_CALLBACK:String = "supersaverAdsOnCampaignClose";
      
      private static const const_712:String = "supersaverAdsLoadCampaigns";
      
      private static const const_656:String = "supersaverAdsCamapaignEngage";
       
      
      private var _disposed:Boolean;
      
      private var _catalog:HabboCatalog;
      
      private var var_593:Boolean;
      
      private var _offersAvailable:int;
      
      private var _offersViewed:int = 0;
      
      private var _offersRequested:Boolean;
      
      private var _offersReceived:Boolean;
      
      private var _launchers:Vector.<IVideoOfferLauncher>;
      
      private var _callbacksAdded:Boolean;
      
      public function VideoOfferManager(param1:HabboCatalog)
      {
         super();
         _catalog = param1;
         _launchers = new Vector.<IVideoOfferLauncher>();
         var_593 = false;
         _catalog.connection.addMessageEvent(new class_143(onUserRights));
         addCallbacks();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get enabled() : Boolean
      {
         return var_593;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _catalog = null;
         _launchers = null;
         var_593 = false;
         if(_callbacksAdded && ExternalInterface.available)
         {
            ExternalInterface.addCallback("supersaverAdsOnCampaignsReady",null);
            ExternalInterface.addCallback("supersaverAdsOnCampaignCompleted",null);
            ExternalInterface.addCallback("supersaverAdsOnCampaignOpen",null);
            ExternalInterface.addCallback("supersaverAdsOnCampaignClose",null);
            _callbacksAdded = false;
         }
         _disposed = true;
      }
      
      private function addCallbacks() : void
      {
         if(var_593 && !_callbacksAdded && ExternalInterface.available)
         {
            ExternalInterface.addCallback("supersaverAdsOnCampaignsReady",onCampaignsReady);
            ExternalInterface.addCallback("supersaverAdsOnCampaignCompleted",onCampaignComplete);
            ExternalInterface.addCallback("supersaverAdsOnCampaignOpen",onCampaignOpen);
            ExternalInterface.addCallback("supersaverAdsOnCampaignClose",onCampaignClose);
            _callbacksAdded = true;
         }
      }
      
      private function onUserRights(param1:class_143) : void
      {
         if(param1.securityLevel >= 1)
         {
            var_593 = false;
            addCallbacks();
         }
      }
      
      public function load(param1:IVideoOfferLauncher) : void
      {
         if(!var_593)
         {
            return;
         }
         if(_offersRequested && _offersReceived)
         {
            param1.offersAvailable(_offersAvailable);
         }
         else
         {
            if(!_offersRequested && ExternalInterface.available)
            {
               ExternalInterface.call("supersaverAdsLoadCampaigns");
               _offersRequested = true;
            }
            _launchers.push(param1);
         }
      }
      
      public function launch(param1:VideoOfferTypeEnum) : Boolean
      {
         if(!var_593 || _offersAvailable < 1)
         {
            return false;
         }
         if(ExternalInterface.available)
         {
            _offersViewed += 1;
            ExternalInterface.call("supersaverAdsCamapaignEngage");
            turnVolumeDown();
            if(_catalog.connection)
            {
               _catalog.connection.send(new EventLogMessageComposer("SuperSaverAds","client_action","supersaverads.video.promo.launched"));
            }
            return _offersAvailable > _offersViewed;
         }
         return false;
      }
      
      public function onCampaignsReady(param1:String) : void
      {
         _offersReceived = true;
         _offersAvailable = parseInt(param1);
         if(isNaN(_offersAvailable))
         {
            _offersAvailable = 0;
         }
         while(_launchers.length > 0)
         {
            _launchers.pop().offersAvailable(_offersAvailable);
         }
      }
      
      public function onCampaignOpen() : void
      {
      }
      
      public function onCampaignClose() : void
      {
         turnVolumeUp();
         if(_catalog.connection)
         {
            _catalog.connection.send(new EventLogMessageComposer("SuperSaverAds","client_action","supersaverads.video.promo.close"));
         }
      }
      
      public function onCampaignComplete() : void
      {
         turnVolumeUp();
         if(_catalog.connection)
         {
            _catalog.connection.send(new EventLogMessageComposer("SuperSaverAds","client_action","supersaverads.video.promo.complete"));
         }
      }
      
      private function turnVolumeDown() : void
      {
         if(_catalog.soundManager)
         {
            _catalog.soundManager.mute(true);
         }
      }
      
      private function turnVolumeUp() : void
      {
         if(_catalog.soundManager)
         {
            _catalog.soundManager.mute(false);
         }
      }
   }
}
