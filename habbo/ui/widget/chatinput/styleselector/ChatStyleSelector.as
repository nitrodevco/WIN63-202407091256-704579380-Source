package com.sulake.habbo.ui.widget.chatinput.styleselector
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3431;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.freeflowchat.style.class_3632;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.ui.widget.chatinput.RoomChatInputView;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class ChatStyleSelector implements IDisposable
   {
      
      private static const GRID_SPACING:int = 1;
      
      private static const MAX_GRID_COLUMNS:int = 6;
      
      private static var _selected:ChatStyleGridEntry = null;
      
      private static var _styleRequiresUpdate:Boolean = false;
       
      
      private var var_2672:RoomChatInputView;
      
      private var _container:IWindowContainer;
      
      private var var_1803:ChatStyleGridView;
      
      private var var_97:Vector.<ChatStyleGridEntry>;
      
      private var var_3465:IWindow;
      
      private var var_2074:Shape;
      
      public function ChatStyleSelector(param1:RoomChatInputView, param2:IWindowContainer, param3:ISessionDataManager)
      {
         var_97 = new Vector.<ChatStyleGridEntry>();
         super();
         var_2672 = param1;
         var_1803 = new ChatStyleGridView(this,var_2672.sessionDataManager);
         var_3465 = param1.widget.windowManager.buildFromXML(param1.widget.assets.getAssetByName("chatinput_chatstyle_template_xml").content as XML);
         _container = param2;
         _container.procedure = windowProc;
         var_2672.chatStyleMenuContainer.addChild(var_1803.window);
         var_1803.window.x = 0;
         var_1803.window.y = 0;
      }
      
      public function dispose() : void
      {
         while(var_97.length > 1)
         {
            var_97.pop();
         }
         var_97 = null;
         var_1803.dispose();
         var_1803 = null;
         if(var_2074 && var_2074.parent)
         {
            var_2074.parent.removeChild(var_2074);
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_1803 == null;
      }
      
      public function get chatInputView() : RoomChatInputView
      {
         return var_2672;
      }
      
      public function addItem(param1:int, param2:BitmapData) : void
      {
         var_97.push(new ChatStyleGridEntry(param1,param2));
         var _loc3_:IWindowContainer = getGridItemWindowWrapper(param2);
         var_1803.grid.addGridItem(_loc3_);
         _loc3_.findChildByName("background_color").visible = false;
      }
      
      public function get selectedStyleId() : int
      {
         if(_styleRequiresUpdate && selected)
         {
            _styleRequiresUpdate = false;
            return selected.id;
         }
         return -1;
      }
      
      public function get selectedStyleBitmap() : BitmapData
      {
         if(selected)
         {
            return selected.bitmap;
         }
         return null;
      }
      
      public function initSelection() : void
      {
         selected = selected;
         _styleRequiresUpdate = false;
      }
      
      public function set gridColumns(param1:int) : void
      {
         param1 = Math.min(param1,6);
         var _loc2_:int = (param1 - 1) * (var_3465.width + 1) + var_3465.width;
         if(param1 > 1)
         {
            var_1803.grid.width = _loc2_;
         }
         else
         {
            var_1803.grid.width = var_3465.width + 16;
         }
      }
      
      private function set selected(param1:ChatStyleGridEntry) : void
      {
         _selected = param1;
         _styleRequiresUpdate = true;
         var _loc4_:class_3632 = var_2672.widget.roomUi.chatStyleLibrary.getStyle(param1.id);
         if(var_2672.window.findChildByName("chat_bg_preview") == null)
         {
            return;
         }
         var _loc2_:Sprite = _loc4_.getNewBackgroundSprite(16777215);
         var _loc3_:class_3431 = class_3431(var_2672.window.findChildByName("chat_bg_preview"));
         _loc2_.width = _loc3_.width + _loc4_.overlap.width;
         _loc2_.height = _loc3_.height + _loc4_.overlap.y + _loc4_.overlap.height;
         _loc2_.y -= _loc4_.overlap.y;
         if(!var_2074)
         {
            var_2074 = new Shape();
         }
         else
         {
            var_2074.graphics.clear();
         }
         var_2074.graphics.beginFill(16711680);
         var_2074.graphics.drawRect(0,0,_loc2_.width - 28,_loc2_.height);
         _loc3_.setDisplayObject(_loc2_);
         if(_loc2_.parent)
         {
            _loc2_.parent.addChild(var_2074);
            var_2074.x = _loc2_.x + 28;
            var_2074.y = _loc2_.y;
            _loc2_.mask = var_2074;
         }
         var_2672.setInputFieldColor(_loc4_.textFormat.color as uint);
      }
      
      private function get selected() : ChatStyleGridEntry
      {
         if(_selected == null)
         {
            _selected = var_97[var_97.length - 1];
         }
         return _selected;
      }
      
      private function getGridItemWindowWrapper(param1:BitmapData) : IWindowContainer
      {
         var _loc2_:IWindowContainer = IWindowContainer(var_3465.clone());
         var _loc3_:IBitmapWrapperWindow = IBitmapWrapperWindow(_loc2_.findChildByName("bubble_preview"));
         _loc3_.bitmap = param1;
         _loc3_.center();
         _loc2_.procedure = gridItemWindowProc;
         return _loc2_;
      }
      
      public function alignMenuToSelector() : void
      {
         if(var_1803.window.visible)
         {
            var_1803.alignToSelector(_container);
         }
      }
      
      private function windowProc(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var_1803.window.visible = !var_1803.window.visible;
            alignMenuToSelector();
         }
      }
      
      private function gridItemWindowProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:int = 0;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = var_1803.grid.getGridItemIndex(param2);
            showBackgroundOnlyForItem(param2);
            selected = var_97[_loc3_];
            var_1803.window.visible = false;
         }
         if(param1.type == "WME_OVER")
         {
            IWindowContainer(param2).findChildByName("background_color").color = 4291875024;
         }
         if(param1.type == "WME_OUT")
         {
            IWindowContainer(param2).findChildByName("background_color").color = 4294967295;
         }
      }
      
      private function showBackgroundOnlyForItem(param1:IWindow) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < var_1803.grid.numGridItems)
         {
            IWindowContainer(var_1803.grid.getGridItemAt(_loc2_)).findChildByName("background_color").visible = false;
            _loc2_++;
         }
         IWindowContainer(param1).findChildByName("background_color").visible = true;
      }
   }
}
