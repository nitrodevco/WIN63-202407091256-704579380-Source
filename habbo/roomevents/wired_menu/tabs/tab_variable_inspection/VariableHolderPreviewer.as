package com.sulake.habbo.roomevents.wired_menu.tabs.tab_variable_inspection
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.utils.class_3501;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.class_3499;
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   import com.sulake.habbo.session.class_3490;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   import com.sulake.habbo.window.widgets.class_3654;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   
   public class VariableHolderPreviewer implements IGetImageListener, IDisposable
   {
       
      
      private var _disposed:Boolean;
      
      private var var_3116:Number;
      
      private var _container:IWindowContainer;
      
      private var var_319:WiredMenuController;
      
      private var var_3197:int = 0;
      
      private var var_3874:int = -1;
      
      public function VariableHolderPreviewer(param1:IWindowContainer, param2:WiredMenuController)
      {
         super();
         _container = param1;
         var_319 = param2;
         clearPreviewer();
      }
      
      public static function centerContainer(param1:IWindow) : void
      {
         param1.x = param1.parent.width / 2 - param1.width / 2;
         param1.y = param1.parent.height / 2 - param1.height / 2;
      }
      
      public function clearPreviewer() : void
      {
         var_3197 = 0;
         var_3874 = -1;
         previewFurniInstructionText.visible = false;
         previewUserInstructionText.visible = false;
         previewAvatarWidget.visible = false;
         previewPetWidget.visible = false;
         previewImageBitmap.visible = false;
         previewGlobalPlaceholder.visible = false;
      }
      
      public function setFurniInstructions() : void
      {
         clearPreviewer();
         previewFurniInstructionText.visible = true;
      }
      
      public function setUserInstructions() : void
      {
         clearPreviewer();
         previewUserInstructionText.visible = true;
      }
      
      public function setPreviewByUserIndex(param1:int) : void
      {
         var _loc4_:class_3654 = null;
         var _loc3_:IAvatarImageWidget = null;
         if(param1 == var_3874)
         {
            return;
         }
         clearPreviewer();
         var _loc2_:class_3490 = var_319.roomEvents.roomSession.userDataManager.getUserDataByIndex(param1);
         if(_loc2_ == null)
         {
            return;
         }
         switch(_loc2_.type - 1)
         {
            case 0:
            case 2:
            case 3:
               previewAvatarWidget.visible = true;
               _loc3_ = previewAvatarWidget.widget as IAvatarImageWidget;
               _loc3_.figure = _loc2_.figure;
               centerContainer(previewAvatarWidget);
               break;
            case 1:
               previewPetWidget.visible = true;
               (_loc4_ = previewPetWidget.widget as class_3654).figure = _loc2_.figure;
               centerContainer(previewPetWidget);
         }
         var_3874 = param1;
      }
      
      public function setFurniByObjectId(param1:int) : void
      {
         var _loc4_:int = 0;
         if(param1 == var_3197 || -param1 == var_3197)
         {
            return;
         }
         clearPreviewer();
         if(param1 >= 0)
         {
            _loc4_ = 10;
         }
         else
         {
            param1 = -param1;
            _loc4_ = 20;
         }
         var _loc3_:IRoomEngine = var_319.roomEngine;
         var _loc2_:class_3499 = _loc3_.getRoomObjectImage(_loc3_.activeRoomId,param1,_loc4_,new Vector3d(180),64,null);
         if(_loc2_.data != null)
         {
            previewImageBitmap.bitmap = _loc2_.data.clone();
            if(_loc2_.data.width >= _container.width - 6 || _loc2_.data.height > _container.height - 6)
            {
               (previewImageBitmap as class_3501).zoomX = 0.5;
               (previewImageBitmap as class_3501).zoomY = 0.5;
            }
            else
            {
               (previewImageBitmap as class_3501).zoomX = 1;
               (previewImageBitmap as class_3501).zoomY = 1;
            }
            previewImageBitmap.visible = true;
            centerContainer(previewImageBitmap);
         }
         var_3197 = param1;
      }
      
      public function setGlobalPlaceholder() : void
      {
         clearPreviewer();
         previewGlobalPlaceholder.visible = true;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         var_3116 = -1;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get previewFurniInstructionText() : ITextWindow
      {
         return _container.findChildByName("preview_instruction_furni") as ITextWindow;
      }
      
      private function get previewUserInstructionText() : ITextWindow
      {
         return _container.findChildByName("preview_instruction_user") as ITextWindow;
      }
      
      private function get previewAvatarWidget() : IWidgetWindow
      {
         return _container.findChildByName("preview_avatar") as IWidgetWindow;
      }
      
      private function get previewPetWidget() : IWidgetWindow
      {
         return _container.findChildByName("preview_pet") as IWidgetWindow;
      }
      
      private function get previewImageBitmap() : IBitmapWrapperWindow
      {
         return _container.findChildByName("preview_image_bitmap") as IBitmapWrapperWindow;
      }
      
      private function get previewGlobalPlaceholder() : IStaticBitmapWrapperWindow
      {
         return _container.findChildByName("global_placeholder") as IStaticBitmapWrapperWindow;
      }
   }
}
