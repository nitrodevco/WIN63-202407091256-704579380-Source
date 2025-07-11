package com.sulake.room.renderer
{
   import com.sulake.core.runtime.Component;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.utils.Map;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.RoomGeometry;
   import flash.utils.getTimer;
   
   [SecureSWF(rename="true")]
   public class class_3447 implements IRoomRenderer, class_3446
   {
       
      
      private var var_136:Map;
      
      private var var_1845:Map;
      
      private var var_1660:Component;
      
      private var _disposed:Boolean = false;
      
      private var var_4416:String = null;
      
      public function class_3447(param1:Component)
      {
         super();
         var_136 = new Map();
         var_1845 = new Map();
         if(param1 != null)
         {
            var_1660 = param1;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get roomObjectVariableAccurateZ() : String
      {
         return var_4416;
      }
      
      public function set roomObjectVariableAccurateZ(param1:String) : void
      {
         var_4416 = param1;
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:class_3650 = null;
         if(disposed)
         {
            return;
         }
         if(var_1845 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < var_1845.length)
            {
               _loc1_ = var_1845.getWithIndex(_loc2_) as class_3650;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            var_1845.dispose();
            var_1845 = null;
         }
         if(var_136 != null)
         {
            var_136.dispose();
            var_136 = null;
         }
         if(var_1660 != null)
         {
            var_1660 = null;
         }
         _disposed = true;
      }
      
      public function reset() : void
      {
         var_136.reset();
      }
      
      public function getRoomObjectIdentifier(param1:IRoomObject) : String
      {
         if(param1 != null)
         {
            return String(param1.getInstanceId());
         }
         return null;
      }
      
      public function feedRoomObject(param1:IRoomObject) : void
      {
         if(param1 == null)
         {
            return;
         }
         var_136.add(getRoomObjectIdentifier(param1),param1);
      }
      
      public function removeRoomObject(param1:IRoomObject) : void
      {
         var _loc3_:int = 0;
         var _loc2_:class_3650 = null;
         var _loc4_:String = getRoomObjectIdentifier(param1);
         var_136.remove(_loc4_);
         _loc3_ = 0;
         while(_loc3_ < var_1845.length)
         {
            _loc2_ = var_1845.getWithIndex(_loc3_) as class_3650;
            if(_loc2_ != null)
            {
               _loc2_.roomObjectRemoved(_loc4_);
            }
            _loc3_++;
         }
      }
      
      public function getRoomObject(param1:String) : IRoomObject
      {
         return var_136.getValue(param1) as IRoomObject;
      }
      
      public function getRoomObjectWithIndex(param1:int) : IRoomObject
      {
         return var_136.getWithIndex(param1) as IRoomObject;
      }
      
      public function getRoomObjectIdWithIndex(param1:int) : String
      {
         return var_136.getKey(param1) as String;
      }
      
      public function getRoomObjectCount() : int
      {
         return var_136.length;
      }
      
      public function render() : void
      {
         var _loc3_:int = 0;
         var _loc2_:IRoomRenderingCanvas = null;
         var _loc1_:int = getTimer();
         ErrorReportStorage.addDebugData("Canvas count",String(var_1845.length));
         _loc3_ = var_1845.length - 1;
         while(_loc3_ >= 0)
         {
            _loc2_ = var_1845.getWithIndex(_loc3_) as IRoomRenderingCanvas;
            if(_loc2_ != null)
            {
               _loc2_.render(_loc1_);
            }
            _loc3_--;
         }
      }
      
      public function createCanvas(param1:int, param2:int, param3:int, param4:int) : IRoomRenderingCanvas
      {
         var _loc6_:RoomGeometry = null;
         var _loc5_:IRoomRenderingCanvas;
         if((_loc5_ = var_1845.getValue(String(param1)) as IRoomRenderingCanvas) != null)
         {
            _loc5_.initialize(param2,param3);
            if(_loc6_ = _loc5_.geometry as RoomGeometry)
            {
               _loc6_.scale = param4;
            }
            return _loc5_;
         }
         _loc5_ = createCanvasInstance(param1,param2,param3,param4);
         var_1845.add(String(param1),_loc5_);
         return _loc5_;
      }
      
      protected function createCanvasInstance(param1:int, param2:int, param3:int, param4:int) : IRoomRenderingCanvas
      {
         return new class_3656(this,param1,param2,param3,param4);
      }
      
      public function getCanvas(param1:int) : IRoomRenderingCanvas
      {
         return var_1845.getValue(String(param1)) as IRoomRenderingCanvas;
      }
      
      public function disposeCanvas(param1:int) : Boolean
      {
         var _loc2_:class_3650 = var_1845.remove(String(param1)) as class_3650;
         if(_loc2_ != null)
         {
            _loc2_.dispose();
         }
         return false;
      }
      
      public function update(param1:uint) : void
      {
         var _loc3_:int = 0;
         var _loc2_:class_3650 = null;
         render();
         _loc3_ = var_1845.length - 1;
         while(_loc3_ >= 0)
         {
            _loc2_ = var_1845.getWithIndex(_loc3_) as class_3650;
            if(_loc2_ != null)
            {
               _loc2_.update();
            }
            _loc3_--;
         }
      }
   }
}
