package com.sulake.habbo.roomevents.wired_menu.views.tables
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3437;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class TableCellView implements IDisposable
   {
       
      
      private var _disposed:Boolean = false;
      
      private var var_3173:TableView;
      
      private var var_4757:TableRowView;
      
      private var var_3105:String;
      
      private var var_1723:TableCell;
      
      private var _container:IRegionWindow;
      
      private var _transitionTimer:Timer;
      
      public function TableCellView(param1:TableView, param2:TableRowView, param3:String, param4:TableCell)
      {
         super();
         var_3173 = param1;
         var_4757 = param2;
         var_3105 = param3;
         var_1723 = param4;
         _container = param1.cellTemplate.clone() as IRegionWindow;
         updateWidth();
         initializeView();
         highlightBorder.visible = false;
         _container.addEventListener("WME_DOUBLE_CLICK",onDoubleClick);
         inputElement.addEventListener("WKE_KEY_DOWN",onInputEdit);
         inputElement.addEventListener("WKE_KEY_UP",onInputEdit);
         inputElement.addEventListener("WE_UNFOCUS",onInputFocusOut);
         _container.addEventListener("WME_DOWN",param2.onDown);
         linkRegion.addEventListener("WME_DOWN",param2.onDown);
         _container.addEventListener("WME_CLICK_AWAY",param2.onClickAway);
         inputElement.addEventListener("WME_CLICK_AWAY",param2.onClickAway);
         linkRegion.addEventListener("WME_CLICK_AWAY",param2.onClickAway);
         linkRegion.addEventListener("WME_CLICK",onLinkClick);
         _container.mouseThreshold = 0;
         linkRegion.mouseThreshold = 0;
      }
      
      private static function easeInOutCubic(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc5_:Number;
         var _loc6_:Number = -((_loc5_ = param1 / param4) * 1.75 - 0.7) * (_loc5_ * 1.75 - 0.7) + 1;
         return param2 + param3 * _loc6_;
      }
      
      public function reuse(param1:TableCell) : void
      {
         var_1723 = param1;
         initializeView();
      }
      
      public function update(param1:TableCell) : void
      {
         var_1723 = param1;
         if(inputElement.visible)
         {
            updateContents();
         }
         else
         {
            initializeView();
            if(param1.highlightOnChange)
            {
               highlight();
            }
         }
      }
      
      private function setAllInvisible() : void
      {
         textElement.visible = false;
         inputElement.visible = false;
         linkRegion.visible = false;
      }
      
      private function onLinkClick(param1:WindowMouseEvent) : void
      {
         if(var_1723 != null && var_1723.linkClickCallback != null)
         {
            var_1723.linkClickCallback();
         }
      }
      
      private function initializeView() : void
      {
         setAllInvisible();
         if(var_1723.type == TableCell.var_4815)
         {
            linkRegion.visible = true;
         }
         else if(var_1723.type == TableCell.var_2017)
         {
            textElement.visible = true;
         }
         updateContents();
      }
      
      private function updateContents() : void
      {
         if(var_1723.type == TableCell.var_4815)
         {
            linkElement.text = var_1723.contents as String;
         }
         else if(var_1723.type == TableCell.var_2017)
         {
            textElement.text = var_1723.contents as String;
            textElement.autoSize = column.alignment;
         }
         var _loc1_:String = "";
         if(var_1723.tooltipText != null)
         {
            _loc1_ = var_1723.tooltipText;
         }
         else if(var_1723.type == TableCell.var_2017 && textElement.isOverflown)
         {
            _loc1_ = var_1723.contents as String;
         }
         _container.toolTipCaption = _loc1_;
      }
      
      private function get column() : TableColumn
      {
         return var_3173.getColumnById(var_3105);
      }
      
      public function updateWidth() : void
      {
         _container.width = var_3173.getCellWidth(var_3105);
      }
      
      public function get container() : IWindowContainer
      {
         return _container;
      }
      
      private function onInputEdit(param1:WindowEvent) : void
      {
         var _loc2_:WindowKeyboardEvent = param1 as WindowKeyboardEvent;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.keyCode == 13 && var_1723.isEditable)
         {
            var_3173.onEnterNewCellValue(inputElement.text,var_4757.object,var_3105);
            initializeView();
         }
         else if(_loc2_.keyCode == 27)
         {
            initializeView();
         }
      }
      
      private function onInputFocusOut(param1:WindowEvent) : void
      {
         initializeView();
      }
      
      private function onDoubleClick(param1:WindowMouseEvent) : void
      {
         if(var_1723.isInspectable || var_1723.isEditable)
         {
            setAllInvisible();
            inputElement.visible = true;
            inputElement.text = var_1723.textFieldValue;
            inputElement.editable = var_1723.isEditable;
            inputElement.focus();
         }
      }
      
      public function recycle() : void
      {
         var_1723 = null;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _container.dispose();
         var_3105 = null;
         var_3173 = null;
         _container = null;
         var_1723 = null;
         _disposed = true;
         if(_transitionTimer != null)
         {
            _transitionTimer.reset();
            _transitionTimer = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get textElement() : ITextWindow
      {
         return _container.findChildByName("element_text") as ITextWindow;
      }
      
      private function get inputElement() : ITextFieldWindow
      {
         return _container.findChildByName("element_input") as ITextFieldWindow;
      }
      
      private function get linkRegion() : IRegionWindow
      {
         return _container.findChildByName("link_container") as IRegionWindow;
      }
      
      private function get linkElement() : ITextWindow
      {
         return _container.findChildByName("element_link") as ITextWindow;
      }
      
      private function get highlightBorder() : class_3437
      {
         return _container.findChildByName("highlight_border") as class_3437;
      }
      
      private function highlight() : void
      {
         var transitionDuration:Number;
         var delay:int;
         var steps:int;
         var minValue:Number;
         var maxValue:Number;
         var updateValue:* = function(param1:TimerEvent):void
         {
            var _loc2_:Number = easeInOutCubic(_transitionTimer.currentCount,minValue,maxValue - minValue,steps);
            highlightBorder.blend = _loc2_;
         };
         var onTimerComplete:* = function(param1:TimerEvent):void
         {
            highlightBorder.visible = false;
         };
         if(_transitionTimer != null && _transitionTimer.running)
         {
            return;
         }
         transitionDuration = 500;
         delay = 16;
         steps = transitionDuration / delay;
         minValue = 0;
         maxValue = 0.35;
         highlightBorder.visible = true;
         highlightBorder.blend = 0;
         if(_transitionTimer != null)
         {
            _transitionTimer.reset();
         }
         else
         {
            _transitionTimer = new Timer(delay,steps);
            _transitionTimer.addEventListener("timer",updateValue);
            _transitionTimer.addEventListener("timerComplete",onTimerComplete);
         }
         _transitionTimer.start();
      }
   }
}
