package com.sulake.habbo.ui.widget.playlisteditor
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.sound.ISongInfo;
   import com.sulake.habbo.sound.class_3410;
   import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
   import flash.geom.ColorTransform;
   
   public class MusicInventoryGridView
   {
       
      
      private var var_1923:class_3410;
      
      private var var_2438:IItemGridWindow;
      
      private var _items:Map;
      
      private var var_1629:PlayListEditorWidget;
      
      private var var_1741:MusicInventoryGridItem;
      
      public function MusicInventoryGridView(param1:PlayListEditorWidget, param2:IItemGridWindow, param3:class_3410)
      {
         _items = new Map();
         super();
         var_1923 = param3;
         var_2438 = param2;
         var_1629 = param1;
         var_1741 = null;
         var_1923.events.addEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
      }
      
      public function get itemCount() : int
      {
         return _items.length;
      }
      
      public function destroy() : void
      {
         if(var_2438 != null)
         {
            var_2438.destroyGridItems();
            var_2438 = null;
         }
         if(var_1923 != null)
         {
            if(var_1923.events != null)
            {
               var_1923.events.removeEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
            }
            var_1923 = null;
         }
         if(_items)
         {
            _items.reset();
            _items = null;
         }
         var_1741 = null;
         var_1629 = null;
      }
      
      public function refresh() : void
      {
         var _loc4_:int = 0;
         var _loc9_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:ISongInfo = null;
         var _loc1_:String = null;
         var _loc13_:ColorTransform = null;
         var _loc3_:MusicInventoryGridItem = null;
         var _loc7_:MusicInventoryGridItem = null;
         if(var_2438 == null)
         {
            return;
         }
         var_2438.removeGridItems();
         var _loc8_:Map = _items;
         var _loc2_:Map = new Map();
         var _loc5_:Array = _loc8_.getKeys();
         _items = new Map();
         var _loc6_:int = var_1923.getSongDiskInventorySize();
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc9_ = var_1923.getSongDiskInventoryDiskId(_loc4_);
            _loc11_ = var_1923.getSongDiskInventorySongId(_loc4_);
            _loc12_ = var_1923.getSongInfo(_loc11_);
            _loc1_ = null;
            _loc13_ = null;
            if(_loc12_ != null)
            {
               _loc1_ = _loc12_.name;
               _loc13_ = var_1629.getDiskColorTransformFromSongData(_loc12_.songData);
            }
            if(_loc5_.indexOf(_loc9_) == -1)
            {
               _loc3_ = new MusicInventoryGridItem(var_1629,_loc9_,_loc11_,_loc1_,_loc13_);
            }
            else
            {
               _loc3_ = _loc8_[_loc9_];
               _loc5_.splice(_loc5_.indexOf(_loc9_),1);
            }
            _loc3_.window.procedure = gridItemEventProc;
            _loc3_.toPlayListButton.procedure = gridItemEventProc;
            var_2438.addGridItem(_loc3_.window);
            _items.add(_loc9_,_loc3_);
            _loc4_++;
         }
         for each(var _loc10_ in _loc5_)
         {
            (_loc7_ = _loc8_[_loc10_]).destroy();
            _loc8_.remove(_loc10_);
         }
      }
      
      public function setPreviewIconToPause() : void
      {
         if(var_1741 != null)
         {
            var_1741.playButtonState = 1;
         }
      }
      
      public function setPreviewIconToPlay() : void
      {
         if(var_1741 != null)
         {
            var_1741.playButtonState = 0;
         }
      }
      
      public function deselectAny() : void
      {
         if(var_1741 != null)
         {
            var_1741.deselect();
            var_1741 = null;
         }
      }
      
      private function gridItemEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc4_:int = 0;
         var _loc5_:MusicInventoryGridItem = null;
         var _loc3_:* = param1.type == "WME_DOUBLE_CLICK";
         if(param1.type == "WME_CLICK" || _loc3_)
         {
            if(param2.name == "button_to_playlist" || _loc3_)
            {
               if(var_1741 != null)
               {
                  var_1741.deselect();
                  stopPreview();
                  var_1629.sendAddToPlayListMessage(var_1741.diskId);
                  var_1741 = null;
               }
            }
            else if(param2.name == "button_play_pause")
            {
               if(var_1741.playButtonState == 0)
               {
                  var_1741.playButtonState = 2;
                  var_1629.playUserSong(var_1741.songId);
               }
               else
               {
                  stopPreview();
               }
            }
            else if((_loc4_ = var_2438.getGridItemIndex(param1.window)) != -1)
            {
               if((_loc5_ = _items.getWithIndex(_loc4_)) != var_1741)
               {
                  if(var_1741 != null)
                  {
                     var_1741.deselect();
                  }
                  var_1741 = _loc5_;
                  var_1741.select();
                  stopPreview();
               }
               if(var_1629.mainWindowHandler != null)
               {
                  var_1629.mainWindowHandler.playListEditorView.deselectAny();
               }
            }
         }
      }
      
      private function stopPreview() : void
      {
         var_1629.stopUserSong();
         setPreviewIconToPlay();
      }
      
      private function onSongInfoReceivedEvent(param1:SongInfoReceivedEvent) : void
      {
         var _loc4_:ISongInfo = null;
         var _loc2_:String = null;
         var _loc5_:ColorTransform = null;
         var _loc3_:MusicInventoryGridItem = null;
         if(var_1923 != null)
         {
            if((_loc4_ = var_1923.getSongInfo(param1.id)) != null)
            {
               _loc2_ = _loc4_.name;
               _loc5_ = var_1629.getDiskColorTransformFromSongData(_loc4_.songData);
               _loc3_ = _items[param1.id];
               if(_loc3_ != null)
               {
                  _loc3_.update(param1.id,_loc2_,_loc5_);
               }
            }
         }
      }
   }
}
