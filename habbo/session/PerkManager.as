package com.sulake.habbo.session
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.habbo.session.events.PerksUpdatedEvent;
   import flash.utils.Dictionary;
   import com.sulake.habbo.communication.messages.parser.perk.class_1694;
   import com.sulake.habbo.communication.messages.incoming.perk.class_828;
   
   public class PerkManager implements IDisposable
   {
       
      
      private var var_185:Boolean = false;
      
      private var _sessionDataManager:SessionDataManager;
      
      private var _perkAllowancesMessageEvent:IMessageEvent;
      
      private var var_221:Dictionary;
      
      public function PerkManager(param1:SessionDataManager)
      {
         var_221 = new Dictionary();
         super();
         _sessionDataManager = param1;
         if(_sessionDataManager.communication)
         {
            _perkAllowancesMessageEvent = _sessionDataManager.communication.addHabboConnectionMessageEvent(new class_828(onPerkAllowances));
         }
      }
      
      public function get disposed() : Boolean
      {
         return _sessionDataManager == null;
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(var_221)
         {
            for(var _loc1_ in var_221)
            {
               delete var_221[_loc1_];
            }
            var_221 = null;
         }
         if(_sessionDataManager.communication)
         {
            _sessionDataManager.communication.removeHabboConnectionMessageEvent(_perkAllowancesMessageEvent);
         }
         _perkAllowancesMessageEvent = null;
         _sessionDataManager = null;
      }
      
      public function get isReady() : Boolean
      {
         return var_185;
      }
      
      public function isPerkAllowed(param1:String) : Boolean
      {
         return param1 in var_221 && var_221[param1].isAllowed;
      }
      
      public function getPerkErrorMessage(param1:String) : String
      {
         var _loc2_:class_1694 = var_221[param1];
         return _loc2_ != null ? _loc2_.errorMessage : "";
      }
      
      private function onPerkAllowances(param1:class_828) : void
      {
         for each(var _loc2_ in param1.getParser().getPerks())
         {
            var_221[_loc2_.code] = _loc2_;
         }
         var_185 = true;
         _sessionDataManager.events.dispatchEvent(new PerksUpdatedEvent());
      }
   }
}
