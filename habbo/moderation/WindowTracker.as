package com.sulake.habbo.moderation
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.class_3514;
   import flash.utils.Dictionary;
   
   public class WindowTracker
   {
      
      public static const TYPE_USERINFO:int = 1;
      
      public static const const_831:int = 2;
      
      public static const const_940:int = 3;
      
      public static const const_1134:int = 4;
      
      public static const const_1159:int = 5;
      
      public static const const_895:int = 6;
      
      public static const const_952:int = 7;
      
      public static const TYPE_ISSUEHANDLER:int = 8;
      
      public static const TYPE_ROOMINFO:int = 9;
       
      
      private var var_4085:Dictionary;
      
      public function WindowTracker()
      {
         var_4085 = new Dictionary();
         super();
      }
      
      public function show(param1:ITrackedWindow, param2:class_3514, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean = false, param7:int = 0, param8:int = 0, param9:int = 0, param10:int = 0) : void
      {
         var _loc14_:IWindow = null;
         var _loc13_:int = 0;
         var _loc11_:IWindow = null;
         var _loc12_:ITrackedWindow;
         if((_loc12_ = this.removeWindow(param1.getType(),param1.getId())) != null && !_loc12_.disposed)
         {
            if(param5)
            {
               param1.dispose();
               _loc12_.dispose();
               return;
            }
            param1.show();
            _loc14_ = _loc12_.getFrame();
            param1.getFrame().x = param6 ? param7 : _loc14_.x;
            param1.getFrame().y = param6 ? param8 : _loc14_.y;
            param1.getFrame().width = param6 ? param9 : _loc14_.width;
            param1.getFrame().height = param6 ? param10 : _loc14_.height;
            this.getWindowsForType(param1.getType())[param1.getId()] = param1;
            _loc12_.dispose();
         }
         else if(!param4)
         {
            param1.show();
            if(param2 != null)
            {
               _loc13_ = 5;
               if(param3)
               {
                  param1.getFrame().x = param6 ? param7 : int(param2.x);
                  param1.getFrame().y = param6 ? param8 : param2.y + param2.height + _loc13_;
               }
               else
               {
                  param1.getFrame().x = param6 ? param7 : param2.x + param2.width + _loc13_;
                  param1.getFrame().y = param6 ? param8 : int(param2.y);
               }
            }
            else if(param6)
            {
               param1.getFrame().x = param7;
               param1.getFrame().y = param8;
            }
            else
            {
               _loc11_ = param1.getFrame().desktop;
               param1.getFrame().x = _loc11_.width / 2 - param1.getFrame().width / 2;
               param1.getFrame().y = _loc11_.height / 2 - param1.getFrame().height / 2;
            }
            param1.getFrame().x = Math.max(0,Math.min(param1.getFrame().x,param1.getFrame().desktop.width - param1.getFrame().width));
            param1.getFrame().y = Math.max(0,Math.min(param1.getFrame().y,param1.getFrame().desktop.height - param1.getFrame().height));
            this.getWindowsForType(param1.getType())[param1.getId()] = param1;
         }
      }
      
      private function removeWindow(param1:int, param2:String) : ITrackedWindow
      {
         var _loc4_:Dictionary;
         var _loc3_:ITrackedWindow = (_loc4_ = this.getWindowsForType(param1))[param2];
         _loc4_[param2] = null;
         return _loc3_;
      }
      
      private function getWindowsForType(param1:int) : Dictionary
      {
         var _loc2_:Dictionary = var_4085[param1];
         if(_loc2_ == null)
         {
            _loc2_ = new Dictionary();
            var_4085[param1] = _loc2_;
         }
         return _loc2_;
      }
   }
}
