package com.sulake.habbo.catalog.collectibles.widget.subviews
{
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.avatar.IAvatarImageListener;
   import com.sulake.habbo.avatar.class_3374;
   import com.sulake.habbo.room.preview.RoomPreviewer;
   import com.sulake.habbo.window.widgets.IRoomPreviewerWidget;
   
   public class EffectPreviewer implements IAvatarImageListener
   {
      
      private static var var_4887:int = 2;
       
      
      private var var_1704:IWidgetWindow;
      
      private var _avatarRenderManager:IAvatarRenderManager;
      
      private var var_318:Boolean;
      
      public function EffectPreviewer(param1:IWidgetWindow, param2:IAvatarRenderManager)
      {
         super();
         var_1704 = param1;
         _avatarRenderManager = param2;
         roomPreviewer.updateRoomWallsAndFloorVisibility(false,false);
      }
      
      public function update(param1:String, param2:int) : void
      {
         var _loc3_:class_3374 = null;
         var _loc4_:RoomPreviewer;
         if((_loc4_ = roomPreviewer).isRoomEngineReady)
         {
            _loc4_.addAvatarIntoRoom(param1,param2);
            _loc4_.updateAvatarDirection(var_4887,var_4887);
            _loc4_.updatePreviewRoomView(true);
            _loc4_.updateRoomEngine();
         }
         else
         {
            _loc3_ = _avatarRenderManager.createAvatarImage(param1,"h",null,this);
            widget.showPreview(_loc3_.getCroppedImage("full"));
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         var _loc2_:class_3374 = null;
         if(!var_318)
         {
            _loc2_ = _avatarRenderManager.createAvatarImage(param1,"h",null,this);
            widget.showPreview(_loc2_.getCroppedImage("full"));
         }
      }
      
      public function dispose() : void
      {
         if(var_318)
         {
            return;
         }
         var_318 = true;
         roomPreviewer.reset(false);
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      private function get widget() : IRoomPreviewerWidget
      {
         return var_1704.widget as IRoomPreviewerWidget;
      }
      
      private function get roomPreviewer() : RoomPreviewer
      {
         return widget.roomPreviewer;
      }
      
      public function set visible(param1:Boolean) : void
      {
         var_1704.visible = param1;
      }
   }
}
