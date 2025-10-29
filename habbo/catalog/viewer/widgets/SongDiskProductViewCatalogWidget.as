package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.class_3388;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.sound.ISongInfo;
   import com.sulake.habbo.sound.class_2240;
   import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
   import com.sulake.habbo.communication.messages.outgoing.sound.GetOfficialSongIdMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.sound.OfficialSongIdMessageEvent;
   
   public class SongDiskProductViewCatalogWidget extends ProductViewCatalogWidget
   {
       
      
      private var _soundManager:class_2240;
      
      private var var_26:IConnection;
      
      private var _playPreviewContainer:IWindowContainer;
      
      private var var_2296:class_3357;
      
      private var var_3391:IWindow;
      
      private var var_2294:int = -1;
      
      private var _officialSongId:String = "";
      
      private var var_4993:String = "";
      
      private var _officialSongIdListener:IMessageEvent = null;
      
      public function SongDiskProductViewCatalogWidget(param1:IWindowContainer, param2:HabboCatalog)
      {
         super(param1,param2);
         var_2296 = _window.findChildByName("listen") as class_3357;
         var_3391 = _window.findChildByName("ctlg_song_length");
         if(var_2296 != null)
         {
            var_2296.addEventListener("WME_CLICK",onClickPlay);
            var_2296.disable();
         }
         _playPreviewContainer = _window.findChildByName("playPreviewContainer") as IWindowContainer;
         if(_playPreviewContainer != null)
         {
            _playPreviewContainer.visible = false;
         }
         _soundManager = param2.soundManager;
         if(_soundManager != null)
         {
            _soundManager.events.addEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
         }
         var_26 = param2.connection;
         if(var_26 && !_officialSongIdListener)
         {
            _officialSongIdListener = new OfficialSongIdMessageEvent(onOfficialSongIdMessageEvent);
            var_26.addMessageEvent(_officialSongIdListener);
         }
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
            if(_soundManager.events != null)
            {
               _soundManager.events.removeEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
            }
            _soundManager = null;
            if(var_26 && _officialSongIdListener)
            {
               var_26.removeMessageEvent(_officialSongIdListener);
               _officialSongIdListener = null;
            }
            var_26 = null;
         }
         super.dispose();
      }
      
      override public function closed() : void
      {
         super.closed();
         if(_soundManager != null && _soundManager.musicController != null)
         {
            _soundManager.musicController.stop(3);
         }
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
      
      private function onClickPlay(param1:WindowMouseEvent) : void
      {
         if(_soundManager != null && _soundManager.musicController != null)
         {
            forceNoFadeoutOnPlayingSong(0);
            forceNoFadeoutOnPlayingSong(3);
            _soundManager.musicController.playSong(var_2294,3,15,40,0.5,2);
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
      
      private function onSelectProduct(param1:SelectProductEvent) : void
      {
         if(param1 == null || param1.offer == null)
         {
            return;
         }
         var _loc2_:class_3388 = param1.offer.product;
         if(_loc2_.extraParam.length > 0)
         {
            var_2294 = parseInt(_loc2_.extraParam);
            if(var_2294 == 0)
            {
               _officialSongId = _loc2_.extraParam;
               if(var_26)
               {
                  var_26.send(new GetOfficialSongIdMessageComposer(_officialSongId));
               }
            }
            if(_playPreviewContainer != null)
            {
               _playPreviewContainer.visible = true;
            }
         }
         else
         {
            var_2294 = -1;
         }
         updateView();
      }
      
      private function updateView() : void
      {
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:String = null;
         var _loc6_:String = null;
         var _loc3_:IHabboLocalizationManager = null;
         var _loc7_:String = null;
         var _loc2_:Boolean = false;
         var _loc5_:int;
         if((_loc5_ = getSongLength()) >= 0)
         {
            _loc1_ = _loc5_ / 60;
            _loc4_ = _loc5_ % 60;
            _loc8_ = "" + _loc1_;
            _loc6_ = "" + _loc4_;
            if(_loc4_ < 10)
            {
               _loc6_ = "0" + _loc6_;
            }
            _loc3_ = (page.viewer.catalog as HabboCatalog).localization;
            _loc3_.registerParameter("catalog.song.length","min",_loc8_);
            _loc7_ = String(_loc3_.registerParameter("catalog.song.length","sec",_loc6_));
            _loc2_ = true;
            if(var_3391 != null)
            {
               var_3391.caption = _loc7_;
            }
         }
         else if(var_3391 != null)
         {
            var_3391.caption = "";
         }
         if(var_2296 != null)
         {
            if(_loc2_)
            {
               var_2296.enable();
            }
            else
            {
               var_2296.disable();
            }
         }
      }
      
      private function getSongLength() : int
      {
         var _loc1_:ISongInfo = null;
         if(_soundManager != null && _soundManager.musicController != null)
         {
            _loc1_ = _soundManager.musicController.getSongInfo(var_2294);
            if(_loc1_ != null)
            {
               return _loc1_.length / 1000;
            }
            _soundManager.musicController.requestSongInfoWithoutSamples(var_2294);
         }
         return -1;
      }
      
      private function onSongInfoReceivedEvent(param1:SongInfoReceivedEvent) : void
      {
         if(param1.id == var_2294)
         {
            updateView();
         }
      }
      
      private function onOfficialSongIdMessageEvent(param1:OfficialSongIdMessageEvent) : void
      {
         if(param1.getParser().officialSongId == _officialSongId)
         {
            var_2294 = param1.getParser().songId;
            updateView();
         }
      }
   }
}
