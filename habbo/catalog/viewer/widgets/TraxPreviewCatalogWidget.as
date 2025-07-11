package com.sulake.habbo.catalog.viewer.widgets
{
    import assets.class_14

    import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.viewer.class_3388;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.sound.ISongInfo;
   import com.sulake.habbo.sound.class_2240;
   
   public class TraxPreviewCatalogWidget extends CatalogWidget implements class_3558
   {
       
      
      private var _soundManager:class_2240;
      
      private var var_2296:class_3357;
      
      private var var_2294:int = -1;
      
      public function TraxPreviewCatalogWidget(param1:IWindowContainer, param2:class_2240)
      {
         super(param1);
         var_2296 = _window.findChildByName("listen") as class_3357;
         class_14.log("Trax listener found button: " + var_2296);
         if(var_2296 != null)
         {
            var_2296.addEventListener("WME_CLICK",onClickPlay);
            var_2296.disable();
         }
         _soundManager = param2;
      }
      
      override public function dispose() : void
      {
         if(var_2296 != null)
         {
            var_2296.removeEventListener("WME_CLICK",onClickPlay);
         }
         if(_soundManager != null && _soundManager.musicController != null)
         {
            _soundManager.musicController.stop(3);
            _soundManager = null;
         }
         super.dispose();
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         if(page.offers.length == 0)
         {
            return false;
         }
         events.addEventListener("SELECT_PRODUCT",onSelectProduct);
         return true;
      }
      
      override public function closed() : void
      {
         super.closed();
         if(_soundManager != null && _soundManager.musicController != null)
         {
            _soundManager.musicController.stop(3);
         }
      }
      
      private function onSelectProduct(param1:SelectProductEvent) : void
      {
         if(param1 == null || param1.offer == null)
         {
            return;
         }
         var _loc3_:Boolean = false;
         var _loc2_:class_3388 = param1.offer.product;
         if(_loc2_.extraParam.length > 0)
         {
            var_2294 = parseInt(_loc2_.extraParam);
            _loc3_ = true;
         }
         if(var_2296 != null)
         {
            if(_loc3_)
            {
               var_2296.enable();
            }
            else
            {
               var_2296.disable();
            }
         }
      }
      
      private function onClickPlay(param1:WindowMouseEvent) : void
      {
         if(_soundManager != null && _soundManager.musicController != null)
         {
            forceNoFadeoutOnPlayingSong(0);
            forceNoFadeoutOnPlayingSong(3);
            _soundManager.musicController.playSong(var_2294,3,15,40,0,2);
         }
      }
      
      private function forceNoFadeoutOnPlayingSong(param1:int) : void
      {
         var _loc2_:ISongInfo = null;
         var _loc3_:int = _soundManager.musicController.getSongIdPlayingAtPriority(param1);
         if(_loc3_ != -1)
         {
            _loc2_ = _soundManager.musicController.getSongInfo(_loc3_);
            if(_loc2_.soundObject != null)
            {
               _loc2_.soundObject.fadeOutSeconds = 0;
            }
         }
      }
   }
}
