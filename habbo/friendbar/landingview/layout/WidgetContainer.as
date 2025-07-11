package com.sulake.habbo.friendbar.landingview.layout
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.IResizeAwareWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISettingsAwareWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.class_3837;
   
   public class WidgetContainer implements IDisposable
   {
       
      
      private var var_1629:ILandingViewWidget;
      
      private var _placeholderName:String;
      
      private var var_4241:IWindowContainer;
      
      private var var_78:Boolean;
      
      private var var_2696:CommonWidgetSettings;
      
      public function WidgetContainer(param1:ILandingViewWidget, param2:String, param3:CommonWidgetSettings, param4:IWindowContainer = null)
      {
         super();
         var_1629 = param1;
         _placeholderName = param2;
         var_2696 = param3;
         var_4241 = param4;
      }
      
      public function dispose() : void
      {
         if(var_1629)
         {
            var_1629.dispose();
            var_1629 = null;
         }
         if(var_2696)
         {
            var_2696 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_1629 == null && var_2696 == null;
      }
      
      public function refresh(param1:IWindowContainer) : void
      {
         var _loc3_:IWindow = null;
         var _loc2_:IWindowContainer = IWindowContainer(param1.findChildByName("content_background"));
         if(!var_78)
         {
            var_78 = true;
            if(_placeholderName != null)
            {
               _loc3_ = _loc2_.getChildByName(_placeholderName);
               if(_loc3_ == null)
               {
                  return;
               }
               var_1629.initialize();
               _loc2_.addChildAt(var_1629.container,_loc2_.getChildIndex(_loc3_));
               var_1629.container.x = _loc3_.x;
               var_1629.container.y = _loc3_.y;
               _loc2_.removeChild(_loc3_);
               _loc3_.dispose();
            }
            else
            {
               if(!(var_4241 != null && var_1629 != null))
               {
                  return;
               }
               var_1629.initialize();
               var_4241.addChild(var_1629.container);
            }
         }
         if(var_1629.container != null)
         {
            if(var_1629 is ISettingsAwareWidget && var_2696 != null)
            {
               ISettingsAwareWidget(var_1629).settings = var_2696;
            }
            var_1629.refresh();
         }
      }
      
      public function get container() : IWindow
      {
         return var_1629.container;
      }
      
      public function windowResized() : void
      {
         if(var_1629 != null && var_1629.container != null && var_1629 is IResizeAwareWidget)
         {
            IResizeAwareWidget(var_1629).windowResized();
         }
      }
      
      public function disable() : void
      {
         if(var_1629 != null && var_1629.container != null && var_1629 is class_3837)
         {
            class_3837(var_1629).disable();
         }
      }
   }
}
