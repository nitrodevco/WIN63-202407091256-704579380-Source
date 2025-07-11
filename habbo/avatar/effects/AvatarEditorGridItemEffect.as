package com.sulake.habbo.avatar.effects
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.class_3600;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public class AvatarEditorGridItemEffect
   {
       
      
      private var _window:IWindowContainer;
      
      private var var_2348:IWindow;
      
      private var var_3588:Boolean = false;
      
      private var var_4139:class_3600;
      
      public function AvatarEditorGridItemEffect(param1:class_3600, param2:IHabboWindowManager, param3:IAssetLibrary)
      {
         super();
         _window = IWindowContainer(param2.buildFromXML(param3.getAssetByName("avatar_editor_effect_griditem_xml").content as XML));
         var_2348 = _window.findChildByTag("BG_COLOR");
         var_4139 = param1;
         if(param1 != null)
         {
            bitmap = param1.icon;
            amount = param1.amountInInventory;
            if(param1.isPermanent)
            {
               setSecondsLeft(param1.duration,param1.duration);
            }
            else if(param1.isActive)
            {
               setSecondsLeft(param1.secondsLeft,param1.duration);
            }
         }
         else
         {
            bitmap = BitmapData(param2.assets.getAssetByName("avatar_editor_generic_remove_selection").content);
            amount = 1;
         }
         selected = false;
         _window.addEventListener("WME_OVER",onMouseOver);
         _window.addEventListener("WME_OUT",onMousetOut);
      }
      
      public function get effectType() : int
      {
         return var_4139 != null ? var_4139.type : -1;
      }
      
      private function onMousetOut(param1:WindowMouseEvent) : void
      {
         if(!var_3588)
         {
            var_2348.visible = false;
         }
         var_2348.blend = 1;
      }
      
      private function onMouseOver(param1:WindowMouseEvent) : void
      {
         if(!var_3588)
         {
            var_2348.visible = true;
            var_2348.blend = 0.5;
         }
      }
      
      public function get window() : IWindow
      {
         return _window;
      }
      
      public function set selected(param1:Boolean) : void
      {
         var_3588 = param1;
         var_2348.visible = var_3588;
         var_2348.blend = 1;
      }
      
      private function set bitmap(param1:BitmapData) : void
      {
         IBitmapWrapperWindow(_window.findChildByName("bitmap")).bitmap = param1;
      }
      
      private function set amount(param1:int) : void
      {
         var _loc2_:IWindowContainer = IWindowContainer(_window.findChildByName("effect_amount_bg1"));
         var _loc3_:ITextWindow = ITextWindow(_window.findChildByName("effect_amount"));
         _loc2_.visible = param1 > 1;
         _loc3_.text = param1.toString();
      }
      
      private function setSecondsLeft(param1:int, param2:int) : void
      {
         _window.findChildByName("duration_container").visible = true;
         var _loc5_:IBitmapWrapperWindow = IBitmapWrapperWindow(_window.findChildByName("progress_bar"));
         var _loc3_:BitmapData = new BitmapData(_loc5_.width,_loc5_.height,false,0);
         var _loc4_:Rectangle = new Rectangle(0,0,int(_loc3_.width * (param1 / param2)),_loc3_.height);
         _loc3_.fillRect(_loc4_,2146080);
         _loc5_.bitmap = _loc3_;
      }
   }
}
