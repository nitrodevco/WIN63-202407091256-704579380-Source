package com.sulake.habbo.roomevents.wired_setup.inputsources
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.*;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.InputSourcesConf;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.*;
   import com.sulake.habbo.roomevents.wired_setup.common.class_3819;
   import flash.utils.Dictionary;
   
   public class WiredInputSourcePicker implements class_3599
   {
      
      public static var var_1736:int = 0;
      
      public static var USER_SOURCE:int = 1;
      
      public static var MERGED_SOURCE:int = 2;
       
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_2283:int;
      
      private var var_280:int;
      
      private var _container:IWindowContainer;
      
      private var var_2232:SourceTypePicker;
      
      private var var_1835:class_1659;
      
      private var var_2339:class_3531;
      
      private var _selectionCache:Dictionary;
      
      public function WiredInputSourcePicker(param1:HabboUserDefinedRoomEvents, param2:int, param3:int)
      {
         super();
         this._roomEvents = param1;
         this.var_2283 = param2;
         this.var_280 = param3;
         _container = IWindowContainer(_roomEvents.getXmlWindow("ude_inputsource"));
         _container.name = "selector" + param2 + "-" + param3;
         if(var_2283 == MERGED_SOURCE)
         {
            _selectionCache = new Dictionary();
            var_2232 = new SourceTypePicker(_roomEvents,sourceTypePickerContainer,this);
         }
         else
         {
            sourceTypePickerContainer.visible = false;
         }
         setInputHandlersInputSources();
      }
      
      public static function getTypeNameForSource(param1:int) : String
      {
         if(param1 == var_1736)
         {
            return "furni";
         }
         if(param1 == USER_SOURCE)
         {
            return "users";
         }
         if(param1 == class_3819.CONTEXT_SOURCE)
         {
            return "context";
         }
         if(param1 == class_3819.GLOBAL_SOURCE)
         {
            return "global";
         }
         return "";
      }
      
      private function setInputHandlersInputSources() : void
      {
         Util.setProcDirectly(decrementSourceSelect,function(param1:WindowEvent, param2:IWindow):void
         {
            if(param1.type == "WME_CLICK")
            {
               onChangeInputSource(false);
            }
         });
         Util.setProcDirectly(incrementSourceSelect,function(param1:WindowEvent, param2:IWindow):void
         {
            if(param1.type == "WME_CLICK")
            {
               onChangeInputSource(true);
            }
         });
      }
      
      private function onChangeInputSource(param1:Boolean) : void
      {
         var _loc9_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc7_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:InputSourcesConf = var_1835.inputSourcesConf;
         if(var_2283 == var_1736)
         {
            _loc9_ = _loc4_.getAllowedFurniSources(var_280);
            _loc2_ = int(var_1835.furniSourceTypes[var_280]);
            _loc3_ = _loc9_.indexOf(_loc2_);
         }
         else if(var_2283 == USER_SOURCE)
         {
            _loc9_ = _loc4_.getAllowedUserSources(var_280);
            _loc2_ = int(var_1835.userSourceTypes[var_280]);
            _loc3_ = _loc9_.indexOf(_loc2_);
         }
         else
         {
            _loc5_ = int((_loc7_ = var_2339.mergedSelections()[var_280])[0]);
            _loc6_ = int(_loc7_[1]);
            if((_loc8_ = var_2339.getMergedType(var_280)) == var_1736)
            {
               _loc9_ = _loc4_.getAllowedFurniSources(_loc5_);
               _loc2_ = int(var_1835.furniSourceTypes[_loc5_]);
               _loc3_ = _loc9_.indexOf(_loc2_);
            }
            else
            {
               if(_loc8_ != USER_SOURCE)
               {
                  return;
               }
               _loc9_ = _loc4_.getAllowedUserSources(_loc6_);
               _loc2_ = int(var_1835.userSourceTypes[_loc6_]);
               _loc3_ = _loc9_.indexOf(_loc2_);
            }
         }
         if(_loc3_ == -1)
         {
            _loc3_ = 0;
         }
         else if(param1)
         {
            _loc3_ = (_loc3_ + 1) % _loc9_.length;
         }
         else
         {
            _loc3_ = (_loc3_ - 1 + _loc9_.length) % _loc9_.length;
         }
         if(var_2283 == var_1736)
         {
            var_1835.furniSourceTypes[var_280] = _loc9_[_loc3_];
         }
         else if(var_2283 == USER_SOURCE)
         {
            var_1835.userSourceTypes[var_280] = _loc9_[_loc3_];
         }
         else if(_loc8_ == var_1736)
         {
            var_1835.furniSourceTypes[_loc5_] = _loc9_[_loc3_];
         }
         else if(_loc8_ == USER_SOURCE)
         {
            var_1835.userSourceTypes[_loc6_] = _loc9_[_loc3_];
         }
         refreshContainer(var_1835,var_2339);
      }
      
      public function set sourceType(param1:int) : void
      {
         var _loc4_:int = 0;
         if(var_2283 != MERGED_SOURCE)
         {
            return;
         }
         var _loc2_:int = var_2339.getMergedType(var_280);
         var_2339.setMergedType(var_280,param1);
         if(_loc2_ == var_1736)
         {
            _selectionCache[_loc2_] = var_1835.furniSourceTypes[var_280];
         }
         else if(_loc2_ == USER_SOURCE)
         {
            _selectionCache[_loc2_] = var_1835.userSourceTypes[var_280];
         }
         var _loc3_:InputSourcesConf = var_1835.inputSourcesConf;
         if(param1 == var_1736)
         {
            _loc4_ = int(param1 in _selectionCache ? _selectionCache[param1] : _loc3_.getAllowedFurniSources(var_280)[0]);
            var_1835.furniSourceTypes[var_280] = _loc4_;
         }
         else if(param1 == USER_SOURCE)
         {
            _loc4_ = int(param1 in _selectionCache ? _selectionCache[param1] : _loc3_.getAllowedUserSources(var_280)[0]);
            var_1835.userSourceTypes[var_280] = _loc4_;
         }
         refreshContainer(var_1835,var_2339);
      }
      
      public function refreshContainer(param1:class_1659, param2:class_3531) : void
      {
         var _loc18_:Array = null;
         var _loc19_:int = 0;
         var _loc10_:String = null;
         var _loc7_:String = null;
         var _loc11_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc12_:int = 0;
         var _loc4_:String = null;
         var _loc14_:int = 0;
         var _loc17_:int = 0;
         if(var_1835 != param1 || var_2339 != param2)
         {
            var_1835 = param1;
            var_2339 = param2;
            if(var_2283 == MERGED_SOURCE)
            {
               _selectionCache = new Dictionary();
               _loc18_ = [var_1736,USER_SOURCE];
               for each(var _loc6_ in var_2339.getCustomSourcesForMergedType(var_280))
               {
                  if(!(!_roomEvents.getBoolean("wired.variables.context_visible") && _loc6_ == class_3819.CONTEXT_SOURCE && param2.getMergedType(var_280) != class_3819.CONTEXT_SOURCE))
                  {
                     _loc18_.push(_loc6_);
                  }
               }
               var_2232.setOptions(_loc18_,var_2339.getMergedType(var_280));
            }
         }
         var _loc3_:Boolean = false;
         if(var_2283 == var_1736)
         {
            _loc7_ = param2.furniSelectionTitle(var_280);
            _loc10_ = "furni";
            _loc19_ = int(param1.furniSourceTypes[var_280]);
         }
         else if(var_2283 == USER_SOURCE)
         {
            _loc7_ = param2.userSelectionTitle(var_280);
            _loc10_ = "users";
            _loc19_ = int(param1.userSourceTypes[var_280]);
         }
         else
         {
            _loc7_ = param2.mergedSelectionTitle(var_280);
            _loc8_ = int((_loc11_ = param2.mergedSelections()[var_280])[0]);
            _loc9_ = int(_loc11_[1]);
            if((_loc12_ = param2.getMergedType(var_280)) == var_1736)
            {
               _loc10_ = "furni";
               _loc19_ = int(param1.furniSourceTypes[_loc8_]);
            }
            else if(_loc12_ == USER_SOURCE)
            {
               _loc10_ = "users";
               _loc19_ = int(param1.userSourceTypes[_loc9_]);
            }
            else
            {
               _loc3_ = true;
               _loc10_ = getTypeNameForSource(param2.getMergedType(var_280));
            }
         }
         var _loc13_:String = String(_roomEvents.localization.getLocalization(_loc7_,_loc7_));
         inputSourceDesc.caption = _loc13_;
         if(_loc3_)
         {
            _loc4_ = "wiredfurni.params.sources." + _loc10_;
         }
         else
         {
            _loc4_ = "wiredfurni.params.sources." + _loc10_ + "." + _loc19_;
         }
         var _loc22_:String = String(_roomEvents.localization.getLocalization(_loc4_,_loc4_));
         if(_loc10_ == "furni" && _loc19_ == 100 && wiredCtrl.hidePickFurniInstructions)
         {
            _loc14_ = int(wiredCtrl.getStuffIds().length);
            _loc17_ = param1.furniLimit;
            _loc22_ += " [" + _loc14_ + "/" + _loc17_ + "]";
         }
         var _loc21_:ITextWindow;
         (_loc21_ = inputSourceSelectionText).caption = _loc22_;
         _loc21_.y = 34 - _loc21_.height / 2;
         var _loc20_:Boolean = param2.isInputSourceDisabled(var_280,var_2283);
         var _loc16_:IWindow = decrementSourceSelect;
         var _loc15_:IWindow = incrementSourceSelect;
         var _loc5_:uint = _loc20_ ? 10066329 : 16777215;
         if(_loc20_ || _loc3_)
         {
            _loc16_.disable();
            _loc15_.disable();
         }
         else
         {
            _loc16_.enable();
            _loc15_.enable();
         }
         inputSourceDesc.textColor = _loc5_;
         _loc21_.textColor = _loc5_;
         if(var_2232 != null)
         {
            var_2232.disabled = _loc20_;
         }
      }
      
      public function set visible(param1:Boolean) : void
      {
         _container.visible = param1;
      }
      
      public function restoreLayout() : void
      {
         if(var_2232 != null)
         {
            var_2232.restoreLayout();
         }
      }
      
      public function get container() : IWindowContainer
      {
         return _container;
      }
      
      public function get sourceTypePicker() : SourceTypePicker
      {
         return var_2232;
      }
      
      private function get wiredCtrl() : UserDefinedRoomEventsCtrl
      {
         return _roomEvents.userDefinedRoomEventsCtrl;
      }
      
      public function dispose() : void
      {
         if(_container != null)
         {
            _container.dispose();
            _container = null;
         }
         if(var_2232 != null)
         {
            var_2232.dispose();
            var_2232 = null;
         }
      }
      
      private function get decrementSourceSelect() : IWindow
      {
         return _container.findChildByName("dec_stuff_sel_button");
      }
      
      private function get incrementSourceSelect() : IWindow
      {
         return _container.findChildByName("inc_stuff_sel_button");
      }
      
      private function get inputSourceDesc() : ITextWindow
      {
         return ITextWindow(_container.findChildByName("input_source_desc_txt"));
      }
      
      private function get inputSourceSelectionText() : ITextWindow
      {
         return ITextWindow(_container.findChildByName("furni_selected_source_txt"));
      }
      
      private function get sourceTypePickerContainer() : IWindowContainer
      {
         return IWindowContainer(_container.findChildByName("sourcetype_container"));
      }
   }
}
