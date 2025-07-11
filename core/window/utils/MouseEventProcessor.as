package com.sulake.core.window.utils
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IInputEventTracker;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IInteractiveWindow;
   import com.sulake.core.window.components.RegionController;
   import com.sulake.core.window.components.class_3460;
   import com.sulake.core.window.enum.*;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.graphics.class_3354;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MouseEventProcessor implements IEventProcessor, IDisposable
   {
      
      protected static var var_2206:Array;
      
      protected static var var_2091:Array;
      
      protected static var GLOBAL_POINT:Point = new Point();
       
      
      protected var var_2613:Point;
      
      protected var var_1771:WindowController;
      
      protected var var_1889:WindowController;
      
      protected var var_2354:WindowController;
      
      protected var var_1739:WindowController;
      
      protected var var_1836:class_3354;
      
      protected var var_1750:class_3460;
      
      protected var _eventTrackers:Vector.<IInputEventTracker>;
      
      private var _disposed:Boolean = false;
      
      public function MouseEventProcessor()
      {
         super();
         var_2613 = new Point();
         if(var_2206 == null)
         {
            var_2206 = [];
            var_2206[0] = 2;
            var_2206[1] = 0;
            var_2206[2] = 2;
            var_2206[3] = 2;
            var_2206[4] = 2;
            var_2206[5] = 0;
            var_2206[6] = 2;
         }
         if(var_2091 == null)
         {
            var_2091 = [];
            var_2091[0] = 1;
            var_2091[1] = 2;
            var_2091[2] = 4;
            var_2091[3] = 64;
            var_2091[4] = 8;
            var_2091[5] = 16;
            var_2091[6] = 32;
         }
      }
      
      public static function setMouseCursorByState(param1:uint, param2:uint) : void
      {
         var _loc3_:int = var_2091.indexOf(param1);
         if(_loc3_ > -1)
         {
            var_2206[_loc3_] = param2;
         }
      }
      
      public static function getMouseCursorByState(param1:uint) : uint
      {
         var _loc2_:uint = var_2091.length;
         while(_loc2_-- > 0)
         {
            if((param1 & var_2091[_loc2_]) > 0)
            {
               return var_2206[_loc2_];
            }
         }
         return 0;
      }
      
      protected static function convertMouseEventType(param1:MouseEvent, param2:IWindow, param3:IWindow, param4:String = null) : WindowMouseEvent
      {
         var _loc6_:String = null;
         var _loc7_:Boolean = false;
         var _loc8_:Point = new Point(param1.stageX,param1.stageY);
         param2.convertPointFromGlobalToLocalSpace(_loc8_);
         var _loc5_:String;
         switch(_loc5_ = param4 == null ? param1.type : param4)
         {
            case "mouseMove":
               _loc6_ = "WME_MOVE";
               break;
            case "mouseOver":
               _loc6_ = "WME_OVER";
               break;
            case "mouseOut":
               _loc6_ = "WME_OUT";
               break;
            case "rollOut":
               _loc6_ = "WME_ROLL_OUT";
               break;
            case "rollOver":
               _loc6_ = "WME_ROLL_OVER";
               break;
            case "click":
               _loc6_ = "WME_CLICK";
               break;
            case "doubleClick":
               _loc6_ = "WME_DOUBLE_CLICK";
               break;
            case "mouseDown":
               _loc6_ = "WME_DOWN";
               break;
            case "mouseUp":
               _loc6_ = (_loc7_ = _loc8_.x > -1 && _loc8_.y > -1 && _loc8_.x < param2.width && _loc8_.y < param2.height) ? "WME_UP" : "WME_UP_OUTSIDE";
               break;
            case "mouseWheel":
               _loc6_ = "WME_WHEEL";
               break;
            default:
               _loc6_ = "";
         }
         return WindowMouseEvent.allocate(_loc6_,param2,param3,_loc8_.x,_loc8_.y,param1.stageX,param1.stageY,param1.altKey,param1.ctrlKey,param1.shiftKey,param1.buttonDown,param1.delta);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _disposed = true;
         }
      }
      
      public function process(param1:EventProcessorState, param2:IEventQueue) : void
      {
         var _loc7_:int = 0;
         var _loc11_:WindowController = null;
         var _loc4_:Array = null;
         var _loc10_:MouseEvent = null;
         var _loc8_:WindowEvent = null;
         var _loc9_:IWindow = null;
         var _loc5_:WindowMouseEvent = null;
         var _loc3_:IWindow = null;
         var _loc6_:IInteractiveWindow = null;
         if(param2.length == 0)
         {
            return;
         }
         var_1750 = param1.desktop;
         var_1739 = param1.var_3892 as WindowController;
         var_1771 = param1.lastClickTarget as WindowController;
         var_1889 = param1.lastMouseDownTarget as WindowController;
         var_2354 = param1.var_4720 as WindowController;
         var_1836 = param1.renderer;
         _eventTrackers = param1.eventTrackers;
         param2.begin();
         var_2613.x = -1;
         var_2613.y = -1;
         var _loc12_:int = 0;
         while((_loc10_ = param2.next() as MouseEvent) != null)
         {
            if(_loc10_.stageX != var_2613.x || _loc10_.stageY != var_2613.y)
            {
               var_2613.x = _loc10_.stageX;
               var_2613.y = _loc10_.stageY;
               _loc4_ = [];
               var_1750.groupParameterFilteredChildrenUnderPoint(var_2613,_loc4_,1);
            }
            if((_loc7_ = int(_loc4_ != null ? _loc4_.length : 0)) == 0)
            {
               switch(_loc10_.type)
               {
                  case "mouseMove":
                     if(var_1739 != var_1750 && !var_1739.disposed)
                     {
                        var_1739.getGlobalPosition(GLOBAL_POINT);
                        _loc8_ = WindowMouseEvent.allocate("WME_OUT",var_1739,null,_loc10_.stageX - GLOBAL_POINT.x,_loc10_.stageY - GLOBAL_POINT.y,_loc10_.stageX,_loc10_.stageY,_loc10_.altKey,_loc10_.ctrlKey,_loc10_.shiftKey,_loc10_.buttonDown,_loc10_.delta);
                        var_1739.update(var_1739,_loc8_);
                        var_1739 = WindowController(var_1750);
                        _loc8_.recycle();
                     }
                     break;
                  case "mouseDown":
                     if(_loc9_ = var_1750.getActiveWindow())
                     {
                        _loc9_.deactivate();
                     }
               }
            }
            if(_loc10_.type == "mouseUp" && var_1889 != null && _loc4_.indexOf(var_1889) == -1)
            {
               if(_loc4_ == null)
               {
                  _loc4_ = [];
               }
               _loc4_.push(var_1889);
               _loc7_++;
            }
            while(true)
            {
               _loc7_--;
               if(_loc7_ <= -1)
               {
                  break;
               }
               if((_loc11_ = passMouseEvent(WindowController(_loc4_[_loc7_]),_loc10_)) != null && _loc11_.visible)
               {
                  if(_loc10_.type == "mouseMove")
                  {
                     if(_loc11_ != var_1739)
                     {
                        if(!var_1739.disposed)
                        {
                           var_1739.getGlobalPosition(GLOBAL_POINT);
                           _loc8_ = WindowMouseEvent.allocate("WME_OUT",var_1739,_loc11_,_loc10_.stageX - GLOBAL_POINT.x,_loc10_.stageY - GLOBAL_POINT.y,_loc10_.stageX,_loc10_.stageY,_loc10_.altKey,_loc10_.ctrlKey,_loc10_.shiftKey,_loc10_.buttonDown,_loc10_.delta);
                           var_1739.update(var_1739,_loc8_);
                           _loc8_.recycle();
                        }
                        if(!_loc11_.disposed)
                        {
                           _loc11_.getGlobalPosition(GLOBAL_POINT);
                           _loc8_ = WindowMouseEvent.allocate("WME_OVER",_loc11_,null,_loc10_.stageX - GLOBAL_POINT.x,_loc10_.stageY - GLOBAL_POINT.y,_loc10_.stageX,_loc10_.stageY,_loc10_.altKey,_loc10_.ctrlKey,_loc10_.shiftKey,_loc10_.buttonDown,_loc10_.delta);
                           _loc11_.update(_loc11_,_loc8_);
                           _loc8_.recycle();
                        }
                        if(!_loc11_.disposed)
                        {
                           var_1739 = _loc11_;
                        }
                     }
                  }
                  if(_loc10_.type == "mouseDown")
                  {
                     if(var_2354 != null && !var_2354.disposed && _loc11_ != var_2354)
                     {
                        _loc5_ = WindowMouseEvent.allocate("WME_CLICK_AWAY",var_2354,_loc11_,NaN,NaN,_loc10_.stageX,_loc10_.stageY,_loc10_.altKey,_loc10_.ctrlKey,_loc10_.shiftKey,_loc10_.buttonDown,_loc10_.delta);
                        var_2354.update(var_2354,_loc5_);
                        _loc5_.recycle();
                     }
                     var_2354 = _loc11_;
                  }
                  _loc3_ = _loc11_.parent;
                  while(_loc3_ && !_loc3_.disposed)
                  {
                     if(_loc3_ is IInputProcessorRoot)
                     {
                        _loc8_ = convertMouseEventType(_loc10_,_loc3_,_loc11_);
                        IInputProcessorRoot(_loc3_).process(_loc8_);
                        _loc8_.recycle();
                        break;
                     }
                     _loc3_ = _loc3_.parent;
                  }
                  if(var_1739 is IInteractiveWindow)
                  {
                     try
                     {
                        if((_loc6_ = IInteractiveWindow(var_1739)).interactiveCursorDisabled)
                        {
                           _loc12_ = 0;
                        }
                        else if((_loc12_ = int(_loc6_.getMouseCursorByState(var_1739.state))) == 0)
                        {
                           _loc12_ = int(getMouseCursorByState(var_1739.state));
                        }
                     }
                     catch(e:Error)
                     {
                        _loc12_ = 0;
                     }
                  }
                  if(_loc11_ != var_1750)
                  {
                     _loc10_.stopPropagation();
                     param2.remove();
                  }
                  break;
               }
            }
         }
         param2.end();
         MouseCursorControl.type = _loc12_;
         param1.desktop = var_1750;
         param1.var_3892 = var_1739;
         param1.lastClickTarget = var_1771;
         param1.lastMouseDownTarget = var_1889;
         param1.var_4720 = var_2354;
         param1.renderer = var_1836;
         param1.eventTrackers = _eventTrackers;
      }
      
      private function passMouseEvent(param1:WindowController, param2:MouseEvent, param3:Boolean = false) : WindowController
      {
         var _loc9_:BitmapData = null;
         var _loc6_:WindowMouseEvent = null;
         if(param1.disposed)
         {
            return null;
         }
         if(param1.testStateFlag(32) && param2.type == "mouseMove" && param1 is RegionController)
         {
            return param1;
         }
         if(param1.testStateFlag(32))
         {
            return null;
         }
         var _loc7_:* = false;
         var _loc12_:Point = new Point(param2.stageX,param2.stageY);
         param1.convertPointFromGlobalToLocalSpace(_loc12_);
         if(param2.type == "mouseUp")
         {
            if(var_1889 == null)
            {
               var_1771 = null;
               return null;
            }
            if(param1 != var_1889)
            {
               if(var_1889 && !var_1889.disposed)
               {
                  var_1889.update(var_1889,convertMouseEventType(new MouseEvent("mouseUp",false,true,param2.localX,param2.localY,null,param2.ctrlKey,param2.altKey,param2.shiftKey,param2.buttonDown,param2.delta),var_1889,param1));
                  var_1771 = null;
                  if(param1.disposed)
                  {
                     return null;
                  }
               }
            }
            else
            {
               _loc7_ = !param1.hitTestLocalPoint(_loc12_);
            }
            var_1889 = null;
         }
         if(!_loc7_)
         {
            if(param1.ignoreMouseEvents)
            {
               return null;
            }
            _loc9_ = var_1836.getDrawBufferForRenderable(param1);
            if(!param1.validateLocalPointIntersection(_loc12_,_loc9_))
            {
               return null;
            }
         }
         if(param1.testParamFlag(3))
         {
            if(param1.parent != null)
            {
               return passMouseEvent(WindowController(param1.parent),param2);
            }
         }
         if(!param3)
         {
            switch(param2.type)
            {
               case "mouseDown":
                  var_1771 = param1;
                  var_1889 = param1;
                  break;
               case "click":
                  if(var_1771 != param1)
                  {
                     var_1771 = null;
                     return null;
                  }
                  var_1771 = null;
                  break;
               case "doubleClick":
                  if(var_1771 != param1)
                  {
                     var_1771 = null;
                     return null;
                  }
                  var_1771 = null;
                  break;
            }
         }
         var _loc5_:IWindow = null;
         var _loc11_:Array = [];
         if(param2.type == "doubleClick")
         {
            _loc11_.push("click");
         }
         _loc11_.push(param2.type);
         var _loc4_:Boolean = false;
         for each(var _loc10_ in _loc11_)
         {
            _loc6_ = convertMouseEventType(param2,param1,_loc5_,_loc10_);
            if(param1.update(param1,_loc6_))
            {
               _loc4_ = true;
            }
            for each(var _loc8_ in _eventTrackers)
            {
               _loc8_.eventReceived(_loc6_,param1);
            }
            _loc6_.recycle();
         }
         if(!_loc4_ && !param3)
         {
            if(param1.parent)
            {
               return passMouseEvent(WindowController(param1.parent),param2);
            }
         }
         return param1;
      }
   }
}
