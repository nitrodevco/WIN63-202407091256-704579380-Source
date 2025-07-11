package com.sulake.habbo.ui.widget.playlisteditor
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IScrollbarWindow;
   import com.sulake.core.window.components.class_3437;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.sound.ISongInfo;
   import com.sulake.habbo.sound.class_3410;
   import com.sulake.habbo.sound.class_3609;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPlayListEditorNowPlayingEvent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class MainWindowHandler
   {
      
      private static const SHOW_BUY_MORE_MUSIC_DISK_COUNT:int = 6;
      
      private static const MY_MUSIC_SHOW_SCROLLBAR_ITEM_COUNT_LIMIT:int = 9;
      
      private static const PLAYLIST_SHOW_SCROLLBAR_ITEM_COUNT_LIMIT:int = 5;
       
      
      private var var_1629:PlayListEditorWidget;
      
      private var var_1923:class_3410;
      
      private var var_1641:IWindowContainer;
      
      private var var_3000:class_3437;
      
      private var var_3226:class_3437;
      
      private var var_2398:MusicInventoryGridView;
      
      private var var_2726:PlayListEditorItemListView;
      
      private var var_1943:MusicInventoryStatusView;
      
      private var var_2066:PlayListStatusView;
      
      private var var_3984:IScrollbarWindow;
      
      private var var_4140:IScrollbarWindow;
      
      public function MainWindowHandler(param1:PlayListEditorWidget, param2:class_3410)
      {
         var _loc3_:BitmapData = null;
         super();
         var_1629 = param1;
         var_1923 = param2;
         var _loc5_:Array = ["title_mymusic","title_playlist","background_preview_playing","background_get_more_music","background_add_songs"];
         for each(var _loc4_ in _loc5_)
         {
            _loc3_ = var_1629.getImageGalleryAssetBitmap(_loc4_);
            if(_loc3_ != null)
            {
               _loc3_.dispose();
            }
            else
            {
               var_1629.retrieveWidgetImage(_loc4_);
            }
         }
         createWindow();
         var_2398 = new MusicInventoryGridView(param1,getMusicInventoryGrid(),param2);
         var_2726 = new PlayListEditorItemListView(param1,getPlayListEditorItemList());
         var_1943 = new MusicInventoryStatusView(param1,getMusicInventoryStatusContainer());
         var_2066 = new PlayListStatusView(param1,getPlayListStatusContainer());
         refreshLoadableAsset();
      }
      
      public function get window() : IWindow
      {
         return var_1641;
      }
      
      public function get musicInventoryView() : MusicInventoryGridView
      {
         return var_2398;
      }
      
      public function get playListEditorView() : PlayListEditorItemListView
      {
         return var_2726;
      }
      
      public function destroy() : void
      {
         if(var_1923)
         {
            var_1923.stop(2);
            var_1923 = null;
         }
         if(var_2398)
         {
            var_2398.destroy();
            var_2398 = null;
         }
         if(var_2726)
         {
            var_2726.destroy();
            var_2726 = null;
         }
         if(var_2066)
         {
            var_2066.destroy();
            var_2066 = null;
         }
         if(var_1943)
         {
            var_1943.destroy();
            var_1943 = null;
         }
         var_1641.destroy();
         var_1641 = null;
      }
      
      public function hide() : void
      {
         var_1641.visible = false;
         if(var_1629 != null)
         {
            var_1629.stopUserSong();
         }
      }
      
      public function show() : void
      {
         var_1923.requestUserSongDisks();
         var _loc1_:class_3609 = var_1923.getRoomItemPlaylist();
         if(_loc1_ != null)
         {
            _loc1_.requestPlayList();
            selectPlayListStatusViewByFurniPlayListState();
         }
         var_1641.visible = true;
      }
      
      public function refreshLoadableAsset(param1:String = "") : void
      {
         if(param1 == "" || param1 == "title_mymusic")
         {
            assignWindowBitmapByAsset(var_3000,"music_inventory_splash_image","title_mymusic");
         }
         if(param1 == "" || param1 == "title_playlist")
         {
            assignWindowBitmapByAsset(var_3226,"playlist_editor_splash_image","title_playlist");
         }
         if(param1 == "" || param1 == "background_preview_playing")
         {
            var_1943.setPreviewPlayingBackgroundImage(var_1629.getImageGalleryAssetBitmap("background_preview_playing"));
         }
         if(param1 == "" || param1 == "background_get_more_music")
         {
            var_1943.setGetMoreMusicBackgroundImage(var_1629.getImageGalleryAssetBitmap("background_get_more_music"));
         }
         if(param1 == "" || param1 == "background_add_songs")
         {
            var_2066.addSongsBackgroundImage = var_1629.getImageGalleryAssetBitmap("background_add_songs");
         }
      }
      
      private function assignWindowBitmapByAsset(param1:IWindowContainer, param2:String, param3:String) : void
      {
         var _loc4_:BitmapData = null;
         var _loc5_:IBitmapWrapperWindow;
         if((_loc5_ = param1.getChildByName(param2) as IBitmapWrapperWindow) != null)
         {
            if((_loc4_ = var_1629.getImageGalleryAssetBitmap(param3)) != null)
            {
               _loc5_.bitmap = _loc4_;
               _loc5_.width = _loc4_.width;
               _loc5_.height = _loc4_.height;
            }
         }
      }
      
      private function createWindow() : void
      {
         if(var_1629 == null)
         {
            return;
         }
         var _loc2_:XmlAsset = var_1629.assets.getAssetByName("playlisteditor_main_window") as XmlAsset;
         var_1641 = var_1629.windowManager.buildFromXML(_loc2_.content as XML) as IWindowContainer;
         if(var_1641 == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         var_1641.position = new Point(80,0);
         var _loc3_:IWindowContainer = var_1641.getChildByName("content_area") as IWindowContainer;
         if(_loc3_ == null)
         {
            throw new Error("Window is missing \'content_area\' element");
         }
         var_3000 = _loc3_.getChildByName("my_music_border") as class_3437;
         var_3226 = _loc3_.getChildByName("playlist_border") as class_3437;
         if(var_3000 == null)
         {
            throw new Error("Window content area is missing \'my_music_border\' window element");
         }
         if(var_3226 == null)
         {
            throw new Error("Window content area is missing \'playlist_border\' window element");
         }
         var_3984 = var_3000.getChildByName("music_inventory_scrollbar") as IScrollbarWindow;
         var_4140 = var_3226.getChildByName("playlist_scrollbar") as IScrollbarWindow;
         if(var_3984 == null)
         {
            throw new Error("Window content area is missing \'music_inventory_scrollbar\' window element");
         }
         if(var_4140 == null)
         {
            throw new Error("Window content area is missing \'playlist_scrollbar\' window element");
         }
         var _loc1_:IWindow = var_1641.findChildByTag("close");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",onClose);
         }
      }
      
      private function getMusicInventoryGrid() : IItemGridWindow
      {
         return var_3000.getChildByName("music_inventory_itemgrid") as IItemGridWindow;
      }
      
      private function getPlayListEditorItemList() : IItemListWindow
      {
         return var_3226.getChildByName("playlist_editor_itemlist") as IItemListWindow;
      }
      
      private function getMusicInventoryStatusContainer() : IWindowContainer
      {
         return var_3000.getChildByName("preview_play_container") as IWindowContainer;
      }
      
      private function getPlayListStatusContainer() : IWindowContainer
      {
         return var_3226.getChildByName("now_playing_container") as IWindowContainer;
      }
      
      private function selectPlayListStatusViewByFurniPlayListState() : void
      {
         var _loc1_:class_3609 = var_1923.getRoomItemPlaylist();
         if(_loc1_ == null)
         {
            return;
         }
         if(_loc1_.isPlaying)
         {
            var_2066.selectView("PLSV_NOW_PLAYING");
         }
         else if(_loc1_.length > 0)
         {
            var_2066.selectView("PLSV_START_PLAYBACK");
         }
         else
         {
            var_2066.selectView("PLSV_ADD_SONGS");
         }
      }
      
      private function selectMusicStatusViewByMusicState() : void
      {
         if(isPreviewPlaying())
         {
            var_1943.show();
            var_1943.selectView("MISV_PREVIEW_PLAYING");
         }
         else if(var_1923.getSongDiskInventorySize() <= 6)
         {
            var_1943.show();
            var_1943.selectView("MISV_BUY_MORE");
         }
         else
         {
            var_1943.hide();
         }
      }
      
      private function updatePlaylistEditorView() : void
      {
         var _loc4_:int = 0;
         var _loc5_:ISongInfo = null;
         var _loc2_:class_3609 = var_1923.getRoomItemPlaylist();
         var _loc3_:Array = [];
         var _loc1_:int = -1;
         if(_loc2_ != null)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               if((_loc5_ = _loc2_.getEntry(_loc4_)) != null)
               {
                  _loc3_.push(_loc5_);
               }
               _loc4_++;
            }
            _loc1_ = _loc2_.playPosition;
         }
         var_2726.refresh(_loc3_,_loc1_);
      }
      
      public function onPlayListUpdated() : void
      {
         var _loc3_:ISongInfo = null;
         updatePlaylistEditorView();
         selectPlayListStatusViewByFurniPlayListState();
         var _loc1_:class_3609 = var_1923.getRoomItemPlaylist();
         if(_loc1_ == null)
         {
            return;
         }
         var _loc2_:int = _loc1_.nowPlayingSongId;
         if(_loc2_ != -1)
         {
            _loc3_ = var_1923.getSongInfo(_loc2_);
            var_2066.nowPlayingTrackName = _loc3_.name;
            var_2066.nowPlayingAuthorName = _loc3_.creator;
         }
         var_4140.visible = _loc1_.length > 5;
      }
      
      public function onSongDiskInventoryReceived() : void
      {
         var_2398.refresh();
         selectMusicStatusViewByMusicState();
         var_3984.visible = var_2398.itemCount > 9;
      }
      
      public function onNowPlayingChanged(param1:RoomWidgetPlayListEditorNowPlayingEvent) : void
      {
         var _loc3_:ISongInfo = null;
         var _loc2_:ISongInfo = null;
         switch(param1.type)
         {
            case "RWPLENPE_SONG_CHANGED":
               selectPlayListStatusViewByFurniPlayListState();
               var_2726.setItemIndexPlaying(param1.position);
               if(param1.id != -1)
               {
                  _loc3_ = var_1923.getSongInfo(param1.id);
                  var_2066.nowPlayingTrackName = _loc3_ != null ? _loc3_.name : "";
                  var_2066.nowPlayingAuthorName = _loc3_ != null ? _loc3_.creator : "";
               }
               break;
            case "RWPLENPE_USER_PLAY_SONG":
               var_2398.setPreviewIconToPause();
               _loc2_ = var_1923.getSongInfo(param1.id);
               var_1943.songName = _loc2_ != null ? _loc2_.name : "";
               var_1943.songName = _loc2_ != null ? _loc2_.name : "";
               var_1943.authorName = _loc2_ != null ? _loc2_.creator : "";
               selectMusicStatusViewByMusicState();
               break;
            case "RWPLENPW_USER_STOP_SONG":
               var_2398.setPreviewIconToPlay();
               selectMusicStatusViewByMusicState();
         }
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         hide();
      }
      
      private function isPreviewPlaying() : Boolean
      {
         return var_1923.getSongIdPlayingAtPriority(2) != -1;
      }
   }
}
