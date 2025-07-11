package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.class_3863;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   
   public class TitleElementHandler implements IElementHandler, class_3863
   {
       
      
      private var var_4661:Boolean = false;
      
      public function TitleElementHandler()
      {
         super();
      }
      
      public function initialize(param1:HabboLandingView, param2:IWindow, param3:Array, param4:GenericWidget) : void
      {
         var _loc5_:IWindowContainer = IWindowContainer(param2);
         var _loc6_:String = String(param3[1]);
         var_4661 = param3.length > 2 ? param3[2] == "true" : false;
         _loc5_.findChildByName("title_txt").caption = "${" + _loc6_ + "}";
         HabboLandingView.positionAfterAndStretch(_loc5_,"title_txt","hdr_line");
      }
      
      public function isFloating(param1:Boolean) : Boolean
      {
         return param1 || var_4661;
      }
      
      public function refresh() : void
      {
      }
   }
}
