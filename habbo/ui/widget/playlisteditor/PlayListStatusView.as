package com.sulake.habbo.ui.widget.playlisteditor
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.components.class_3489;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.display.BitmapData;
   
   public class PlayListStatusView
   {
      
      public static const ADD_SONGS:String = "PLSV_ADD_SONGS";
      
      public static const START_PLAYBACK:String = "PLSV_START_PLAYBACK";
      
      public static const NOW_PLAYING:String = "PLSV_NOW_PLAYING";
       
      
      private var _container:IWindowContainer;
      
      private var var_2221:Map;
      
      private var var_1629:PlayListEditorWidget;
      
      private var var_1674:String;
      
      public function PlayListStatusView(param1:PlayListEditorWidget, param2:IWindowContainer)
      {
         var_2221 = new Map();
         super();
         _container = param2;
         var_1629 = param1;
         createWindows();
      }
      
      public function destroy() : void
      {
         for each(var _loc1_ in var_2221.getValues())
         {
            _loc1_.destroy();
         }
         var_2221 = null;
      }
      
      public function selectView(param1:String) : void
      {
         _container.removeChildAt(0);
         _container.addChildAt(var_2221[param1] as IWindowContainer,0);
         var_1674 = param1;
      }
      
      public function set nowPlayingTrackName(param1:String) : void
      {
         if(var_1674 != "PLSV_NOW_PLAYING")
         {
            return;
         }
         var _loc2_:IWindowContainer = var_2221[var_1674];
         var _loc3_:ITextWindow = _loc2_.getChildByName("now_playing_track_name") as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.text = param1;
         }
      }
      
      public function set nowPlayingAuthorName(param1:String) : void
      {
         if(var_1674 != "PLSV_NOW_PLAYING")
         {
            return;
         }
         var _loc2_:IWindowContainer = var_2221[var_1674];
         var _loc3_:ITextWindow = _loc2_.getChildByName("now_playing_author_name") as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.text = param1;
         }
      }
      
      public function set addSongsBackgroundImage(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:IWindowContainer = var_2221["PLSV_ADD_SONGS"];
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IBitmapWrapperWindow = _loc2_.getChildByName("background_image") as IBitmapWrapperWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.bitmap = param1.clone();
         _loc3_.width = param1.width;
         _loc3_.height = param1.height;
      }
      
      private function createWindows() : void
      {
         var _loc3_:IWindowContainer = null;
         var _loc2_:XmlAsset = null;
         var _loc4_:class_3357 = null;
         var _loc1_:class_3489 = null;
         _loc2_ = var_1629.assets.getAssetByName("playlisteditor_playlist_subwindow_add_songs") as XmlAsset;
         _loc3_ = var_1629.windowManager.buildFromXML(_loc2_.content as XML) as IWindowContainer;
         if(_loc3_ != null)
         {
            var_2221.add("PLSV_ADD_SONGS",_loc3_);
         }
         _loc2_ = var_1629.assets.getAssetByName("playlisteditor_playlist_subwindow_play_now") as XmlAsset;
         _loc3_ = var_1629.windowManager.buildFromXML(_loc2_.content as XML) as IWindowContainer;
         if(_loc3_ != null)
         {
            var_2221.add("PLSV_START_PLAYBACK",_loc3_);
            (_loc4_ = _loc3_.getChildByName("play_now_button") as class_3357).addEventListener("WME_CLICK",onPlayPauseClicked);
         }
         _loc2_ = var_1629.assets.getAssetByName("playlisteditor_playlist_subwindow_nowplaying") as XmlAsset;
         _loc3_ = var_1629.windowManager.buildFromXML(_loc2_.content as XML) as IWindowContainer;
         if(_loc3_ != null)
         {
            var_2221.add("PLSV_NOW_PLAYING",_loc3_);
            _loc1_ = _loc3_.getChildByName("button_pause") as class_3489;
            _loc1_.addEventListener("WME_CLICK",onPlayPauseClicked);
            assignAssetToElement("icon_pause_large",_loc1_.getChildByName("pause_image") as IBitmapWrapperWindow);
            assignAssetToElement("jb_icon_disc",_loc3_.getChildByName("song_name_icon_bitmap") as IBitmapWrapperWindow);
            assignAssetToElement("jb_icon_composer",_loc3_.getChildByName("author_name_icon_bitmap") as IBitmapWrapperWindow);
         }
      }
      
      private function assignAssetToElement(param1:String, param2:IBitmapWrapperWindow) : void
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
      
      private function onPlayPauseClicked(param1:WindowMouseEvent) : void
      {
         var_1629.sendTogglePlayPauseStateMessage();
      }
   }
}
