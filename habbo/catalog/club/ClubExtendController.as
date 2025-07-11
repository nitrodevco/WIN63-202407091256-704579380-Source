package com.sulake.habbo.catalog.club
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.ICoreConfiguration;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.communication.messages.parser.catalog.class_1307;
   import com.sulake.habbo.communication.messages.outgoing.tracking.class_955;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_1646;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_786;
   
   public class ClubExtendController
   {
       
      
      private var _catalog:HabboCatalog;
      
      private var var_1715:ClubExtendConfirmationDialog;
      
      private var _offer:class_1646;
      
      private var _disposed:Boolean = false;
      
      public function ClubExtendController(param1:HabboCatalog)
      {
         super();
         _catalog = param1;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         closeConfirmation();
         _offer = null;
         _catalog = null;
         _disposed = true;
      }
      
      public function onOffer(param1:class_786) : void
      {
         if(_disposed)
         {
            return;
         }
         var _loc2_:class_1307 = param1.getParser();
         _offer = _loc2_.offer();
         showConfirmation();
         if(_catalog.connection)
         {
            if(_offer.vip)
            {
               _catalog.connection.send(new class_955("Catalog","dialog_show","vip.membership.extension.purchase"));
            }
            else
            {
               _catalog.connection.send(new class_955("Catalog","dialog_show","basic.membership.extension.purchase"));
            }
         }
      }
      
      public function closeConfirmation() : void
      {
         if(var_1715)
         {
            var_1715.dispose();
            var_1715 = null;
         }
      }
      
      public function showConfirmation() : void
      {
         closeConfirmation();
         var_1715 = new ClubExtendConfirmationDialog(this,_offer);
         var_1715.showConfirmation();
      }
      
      public function confirmSelection() : void
      {
         if(!_catalog || !_catalog.connection || !_offer)
         {
            return;
         }
         if(_catalog.getPurse().credits < _offer.priceCredits)
         {
            _catalog.showNotEnoughCreditsAlert();
            return;
         }
         if(_offer.vip)
         {
            _catalog.purchaseVipMembershipExtension(_offer.offerId);
         }
         else
         {
            _catalog.purchaseBasicMembershipExtension(_offer.offerId);
         }
         closeConfirmation();
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         if(!_catalog)
         {
            return null;
         }
         return _catalog.windowManager;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         if(!_catalog)
         {
            return null;
         }
         return _catalog.localization;
      }
      
      public function get assets() : IAssetLibrary
      {
         if(!_catalog)
         {
            return null;
         }
         return _catalog.assets;
      }
      
      public function get config() : ICoreConfiguration
      {
         return _catalog;
      }
   }
}
