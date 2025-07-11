package com.sulake.habbo.ui.widget.playlisteditor
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class MusicInventoryStatusView
   {
      
      public static const BUY_MORE:String = "MISV_BUY_MORE";
      
      public static const PREVIEW_PLAYING:String = "MISV_PREVIEW_PLAYING";
       
      
      private var _container:IWindowContainer;
      
      private var var_2221:Map;
      
      private var var_1629:PlayListEditorWidget;
      
      private var var_1674:String;
      
      private var var_4190:ITextWindow;
      
      private var var_4157:ITextWindow;
      
      public function MusicInventoryStatusView(param1:PlayListEditorWidget, param2:IWindowContainer)
      {
         var_2221 = new Map();
         super();
         _container = param2;
         var_1629 = param1;
         createWindows();
         hide();
      }
      
      public function destroy() : void
      {
         for each(var _loc1_ in var_2221.getValues())
         {
            _loc1_.destroy();
         }
         var_2221 = null;
      }
      
      public function show() : void
      {
         _container.visible = true;
      }
      
      public function hide() : void
      {
         _container.visible = false;
      }
      
      public function selectView(param1:String) : void
      {
         _container.removeChildAt(0);
         _container.addChildAt(var_2221[param1] as IWindowContainer,0);
         var_1674 = param1;
      }
      
      public function set songName(param1:String) : void
      {
         if(var_4190 == null)
         {
            return;
         }
         var_4190.text = param1;
      }
      
      public function set authorName(param1:String) : void
      {
         if(var_4157 == null)
         {
            return;
         }
         var_4157.text = param1;
      }
      
      public function setPreviewPlayingBackgroundImage(param1:BitmapData, param2:Boolean = true) : void
      {
         blitBackgroundImage("MISV_PREVIEW_PLAYING","preview_play_background_image",param1);
         if(param2 && param1 != null)
         {
            param1.dispose();
         }
      }
      
      public function setGetMoreMusicBackgroundImage(param1:BitmapData, param2:Boolean = true) : void
      {
         blitBackgroundImage("MISV_BUY_MORE","get_more_music_background_image",param1);
         if(param2 && param1 != null)
         {
            param1.dispose();
         }
      }
      
      private function createWindows() : void
      {
         var _loc3_:IWindowContainer = null;
         var _loc2_:XmlAsset = null;
         var _loc1_:class_3357 = null;
         var _loc4_:class_3357 = null;
         _loc2_ = var_1629.assets.getAssetByName("playlisteditor_inventory_subwindow_play_preview") as XmlAsset;
         _loc3_ = var_1629.windowManager.buildFromXML(_loc2_.content as XML) as IWindowContainer;
         if(_loc3_ != null)
         {
            var_2221.add("MISV_PREVIEW_PLAYING",_loc3_);
            var_4190 = _loc3_.getChildByName("preview_play_track_name") as ITextWindow;
            var_4157 = _loc3_.getChildByName("preview_play_author_name") as ITextWindow;
            _loc1_ = _loc3_.getChildByName("stop_preview_button") as class_3357;
            _loc1_.addEventListener("WME_CLICK",onStopPreviewClicked);
            setPreviewPlayingBackgroundImage(var_1629.getImageGalleryAssetBitmap("background_preview_playing"));
            assignAssetByNameToElement("jb_icon_disc",_loc3_.getChildByName("song_name_icon_bitmap") as IBitmapWrapperWindow);
            assignAssetByNameToElement("jb_icon_composer",_loc3_.getChildByName("author_name_icon_bitmap") as IBitmapWrapperWindow);
         }
         _loc2_ = var_1629.assets.getAssetByName("playlisteditor_inventory_subwindow_get_more_music") as XmlAsset;
         _loc3_ = var_1629.windowManager.buildFromXML(_loc2_.content as XML) as IWindowContainer;
         if(_loc3_ != null)
         {
            var_2221.add("MISV_BUY_MORE",_loc3_);
            (_loc4_ = _loc3_.getChildByName("open_catalog_button") as class_3357).addEventListener("WME_CLICK",onOpenCatalogButtonClicked);
            setGetMoreMusicBackgroundImage(var_1629.getImageGalleryAssetBitmap("background_get_more_music"));
         }
      }
      
      private function blitBackgroundImage(param1:String, param2:String, param3:BitmapData) : void
      {
         var _loc5_:BitmapData = null;
         var _loc6_:IWindowContainer;
         if((_loc6_ = var_2221[param1] as IWindowContainer) == null)
         {
            return;
         }
         var _loc4_:IBitmapWrapperWindow;
         if((_loc4_ = _loc6_.getChildByName(param2) as IBitmapWrapperWindow) == null)
         {
            return;
         }
         if(param3 != null)
         {
            (_loc5_ = new BitmapData(_loc4_.width,_loc4_.height,false,4294967295)).copyPixels(param3,param3.rect,new Point(0,0));
            _loc4_.bitmap = _loc5_;
         }
      }
      
      private function assignAssetByNameToElement(param1:String, param2:IBitmapWrapperWindow) : void
      {
         var _loc3_:BitmapData = null;
         var _loc4_:BitmapDataAsset;
         if((_loc4_ = var_1629.assets.getAssetByName(param1) as BitmapDataAsset) != null)
         {
            if(param2 != null && _loc4_.content != null)
            {
               _loc3_ = _loc4_.content as BitmapData;
               param2.bitmap = _loc3_.clone();
            }
         }
      }
      
      private function onOpenCatalogButtonClicked(param1:WindowMouseEvent) : void
      {
         var_1629.openSongDiskShopCataloguePage();
      }
      
      private function onStopPreviewClicked(param1:WindowMouseEvent) : void
      {
         var_1629.stopUserSong();
      }
   }
}
