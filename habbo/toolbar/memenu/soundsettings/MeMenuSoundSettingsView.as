package com.sulake.habbo.toolbar.memenu.soundsettings
{
    import assets.class_14

    import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.toolbar.ToolbarView;
   import com.sulake.habbo.toolbar.memenu.MeMenuController;
   import com.sulake.habbo.toolbar.memenu.MeMenuSettingsMenuView;
   import flash.display.BitmapData;
   
   public class MeMenuSoundSettingsView
   {
       
      
      private var var_1629:MeMenuSettingsMenuView;
      
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
      
      private var var_1733:ToolbarView;
      
      public function MeMenuSoundSettingsView()
      {
         super();
      }
      
      public function init(param1:MeMenuSettingsMenuView, param2:ToolbarView) : void
      {
         var_1733 = param2;
         var_1629 = param1;
         createWindow();
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
      
      public function updateSettings() : void
      {
         _genericVolume = var_1629.widget.toolbar.soundManager.genericVolume;
         _furniVolume = var_1629.widget.toolbar.soundManager.furniVolume;
         _traxVolume = var_1629.widget.toolbar.soundManager.traxVolume;
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
      
      private function createWindow() : void
      {
         var _loc1_:IWindow = null;
         var _loc3_:int = 0;
         var _loc2_:XmlAsset = var_1629.widget.toolbar.assets.getAssetByName("me_menu_sound_settings_xml") as XmlAsset;
         _window = var_1629.widget.toolbar.windowManager.buildFromXML(_loc2_.content as XML) as IWindowContainer;
         _window.x = var_1733.window.width + 10;
         _window.y = var_1733.window.bottom - _window.height;
         _loc3_ = 0;
         while(_loc3_ < _window.numChildren)
         {
            _loc1_ = _window.getChildAt(_loc3_);
            _loc1_.addEventListener("WME_CLICK",onButtonClicked);
            _loc3_++;
         }
         var_2781 = new MeMenuSoundSettingsItem(this,0,uiVolumeContainer);
         var_2761 = new MeMenuSoundSettingsItem(this,1,furniVolumeContainer);
         var_2862 = new MeMenuSoundSettingsItem(this,2,traxVolumeContainer);
         updateSettings();
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:IWindow = param1.target as IWindow;
         var _loc3_:String = _loc2_.name;
         class_14.log(_loc3_);
         var _loc4_:* = _loc3_;
         if("back_btn" !== _loc4_)
         {
            class_14.log("Me Menu Settings View: unknown button: " + _loc3_);
         }
         else
         {
            var_1629.window.visible = true;
            dispose();
         }
      }
      
      public function saveVolume(param1:Number, param2:Number, param3:Number, param4:Boolean = true) : void
      {
         var _loc6_:Number = param2 != -1 ? param2 : _furniVolume;
         var _loc5_:Number = param1 != -1 ? param1 : _genericVolume;
         var _loc7_:Number = param3 != -1 ? param3 : _traxVolume;
         if(param4)
         {
            if(var_1629 == null)
            {
               return;
            }
            var_1629.widget.toolbar.soundManager.furniVolume = _loc6_;
            var_1629.widget.toolbar.soundManager.genericVolume = _loc5_;
            var_1629.widget.toolbar.soundManager.traxVolume = _loc7_;
         }
         else
         {
            var_1629.widget.toolbar.soundManager.previewVolume(_loc5_,_loc6_,_loc7_);
         }
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
      
      public function get widget() : MeMenuController
      {
         return var_1629.widget;
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
