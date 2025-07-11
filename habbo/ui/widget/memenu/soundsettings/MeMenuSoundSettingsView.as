package com.sulake.habbo.ui.widget.memenu.soundsettings
{
    import assets.class_14

    import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetSettingsUpdateEvent;
   import com.sulake.habbo.ui.widget.memenu.IMeMenuView;
   import com.sulake.habbo.ui.widget.memenu.MeMenuWidget;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetGetSettingsMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetStoreSettingsMessage;
   import flash.display.BitmapData;
   
   public class MeMenuSoundSettingsView implements IMeMenuView
   {
       
      
      private var var_1629:MeMenuWidget;
      
      private var _window:IWindowContainer;
      
      private var var_2781:MeMenuSoundSettingsItem;
      
      private var var_2761:MeMenuSoundSettingsItem;
      
      private var var_2862:MeMenuSoundSettingsItem;
      
      private var _soundsOffIconColor:BitmapData;
      
      private var _soundsOffIconWhite:BitmapData;
      
      private var _soundsOnIconColor:BitmapData;
      
      private var _soundsOnIconWhite:BitmapData;
      
      private var _genericVolume:Number = 1;
      
      private var _furniVolume:Number = 1;
      
      private var _traxVolume:Number = 1;
      
      public function MeMenuSoundSettingsView()
      {
         super();
      }
      
      public function init(param1:MeMenuWidget, param2:String) : void
      {
         var_1629 = param1;
         createWindow(param2);
      }
      
      public function dispose() : void
      {
         saveVolume(_genericVolume,_furniVolume,_traxVolume);
         var_1629 = null;
         if(_window != null)
         {
            _window.dispose();
         }
         _window = null;
         if(var_2781 != null)
         {
            var_2781.dispose();
         }
         var_2781 = null;
         if(var_2761 != null)
         {
            var_2761.dispose();
         }
         var_2761 = null;
         if(var_2862 != null)
         {
            var_2862.dispose();
         }
         var_2862 = null;
         if(_soundsOffIconColor)
         {
            _soundsOffIconColor.dispose();
            _soundsOffIconColor = null;
         }
         if(_soundsOffIconWhite)
         {
            _soundsOffIconWhite.dispose();
            _soundsOffIconWhite = null;
         }
         if(_soundsOnIconColor)
         {
            _soundsOnIconColor.dispose();
            _soundsOnIconColor = null;
         }
         if(_soundsOnIconWhite)
         {
            _soundsOnIconWhite.dispose();
            _soundsOnIconWhite = null;
         }
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      public function updateSettings(param1:RoomWidgetSettingsUpdateEvent) : void
      {
         _genericVolume = param1.uiVolume;
         _furniVolume = param1.furniVolume;
         _traxVolume = param1.traxVolume;
         if(var_2781 != null)
         {
            var_2781.setValue(_genericVolume);
         }
         if(var_2761 != null)
         {
            var_2761.setValue(_furniVolume);
         }
         if(var_2862 != null)
         {
            var_2862.setValue(_traxVolume);
         }
      }
      
      private function createWindow(param1:String) : void
      {
         var _loc2_:IWindow = null;
         var _loc5_:int = 0;
         var _loc4_:BitmapDataAsset = null;
         var _loc3_:XmlAsset = var_1629.assets.getAssetByName("memenu_settings") as XmlAsset;
         if(_loc3_)
         {
            _window = var_1629.windowManager.buildFromXML(_loc3_.content as XML) as IWindowContainer;
         }
         if(_window == null)
         {
            throw new Error("Failed to construct sound settings window from XML!");
         }
         _window.name = param1;
         _loc5_ = 0;
         while(_loc5_ < _window.numChildren)
         {
            _loc2_ = _window.getChildAt(_loc5_);
            _loc2_.addEventListener("WME_CLICK",onButtonClicked);
            _loc5_++;
         }
         if((_loc4_ = var_1629.assets.getAssetByName("sounds_off_color") as BitmapDataAsset) != null && _loc4_.content != null)
         {
            _soundsOffIconColor = (_loc4_.content as BitmapData).clone();
         }
         if((_loc4_ = var_1629.assets.getAssetByName("sounds_off_white") as BitmapDataAsset) != null && _loc4_.content != null)
         {
            _soundsOffIconWhite = (_loc4_.content as BitmapData).clone();
         }
         if((_loc4_ = var_1629.assets.getAssetByName("sounds_on_color") as BitmapDataAsset) != null && _loc4_.content != null)
         {
            _soundsOnIconColor = (_loc4_.content as BitmapData).clone();
         }
         if((_loc4_ = var_1629.assets.getAssetByName("sounds_on_white") as BitmapDataAsset) != null && _loc4_.content != null)
         {
            _soundsOnIconWhite = (_loc4_.content as BitmapData).clone();
         }
         var_2781 = new MeMenuSoundSettingsItem(this,0,uiVolumeContainer);
         var_2761 = new MeMenuSoundSettingsItem(this,1,furniVolumeContainer);
         var_2862 = new MeMenuSoundSettingsItem(this,2,traxVolumeContainer);
         var_1629.messageListener.processWidgetMessage(new RoomWidgetGetSettingsMessage("RWGSM_GET_SETTINGS"));
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:IWindow = param1.target as IWindow;
         var _loc3_:String = _loc2_.name;
         var _loc4_:* = _loc3_;
         if("back_btn" !== _loc4_)
         {
            class_14.log("Me Menu Settings View: unknown button: " + _loc3_);
         }
         else
         {
            var_1629.changeView("me_menu_settings_view");
         }
      }
      
      public function saveVolume(param1:Number, param2:Number, param3:Number, param4:Boolean = true) : void
      {
         var _loc5_:RoomWidgetStoreSettingsMessage = null;
         if(param4)
         {
            _loc5_ = new RoomWidgetStoreSettingsMessage("RWSSM_STORE_SOUND");
         }
         else
         {
            _loc5_ = new RoomWidgetStoreSettingsMessage("RWSSM_PREVIEW_SOUND");
         }
         _loc5_.genericVolume = param1 != -1 ? param1 : _genericVolume;
         _loc5_.furniVolume = param2 != -1 ? param2 : _furniVolume;
         _loc5_.traxVolume = param3 != -1 ? param3 : _traxVolume;
         var_1629.messageListener.processWidgetMessage(_loc5_);
      }
      
      public function updateUnseenItemCount(param1:String, param2:int) : void
      {
      }
      
      public function get uiVolumeContainer() : IWindowContainer
      {
         return _window.findChildByName("ui_volume_container") as IWindowContainer;
      }
      
      public function get furniVolumeContainer() : IWindowContainer
      {
         return _window.findChildByName("furni_volume_container") as IWindowContainer;
      }
      
      public function get traxVolumeContainer() : IWindowContainer
      {
         return _window.findChildByName("trax_volume_container") as IWindowContainer;
      }
      
      public function get widget() : MeMenuWidget
      {
         return var_1629;
      }
      
      public function get soundsOffIconColor() : BitmapData
      {
         return _soundsOffIconColor;
      }
      
      public function get soundsOffIconWhite() : BitmapData
      {
         return _soundsOffIconWhite;
      }
      
      public function get soundsOnIconColor() : BitmapData
      {
         return _soundsOnIconColor;
      }
      
      public function get soundsOnIconWhite() : BitmapData
      {
         return _soundsOnIconWhite;
      }
   }
}
