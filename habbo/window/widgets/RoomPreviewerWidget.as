package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3431;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.room.preview.RoomPreviewer;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   
   public class RoomPreviewerWidget implements IRoomPreviewerWidget
   {
      
      public static const TYPE:String = "room_previewer";
      
      private static const SCALE_KEY:String = "room_previewer:scale";
      
      private static const const_720:String = "room_previewer:offsetx";
      
      private static const const_799:String = "room_previewer:offsety";
      
      private static const const_875:String = "room_previewer:zoom";
      
      private static const SCALE_DEFAULT:PropertyStruct = new PropertyStruct("room_previewer:scale",64,"int",false,[32,64]);
      
      private static const OFFSET_X_DEFAULT:PropertyStruct = new PropertyStruct("room_previewer:offsetx",0,"int",false);
      
      private static const OFFSET_Y_DEFAULT:PropertyStruct = new PropertyStruct("room_previewer:offsety",0,"int",false);
      
      private static const ZOOM_DEFAULT:PropertyStruct = new PropertyStruct("room_previewer:zoom",1,"int",false);
      
      private static var ROOM_ID_COUNTER:int = 2;
       
      
      private var _disposed:Boolean;
      
      private var var_1759:IWidgetWindow;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_509:IWindowContainer;
      
      private var var_2068:class_3431;
      
      private var var_1799:RoomPreviewer;
      
      private var var_911:int;
      
      private var _offsetX:int = 0;
      
      private var _offsetY:int = 0;
      
      private var var_3477:int;
      
      public function RoomPreviewerWidget(param1:IWidgetWindow, param2:HabboWindowManagerComponent)
      {
         var_911 = int(SCALE_DEFAULT.value);
         var_3477 = int(ZOOM_DEFAULT.value);
         super();
         var_1759 = param1;
         _windowManager = param2;
         if(param2.roomEngine)
         {
            param2.roomEngine.events.addEventListener("REE_INITIALIZED",onRoomInitialized);
         }
         var_509 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("room_previewer_xml").content as XML) as IWindowContainer;
         var_2068 = var_509.findChildByName("room_canvas") as class_3431;
         var_1799 = new RoomPreviewer(param2.roomEngine,ROOM_ID_COUNTER++);
         var_1799.createRoomForPreviews();
         var_509.addEventListener("WME_CLICK",onClickRoomView);
         var_509.addEventListener("WE_RESIZE",onResizeCanvas);
         var_1759.rootWindow = var_509;
         var_509.width = var_1759.width;
         var_509.height = var_1759.height;
         var_1799.modifyRoomCanvas(var_509.width,var_509.height);
      }
      
      public function get scale() : int
      {
         return var_911;
      }
      
      public function set scale(param1:int) : void
      {
         var_911 = param1;
         refresh();
      }
      
      public function get offsetX() : int
      {
         return _offsetX;
      }
      
      public function set offsetX(param1:int) : void
      {
         _offsetX = param1;
         refresh();
      }
      
      public function get offsetY() : int
      {
         return _offsetY;
      }
      
      public function set offsetY(param1:int) : void
      {
         _offsetY = param1;
         refresh();
      }
      
      public function get zoom() : int
      {
         return var_3477;
      }
      
      public function set zoom(param1:int) : void
      {
         var_3477 = param1;
         refresh();
      }
      
      public function get properties() : Array
      {
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(SCALE_DEFAULT.withValue(var_911));
         _loc1_.push(OFFSET_X_DEFAULT.withValue(_offsetX));
         _loc1_.push(OFFSET_Y_DEFAULT.withValue(_offsetY));
         _loc1_.push(ZOOM_DEFAULT.withValue(var_3477));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "room_previewer:scale":
                  scale = int(_loc2_.value);
                  break;
               case "room_previewer:offsetx":
                  offsetX = int(_loc2_.value);
                  break;
               case "room_previewer:offsety":
                  offsetY = int(_loc2_.value);
                  break;
               case "room_previewer:zoom":
                  zoom = int(_loc2_.value);
                  break;
            }
         }
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_1799 != null)
            {
               var_1799.dispose();
               var_1799 = null;
            }
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
            if(_windowManager && _windowManager.roomEngine && _windowManager.roomEngine.events)
            {
               _windowManager.roomEngine.events.removeEventListener("REE_INITIALIZED",onRoomInitialized);
            }
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
      
      private function onRoomInitialized(param1:RoomEngineEvent) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:* = param1.type;
         if("REE_INITIALIZED" === _loc3_)
         {
            if(var_1799 && param1.roomId == var_1799.previewRoomId)
            {
               var_1799.reset(false);
               _loc2_ = var_1799.getRoomCanvas(var_2068.width,var_2068.height);
               if(_loc2_ != null)
               {
                  var_2068.setDisplayObject(_loc2_);
               }
            }
         }
      }
      
      private function refresh() : void
      {
         var _loc1_:DisplayObject = null;
         if(var_1799 && var_1799.isRoomEngineReady)
         {
            var_911 == 64 ? var_1799.zoomIn() : var_1799.zoomOut();
            var_1799.addViewOffset = new Point(_offsetX,_offsetY);
            _loc1_ = var_2068.getDisplayObject();
            _loc1_.scaleX = _loc1_.scaleY = zoom;
            _loc1_.x = offsetX;
            _loc1_.y = offsetY;
         }
      }
      
      public function toString() : String
      {
         return "RoomPreviewerWidget";
      }
      
      private function onResizeCanvas(param1:WindowEvent, param2:IWindow = null) : void
      {
         var _loc3_:int = param1.window.width;
         var _loc4_:int = param1.window.height;
         var_1799.modifyRoomCanvas(_loc3_,_loc4_);
      }
      
      private function onClickRoomView(param1:WindowMouseEvent) : void
      {
         var_1799.changeRoomObjectState();
      }
      
      public function get roomPreviewer() : RoomPreviewer
      {
         return var_1799;
      }
      
      public function showPreview(param1:BitmapData) : void
      {
         var _loc2_:Bitmap = new Bitmap(param1);
         _loc2_.scaleX = 2;
         _loc2_.scaleY = 2;
         var_2068.setDisplayObject(_loc2_);
      }
   }
}
