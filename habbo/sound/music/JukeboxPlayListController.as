package com.sulake.habbo.sound.music
{
    import assets.class_14

    import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.sound.HabboSoundManagerFlash10;
   import com.sulake.habbo.sound.ISongInfo;
   import com.sulake.habbo.sound.class_3410;
   import com.sulake.habbo.sound.class_3609;
   import com.sulake.habbo.sound.events.NowPlayingEvent;
   import com.sulake.habbo.sound.events.PlayListStatusEvent;
   import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
   import com.sulake.habbo.sound.events.SoundCompleteEvent;
   import flash.events.IEventDispatcher;
   import com.sulake.habbo.communication.messages.parser.sound.NowPlayingMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.sound.JukeboxSongDisksMessageEventParser;
   import com.sulake.habbo.communication.messages.outgoing.sound.GetJukeboxPlayListMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.sound.JukeboxSongDisksMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.sound.NowPlayingMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.sound.JukeboxPlayListFullMessageEvent;
   
   public class JukeboxPlayListController implements class_3609
   {
       
      
      private var _disposed:Boolean = false;
      
      private var var_521:Boolean = false;
      
      private var var_97:Array;
      
      private var var_1923:class_3410;
      
      private var name_1:IEventDispatcher;
      
      private var var_26:IConnection;
      
      private var _soundManager:HabboSoundManagerFlash10;
      
      private var var_2077:int = -1;
      
      private var _missingSongInfo:Array;
      
      private var _messageEvents:Array;
      
      private var var_3745:int = -1;
      
      public function JukeboxPlayListController(param1:HabboSoundManagerFlash10, param2:HabboMusicController, param3:IEventDispatcher, param4:IConnection)
      {
         var_97 = [];
         _missingSongInfo = [];
         super();
         _soundManager = param1;
         var_1923 = param2;
         name_1 = param3;
         var_26 = param4;
         _messageEvents = [];
         _messageEvents.push(new NowPlayingMessageEvent(onNowPlayingMessage));
         _messageEvents.push(new JukeboxSongDisksMessageEvent(onJukeboxSongDisksMessage));
         _messageEvents.push(new JukeboxPlayListFullMessageEvent(onJukeboxPlayListFullMessage));
         for each(var _loc5_ in _messageEvents)
         {
            var_26.addMessageEvent(_loc5_);
         }
         name_1.addEventListener("SCE_TRAX_SONG_COMPLETE",onSongFinishedPlayingEvent);
         var_1923.events.addEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
      }
      
      public function get priority() : int
      {
         return 0;
      }
      
      public function get nowPlayingSongId() : int
      {
         return var_2077;
      }
      
      public function get playPosition() : int
      {
         return var_3745;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get isPlaying() : Boolean
      {
         return var_521;
      }
      
      public function get length() : int
      {
         if(var_97 == null)
         {
            return 0;
         }
         return var_97.length;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            stopPlaying();
            if(var_1923.events)
            {
               var_1923.events.removeEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
            }
            var_1923 = null;
            _soundManager = null;
            if(var_26)
            {
               for each(var _loc1_ in _messageEvents)
               {
                  var_26.removeMessageEvent(_loc1_);
                  _loc1_.dispose();
               }
               _messageEvents = null;
               var_26 = null;
            }
            if(name_1)
            {
               name_1.removeEventListener("SCE_TRAX_SONG_COMPLETE",onSongFinishedPlayingEvent);
               name_1 = null;
            }
            _disposed = true;
         }
      }
      
      public function stopPlaying() : void
      {
         var_1923.stop(priority);
         var_2077 = -1;
         var_3745 = -1;
         var_521 = false;
      }
      
      public function requestPlayList() : void
      {
         if(var_26 == null)
         {
            return;
         }
         var_26.send(new GetJukeboxPlayListMessageComposer());
      }
      
      public function getEntry(param1:int) : ISongInfo
      {
         if(param1 < 0 || param1 >= var_97.length)
         {
            return null;
         }
         return var_97[param1];
      }
      
      protected function onSongFinishedPlayingEvent(param1:SoundCompleteEvent) : void
      {
      }
      
      private function onNowPlayingMessage(param1:IMessageEvent) : void
      {
         var _loc3_:NowPlayingMessageEvent = param1 as NowPlayingMessageEvent;
         var _loc2_:NowPlayingMessageEventParser = _loc3_.getParser() as NowPlayingMessageEventParser;
         class_14.log("Received Now Playing message with: " + _loc2_.currentSongId + ", " + _loc2_.nextSongId + ", " + _loc2_.syncCount);
         var_521 = _loc2_.currentSongId != -1;
         if(_loc2_.currentSongId >= 0)
         {
            var_1923.playSong(_loc2_.currentSongId,0,_loc2_.syncCount / 1000,0,1,1);
            var_2077 = _loc2_.currentSongId;
         }
         else
         {
            stopPlaying();
         }
         if(_loc2_.nextSongId >= 0)
         {
            var_1923.addSongInfoRequest(_loc2_.nextSongId);
         }
         var_3745 = _loc2_.currentPosition;
         _soundManager.events.dispatchEvent(new NowPlayingEvent("NPE_SONG_CHANGED",0,_loc2_.currentSongId,_loc2_.currentPosition));
      }
      
      private function onJukeboxSongDisksMessage(param1:IMessageEvent) : void
      {
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:SongDataEntry = null;
         var _loc5_:JukeboxSongDisksMessageEvent;
         var _loc2_:JukeboxSongDisksMessageEventParser = (_loc5_ = param1 as JukeboxSongDisksMessageEvent).getParser() as JukeboxSongDisksMessageEventParser;
         class_14.log("Received Jukebox song disks (=playlist) message, length of playlist: " + _loc2_.songDisks.length);
         var_97 = [];
         _loc4_ = 0;
         while(_loc4_ < _loc2_.songDisks.length)
         {
            _loc7_ = _loc2_.songDisks.getWithIndex(_loc4_);
            _loc6_ = _loc2_.songDisks.getKey(_loc4_);
            _loc3_ = var_1923.getSongInfo(_loc7_) as SongDataEntry;
            if(_loc3_ == null)
            {
               _loc3_ = new SongDataEntry(_loc7_,-1,null,null,null);
               if(_missingSongInfo.indexOf(_loc7_) < 0)
               {
                  _missingSongInfo.push(_loc7_);
                  var_1923.requestSongInfoWithoutSamples(_loc7_);
               }
            }
            _loc3_.diskId = _loc6_;
            var_97.push(_loc3_);
            _loc4_++;
         }
         if(_missingSongInfo.length == 0)
         {
            name_1.dispatchEvent(new PlayListStatusEvent("PLUE_PLAY_LIST_UPDATED"));
         }
      }
      
      private function onJukeboxPlayListFullMessage(param1:IMessageEvent) : void
      {
         class_14.log("Received jukebox playlist full message.");
         name_1.dispatchEvent(new PlayListStatusEvent("PLUE_PLAY_LIST_FULL"));
      }
      
      private function onSongInfoReceivedEvent(param1:SongInfoReceivedEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:ISongInfo = null;
         var _loc6_:int = 0;
         var _loc3_:SongDataEntry = null;
         _loc4_ = 0;
         while(_loc4_ < length)
         {
            _loc2_ = var_97[_loc4_];
            if(_loc2_.id == param1.id)
            {
               _loc6_ = _loc2_.diskId;
               _loc3_ = var_1923.getSongInfo(param1.id) as SongDataEntry;
               if(_loc3_ != null)
               {
                  _loc3_.diskId = _loc6_;
                  var_97[_loc4_] = _loc3_;
               }
               break;
            }
            _loc4_++;
         }
         var _loc5_:int;
         if((_loc5_ = _missingSongInfo.indexOf(param1.id)) >= 0)
         {
            _missingSongInfo.splice(_loc5_,1);
         }
         if(_missingSongInfo.length == 0)
         {
            name_1.dispatchEvent(new PlayListStatusEvent("PLUE_PLAY_LIST_UPDATED"));
         }
      }
   }
}
