package com.sulake.habbo.navigator
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class AlertView implements IDisposable
   {
      
      private static var var_2785:Dictionary = new Dictionary();
       
      
      private var _navigator:IHabboTransitionalNavigator;
      
      protected var var_1969:class_3514;
      
      protected var _xmlFileName:String;
      
      protected var var_617:String;
      
      protected var _disposed:Boolean;
      
      public function AlertView(param1:IHabboTransitionalNavigator, param2:String, param3:String = null)
      {
         super();
         _navigator = param1;
         _xmlFileName = param2;
         var_617 = param3;
      }
      
      public static function findAlertView(param1:IWindow) : AlertView
      {
         if(var_2785 != null)
         {
            for each(var _loc2_ in var_2785)
            {
               if(_loc2_.var_1969 == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function show() : void
      {
         var _loc2_:AlertView = var_2785[_xmlFileName] as AlertView;
         if(_loc2_ != null)
         {
            _loc2_.dispose();
         }
         var_1969 = getAlertWindow();
         if(var_617 != null)
         {
            var_1969.caption = var_617;
         }
         setupAlertWindow(var_1969);
         var _loc1_:Rectangle = Util.getLocationRelativeTo(var_1969.desktop,var_1969.width,var_1969.height);
         var_1969.x = _loc1_.x;
         var_1969.y = _loc1_.y;
         var_2785[_xmlFileName] = this;
         var_1969.activate();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(var_2785[_xmlFileName] == this)
         {
            var_2785[_xmlFileName] = null;
         }
         _disposed = true;
         if(var_1969 != null)
         {
            var_1969.destroy();
            var_1969 = null;
         }
         _navigator = null;
      }
      
      internal function setupAlertWindow(param1:class_3514) : void
      {
      }
      
      internal function onClose(param1:WindowMouseEvent) : void
      {
         dispose();
      }
      
      private function getAlertWindow() : class_3514
      {
         var _loc2_:class_3514 = _navigator.getXmlWindow(this._xmlFileName,2) as class_3514;
         var _loc1_:IWindow = _loc2_.findChildByTag("close");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",onClose);
         }
         return _loc2_;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get navigator() : IHabboTransitionalNavigator
      {
         return _navigator;
      }
   }
}
