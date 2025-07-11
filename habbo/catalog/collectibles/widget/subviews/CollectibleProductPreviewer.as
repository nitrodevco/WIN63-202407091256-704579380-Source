package com.sulake.habbo.catalog.collectibles.widget.subviews
{
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.catalog.collectibles.class_3573;
   import com.sulake.habbo.room.class_3499;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   import com.sulake.habbo.window.widgets.class_3654;
   import flash.display.BitmapData;
   
   public class CollectibleProductPreviewer implements class_3573
   {
       
      
      private var var_3116:Number;
      
      private var var_2991:IWidgetWindow;
      
      private var var_3253:IWidgetWindow;
      
      private var var_3057:IWidgetWindow;
      
      private var var_2540:IBitmapWrapperWindow;
      
      private var var_3443:IStaticBitmapWrapperWindow;
      
      private var var_2277:EffectPreviewer;
      
      private var var_3303:IStaticBitmapWrapperWindow;
      
      private var _disposed:Boolean;
      
      public function CollectibleProductPreviewer(param1:IBitmapWrapperWindow, param2:IWidgetWindow, param3:IWidgetWindow, param4:IStaticBitmapWrapperWindow, param5:IWidgetWindow = null, param6:IStaticBitmapWrapperWindow = null, param7:IWidgetWindow = null, param8:IAvatarRenderManager = null)
      {
         super();
         var_2991 = param5;
         var_3253 = param2;
         var_3057 = param3;
         var_2540 = param1;
         var_3443 = param6;
         if(param7 != null && param8 != null)
         {
            var_2277 = new EffectPreviewer(param7,param8);
         }
         var_3303 = param4;
         clearPreviewer();
      }
      
      public function clearPreviewer() : void
      {
         var_3116 = -1;
         if(var_2991 != null)
         {
            var_2991.visible = false;
         }
         if(var_2540 != null)
         {
            var_2540.visible = false;
         }
         if(var_3253 != null)
         {
            var_3253.visible = false;
         }
         if(var_3443 != null)
         {
            var_3443.visible = false;
         }
         if(var_3057 != null)
         {
            var_3057.visible = false;
         }
         if(var_2277 != null)
         {
            var_2277.visible = false;
         }
         if(var_3303 != null)
         {
            var_3303.visible = false;
         }
      }
      
      public function set imageResult(param1:class_3499) : void
      {
         clearPreviewer();
         if(!var_2540)
         {
            return;
         }
         if(param1 != null)
         {
            var_3116 = param1.id;
            setPreviewImage(param1.data);
         }
      }
      
      public function set avatarResult(param1:String) : void
      {
         clearPreviewer();
         if(!var_2991)
         {
            return;
         }
         var_2991.visible = true;
         var _loc2_:IAvatarImageWidget = var_2991.widget as IAvatarImageWidget;
         _loc2_.figure = param1;
      }
      
      public function set badgeResult(param1:String) : void
      {
         clearPreviewer();
         if(!var_3253)
         {
            return;
         }
         var_3253.visible = true;
         var _loc2_:IBadgeImageWidget = var_3253.widget as IBadgeImageWidget;
         _loc2_.badgeId = param1;
      }
      
      public function set petResult(param1:String) : void
      {
         clearPreviewer();
         if(!var_3057)
         {
            return;
         }
         var_3057.visible = true;
         var _loc2_:class_3654 = var_3057.widget as class_3654;
         _loc2_.figure = param1;
      }
      
      public function setEffectResult(param1:String, param2:int) : void
      {
         clearPreviewer();
         if(!var_2277)
         {
            return;
         }
         var_2277.visible = true;
         var_2277.update(param1,param2);
      }
      
      public function setUnknownImage() : void
      {
         clearPreviewer();
         if(!var_3303)
         {
            return;
         }
         var_3303.visible = true;
      }
      
      public function setPlaceholder() : void
      {
         clearPreviewer();
         if(!var_3443)
         {
            return;
         }
         var_3443.visible = true;
      }
      
      private function setPreviewImage(param1:BitmapData) : void
      {
         if(var_2540 == null)
         {
            return;
         }
         if(param1 == null)
         {
            var_2540.visible = false;
            return;
         }
         var_2540.bitmap = param1.clone();
         var_2540.visible = true;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(var_3116 == param1 && var_2540 != null)
         {
            setPreviewImage(param2);
         }
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
         _disposed = true;
         if(var_2277 != null)
         {
            var_2277.dispose();
            var_2277 = null;
         }
         var_3116 = -1;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}
