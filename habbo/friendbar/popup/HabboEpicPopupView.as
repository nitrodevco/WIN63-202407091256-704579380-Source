package com.sulake.habbo.friendbar.popup
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.friendbar.IHabboEpicPopupView;
   import com.sulake.habbo.friendbar.view.AbstractView;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.quest.EpicPopupMessageEvent;
   
   public class HabboEpicPopupView extends AbstractView implements IHabboEpicPopupView
   {
       
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var _activeFrame:IWindowContainer;
      
      public function HabboEpicPopupView(param1:IContext, param2:uint, param3:IAssetLibrary)
      {
         super(param1,param2,param3);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         })]);
      }
      
      override public function dispose() : void
      {
         if(_activeFrame != null)
         {
            _activeFrame.dispose();
            _activeFrame = null;
         }
         super.dispose();
      }
      
      override protected function initComponent() : void
      {
         _communicationManager.addHabboConnectionMessageEvent(new EpicPopupMessageEvent(onEpicPopupMessageEvent));
      }
      
      private function onEpicPopupMessageEvent(param1:EpicPopupMessageEvent) : void
      {
         showPopup(param1.getParser().imageUri);
      }
      
      public function showPopup(param1:String) : void
      {
         if(_activeFrame != null)
         {
            _activeFrame.dispose();
         }
         _activeFrame = _windowManager.buildFromXML(assets.getAssetByName("epic_popup_frame_xml").content as XML) as IWindowContainer;
         IStaticBitmapWrapperWindow(_activeFrame.findChildByName("content_static_bitmap")).assetUri = param1;
         _activeFrame.procedure = windowProc;
         _activeFrame.center();
      }
      
      private function windowProc(param1:WindowEvent, param2:IWindow) : void
      {
         if(_activeFrame != null && param1.type == "WME_CLICK")
         {
            switch(param1.target.name)
            {
               case "close_button":
               case "header_button_close":
                  _activeFrame.dispose();
                  _activeFrame = null;
            }
         }
      }
   }
}
