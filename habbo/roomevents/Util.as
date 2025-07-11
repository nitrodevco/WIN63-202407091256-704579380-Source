package com.sulake.habbo.roomevents
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.components.class_3398;
   import com.sulake.core.window.utils.class_3402;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.class_3556;
   
   public class Util
   {
      
      public static const VARIABLE_SYNTAX_MODE_PRETTIFY:int = 0;
      
      public static const VARIABLE_SYNTAX_MODE_NONE:int = 1;
       
      
      public function Util()
      {
         super();
      }
      
      public static function setProcDirectly(param1:IWindow, param2:Function) : void
      {
         param1.setParamFlag(1,true);
         param1.procedure = param2;
      }
      
      public static function getLowestPoint(param1:IWindowContainer) : int
      {
         var _loc2_:int = 0;
         var _loc4_:IWindow = null;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            if((_loc4_ = param1.getChildAt(_loc2_)).visible && _loc4_.height > 0)
            {
               _loc3_ = Math.max(_loc3_,_loc4_.y + _loc4_.height);
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      public static function hideChildren(param1:IWindowContainer, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:IWindow = null;
         _loc3_ = 0;
         while(_loc3_ < param1.numChildren)
         {
            _loc4_ = param1.getChildAt(_loc3_);
            if(!(param2 && _loc4_.name == "ruler"))
            {
               _loc4_.visible = false;
            }
            _loc3_++;
         }
      }
      
      public static function showChildren(param1:IWindowContainer) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            param1.getChildAt(_loc2_).visible = true;
            _loc2_++;
         }
      }
      
      public static function moveChildrenToColumn(param1:IWindowContainer, param2:Array, param3:int, param4:int) : void
      {
         var _loc6_:IWindow = null;
         for each(var _loc5_ in param2)
         {
            if((_loc6_ = param1.getChildByName(_loc5_)) != null && _loc6_.visible && _loc6_.height > 0)
            {
               _loc6_.y = param3;
               param3 += _loc6_.height + param4;
            }
         }
      }
      
      public static function moveAllChildrenToColumn(param1:IWindowContainer, param2:int, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:IWindow = null;
         _loc4_ = 0;
         while(_loc4_ < param1.numChildren)
         {
            if((_loc5_ = param1.getChildAt(_loc4_)) != null && _loc5_.visible && _loc5_.height > 0)
            {
               _loc5_.y = param2;
               param2 += _loc5_.height + param3;
            }
            _loc4_++;
         }
      }
      
      public static function select(param1:class_3398, param2:Boolean) : void
      {
         if(param2)
         {
            param1.select();
         }
         else
         {
            param1.unselect();
         }
      }
      
      public static function variableDisplayName(param1:WiredVariable, param2:int) : String
      {
         if(param1.availabilityType == class_3556.var_2975 || param2 == 1)
         {
            return param1.variableName;
         }
         var _loc3_:String = param1.variableName.split("_").join(" ").replace("."," -> ");
         return firstLetterUpperCase(_loc3_);
      }
      
      public static function variableValueWithString(param1:WiredVariable, param2:int) : String
      {
         if(!param1.hasValue)
         {
            return null;
         }
         var _loc3_:String = getConnectedText(param1,param2);
         return String(param2) + (_loc3_ == null ? "" : " (" + _loc3_ + ")");
      }
      
      public static function getConnectedText(param1:WiredVariable, param2:int) : String
      {
         var _loc3_:Map = param1.textConnector;
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.getValue(param2);
      }
      
      private static function firstLetterUpperCase(param1:String) : String
      {
         var _loc3_:Array = param1.split(" ");
         var _loc4_:Array = [];
         for(var _loc2_ in _loc3_)
         {
            _loc4_.push(_loc3_[_loc2_].charAt(0).toUpperCase() + _loc3_[_loc2_].slice(1));
         }
         return _loc4_.join(" ");
      }
      
      public static function getIntFromInput(param1:ITextFieldWindow, param2:int, param3:Boolean = false) : int
      {
         return getIntFromString(param1.text,param2,param3);
      }
      
      public static function getIntFromString(param1:String, param2:int, param3:Boolean = false) : int
      {
         if(param3 && param1.indexOf("0b") == 0)
         {
            return parseInt(param1.substr(2),2);
         }
         if(param3 && param1.indexOf("0x") == 0)
         {
            return parseInt(param1.substr(2),16);
         }
         if(isNaN(Number(param1)))
         {
            return param2;
         }
         return int(param1);
      }
      
      public static function pushIntAsLong(param1:Array, param2:int) : void
      {
         param1.push(param2 < 0 ? -1 : 0);
         param1.push(param2);
      }
      
      public static function disableSection(param1:IWindow, param2:Boolean = true) : void
      {
         var _loc3_:IWindowContainer = null;
         var _loc4_:int = 0;
         if(param1.tags.indexOf("DO_NOT_DISABLE") != -1)
         {
            return;
         }
         var _loc5_:Number = param2 ? 0.5 : 1;
         if(!(param1 is class_3357))
         {
            if(param1 is IWindowContainer || param1 is IItemListWindow || param1 is ISelectorWindow)
            {
               if(param1 is class_3402)
               {
                  for each(var _loc6_ in (param1 as class_3402).children)
                  {
                     disableSection(_loc6_,param2);
                  }
               }
               else if(param1 is IWindowContainer)
               {
                  _loc3_ = param1 as IWindowContainer;
                  _loc4_ = 0;
                  while(_loc4_ < _loc3_.numChildren)
                  {
                     disableSection(_loc3_.getChildAt(_loc4_),param2);
                     _loc4_++;
                  }
               }
            }
            else
            {
               param1.blend = _loc5_;
            }
         }
         if(param2)
         {
            param1.disable();
         }
         else
         {
            param1.enable();
         }
      }
      
      private static function variableCompare(param1:WiredVariable, param2:WiredVariable) : int
      {
         var _loc4_:* = param1.availabilityType == class_3556.var_2975;
         var _loc3_:* = param2.availabilityType == class_3556.var_2975;
         if(_loc4_ && !_loc3_)
         {
            return 1;
         }
         if(_loc3_ && !_loc4_)
         {
            return -1;
         }
         if(_loc4_)
         {
            if(param1.variableId > param2.variableId)
            {
               return -1;
            }
            if(param1.variableId == param2.variableId)
            {
               return 0;
            }
            return 1;
         }
         return param1.variableName.localeCompare(param2.variableName);
      }
      
      public static function sortVariables(param1:Array) : void
      {
         param1.sort(variableCompare);
      }
   }
}
