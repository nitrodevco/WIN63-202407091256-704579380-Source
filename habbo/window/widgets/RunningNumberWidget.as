package com.sulake.habbo.window.widgets
{
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   
   public class RunningNumberWidget implements IRunningNumberWidget, IUpdateReceiver
   {
      
      public static const TYPE:String = "running_number";
      
      private static const NUMBER_KEY:String = "running_number:number";
      
      private static const const_1072:String = "running_number:digits";
      
      private static const COLOR_STYLE_KEY:String = "running_number:color_style";
      
      private static const const_912:String = "running_number:update_frequency";
      
      private static const NUMBER_DEFAULT:PropertyStruct = new PropertyStruct("running_number:number",0,"int");
      
      private static const DIGITS_DEFAULT:PropertyStruct = new PropertyStruct("running_number:digits",8,"uint");
      
      private static const COLOR_STYLE_DEFAULT:PropertyStruct = new PropertyStruct("running_number:color_style",0,"int");
      
      private static const UPDATE_FREQUENCY_DEFAULT:PropertyStruct = new PropertyStruct("running_number:update_frequency",50,"int");
       
      
      private var _disposed:Boolean;
      
      private var var_1759:IWidgetWindow;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_509:IWindowContainer;
      
      private var var_3606:int;
      
      private var var_3546:uint;
      
      private var var_2743:int;
      
      private var _newNumber:int;
      
      private var _displayedNumber:Number = 0;
      
      private var _millisSinceLastUpdate:uint = 0;
      
      public function RunningNumberWidget(param1:IWidgetWindow, param2:HabboWindowManagerComponent)
      {
         var_3606 = int(COLOR_STYLE_DEFAULT.value);
         var_3546 = uint(DIGITS_DEFAULT.value);
         var_2743 = int(UPDATE_FREQUENCY_DEFAULT.value);
         _newNumber = int(NUMBER_DEFAULT.value);
         super();
         var_1759 = param1;
         _windowManager = param2;
         var_509 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("running_number_xml").content as XML) as IWindowContainer;
         _windowManager.registerUpdateReceiver(this,var_2743);
         var_1759.setParamFlag(147456);
         var_1759.rootWindow = var_509;
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
      
      public function get properties() : Array
      {
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(NUMBER_DEFAULT.withValue(colorStyle));
         _loc1_.push(COLOR_STYLE_DEFAULT.withValue(colorStyle));
         _loc1_.push(DIGITS_DEFAULT.withValue(digits));
         _loc1_.push(UPDATE_FREQUENCY_DEFAULT.withValue(updateFrequency));
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
               case "running_number:number":
                  number = int(_loc2_.value);
                  break;
               case "running_number:digits":
                  digits = uint(_loc2_.value);
                  break;
               case "running_number:color_style":
                  colorStyle = int(_loc2_.value);
                  break;
               case "running_number:update_frequency":
                  updateFrequency = int(_loc2_.value);
                  break;
            }
         }
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
      
      public function update(param1:uint) : void
      {
         if(_displayedNumber < number)
         {
            _millisSinceLastUpdate += param1;
            if(_millisSinceLastUpdate > var_2743)
            {
               _displayedNumber = Math.min(_newNumber,_displayedNumber + _millisSinceLastUpdate / var_2743);
               _millisSinceLastUpdate -= var_2743;
            }
            fieldValue = _displayedNumber;
         }
      }
      
      private function set fieldValue(param1:uint) : void
      {
         var _loc3_:String = param1.toString();
         while(_loc3_.length < var_3546)
         {
            _loc3_ = "0" + _loc3_;
         }
         var _loc2_:ITextWindow = ITextWindow(var_509.findChildByName("number_field"));
         _loc2_.text = _loc3_;
         _loc2_.invalidate();
      }
      
      public function get digits() : uint
      {
         return var_3546;
      }
      
      public function set digits(param1:uint) : void
      {
         var_3546 = param1;
      }
      
      public function get colorStyle() : int
      {
         return var_3606;
      }
      
      public function set colorStyle(param1:int) : void
      {
         var_3606 = param1;
      }
      
      public function get updateFrequency() : int
      {
         return var_2743;
      }
      
      public function set updateFrequency(param1:int) : void
      {
         var_2743 = param1;
      }
      
      public function get number() : int
      {
         return _newNumber;
      }
      
      public function set number(param1:int) : void
      {
         _newNumber = param1;
      }
      
      public function set initialNumber(param1:int) : void
      {
         _displayedNumber = param1;
         _newNumber = param1;
         fieldValue = _displayedNumber;
      }
   }
}
