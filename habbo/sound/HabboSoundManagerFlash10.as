package com.sulake.habbo.sound
{
    import assets.class_14

    import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.notifications.IHabboNotifications;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineObjectPlaySoundEvent;
   import com.sulake.habbo.sound.events.TraxSongLoadEvent;
   import com.sulake.habbo.sound.furni.FurniSamplePlaybackManager;
   import com.sulake.habbo.sound.music.HabboMusicController;
   import com.sulake.habbo.sound.music.TraxSampleManager;
   import com.sulake.habbo.sound.trax.TraxData;
   import com.sulake.habbo.sound.trax.TraxSequencer;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboNotifications;
   import com.sulake.iid.IIDRoomEngine;
   import flash.events.Event;
   import flash.media.Sound;
   import com.sulake.habbo.communication.messages.outgoing.sound.GetSoundSettingsComposer;
   import com.sulake.habbo.communication.messages.parser.preferences.class_1413;
   import com.sulake.habbo.communication.messages.outgoing.preferences.SetSoundSettingsComposer;
   import com.sulake.habbo.communication.messages.incoming.preferences.AccountPreferencesEvent;
   
   public class HabboSoundManagerFlash10 extends Component implements class_2240, IUpdateReceiver
   {
       
      
      private var _communication:IHabboCommunicationManager;
      
      private var var_26:IConnection;
      
      private var _roomEngine:IRoomEngine;
      
      private var _notifications:IHabboNotifications;
      
      private var _genericVolume:Number = 0;
      
      private var _traxVolume:Number = 1;
      
      private var _furniVolume:Number = 1;
      
      private var var_2719:Map;
      
      private var var_2654:int = -1;
      
      private var var_2231:TraxSequencer;
      
      private var var_1923:class_3410;
      
      private var var_2326:TraxSampleManager;
      
      private var var_2935:FurniSamplePlaybackManager;
      
      private var var_3573:Map;
      
      private var var_4500:Boolean = false;
      
      public function HabboSoundManagerFlash10(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null, param4:Boolean = true)
      {
         var_2719 = new Map();
         var_3573 = new Map();
         super(param1,param2,param3);
         if(param4)
         {
            queueInterface(new IIDHabboCommunicationManager(),onCommunicationManagerReady);
            queueInterface(new IIDRoomEngine(),onRoomEngineReady);
            queueInterface(new IIDHabboNotifications(),onNotificationsReady);
         }
         events.addEventListener("TSLE_TRAX_LOAD_COMPLETE",onTraxLoadComplete);
         registerUpdateReceiver(this,1);
         class_14.log("Sound manager 10 init");
      }
      
      public function get musicController() : class_3410
      {
         return var_1923;
      }
      
      public function get genericVolume() : Number
      {
         return _genericVolume;
      }
      
      public function set genericVolume(param1:Number) : void
      {
         updateVolumeSetting(param1,_furniVolume,_traxVolume);
         storeVolumeSetting();
      }
      
      public function get traxVolume() : Number
      {
         return _traxVolume;
      }
      
      public function set traxVolume(param1:Number) : void
      {
         updateVolumeSetting(_genericVolume,_furniVolume,param1);
         storeVolumeSetting();
      }
      
      public function get furniVolume() : Number
      {
         return _furniVolume;
      }
      
      public function set furniVolume(param1:Number) : void
      {
         updateVolumeSetting(_genericVolume,param1,_traxVolume);
         storeVolumeSetting();
      }
      
      public function previewVolume(param1:Number, param2:Number, param3:Number) : void
      {
         updateVolumeSetting(param1,param2,param3);
      }
      
      override public function dispose() : void
      {
         var_26 = null;
         if(var_1923)
         {
            var_1923.dispose();
            var_1923 = null;
         }
         if(var_2326)
         {
            var_2326.dispose();
            var_2326 = null;
         }
         if(var_2719)
         {
            var_2719.dispose();
            var_2719 = null;
         }
         if(var_2935)
         {
            var_2935.dispose();
            var_2935 = null;
         }
         if(_communication)
         {
            _communication.release(new IIDHabboCommunicationManager());
            _communication = null;
         }
         if(_roomEngine)
         {
            _roomEngine.events.removeEventListener("REPSE_PLAY_SOUND",onRoomEngineObjectPlaySound);
            _roomEngine.events.removeEventListener("REPSE_PLAY_SOUND_AT_PITCH",onRoomEngineObjectPlaySound);
            _roomEngine.release(new IIDRoomEngine());
            _roomEngine = null;
         }
         if(_notifications)
         {
            _notifications.release(new IIDHabboNotifications());
            _notifications = null;
         }
         super.dispose();
      }
      
      public function playSound(param1:String, param2:int = 0) : void
      {
         var _loc4_:Sound = null;
         var _loc3_:class_3371 = var_2719.getValue(param1);
         if(_loc3_ == null)
         {
            if((_loc4_ = getSoundBySoundId(param1)) != null)
            {
               _loc3_ = new HabboSoundBase(_loc4_,param2);
               var_2719.add(param1,class_3371(_loc3_));
            }
         }
         _loc3_.volume = _genericVolume;
         _loc3_.play();
      }
      
      public function playSoundAtPitch(param1:String, param2:Number) : class_3371
      {
         var _loc4_:Sound;
         if((_loc4_ = getSoundBySoundId(param1)) == null)
         {
            return null;
         }
         var _loc3_:HabboSoundWithPitch = new HabboSoundWithPitch(_loc4_,param2);
         _loc3_.volume = _genericVolume;
         _loc3_.play();
         return _loc3_;
      }
      
      public function stopSound(param1:String) : void
      {
         var _loc2_:class_3371 = var_2719.getValue(param1);
         if(_loc2_ != null)
         {
            _loc2_.stop();
         }
      }
      
      public function get loadingSongId() : int
      {
         return var_2654;
      }
      
      private function onSampleLoadError() : void
      {
         var_2654 = -1;
         var_2231 = null;
      }
      
      private function getSoundBySoundId(param1:String) : Sound
      {
         var _loc2_:* = "";
         switch(param1)
         {
            case "HBST_call_for_help":
               _loc2_ = "sound_call_for_help";
               break;
            case "HBST_guide_invitation":
               _loc2_ = "sound_guide_received_invitation";
               break;
            case "HBST_guide_request":
               _loc2_ = "sound_guide_help_requested";
               break;
            case "HBST_message_received":
               _loc2_ = "sound_console_new_message";
               break;
            case "HBST_message_sent":
               _loc2_ = "sound_console_message_sent";
               break;
            case "HBST_pixels":
               _loc2_ = "sound_catalogue_duckets";
               break;
            case "HBST_purchase":
               _loc2_ = "sound_catalogue_cash";
               break;
            case "HBST_respect":
               _loc2_ = "sound_respect_received";
               break;
            case "CAMERA_shutter":
               _loc2_ = "sound_camera_shutter";
               break;
            case "HBSTG_snowwar_get_snowball":
            case "HBSTG_snowwar_hit1":
            case "HBSTG_snowwar_hit2":
            case "HBSTG_snowwar_hit3":
            case "HBSTG_snowwar_make_snowball":
            case "HBSTG_snowwar_miss":
            case "HBSTG_snowwar_throw":
            case "HBSTG_snowwar_walk":
            case "HBSTG_ig_countdown":
            case "HBSTG_ig_winning":
            case "HBSTG_ig_losing":
               _loc2_ = param1;
               break;
            case "FURNITURE_cuckoo_clock":
               _loc2_ = param1;
               break;
            default:
               class_14.log("HabboSoundManagerFlash10: Unknown sound request: " + param1);
               return null;
         }
         return getSoundByAssetName(_loc2_);
      }
      
      private function getSoundByAssetName(param1:String) : Sound
      {
         var _loc2_:IAsset = this.findAssetByName(param1);
         return _loc2_.content as Sound;
      }
      
      public function loadTraxSong(param1:int, param2:String) : class_3371
      {
         if(var_2231 != null)
         {
            return addTraxSongForDownload(param1,param2);
         }
         var _loc3_:TraxSequencer = createTraxInstance(param1,param2);
         if(!_loc3_.ready)
         {
            var_2231 = _loc3_;
            var_2654 = param1;
         }
         return _loc3_ as class_3371;
      }
      
      private function addTraxSongForDownload(param1:int, param2:String) : class_3371
      {
         var _loc3_:TraxSequencer = createTraxInstance(param1,param2,false);
         if(!_loc3_.ready)
         {
            var_3573.add(param1,_loc3_);
         }
         return _loc3_;
      }
      
      private function createTraxInstance(param1:int, param2:String, param3:Boolean = true) : TraxSequencer
      {
         var _loc5_:TraxData = new TraxData(param2);
         var _loc4_:TraxSequencer;
         (_loc4_ = new TraxSequencer(param1,_loc5_,var_2326.traxSamples,events)).volume = _genericVolume;
         validateSampleAvailability(_loc4_,param3);
         return _loc4_;
      }
      
      private function validateSampleAvailability(param1:TraxSequencer, param2:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc6_:TraxData;
         var _loc5_:Array = (_loc6_ = param1.traxData).getSampleIds();
         var _loc3_:Boolean = false;
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            if(var_2326.traxSamples.getValue(int(_loc5_[_loc4_])) == null)
            {
               if(param2)
               {
                  var_2326.loadSample(int(_loc5_[_loc4_]));
               }
               _loc3_ = true;
            }
            _loc4_++;
         }
         if(_loc3_)
         {
            param1.ready = false;
         }
         else
         {
            param1.ready = true;
         }
      }
      
      public function notifyPlayedSong(param1:String, param2:String) : void
      {
         if(_notifications == null)
         {
            return;
         }
         _notifications.addSongPlayingNotification(param1,param2);
      }
      
      private function onCommunicationManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         var _loc3_:IConnection = null;
         if(param2 != null)
         {
            _communication = IHabboCommunicationManager(param2);
            _loc3_ = _communication.connection;
            if(_loc3_ != null)
            {
               onConnectionReady(_loc3_);
               init();
            }
         }
      }
      
      private function onRoomEngineReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(param2 == null)
         {
            return;
         }
         _roomEngine = IRoomEngine(param2);
         init();
      }
      
      private function onNotificationsReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(param2 == null)
         {
            return;
         }
         _notifications = IHabboNotifications(param2);
      }
      
      private function onConnectionReady(param1:IConnection) : void
      {
         if(disposed)
         {
            return;
         }
         if(param1 != null)
         {
            var_26 = param1;
         }
         init();
      }
      
      private function init() : void
      {
         if(var_26 == null || _roomEngine == null || var_1923 != null)
         {
            return;
         }
         var_1923 = new HabboMusicController(this,events,_roomEngine.events,var_26);
         var_2326 = new TraxSampleManager(this,onSampleLoadError);
         var_2935 = new FurniSamplePlaybackManager(this,_roomEngine.events);
         _roomEngine.events.addEventListener("REPSE_PLAY_SOUND",onRoomEngineObjectPlaySound);
         _roomEngine.events.addEventListener("REPSE_PLAY_SOUND_AT_PITCH",onRoomEngineObjectPlaySound);
         var_26.addMessageEvent(new AccountPreferencesEvent(onSoundSettingsEvent));
         var_26.send(new GetSoundSettingsComposer());
      }
      
      protected function setMusicController(param1:class_3410) : void
      {
         var_1923 = param1;
      }
      
      private function onTraxLoadComplete(param1:Event) : void
      {
         var _loc2_:TraxSongLoadEvent = param1 as TraxSongLoadEvent;
         if(_loc2_ == null)
         {
            return;
         }
         if(var_2231 == null)
         {
            return;
         }
         var_2231.ready = true;
         if(var_1923 == null)
         {
            return;
         }
         var_1923.onSongLoaded(_loc2_.id);
         var_2231 = null;
         var_2654 = -1;
      }
      
      private function storeVolumeSetting() : void
      {
         if(var_26 != null)
         {
            var_26.send(new SetSoundSettingsComposer(int(_traxVolume * 100),int(_furniVolume * 100),int(_genericVolume * 100)));
         }
      }
      
      private function updateVolumeSetting(param1:Number, param2:Number, param3:Number) : void
      {
         if(var_4500)
         {
            _genericVolume = 0;
            _furniVolume = 0;
            _traxVolume = 0;
            var_1923.updateVolume(0);
            var_2935.updateVolume(0);
         }
         else
         {
            _genericVolume = param1;
            _furniVolume = param2;
            _traxVolume = param3;
            var_1923.updateVolume(param3);
            var_2935.updateVolume(param2);
         }
      }
      
      private function onSoundSettingsEvent(param1:IMessageEvent) : void
      {
         var _loc3_:AccountPreferencesEvent = param1 as AccountPreferencesEvent;
         var _loc2_:class_1413 = _loc3_.getParser() as class_1413;
         var _loc4_:Number;
         if((_loc4_ = _loc2_.uiVolume) == 1)
         {
            _loc4_ = 100;
         }
         updateVolumeSetting(_loc4_ / 100,_loc2_.furniVolume / 100,_loc2_.traxVolume / 100);
      }
      
      private function loadNextSong() : void
      {
         var _loc2_:int = 0;
         var _loc1_:TraxSequencer = null;
         if(var_2231 == null && var_3573.length > 0)
         {
            _loc2_ = var_3573.getKey(0);
            _loc1_ = var_3573.remove(_loc2_);
            if(_loc1_ != null && !_loc1_.disposed)
            {
               validateSampleAvailability(_loc1_,true);
               if(_loc1_.ready)
               {
                  events.dispatchEvent(new TraxSongLoadEvent("TSLE_TRAX_LOAD_COMPLETE",_loc2_));
               }
               else
               {
                  var_2231 = _loc1_;
                  var_2654 = _loc2_;
               }
            }
         }
      }
      
      private function onRoomEngineObjectPlaySound(param1:Event) : void
      {
         var _loc2_:RoomEngineObjectPlaySoundEvent = RoomEngineObjectPlaySoundEvent(param1);
         if(param1.type == "REPSE_PLAY_SOUND")
         {
            playSound(_loc2_.soundId);
         }
         if(param1.type == "REPSE_PLAY_SOUND_AT_PITCH")
         {
            playSoundAtPitch(_loc2_.soundId,_loc2_.pitch);
         }
      }
      
      public function update(param1:uint) : void
      {
         if(var_2326 != null)
         {
            var_2326.update(param1);
         }
         loadNextSong();
      }
      
      public function mute(param1:Boolean) : void
      {
         var_4500 = param1;
         updateVolumeSetting(_genericVolume,_furniVolume,_traxVolume);
      }
   }
}
