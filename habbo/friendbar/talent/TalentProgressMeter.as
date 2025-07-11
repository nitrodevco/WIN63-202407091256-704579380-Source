package com.sulake.habbo.friendbar.talent
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.habbo.utils.class_419;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   import com.sulake.habbo.communication.messages.parser.talent.class_1716;
   
   public class TalentProgressMeter implements IDisposable
   {
       
      
      private const ACHIEVED_DIVIDER:String = "talent_achieved_div";
      
      private const UNACHIEVED_DIVIDER:String = "talent_unachieved_div";
      
      private const DIVIDER_WINDOW_PREFIX:String = "progress_divider_level_";
      
      private const AVATAR_GLOW_RADIUS:int = 10;
      
      private var _disposed:Boolean = false;
      
      private var _habboTalent:HabboTalent;
      
      private var var_319:TalentTrackController;
      
      private var _talentTrack:class_1716;
      
      private var var_1917:IWindowContainer;
      
      private var _divider:IStaticBitmapWrapperWindow;
      
      private var var_2009:IWidgetWindow;
      
      private var var_3865:IStaticBitmapWrapperWindow;
      
      private var var_3709:IStaticBitmapWrapperWindow;
      
      public function TalentProgressMeter(param1:HabboTalent, param2:TalentTrackController)
      {
         super();
         _habboTalent = param1;
         var_319 = param2;
         _talentTrack = var_319.talentTrack;
         createMeter();
      }
      
      public function get width() : int
      {
         return var_319.window.width;
      }
      
      public function get progressPerLevelWidth() : int
      {
         return int(Math.floor(class_419.lerp(_talentTrack.progressPerLevel,0,width)));
      }
      
      private function createMeter() : void
      {
         var _loc2_:int = 0;
         var _loc1_:IStaticBitmapWrapperWindow = null;
         var_1917 = IWindowContainer(var_319.window.findChildByName("progress_container"));
         _divider = IStaticBitmapWrapperWindow(var_1917.removeChild(var_1917.findChildByName("progress_level_divider")));
         var_3865 = IStaticBitmapWrapperWindow(var_1917.findChildByName("achieved_mid"));
         var_3709 = IStaticBitmapWrapperWindow(var_1917.findChildByName("unachieved_mid"));
         _loc2_ = 1;
         while(_loc2_ < _talentTrack.levels.length)
         {
            _loc1_ = IStaticBitmapWrapperWindow(_divider.clone());
            _loc1_.name = "progress_divider_level_" + _loc2_;
            var_1917.addChild(_loc1_);
            _loc2_++;
         }
         var_2009 = IWidgetWindow(var_1917.findChildByName("progress_needle"));
         IAvatarImageWidget(var_2009.widget).figure = _habboTalent.sessionManager.figure;
         var_1917.setChildIndex(var_2009,var_1917.numChildren - 1);
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_divider)
            {
               _divider.dispose();
               _divider = null;
            }
            var_3865 = null;
            var_3709 = null;
            var_2009 = null;
            var_1917 = null;
            _talentTrack = null;
            var_319 = null;
            _habboTalent = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function resize() : void
      {
         var _loc5_:int = 0;
         var _loc4_:IStaticBitmapWrapperWindow = null;
         var _loc1_:int = Math.floor(class_419.lerp(_talentTrack.totalProgress,0,width));
         var_1917.width = width;
         var_3709.width = width;
         var_3865.width = _loc1_;
         var_2009.x = class_419.clamp(_loc1_ - int(var_2009.width / 2),0,width - var_2009.width);
         var _loc2_:IWindow = var_1917.findChildByName("avatar_glow");
         _loc2_.x = var_2009.x - 10;
         _loc2_.y = var_2009.y - 10;
         _loc2_.width = var_2009.width + 2 * 10;
         _loc2_.height = var_2009.height + 2 * 10;
         var _loc3_:IWindow = var_1917.findChildByName("progress_balloon");
         _loc3_.x = var_2009.x + Math.floor(var_2009.width / 2) - Math.floor(_loc3_.width / 2) + 5;
         _loc5_ = 1;
         while(_loc5_ < _talentTrack.levels.length)
         {
            (_loc4_ = IStaticBitmapWrapperWindow(var_1917.findChildByName("progress_divider_level_" + _loc5_))).x = _loc5_ * progressPerLevelWidth;
            if(_loc4_.x < _loc1_)
            {
               _loc4_.assetUri = "talent_achieved_div";
            }
            else
            {
               _loc4_.assetUri = "talent_unachieved_div";
            }
            _loc4_.visible = true;
            _loc5_++;
         }
         var_1917.invalidate();
      }
   }
}
