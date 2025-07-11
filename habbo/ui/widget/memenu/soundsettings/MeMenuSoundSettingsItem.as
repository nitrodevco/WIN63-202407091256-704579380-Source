package com.sulake.habbo.ui.widget.memenu.soundsettings
{
    import assets.class_14

    import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.display.BitmapData;
   
   public class MeMenuSoundSettingsItem implements IDisposable
   {
      
      public static const TYPE_UI_VOLUME:int = 0;
      
      public static const TYPE_FURNI_VOLUME:int = 1;
      
      public static const TYPE_TRAX_VOLUME:int = 2;
       
      
      private var var_329:int;
      
      private var _volume:Number;
      
      private var _window:IWindowContainer;
      
      private var var_2973:MeMenuSoundSettingsSlider;
      
      private var var_1977:MeMenuSoundSettingsView;
      
      public function MeMenuSoundSettingsItem(param1:MeMenuSoundSettingsView, param2:int, param3:IWindowContainer)
      {
         var _loc4_:IWindow = null;
         super();
         var_329 = param2;
         var_1977 = param1;
         _window = param3;
         var_2973 = new MeMenuSoundSettingsSlider(this,_window.findChildByName("volume_container") as IWindowContainer,var_1977.widget.assets,0,1);
         if((_loc4_ = _window.findChildByName("sounds_off")) != null)
         {
            _loc4_.addEventListener("WME_CLICK",onButtonClicked);
            _loc4_.addEventListener("WME_OVER",onButtonOver);
            _loc4_.addEventListener("WME_OUT",onButtonOut);
         }
         if((_loc4_ = _window.findChildByName("sounds_on")) != null)
         {
            _loc4_.addEventListener("WME_CLICK",onButtonClicked);
            _loc4_.addEventListener("WME_OVER",onButtonOver);
            _loc4_.addEventListener("WME_OUT",onButtonOut);
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
      }
      
      private function updateSoundIcons() : void
      {
         if(_volume == 0)
         {
            setBitmapWrapperContent("sounds_on_icon",var_1977.soundsOnIconWhite);
            setBitmapWrapperContent("sounds_off_icon",var_1977.soundsOffIconColor);
         }
         else
         {
            setBitmapWrapperContent("sounds_on_icon",var_1977.soundsOnIconColor);
            setBitmapWrapperContent("sounds_off_icon",var_1977.soundsOffIconWhite);
         }
      }
      
      private function onButtonOver(param1:WindowMouseEvent) : void
      {
         var _loc2_:IWindow = param1.target as IWindow;
         var _loc3_:String = _loc2_.name;
         switch(_loc3_)
         {
            case "sounds_off_icon":
            case "sounds_off":
               setBitmapWrapperContent("sounds_off_icon",var_1977.soundsOffIconColor);
               break;
            case "sounds_on_icon":
            case "sounds_on":
               setBitmapWrapperContent("sounds_on_icon",var_1977.soundsOnIconColor);
         }
      }
      
      private function onButtonOut(param1:WindowMouseEvent) : void
      {
         var _loc2_:IWindow = param1.target as IWindow;
         var _loc3_:String = _loc2_.name;
         switch(_loc3_)
         {
            case "sounds_off":
               if(_volume != 0)
               {
                  setBitmapWrapperContent("sounds_off_icon",var_1977.soundsOffIconWhite);
               }
               break;
            case "sounds_on":
               if(_volume != 1)
               {
                  setBitmapWrapperContent("sounds_on_icon",var_1977.soundsOnIconWhite);
               }
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
      
      private function setBitmapWrapperContent(param1:String, param2:BitmapData) : void
      {
         var _loc3_:IBitmapWrapperWindow = _window.findChildByName(param1) as IBitmapWrapperWindow;
         if(_loc3_ != null && param2 != null)
         {
            _loc3_.bitmap = param2.clone();
         }
      }
      
      public function setValue(param1:Number) : void
      {
         var_2973.setValue(param1);
         updateSoundIcons();
      }
   }
}
