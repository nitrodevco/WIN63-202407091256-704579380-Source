package com.sulake.habbo.game.snowwar.ui
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.IAvatarImageListener;
   import com.sulake.habbo.avatar.class_3374;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.utils.SnowWarAnimatedWindowElement;
   import com.sulake.habbo.game.snowwar.utils.WindowUtils;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.outgoing.game.arena.Game2ExitGameMessageComposer;
   
   public class SnowWarUI implements IDisposable, IAvatarImageListener
   {
      
      private static const EMPTY_AMMO_FLASH_FRAMES:int = 4;
      
      private static const EMPTY_AMMO_FRAME_LENGTH:int = 75;
      
      private static const SCORE_FLASH_FRAMES:int = 4;
      
      private static const SCORE_FRAME_LENGTH:int = 50;
      
      private static const MAX_SNOWBALLS:int = 5;
      
      private static const MAX_ENERGY:int = 5;
       
      
      private var var_1655:SnowWarEngine;
      
      private var var_2634:IWindowContainer;
      
      private var _snowballs:IWindowContainer;
      
      private var var_2070:IWindowContainer;
      
      private var var_1883:IWindowContainer;
      
      private var var_1213:IWindowContainer;
      
      private var var_2162:IWindowContainer;
      
      private var _checksumIndicatorColor:RGBColor;
      
      private var _tweenColor:RGBColor;
      
      private var var_1802:IBitmapWrapperWindow;
      
      private var var_318:Boolean = false;
      
      private var var_1321:int = 1;
      
      private var _timeSinceLastUpdate:uint;
      
      private var var_4850:int = -1;
      
      private var var_3852:int = 5;
      
      private var var_3817:IBitmapWrapperWindow;
      
      private var _makingSnowballs:Boolean = false;
      
      private var var_4621:int = 5;
      
      private var var_3232:IBitmapWrapperWindow;
      
      private var var_2372:SnowWarAnimatedWindowElement;
      
      private var _emptyAmmoFlash:IBitmapWrapperWindow;
      
      private var _emptyAmmoAnimation:SnowWarAnimatedWindowElement;
      
      private var var_3029:IBitmapWrapperWindow;
      
      private var var_2648:int = 0;
      
      private var _scoreBackgroundAsset:String = "";
      
      private var var_2302:Timer;
      
      private var var_3500:Boolean;
      
      public function SnowWarUI(param1:SnowWarEngine)
      {
         super();
         var_1655 = param1;
         var_1655.windowManager.getDesktop(1).visible = false;
         var_3500 = var_1655.sessionDataManager.hasSecurity(4);
         if(var_3500)
         {
            _checksumIndicatorColor = new RGBColor();
            _tweenColor = new RGBColor(16777215);
         }
      }
      
      public function dispose() : void
      {
         var_1655.windowManager.getDesktop(1).visible = true;
         var_1655 = null;
         if(var_2634)
         {
            var_2634.dispose();
            var_2634 = null;
         }
         if(_snowballs)
         {
            var_3817 = null;
            var_3232 = null;
            _emptyAmmoFlash = null;
            _snowballs.dispose();
            _snowballs = null;
         }
         if(var_2070)
         {
            var_3029 = null;
            var_2070.dispose();
            var_2070 = null;
         }
         if(var_1883)
         {
            var_1883.dispose();
            var_1883 = null;
         }
         if(var_1213)
         {
            var_1213.dispose();
            var_1213 = null;
         }
         if(var_1802)
         {
            var_1802.dispose();
            var_1802 = null;
         }
         if(_emptyAmmoAnimation != null)
         {
            _emptyAmmoAnimation.dispose();
            _emptyAmmoAnimation = null;
         }
         if(var_2162)
         {
            var_2162.dispose();
            var_2162 = null;
         }
         if(var_2302)
         {
            var_2302.removeEventListener("timerComplete",onTimerHider);
            var_2302.stop();
            var_2302 = null;
         }
         disposeLoadIcon();
         var_318 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      public function init() : void
      {
         var_2634 = WindowUtils.createWindow("snowwar_exit") as IWindowContainer;
         var_2634.addEventListener("WME_CLICK",onExit);
         var_2634.x = 0;
         var_2634.y = 10;
         _snowballs = WindowUtils.createWindow("snowwar_snowballs") as IWindowContainer;
         var _loc1_:IWindow = _snowballs.findChildByName("make_snowball");
         _loc1_.addEventListener("WME_DOWN",onMakeSnowballDown);
         _loc1_.addEventListener("WME_UP",onMakeSnowballUp);
         _loc1_.addEventListener("WME_OUT",onMakeSnowballUp);
         _snowballs.center();
         _snowballs.x = 10;
         var_3817 = _snowballs.findChildByName("makeSnowballImage") as IBitmapWrapperWindow;
         _emptyAmmoFlash = _snowballs.findChildByName("emptyFlashImage") as IBitmapWrapperWindow;
         _emptyAmmoFlash.visible = false;
         _emptyAmmoAnimation = new SnowWarAnimatedWindowElement(var_1655.assets,_emptyAmmoFlash,"ui_no_balls_",4,75,true);
         var_3232 = _snowballs.findChildByName("ballProgress") as IBitmapWrapperWindow;
         var_2070 = WindowUtils.createWindow("snowwar_own_stats") as IWindowContainer;
         var_2070.x = 10;
         var_2070.y = var_2070.desktop.height - var_2070.height - 10;
         var_3029 = var_2070.findChildByName("backgroundFlashImage") as IBitmapWrapperWindow;
         updateUserImage();
         var_1213 = WindowUtils.createWindow("snowwar_team_scores") as IWindowContainer;
         var_1213.x = var_1213.desktop.width - var_1213.width - 10;
         var_1213.y = 10;
         var_1883 = WindowUtils.createWindow("snowwar_timer") as IWindowContainer;
         var_1883.x = var_1883.desktop.width - var_1883.width - 50;
         var_1883.y = 105;
         timer = 0;
         var_1802 = WindowUtils.createWindow("counter") as IBitmapWrapperWindow;
         var_1802.center();
         if(var_3500)
         {
            var_1883.getChildByName("checksumIndicator").visible = true;
            _checksumIndicatorColor.fromInt(var_1883.color);
         }
         var_3852 = 5;
      }
      
      public function avatarImageReady(param1:String) : void
      {
         updateUserImage();
      }
      
      private function updateUserImage() : void
      {
         var _loc1_:BitmapData = null;
         var _loc3_:String = var_1655.sessionDataManager.figure;
         var _loc2_:String = var_1655.sessionDataManager.gender;
         var _loc4_:class_3374;
         if((_loc4_ = var_1655.avatarManager.createAvatarImage(_loc3_,"h",_loc2_,this)) != null)
         {
            _loc4_.setDirection("full",2);
            _loc1_ = _loc4_.getCroppedImage("head");
            _loc4_.dispose();
            WindowUtils.setElementImage(var_2070.findChildByName("user_image"),_loc1_);
            _loc1_.dispose();
         }
      }
      
      private function getBitmap(param1:String) : BitmapData
      {
         return var_1655.assets.getAssetByName(param1).content as BitmapData;
      }
      
      private function getElement(param1:IWindowContainer, param2:String) : IWindow
      {
         return param1.findChildByName(param2);
      }
      
      private function onMakeSnowballDown(param1:WindowMouseEvent) : void
      {
         makeSnowballButtonPressed(true);
         if(var_1655.makeSnowball())
         {
            startWaitingForSnowball();
         }
      }
      
      private function onMakeSnowballUp(param1:WindowMouseEvent) : void
      {
         makeSnowballButtonPressed(false);
      }
      
      public function startWaitingForSnowball() : void
      {
         if(var_2372 != null)
         {
            var_2372.dispose();
            var_2372 = null;
         }
         var_2372 = new SnowWarAnimatedWindowElement(var_1655.assets,var_3232,"load_",8);
         SnowWarEngine.playSound("HBSTG_snowwar_make_snowball");
      }
      
      public function stopWaitingForSnowball() : void
      {
         disposeLoadIcon();
         SnowWarEngine.stopSound("HBSTG_snowwar_make_snowball");
         if(_makingSnowballs)
         {
            onMakeSnowballDown(null);
         }
      }
      
      private function disposeLoadIcon() : void
      {
         if(var_2372 != null)
         {
            var_2372.dispose();
            var_2372 = null;
         }
      }
      
      private function onExit(param1:WindowMouseEvent) : void
      {
         if(!var_2162)
         {
            var_2162 = WindowUtils.createWindow("snowwar_exit_confirmation") as IWindowContainer;
            var_2162.findChildByName("yes").addEventListener("WME_CLICK",confirmationHandler);
            var_2162.findChildByName("no").addEventListener("WME_CLICK",confirmationHandler);
            var_2162.findChildByTag("close").addEventListener("WME_CLICK",confirmationHandler);
         }
         else
         {
            var_2162.visible = true;
            var_2162.activate();
         }
      }
      
      private function confirmationHandler(param1:WindowMouseEvent) : void
      {
         if(param1.window.name == "yes")
         {
            var_1655.send(new Game2ExitGameMessageComposer());
            var_1655.resetGameSession();
            var_1655.resetRoomSession();
         }
         else
         {
            var_2162.visible = false;
         }
      }
      
      public function set snowballs(param1:int) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _snowballs.findChildByName("ball_" + _loc3_).visible = _loc3_ < param1;
            _loc3_++;
         }
         var_4621 = param1;
         var _loc2_:IWindow = _snowballs.findChildByName("ball_" + param1);
         if(_loc2_ != null)
         {
            var_3232.x = _loc2_.x;
            var_3232.y = _loc2_.y;
         }
      }
      
      public function set ownScore(param1:int) : void
      {
         WindowUtils.setCaption(var_2070.findChildByName("personal_score"),param1.toString());
      }
      
      public function set timer(param1:int) : void
      {
         if(var_3500)
         {
            if(_checksumIndicatorColor)
            {
               _checksumIndicatorColor.tweenTo(_tweenColor);
               var_1883.getChildByName("checksumIndicator").color = _checksumIndicatorColor.rgb;
            }
         }
         if(var_4850 == param1)
         {
            return;
         }
         var_4850 = param1;
         var _loc2_:String = "" + int(param1 / 60);
         var _loc3_:String = "" + int(param1 % 60);
         if(int(_loc2_) < 10)
         {
            _loc2_ = "0" + _loc2_;
         }
         if(int(_loc3_) < 10)
         {
            _loc3_ = "0" + _loc3_;
         }
         WindowUtils.showElement(var_1883,"time_left");
         WindowUtils.setCaption(var_1883.findChildByName("time_left"),_loc2_ + ":" + _loc3_);
         if(param1 <= 5 && param1 > 0)
         {
            SnowWarEngine.playSound("HBST_call_for_help");
            if(!var_2302)
            {
               var_2302 = new Timer(500,1);
               var_2302.addEventListener("timerComplete",onTimerHider);
            }
            var_2302.reset();
            var_2302.start();
         }
      }
      
      private function onTimerHider(param1:TimerEvent) : void
      {
         if(var_1883)
         {
            WindowUtils.hideElement(var_1883,"time_left");
         }
      }
      
      public function set hitPoints(param1:int) : void
      {
         if(var_3852 != param1)
         {
            WindowUtils.setElementImage(getElement(var_2070,"energy_bar"),getBitmap("ui_me_health_" + Math.min(5,param1)));
            var_3852 = param1;
         }
      }
      
      public function showChecksumError(param1:uint) : void
      {
         if(var_3500)
         {
            var_1883.color = param1;
            if(_checksumIndicatorColor)
            {
               _checksumIndicatorColor.fromInt(param1);
            }
         }
      }
      
      public function initCounter() : void
      {
         _timeSinceLastUpdate = 0;
         var_1321 = 1;
      }
      
      public function update(param1:uint) : void
      {
         updateAmmoDisplay();
         updateCounterImage(param1);
         updateScoreFlash(param1);
         updateTeamScores();
      }
      
      private function updateScoreFlash(param1:uint) : void
      {
         var _loc2_:int = 0;
         if(var_2648 > 0)
         {
            _loc2_ = var_2648 / 50 + 1;
            if(_loc2_ > 4)
            {
               var_2648 = 0;
               var_3029.visible = false;
            }
            else
            {
               var_2648 += param1;
               var_3029.visible = true;
               WindowUtils.setElementImage(var_3029,getBitmap(_scoreBackgroundAsset + _loc2_));
            }
         }
      }
      
      public function flashOwnScore(param1:Boolean) : void
      {
         var_2648 = 1;
         _scoreBackgroundAsset = param1 ? "ui_me_plus_" : "ui_me_minus_";
      }
      
      private function updateAmmoDisplay() : void
      {
         _emptyAmmoFlash.visible = var_4621 == 0 && var_2372 == null;
      }
      
      private function updateCounterImage(param1:uint) : void
      {
         var _loc2_:BitmapData = null;
         var _loc3_:Point = null;
         var _loc5_:Boolean = false;
         _timeSinceLastUpdate += param1;
         if(var_1321 < 6)
         {
            if(_timeSinceLastUpdate >= 1000)
            {
               _loc5_ = true;
               _timeSinceLastUpdate = 0;
            }
         }
         else if(var_1321 < 11)
         {
            if(_timeSinceLastUpdate > 100)
            {
               _loc5_ = true;
               _timeSinceLastUpdate = 0;
            }
         }
         else if(var_1802)
         {
            var_1802.dispose();
            var_1802 = null;
         }
         if(!_loc5_ || var_318 || !var_1802)
         {
            return;
         }
         var _loc4_:BitmapDataAsset;
         if(_loc4_ = var_1655.assets.getAssetByName(padName("explosion",var_1321)) as BitmapDataAsset)
         {
            _loc2_ = _loc4_.content as BitmapData;
            if(!var_1802.bitmap)
            {
               var_1802.bitmap = new BitmapData(var_1802.width,var_1802.height,true,16777215);
            }
            var_1802.bitmap.fillRect(var_1802.bitmap.rect,16777215);
            _loc3_ = new Point(-_loc4_.offset.x,-_loc4_.offset.y);
            var_1802.bitmap.copyPixels(_loc2_,_loc2_.rect,_loc3_,null,null,true);
            var_1802.invalidate();
         }
         var_1321++;
      }
      
      private function padName(param1:String, param2:int, param3:int = 4) : String
      {
         var _loc4_:String = param2.toString();
         while(_loc4_.length < param3)
         {
            _loc4_ = "0" + _loc4_;
         }
         return param1 + _loc4_;
      }
      
      private function updateTeamScores() : void
      {
         var _loc1_:Array = var_1655.gameArena.getTeamScores();
         if(_loc1_.length >= 2)
         {
            WindowUtils.setCaption(var_1213.findChildByName("score_blue"),_loc1_[0]);
            WindowUtils.setCaption(var_1213.findChildByName("score_red"),_loc1_[1]);
         }
      }
      
      private function makeSnowballButtonPressed(param1:Boolean) : void
      {
         if(_makingSnowballs != param1)
         {
            WindowUtils.setElementImage(var_3817,getBitmap("ui_make_balls_" + (param1 ? "down" : "up")));
         }
         _makingSnowballs = param1;
      }
   }
}

class RGBColor
{
    
   
   private var _r:uint;
   
   private var _g:uint;
   
   private var _b:uint;
   
   private var _a:uint;
   
   public function RGBColor(param1:uint = 0)
   {
      super();
      fromInt(param1);
   }
   
   public function get r() : uint
   {
      return _r;
   }
   
   public function get g() : uint
   {
      return _g;
   }
   
   public function get b() : uint
   {
      return _b;
   }
   
   public function get a() : uint
   {
      return _a;
   }
   
   public function fromInt(param1:uint) : void
   {
      _a = param1 >> 24 & 255;
      _r = param1 >> 16 & 255;
      _g = param1 >> 8 & 255;
      _b = param1 >> 0 & 255;
   }
   
   public function get rgb() : uint
   {
      return _a << 24 | _r << 16 | _g << 8 | _b;
   }
   
   public function tweenTo(param1:RGBColor) : void
   {
      _a += (param1.a - a) / 24;
      _r += (param1.r - r) / 24;
      _g += (param1.g - g) / 24;
      _b += (param1.b - b) / 24;
   }
}
