package com.sulake.habbo.avatar.figuredata
{
   import com.sulake.habbo.avatar.IAvatarImageListener;
   import com.sulake.habbo.avatar.class_3374;
   import com.sulake.habbo.room.preview.RoomPreviewer;
   import com.sulake.habbo.window.widgets.IRoomPreviewerWidget;
   
   public class FigureDataView implements IAvatarImageListener
   {
      
      public static const PREVIEW_AVATAR_DIRECTION:int = 4;
       
      
      private var var_1629:IRoomPreviewerWidget;
      
      private var var_1799:RoomPreviewer;
      
      private var var_1644:FigureData;
      
      private var _figureString:String;
      
      private var var_318:Boolean;
      
      public function FigureDataView(param1:FigureData)
      {
         super();
         var_1644 = param1;
         var_1629 = param1.avatarEditor.view.getFigureContainer().widget as IRoomPreviewerWidget;
         var_1799 = var_1629.roomPreviewer;
         var_1799.updateRoomWallsAndFloorVisibility(false,false);
      }
      
      public function update(param1:String, param2:int = 0, param3:int = 4) : void
      {
         var _loc4_:class_3374 = null;
         _figureString = param1;
         if(var_1799.isRoomEngineReady)
         {
            var_1799.addAvatarIntoRoom(param1,param2);
            var_1799.updateAvatarDirection(param3,param3);
            var_1799.updatePreviewRoomView(true);
            var_1799.updateRoomEngine();
         }
         else
         {
            _loc4_ = var_1644.avatarEditor.manager.avatarRenderManager.createAvatarImage(param1,"h",null,this);
            var_1629.showPreview(_loc4_.getCroppedImage("full"));
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         var _loc2_:class_3374 = null;
         if(param1 == _figureString)
         {
            _loc2_ = var_1644.avatarEditor.manager.avatarRenderManager.createAvatarImage(param1,"h",null,this);
            var_1629.showPreview(_loc2_.getCroppedImage("full"));
         }
      }
      
      public function dispose() : void
      {
         var_318 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
   }
}
