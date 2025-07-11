package com.sulake.habbo.utils
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.events.WindowEvent;
   
   public class class_3527
   {
       
      
      public function class_3527()
      {
         super();
      }
      
      public static function setup(param1:IWindowContainer, param2:Function) : void
      {
         var _loc3_:IWindow = param1.findChildByName("user_info_region");
         _loc3_.addEventListener("WME_OVER",onUserInfoMouseOver);
         _loc3_.addEventListener("WME_OUT",onUserInfoMouseOut);
         _loc3_.addEventListener("WME_CLICK",param2);
      }
      
      private static function onUserInfoMouseOver(param1:WindowEvent) : void
      {
         var _loc2_:IRegionWindow = IRegionWindow(param1.target);
         setUserInfoState(true,_loc2_);
      }
      
      private static function onUserInfoMouseOut(param1:WindowEvent) : void
      {
         var _loc2_:IRegionWindow = IRegionWindow(param1.target);
         setUserInfoState(false,_loc2_);
      }
      
      public static function setUserInfoState(param1:Boolean, param2:IWindowContainer) : void
      {
         param2.findChildByName("icon_eye_off").visible = !param1;
         param2.findChildByName("icon_eye_over").visible = param1;
      }
      
      public static function onEntry(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_OVER")
         {
            class_3527.setUserInfoState(true,IWindowContainer(param2.parent));
         }
         else if(param1.type == "WME_OUT")
         {
            class_3527.setUserInfoState(false,IWindowContainer(param2.parent));
         }
      }
   }
}
