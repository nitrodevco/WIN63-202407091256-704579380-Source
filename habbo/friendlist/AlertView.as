package com.sulake.habbo.friendlist
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class AlertView implements IDisposable
   {
      
      private static var var_2785:Dictionary = new Dictionary();
       
      
      private var _friendList:HabboFriendList;
      
      private var var_2127:class_3514;
      
      private var _xmlFileName:String;
      
      private var var_617:String;
      
      private var _disposed:Boolean;
      
      public function AlertView(param1:HabboFriendList, param2:String, param3:String = null)
      {
         super();
         _friendList = param1;
         _xmlFileName = param2;
         var_617 = param3;
      }
      
      public function show() : void
      {
         var _loc1_:class_3514 = class_3514(var_2785[_xmlFileName]);
         if(_loc1_ != null)
         {
            _loc1_.dispose();
         }
         var_2127 = getAlert();
         if(var_617 != null)
         {
            var_2127.caption = var_617;
         }
         setupContent(var_2127.content);
         var _loc2_:Rectangle = Util.getLocationRelativeTo(_friendList.view.mainWindow,var_2127.width,var_2127.height);
         var_2127.x = _loc2_.x;
         var_2127.y = _loc2_.y;
         var_2785[_xmlFileName] = var_2127;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(var_2127 != null)
         {
            var_2127.destroy();
            var_2127 = null;
         }
         _friendList = null;
      }
      
      internal function setupContent(param1:IWindowContainer) : void
      {
      }
      
      internal function onClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         dispose();
      }
      
      private function getAlert() : class_3514
      {
         var _loc1_:class_3514 = class_3514(_friendList.getXmlWindow(this._xmlFileName));
         var _loc2_:IWindow = _loc1_.findChildByTag("close");
         _loc2_.procedure = onClose;
         return _loc1_;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get friendList() : HabboFriendList
      {
         return _friendList;
      }
   }
}
