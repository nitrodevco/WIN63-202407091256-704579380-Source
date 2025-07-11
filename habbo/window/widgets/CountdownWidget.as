package com.sulake.habbo.window.widgets
{
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import flash.utils.getTimer;
   
   public class CountdownWidget implements class_3570, IUpdateReceiver
   {
      
      public static const TYPE:String = "countdown";
      
      private static const RUNNING_KEY:String = "countdown:running";
      
      private static const const_1072:String = "countdown:digits";
      
      private static const const_662:String = "countdown:seconds";
      
      private static const COLOR_STYLE_KEY:String = "countdown:color_style";
      
      private static const RUNNING_DEFAULT:PropertyStruct = new PropertyStruct("countdown:running",false,"Boolean");
      
      private static const DIGITS_DEFAULT:PropertyStruct = new PropertyStruct("countdown:digits",3,"uint");
      
      private static const SECONDS_DEFAULT:PropertyStruct = new PropertyStruct("countdown:seconds",0,"int");
      
      private static const COLOR_STYLE_DEFAULT:PropertyStruct = new PropertyStruct("countdown:color_style",0,"int");
      
      private static const UNIT_KEY_PREFIX:String = "countdown_clock_unit_";
      
      private static const const_446:Array = ["weeks","days","hours","minutes","seconds"];
      
      private static const const_425:Array = [604800,86400,3600,60,1];
      
      private static const UNIT_MAX_VALUES:Array = [100,7,24,60,60];
      
      private static const COLOR_STYLES_VALUES:Array = [0,16777215];
      
      private static const COLOR_STYLES_ETCHING_VALUES:Array = [3003121663,0];
       
      
      private var _disposed:Boolean;
      
      private var var_1759:IWidgetWindow;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_509:IItemListWindow;
      
      private var var_3137:IWindowContainer;
      
      private var var_3044:ITextWindow;
      
      private var var_92:Boolean;
      
      private var _startSeconds:int;
      
      private var _startTime:int;
      
      private var var_3606:int;
      
      private var _displayedTime:int = -1;
      
      public function CountdownWidget(param1:IWidgetWindow, param2:HabboWindowManagerComponent)
      {
         var_92 = Boolean(RUNNING_DEFAULT.value);
         _startSeconds = int(SECONDS_DEFAULT.value);
         _startTime = getTimer();
         var_3606 = int(COLOR_STYLE_DEFAULT.value);
         super();
         var_1759 = param1;
         _windowManager = param2;
         var_509 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("clock_base_xml").content as XML) as IItemListWindow;
         var_3137 = var_509.getListItemByName("counter") as IWindowContainer;
         var_3044 = var_509.getListItemByName("separator") as ITextWindow;
         digits = uint(DIGITS_DEFAULT.value);
         _windowManager.registerUpdateReceiver(this,10);
         var_1759.setParamFlag(147456);
         var_1759.rootWindow = var_509;
      }
      
      private static function getMaxUnitIndex(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < const_425.length - param1)
         {
            if(param2 >= uint(const_425[_loc3_]))
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return _loc3_;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_509 != null)
            {
               var_509.dispose();
               var_509 = null;
            }
            if(var_3137 != null)
            {
               var_3137.dispose();
               var_3137 = null;
            }
            if(var_3044 != null)
            {
               var_3044.dispose();
               var_3044 = null;
            }
            if(var_1759 != null)
            {
               var_1759.rootWindow = null;
               var_1759 = null;
            }
            _windowManager.removeUpdateReceiver(this);
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
      
      public function update(param1:uint) : void
      {
         updateTime();
      }
      
      public function get properties() : Array
      {
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(RUNNING_DEFAULT.withValue(var_92));
         _loc1_.push(DIGITS_DEFAULT.withValue(digits));
         _loc1_.push(SECONDS_DEFAULT.withValue(seconds));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         if(_disposed)
         {
            return;
         }
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "countdown:running":
                  running = Boolean(_loc2_.value);
                  break;
               case "countdown:digits":
                  digits = uint(_loc2_.value);
                  break;
               case "countdown:seconds":
                  seconds = int(_loc2_.value);
                  break;
               case "countdown:color_style":
                  colorStyle = int(_loc2_.value);
                  break;
            }
         }
      }
      
      public function get colorStyle() : int
      {
         return var_3606;
      }
      
      public function set colorStyle(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:IWindowContainer = null;
         var _loc5_:ITextWindow = null;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var_3606 = param1;
         var _loc4_:int = var_509.numListItems;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = var_509.getListItemAt(_loc3_) as IWindowContainer;
            if(_loc2_ != null)
            {
               if((_loc5_ = _loc2_.getChildByName("unit") as ITextWindow) != null)
               {
                  _loc6_ = _loc5_.textColor;
                  _loc7_ = _loc5_.etchingColor;
                  if(colorStyle >= 0 && colorStyle < COLOR_STYLES_VALUES.length)
                  {
                     _loc6_ = uint(COLOR_STYLES_VALUES[colorStyle]);
                     _loc7_ = uint(COLOR_STYLES_ETCHING_VALUES[colorStyle]);
                  }
                  _loc5_.textColor = _loc6_;
                  _loc5_.etchingColor = _loc7_;
               }
            }
            _loc3_++;
         }
      }
      
      public function get running() : Boolean
      {
         return var_92;
      }
      
      public function set running(param1:Boolean) : void
      {
         if(var_92 && !param1)
         {
            _startSeconds = seconds;
         }
         if(!var_92 && param1)
         {
            _startTime = getTimer();
         }
         var_92 = param1;
      }
      
      public function get digits() : uint
      {
         return (var_509.numListItems + 1) / 2;
      }
      
      public function set digits(param1:uint) : void
      {
         var _loc2_:int = 0;
         param1 = Math.max(2,Math.min(4,param1));
         if(param1 != digits)
         {
            var_509.removeListItems();
            _loc2_ = 0;
            while(_loc2_ < param1)
            {
               if(_loc2_ != 0)
               {
                  var_509.addListItem(var_3044.clone());
               }
               var_509.addListItem(var_3137.clone());
               _loc2_++;
            }
            updateTime(true);
         }
      }
      
      public function get seconds() : int
      {
         return var_92 ? Math.max(0,_startSeconds - (getTimer() - _startTime) / 1000) : _startSeconds;
      }
      
      public function set seconds(param1:int) : void
      {
         _startSeconds = param1;
         _startTime = getTimer();
         updateTime();
      }
      
      private function updateTime(param1:Boolean = false) : void
      {
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:IWindowContainer = null;
         var _loc7_:int = 0;
         var _loc6_:int;
         if((_loc6_ = seconds) == _displayedTime && !param1)
         {
            return;
         }
         var _loc4_:int = int(digits);
         var _loc2_:int = getMaxUnitIndex(_loc4_,_loc6_);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc8_ = _loc2_ + _loc5_;
            _loc3_ = var_509.getListItemAt(_loc5_ * 2) as IWindowContainer;
            _loc7_ = _loc6_ / const_425[_loc8_] % UNIT_MAX_VALUES[_loc8_];
            _loc3_.getChildByName("value").caption = (_loc7_ < 10 ? "0" : "") + _loc7_.toString();
            _loc3_.getChildByName("unit").caption = "${countdown_clock_unit_" + const_446[_loc8_] + "}";
            _loc5_++;
         }
         _displayedTime = _loc6_;
      }
   }
}
