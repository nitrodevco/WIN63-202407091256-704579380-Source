package com.sulake.habbo.catalog.club
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_3377;
   import com.sulake.habbo.catalog.purse.class_3378;
   import com.sulake.habbo.catalog.viewer.widgets.ClubGiftWidget;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.product.class_3423;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.communication.messages.outgoing.catalog.class_600;
   import com.sulake.habbo.communication.messages.outgoing.catalog.class_752;
   
   public class ClubGiftController
   {
       
      
      private var var_1629:ClubGiftWidget;
      
      private var var_845:int;
      
      private var var_1388:int;
      
      private var _offers:Array;
      
      private var var_151:Map;
      
      private var _catalog:HabboCatalog;
      
      private var var_1715:ClubGiftConfirmationDialog;
      
      public function ClubGiftController(param1:HabboCatalog)
      {
         super();
         _catalog = param1;
      }
      
      public function dispose() : void
      {
         _catalog = null;
         if(var_1715)
         {
            var_1715.dispose();
            var_1715 = null;
         }
      }
      
      public function set widget(param1:ClubGiftWidget) : void
      {
         var_1629 = param1;
         _catalog.connection.send(new class_752());
      }
      
      public function get daysUntilNextGift() : int
      {
         return var_845;
      }
      
      public function get giftsAvailable() : int
      {
         return var_1388;
      }
      
      public function setInfo(param1:int, param2:int, param3:Array, param4:Map) : void
      {
         var_845 = param1;
         var_1388 = param2;
         _offers = param3;
         var_151 = param4;
         if(var_1629)
         {
            var_1629.update();
         }
      }
      
      public function selectGift(param1:class_3377) : void
      {
         closeConfirmation();
         var_1715 = new ClubGiftConfirmationDialog(this,param1);
      }
      
      public function confirmSelection(param1:String) : void
      {
         if(!param1 || !_catalog || !_catalog.connection)
         {
            return;
         }
         _catalog.connection.send(new class_600(param1));
         var_1388--;
         var_1629.update();
         closeConfirmation();
      }
      
      public function closeConfirmation() : void
      {
         if(var_1715)
         {
            var_1715.dispose();
            var_1715 = null;
         }
      }
      
      public function getOffers() : Array
      {
         return _offers;
      }
      
      public function getGiftData() : Map
      {
         return var_151;
      }
      
      public function get hasClub() : Boolean
      {
         if(!_catalog || !_catalog.getPurse())
         {
            return false;
         }
         return _catalog.getPurse().clubDays > 0;
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
      
      public function get roomEngine() : IRoomEngine
      {
         if(!_catalog)
         {
            return null;
         }
         return _catalog.roomEngine;
      }
      
      public function getProductData(param1:String) : class_3423
      {
         if(!_catalog)
         {
            return null;
         }
         return _catalog.getProductData(param1);
      }
      
      public function get purse() : class_3378
      {
         if(!_catalog)
         {
            return null;
         }
         return _catalog.getPurse();
      }
      
      public function get catalog() : HabboCatalog
      {
         return _catalog;
      }
   }
}
