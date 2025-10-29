package com.sulake.habbo.phonenumber
{
    import assets.class_14

    import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.incoming.gifts.TryVerificationCodeResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.gifts.TryPhoneNumberResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.gifts.PhoneCollectionStateMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.gifts.class_457;
   import com.sulake.habbo.communication.messages.outgoing.gifts.class_478;
   import com.sulake.habbo.communication.messages.outgoing.gifts.class_706;
   import com.sulake.habbo.communication.messages.outgoing.gifts.class_859;
   
   public class HabboPhoneNumber extends Component
   {
       
      
      protected var _communicationManager:IHabboCommunicationManager;
      
      protected var _localizationManager:IHabboLocalizationManager;
      
      protected var _sessionDataManager:ISessionDataManager;
      
      protected var _toolbar:IHabboToolbar;
      
      protected var _windowManager:IHabboWindowManager;
      
      private var var_26:IConnection;
      
      private var var_2804:PhoneNumberCollectView;
      
      private var var_2625:PhoneNumberCollectMinimizedView;
      
      private var var_2914:VerificationCodeInputView;
      
      private var var_2582:VerificationCodeInputMinimizedView;
      
      private var _retryEnableTime:int;
      
      public function HabboPhoneNumber(param1:IContext, param2:uint, param3:IAssetLibrary)
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
         }),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         if(getBoolean("sms.identity.verification.enabled"))
         {
            var_26 = _communicationManager.connection;
            var_26.addMessageEvent(new PhoneCollectionStateMessageEvent(onStateMessage));
            var_26.addMessageEvent(new TryPhoneNumberResultMessageEvent(onPhoneNumberResultMessage));
            var_26.addMessageEvent(new TryVerificationCodeResultMessageEvent(onVerificationCodeResultMessage));
         }
      }
      
      public function sendTryPhoneNumber(param1:String, param2:String) : void
      {
         var_26.send(new class_859(param1,param2));
      }
      
      public function sendTryVerificationCode(param1:String) : void
      {
         if(!param1)
         {
            return;
         }
         param1 = param1.toUpperCase();
         var_26.send(new class_478(param1));
      }
      
      public function setNeverAgain() : void
      {
         var_26.send(new class_457(2));
         destroyCollectView();
      }
      
      public function setCollectViewMinimized(param1:Boolean) : void
      {
         if(param1)
         {
            destroyCollectView();
            createCollectMinimizedView();
         }
         else
         {
            destroyCollectMinimizedView();
            createCollectView();
         }
      }
      
      public function setVerifyViewMinimized(param1:Boolean) : void
      {
         if(param1)
         {
            destroyVerifyView();
            createVerifyMinimizedView();
         }
         else
         {
            destroyVerifyMinimizedView();
            createVerifyView();
         }
      }
      
      public function requestPhoneNumberCollectionReset() : void
      {
         destroyVerifyView();
         var_26.send(new class_706());
      }
      
      private function onPhoneNumberResultMessage(param1:TryPhoneNumberResultMessageEvent) : void
      {
         switch(param1.getParser().resultCode - 1)
         {
            case 0:
            case 2:
            case 8:
               destroyCollectView();
               _retryEnableTime = param1.getParser().millisToAllowProcessReset + getTimer();
               createVerifyView();
               break;
            case 1:
               destroyCollectView();
               break;
            case 3:
            case 4:
            case 5:
            case 9:
               if(!var_2625 && !var_2804)
               {
                  createCollectView();
               }
               else if(var_2625)
               {
                  setCollectViewMinimized(false);
               }
               _windowManager.alert("${generic.alert.title}","${phone.number.collect.error." + param1.getParser().resultCode + "}",0,null);
               var_2804.handleSubmitFailure(param1.getParser().resultCode);
         }
      }
      
      private function onVerificationCodeResultMessage(param1:TryVerificationCodeResultMessageEvent) : void
      {
         switch(param1.getParser().resultCode - 2)
         {
            case 0:
            case 1:
               destroyVerifyView();
               break;
            case 2:
               if(!var_2582 && !var_2914)
               {
                  _retryEnableTime = getTimer() + param1.getParser().millisecondsToAllowProcessReset;
                  createVerifyView();
               }
               else if(var_2582)
               {
                  setVerifyViewMinimized(false);
               }
               var_2914.handleSubmitFailure(param1.getParser().resultCode);
         }
      }
      
      private function onStateMessage(param1:PhoneCollectionStateMessageEvent) : void
      {
         var _loc2_:int = param1.getParser().collectionStatusCode;
         var _loc3_:int = param1.getParser().phoneStatusCode;
         context.configuration.setProperty("phone.collection.status",_loc2_.toString());
         context.configuration.setProperty("phone.verification.status",_loc3_.toString());
         if(_loc2_ == 2)
         {
            return;
         }
         if(_loc2_ == 3 && (_loc3_ == 9 || _loc3_ == 1))
         {
            destroyCollectView();
            if(_loc2_ == 1)
            {
               createVerifyMinimizedView();
            }
            else
            {
               _retryEnableTime = param1.getParser().millisecondsToAllowProcessReset + getTimer();
               createVerifyView();
            }
            return;
         }
         switch(_loc3_)
         {
            case 0:
            case 9:
               createCollectView();
               break;
            case 2:
            case 3:
               destroyCollectView();
               destroyVerifyView();
               break;
            case 4:
            case 5:
            case 6:
               class_14.log("INVALID STATE!! Phone number / verify errors should not be handled here!");
         }
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return _windowManager;
      }
      
      public function get localizationManager() : IHabboLocalizationManager
      {
         return _localizationManager;
      }
      
      public function get retryEnableTime() : int
      {
         return _retryEnableTime;
      }
      
      private function createCollectView() : void
      {
         destroyCollectView();
         var _loc2_:String = String(context.configuration.getProperty("phone.number.preferred.countries"));
         var _loc1_:Array = _loc2_.split(",");
         var_2804 = new PhoneNumberCollectView(this,_loc1_);
      }
      
      private function createVerifyView() : void
      {
         destroyVerifyView();
         var_2914 = new VerificationCodeInputView(this);
      }
      
      private function createCollectMinimizedView() : void
      {
         destroyCollectMinimizedView();
         var_2625 = new PhoneNumberCollectMinimizedView(this);
         _toolbar.extensionView.attachExtension("phone_number",var_2625.window,12);
      }
      
      private function createVerifyMinimizedView() : void
      {
         destroyVerifyMinimizedView();
         var_2582 = new VerificationCodeInputMinimizedView(this);
         _toolbar.extensionView.attachExtension("verification_code",var_2582.window,12);
      }
      
      private function destroyCollectView() : void
      {
         if(var_2804)
         {
            var_2804.dispose();
            var_2804 = null;
         }
      }
      
      private function destroyVerifyView() : void
      {
         if(var_2914)
         {
            var_2914.dispose();
            var_2914 = null;
         }
      }
      
      private function destroyCollectMinimizedView() : void
      {
         _toolbar.extensionView.detachExtension("phone_number");
         if(var_2625)
         {
            var_2625.dispose();
            var_2625 = null;
         }
      }
      
      private function destroyVerifyMinimizedView() : void
      {
         _toolbar.extensionView.detachExtension("verification_code");
         if(var_2582)
         {
            var_2582.dispose();
            var_2582 = null;
         }
      }
   }
}
