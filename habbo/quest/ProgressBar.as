package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import flash.geom.Point;
   
   public class ProgressBar implements IDisposable
   {
      
      private static const PROGRESS_TEXT_X_OFFSET:int = 3;
      
      private static const CONTAINER_SPACING:int = 10;
       
      
      private var _questEngine:HabboQuestEngine;
      
      private var _window:IWindowContainer;
      
      private var _progressBarWidth:int;
      
      private var _progressKey:String;
      
      private var _hasFrame:Boolean;
      
      private var _currentAmount:int;
      
      private var _maxAmount:int;
      
      private var var_532:int;
      
      private var var_4752:int;
      
      private var _startProgressWidth:int;
      
      private var _currentProgressWidth:int;
      
      private var var_3522:Boolean;
      
      public function ProgressBar(param1:HabboQuestEngine, param2:IWindowContainer, param3:int, param4:String, param5:Boolean, param6:Point)
      {
         super();
         _questEngine = param1;
         _window = param2;
         _progressBarWidth = param3;
         _progressKey = param4;
         _hasFrame = param5;
         var _loc7_:IWindowContainer;
         if((_loc7_ = IWindowContainer(_window.findChildByName("progress_bar_cont"))) == null)
         {
            _loc7_ = IWindowContainer(_questEngine.getXmlWindow("ProgressBar"));
            _window.addChild(_loc7_);
            _loc7_.x = param6.x;
            _loc7_.y = param6.y;
            _loc7_.width = _progressBarWidth + 10;
         }
      }
      
      public function refresh(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:Boolean = param3 != var_4752 || param2 != _maxAmount;
         _maxAmount = param2;
         _currentAmount = param1;
         _startProgressWidth = _currentProgressWidth;
         var_4752 = param3;
         var_532 = param4;
         if(_loc5_)
         {
            _currentProgressWidth = getProgressWidth(_currentAmount);
         }
         var_3522 = true;
         updateView();
      }
      
      public function set visible(param1:Boolean) : void
      {
         var _loc2_:IWindowContainer = IWindowContainer(_window.findChildByName("progress_bar_cont"));
         if(_loc2_ != null)
         {
            _loc2_.visible = param1;
         }
      }
      
      public function updateView(param1:uint = 0) : void
      {
         var _loc4_:Number = NaN;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         if(!var_3522)
         {
            return;
         }
         var _loc12_:IWindow = _window.findChildByName("bar_a_bkg");
         var _loc14_:IWindow = _window.findChildByName("bar_a_c");
         var _loc13_:IWindow = _window.findChildByName("bar_a_r");
         var _loc6_:IWindow = _window.findChildByName("bar_l");
         var _loc2_:IWindow = _window.findChildByName("bar_c");
         var _loc3_:IWindow = _window.findChildByName("bar_r");
         _loc6_.visible = _hasFrame;
         _loc2_.visible = _hasFrame;
         _loc3_.visible = _hasFrame;
         if(_hasFrame)
         {
            _loc2_.width = _progressBarWidth;
            _loc3_.x = _progressBarWidth + _loc14_.x;
         }
         var _loc9_:int = getProgressWidth(_currentAmount);
         if(_currentProgressWidth != _loc9_)
         {
            _loc4_ = param1 / 32;
            _loc7_ = _loc9_ - _currentProgressWidth;
            _loc5_ = Math.max(1,_loc4_ * Math.round(Math.sqrt(Math.abs(_loc7_))));
            if(_currentProgressWidth < _loc9_)
            {
               _currentProgressWidth = Math.min(_loc9_,_currentProgressWidth + _loc5_);
            }
            else
            {
               _currentProgressWidth = Math.max(_loc9_,_currentProgressWidth - _loc5_);
            }
         }
         var _loc8_:* = _currentProgressWidth >= 0;
         _loc12_.visible = _loc8_;
         _loc14_.visible = _loc8_;
         _loc13_.visible = _loc8_;
         if(_loc8_)
         {
            _loc14_.blend = 1 - (_loc9_ - _currentProgressWidth) / (_loc9_ - _startProgressWidth);
            _loc14_.width = _currentProgressWidth;
            _loc13_.x = _currentProgressWidth + _loc14_.x;
            _loc12_.width = _loc13_.right - _loc14_.left;
         }
         var_3522 = _currentProgressWidth != _loc9_;
         var _loc11_:IWindow = _window.findChildByName("progress_txt");
         var _loc10_:int = int(var_3522 ? Math.round(_currentProgressWidth / _progressBarWidth * _maxAmount) : _currentAmount);
         _questEngine.localization.registerParameter(_progressKey,"progress","" + (_loc10_ + var_532));
         _questEngine.localization.registerParameter(_progressKey,"limit","" + (_maxAmount + var_532));
         _loc11_.caption = _questEngine.localization.getLocalization(_progressKey,_progressKey);
         _loc11_.x = 3 + _loc14_.x + (_progressBarWidth - _loc11_.width) / 2;
      }
      
      public function dispose() : void
      {
         _questEngine = null;
         _window = null;
      }
      
      public function get disposed() : Boolean
      {
         return _questEngine == null;
      }
      
      private function getProgressWidth(param1:int) : int
      {
         return Math.max(0,Math.round(_progressBarWidth * param1 / _maxAmount));
      }
   }
}
