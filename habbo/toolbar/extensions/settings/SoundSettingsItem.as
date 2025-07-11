package com.sulake.habbo.toolbar.extensions.settings
{
    import assets.class_14

    import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.toolbar.memenu.soundsettings.MeMenuSoundSettingsSlider;
   
   public class SoundSettingsItem implements IDisposable
   {
      
      public static const TYPE_UI_VOLUME:int = 0;
      
      public static const TYPE_FURNI_VOLUME:int = 1;
      
      public static const TYPE_TRAX_VOLUME:int = 2;
       
      
      private var var_329:int;
      
      private var _volume:Number;
      
      private var _window:IWindowContainer;
      
      private var var_2973:MeMenuSoundSettingsSlider;
      
      private var var_1977:SoundSettingsView;
      
      public function SoundSettingsItem(param1:SoundSettingsView, param2:int, param3:IWindowContainer)
      {
         var _loc4_:IWindow = null;
         super();
         var_329 = param2;
         var_1977 = param1;
         _window = param3;
         var_2973 = new MeMenuSoundSettingsSlider(this,_window.findChildByName("volume_container") as IWindowContainer,param1.toolbar.assets,0,1);
         if((_loc4_ = _window.findChildByName("sounds_off")) != null)
         {
            _loc4_.addEventListener("WME_CLICK",onButtonClicked);
         }
         if((_loc4_ = _window.findChildByName("sounds_on")) != null)
         {
            _loc4_.addEventListener("WME_CLICK",onButtonClicked);
         }
         updateSoundIcons();
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(var_2973)
            {
               var_2973.dispose();
               var_2973 = null;
            }
            if(_window)
            {
               _window.dispose();
               _window = null;
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_1977 == null;
      }
      
      public function saveVolume(param1:Number, param2:Boolean) : void
      {
         _volume = param1;
         switch(var_329)
         {
            case 0:
               var_1977.saveVolume(param1,-1,-1,param2);
               break;
            case 1:
               var_1977.saveVolume(-1,param1,-1,param2);
               break;
            case 2:
               var_1977.saveVolume(-1,-1,param1,param2);
         }
         updateSoundIcons();
         var_1977.updateSettings();
      }
      
      private function updateSoundIcons() : void
      {
         if(_volume == 0)
         {
            setBitmap("sounds_on_icon","sounds_on_white");
            setBitmap("sounds_off_icon","sounds_off_color");
         }
         else
         {
            setBitmap("sounds_on_icon","sounds_on_color");
            setBitmap("sounds_off_icon","sounds_off_white");
         }
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:IWindow = param1.target as IWindow;
         var _loc3_:String = _loc2_.name;
         switch(_loc3_)
         {
            case "sounds_off":
               saveVolume(0,false);
               break;
            case "sounds_on":
               saveVolume(1,false);
               break;
            default:
               class_14.log("Me Menu Settings, Sound settings item: unknown button: " + _loc3_);
         }
      }
      
      private function setBitmap(param1:String, param2:String) : void
      {
         IStaticBitmapWrapperWindow(_window.findChildByName(param1)).assetUri = "toolbar_memenu_settings_" + param2;
      }
      
      public function setValue(param1:Number) : void
      {
         var_2973.setValue(param1);
         updateSoundIcons();
      }
   }
}
