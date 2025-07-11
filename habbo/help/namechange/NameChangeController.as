package com.sulake.habbo.help.namechange
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3348;
   import com.sulake.habbo.help.HabboHelp;
   import com.sulake.habbo.help.INameChangeUI;
   import com.sulake.habbo.help.enum.HabboHelpTutorialEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.communication.messages.parser.users.class_1297;
   import com.sulake.habbo.communication.messages.parser.handshake.class_1267;
   import com.sulake.habbo.communication.messages.parser.avatar.class_1162;
   import com.sulake.habbo.communication.messages.parser.avatar.class_1164;
   import com.sulake.habbo.communication.messages.incoming.avatar.class_341;
   import com.sulake.habbo.communication.messages.incoming.avatar.class_725;
   import com.sulake.habbo.communication.messages.incoming.users.class_210;
   import com.sulake.habbo.communication.messages.outgoing.avatar.class_242;
   import com.sulake.habbo.communication.messages.outgoing.avatar.class_249;
   import com.sulake.habbo.communication.messages.incoming.handshake.class_556;
   
   public class NameChangeController implements INameChangeUI, IDisposable
   {
      
      public static const NAME_CHANGE:String = "TUI_NAME_VIEW";
       
      
      private var _disposed:Boolean;
      
      private var _habboHelp:HabboHelp;
      
      private var var_1847:NameChangeView;
      
      private var _ownUserName:String;
      
      private var var_4252:int;
      
      public function NameChangeController(param1:HabboHelp)
      {
         super();
         _habboHelp = param1;
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new class_210(onUserNameChange));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new class_341(onChangeUserNameResult));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new class_556(onUserObject));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new class_725(onCheckUserNameResult));
      }
      
      public function get help() : HabboHelp
      {
         return _habboHelp;
      }
      
      public function get assets() : IAssetLibrary
      {
         return _habboHelp.assets;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _habboHelp.localization;
      }
      
      public function get myName() : String
      {
         return _ownUserName;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            disposeView();
            if(_habboHelp)
            {
               _habboHelp = null;
            }
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function showView() : void
      {
         if(var_1847 == null || var_1847.disposed)
         {
            var_1847 = new NameChangeView(this);
         }
         var_1847.showMainView();
         prepareForTutorial();
      }
      
      public function buildXmlWindow(param1:String, param2:uint = 1) : IWindow
      {
         if(_habboHelp.assets == null)
         {
            return null;
         }
         var _loc3_:XmlAsset = XmlAsset(_habboHelp.assets.getAssetByName(param1 + "_xml"));
         if(_loc3_ == null || _habboHelp.windowManager == null)
         {
            return null;
         }
         return _habboHelp.windowManager.buildFromXML(XML(_loc3_.content),param2);
      }
      
      private function disposeWindow(param1:WindowEvent = null) : void
      {
      }
      
      public function disposeView() : void
      {
         if(var_1847 != null)
         {
            var_1847.dispose();
            var_1847 = null;
         }
         disposeWindow();
      }
      
      public function hideView() : void
      {
         if(var_1847 != null)
         {
            var_1847.dispose();
            var_1847 = null;
         }
      }
      
      public function setRoomSessionStatus(param1:Boolean) : void
      {
         if(param1 == false)
         {
            disposeView();
         }
      }
      
      public function prepareForTutorial() : void
      {
         if(_habboHelp == null || _habboHelp.events == null)
         {
            return;
         }
         _habboHelp.events.dispatchEvent(new HabboHelpTutorialEvent("HHTPNUFWE_AVATAR_TUTORIAL_START"));
      }
      
      public function windowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:* = param1.type;
         if("WME_CLICK" === _loc3_)
         {
            if(param2.name == "header_button_close")
            {
               disposeView();
            }
         }
      }
      
      public function changeName(param1:String) : void
      {
         disposeWindow();
         _habboHelp.sendMessage(new class_249(param1));
      }
      
      public function checkName(param1:String) : void
      {
         disposeWindow();
         _habboHelp.sendMessage(new class_242(param1));
      }
      
      public function onUserNameChanged(param1:String) : void
      {
         var name:String = param1;
         if(!_habboHelp || !_habboHelp.localization || !_habboHelp.windowManager)
         {
            return;
         }
         _habboHelp.localization.registerParameter("help.tutorial.name.changed","name",name);
         _habboHelp.windowManager.alert("${generic.notice}","${help.tutorial.name.changed}",0,function(param1:class_3348, param2:WindowEvent):void
         {
            param1.dispose();
         });
      }
      
      private function onChangeUserNameResult(param1:class_341) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:class_1162 = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.resultCode == class_341.var_1586)
         {
            onUserNameChanged(_loc2_.name);
            hideView();
         }
         else if(var_1847)
         {
            var_1847.setNameNotAvailableView(_loc2_.resultCode,_loc2_.name,_loc2_.nameSuggestions);
         }
      }
      
      private function onCheckUserNameResult(param1:class_725) : void
      {
         if(!param1 || !var_1847)
         {
            return;
         }
         var _loc2_:class_1164 = param1.getParser();
         if(_loc2_.resultCode == class_341.var_1586)
         {
            var_1847.checkedName = _loc2_.name;
         }
         else
         {
            var_1847.setNameNotAvailableView(_loc2_.resultCode,_loc2_.name,_loc2_.nameSuggestions);
         }
      }
      
      private function onUserObject(param1:IMessageEvent) : void
      {
         var _loc2_:class_1267 = class_556(param1).getParser();
         var_4252 = _loc2_.id;
         _ownUserName = _loc2_.name;
      }
      
      private function onUserNameChange(param1:IMessageEvent) : void
      {
         var _loc2_:class_1297 = class_210(param1).getParser();
         if(var_4252 == _loc2_.webId)
         {
            _ownUserName = _loc2_.newName;
         }
      }
      
      public function get ownUserName() : String
      {
         return _ownUserName;
      }
      
      public function get ownUserId() : int
      {
         return var_4252;
      }
   }
}
