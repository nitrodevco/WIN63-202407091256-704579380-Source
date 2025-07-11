package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   import com.sulake.habbo.utils.HabboWebTools;
   
   public class class_3885 implements IElementHandler, IDisposable
   {
       
      
      private var _landingView:HabboLandingView;
      
      private var var_96:String;
      
      public function class_3885()
      {
         super();
      }
      
      public function dispose() : void
      {
         _landingView = null;
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      public function initialize(param1:HabboLandingView, param2:IWindow, param3:Array, param4:GenericWidget) : void
      {
         _landingView = param1;
         var _loc5_:String = String(param3[1]);
         var_96 = param3[2];
         param2.procedure = onLink;
         IWindowContainer(param2).findChildByName("link_txt").caption = "${" + _loc5_ + "}";
      }
      
      private function onLink(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _landingView.windowManager.alert("${catalog.alert.external.link.title}","${catalog.alert.external.link.desc}",0,null);
            HabboWebTools.openWebPage(var_96);
            _landingView.tracking.trackGoogle("landingView","click_link");
         }
      }
      
      public function refresh() : void
      {
      }
   }
}
