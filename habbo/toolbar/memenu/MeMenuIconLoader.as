package com.sulake.habbo.toolbar.memenu
{
   import com.sulake.habbo.avatar.IAvatarImageListener;
   import com.sulake.habbo.avatar.class_3374;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_337;
   import com.sulake.habbo.communication.messages.incoming.handshake.class_556;
   
   public class MeMenuIconLoader implements IAvatarImageListener
   {
      
      private static const MAX_ICON_HEIGHT:int = 50;
      
      private static const HEAD_MARGIN:int = 3;
       
      
      private var _toolbar:HabboToolbar;
      
      private var var_3658:String;
      
      private var var_3737:BitmapData;
      
      private var var_3604:BitmapData;
      
      private var var_3037:class_556;
      
      private var var_3023:class_337;
      
      public function MeMenuIconLoader(param1:HabboToolbar)
      {
         super();
         _toolbar = param1;
         var_3037 = new class_556(onUserObject);
         var_3023 = new class_337(onUserChange);
         _toolbar.communicationManager.addHabboConnectionMessageEvent(var_3037);
         _toolbar.communicationManager.addHabboConnectionMessageEvent(var_3023);
         setMeMenuToolbarIcon();
      }
      
      private function setMeMenuToolbarIcon(param1:String = null) : void
      {
         var _loc3_:BitmapData = null;
         var _loc5_:BitmapData = null;
         var _loc7_:String = null;
         var _loc4_:String = null;
         var _loc8_:class_3374 = null;
         var _loc6_:* = null;
         var _loc9_:BitmapData = null;
         var _loc2_:Rectangle = null;
         if(_toolbar.avatarRenderManager != null)
         {
            if((_loc7_ = param1 == null ? _toolbar.sessionDataManager.figure : param1) != var_3658)
            {
               _loc4_ = _toolbar.sessionDataManager.gender;
               if((_loc8_ = _toolbar.avatarRenderManager.createAvatarImage(_loc7_,"h",_loc4_,this)) != null)
               {
                  _loc8_.setDirection("full",2);
                  _loc3_ = _loc8_.getCroppedImage("full");
                  _loc5_ = _loc8_.getCroppedImage("head");
                  _loc8_.dispose();
               }
               var_3658 = _loc7_;
               if(var_3737 != null)
               {
                  var_3737.dispose();
               }
               var_3737 = _loc3_;
               if(var_3604 != null)
               {
                  var_3604.dispose();
               }
               var_3604 = _loc5_;
            }
            else
            {
               _loc3_ = var_3737;
               _loc5_ = var_3604;
            }
         }
         if(_toolbar != null)
         {
            if(_loc3_ != null && _loc5_ != null)
            {
               if(_loc3_.height > 50)
               {
                  _loc2_ = (_loc9_ = new BitmapData(_loc3_.width,50,true,0)).rect.clone();
                  if(_loc5_.height > 50 - 3)
                  {
                     _loc2_.offset(0,_loc5_.height - 50 + 3);
                  }
                  _loc9_.copyPixels(_loc3_,_loc2_,new Point(0,0));
                  _loc6_ = _loc9_;
               }
               else
               {
                  _loc6_ = _loc3_.clone();
               }
            }
            _toolbar.setIconBitmap("HTIE_ICON_MEMENU",_loc6_);
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         var_3658 = "";
         setMeMenuToolbarIcon();
      }
      
      private function onUserObject(param1:class_556) : void
      {
         setMeMenuToolbarIcon(param1.getParser().figure);
      }
      
      private function onUserChange(param1:class_337) : void
      {
         if(param1.id == -1)
         {
            setMeMenuToolbarIcon(param1.figure);
         }
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(var_3037 != null)
         {
            _toolbar.communicationManager.removeHabboConnectionMessageEvent(var_3037);
            var_3037 = null;
         }
         if(var_3023 != null)
         {
            _toolbar.communicationManager.removeHabboConnectionMessageEvent(var_3023);
            var_3023 = null;
         }
         _toolbar = null;
      }
      
      public function get disposed() : Boolean
      {
         return _toolbar == null;
      }
   }
}
