package com.sulake.habbo.catalog.vault
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import com.sulake.habbo.communication.messages.parser.vault.IncomeRewardClaimResponseMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.vault.CreditVaultStatusMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.vault.IncomeRewardStatusMessageEventParser;
   import com.sulake.habbo.communication.messages.incoming.vault.CreditVaultStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.vault.IncomeRewardClaimResponseMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.vault.IncomeRewardStatusMessageEvent;
   
   public class VaultController extends Component implements ILinkEventTracker
   {
       
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var _localizationManager:IHabboLocalizationManager;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_1631:VaultView;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      public function VaultController(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         super(param1,param2,param3);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         },true),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManager):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localizationManager = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         _messageEvents = new Vector.<IMessageEvent>(0);
         addMessageEvent(new CreditVaultStatusMessageEvent(onVaultStatusMessageEvent));
         addMessageEvent(new IncomeRewardStatusMessageEvent(onIncomeRewardStatusMessageEvent));
         addMessageEvent(new IncomeRewardClaimResponseMessageEvent(onIncomeRewardClaimResponseMessageEvent));
         context.addLinkEventTracker(this);
      }
      
      private function addMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _messageEvents.push(_communicationManager.addHabboConnectionMessageEvent(param1));
      }
      
      private function onVaultStatusMessageEvent(param1:CreditVaultStatusMessageEvent) : void
      {
         var _loc2_:CreditVaultStatusMessageEventParser = null;
         if(var_1631 && !var_1631.disposed)
         {
            _loc2_ = param1.getParser();
            var_1631.onCreditVaultDataReceived(_loc2_.isUnlocked,_loc2_.totalBalance,_loc2_.withdrawBalance);
         }
      }
      
      private function onIncomeRewardStatusMessageEvent(param1:IncomeRewardStatusMessageEvent) : void
      {
         var _loc2_:IncomeRewardStatusMessageEventParser = null;
         if(var_1631 && !var_1631.disposed)
         {
            _loc2_ = param1.getParser();
            var_1631.onIncomeRewardDataReceived(_loc2_.data);
         }
      }
      
      private function onIncomeRewardClaimResponseMessageEvent(param1:IncomeRewardClaimResponseMessageEvent) : void
      {
         var _loc2_:IncomeRewardClaimResponseMessageEventParser = null;
         if(var_1631 && !var_1631.disposed)
         {
            _loc2_ = param1.getParser();
            var_1631.onIncomeRewardClaimResponse(_loc2_.rewardCategory,_loc2_.result);
         }
      }
      
      public function openCatalogue() : void
      {
         context.createLinkEvent("catalog/open");
      }
      
      public function get linkPattern() : String
      {
         return "habboUI/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 3)
         {
            return;
         }
         if(_loc2_[1] == "open")
         {
            var _loc3_:* = _loc2_[2];
            if("vault" === _loc3_)
            {
               showVault();
            }
         }
      }
      
      public function withdrawVaultCredits() : void
      {
         _sessionDataManager.withdrawCreditVault();
      }
      
      public function claimReward(param1:int) : void
      {
         _sessionDataManager.claimReward(param1);
      }
      
      private function showVault() : void
      {
         if(!var_1631 || var_1631.disposed)
         {
            var_1631 = new VaultView(this,_windowManager);
         }
         _sessionDataManager.getCreditVaultStatus();
         _sessionDataManager.getIncomeRewardStatus();
      }
      
      public function removeView() : void
      {
         if(var_1631)
         {
            var_1631.dispose();
            var_1631 = null;
         }
      }
      
      override public function dispose() : void
      {
         if(_messageEvents != null && _communicationManager != null)
         {
            for each(var _loc1_ in _messageEvents)
            {
               _communicationManager.removeHabboConnectionMessageEvent(_loc1_);
            }
         }
         removeView();
         _messageEvents = null;
         super.dispose();
      }
   }
}
