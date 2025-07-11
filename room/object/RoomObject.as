package com.sulake.room.object
{
   import com.sulake.room.object.logic.IRoomObjectEventHandler;
   import com.sulake.room.object.logic.IRoomObjectMouseHandler;
   import com.sulake.room.object.visualization.IRoomObjectVisualization;
   import com.sulake.room.utils.*;
   
   public class RoomObject implements IRoomObjectController
   {
      
      private static var var_4433:int = 0;
       
      
      private var var_280:int;
      
      private var var_329:String = "";
      
      private var var_501:Vector3d;
      
      private var var_643:Vector3d;
      
      private var var_4217:Vector3d;
      
      private var var_4072:Vector3d;
      
      private var var_2541:Array;
      
      private var var_1644:RoomObjectModel;
      
      private var _visualization:IRoomObjectVisualization;
      
      private var var_2098:IRoomObjectEventHandler;
      
      private var var_1656:int;
      
      private var _avatarLibraryAssetName:String;
      
      private var var_3999:int = 0;
      
      private var var_1618:Boolean = false;
      
      public function RoomObject(param1:int, param2:int, param3:String)
      {
         var _loc4_:Number = NaN;
         super();
         var_280 = param1;
         var_501 = new Vector3d();
         var_643 = new Vector3d();
         var_4217 = new Vector3d();
         var_4072 = new Vector3d();
         var_2541 = new Array(param2);
         _loc4_ = param2 - 1;
         while(_loc4_ >= 0)
         {
            var_2541[_loc4_] = 0;
            _loc4_--;
         }
         var_329 = param3;
         var_1644 = new RoomObjectModel();
         _visualization = null;
         var_2098 = null;
         var_1656 = 0;
         var_3999 = var_4433++;
      }
      
      public function dispose() : void
      {
         var_501 = null;
         var_643 = null;
         var_2541 = null;
         _avatarLibraryAssetName = null;
         setVisualization(null);
         setEventHandler(null);
         if(var_1644 != null)
         {
            var_1644.dispose();
            var_1644 = null;
         }
      }
      
      public function setInitialized(param1:Boolean) : void
      {
         var_1618 = param1;
      }
      
      public function isInitialized() : Boolean
      {
         return var_1618;
      }
      
      public function getId() : int
      {
         return var_280;
      }
      
      public function getInstanceId() : int
      {
         return var_3999;
      }
      
      public function getType() : String
      {
         return var_329;
      }
      
      public function getLocation() : IVector3d
      {
         var_4217.assign(var_501);
         return var_4217;
      }
      
      public function getDirection() : IVector3d
      {
         var_4072.assign(var_643);
         return var_4072;
      }
      
      public function getModel() : IRoomObjectModel
      {
         return var_1644;
      }
      
      public function getModelController() : IRoomObjectModelController
      {
         return var_1644;
      }
      
      public function getState(param1:int) : int
      {
         if(param1 >= 0 && param1 < var_2541.length)
         {
            return var_2541[param1];
         }
         return -1;
      }
      
      public function getVisualization() : IRoomObjectVisualization
      {
         return _visualization;
      }
      
      public function setLocation(param1:IVector3d) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(var_501.x != param1.x || var_501.y != param1.y || var_501.z != param1.z)
         {
            var_501.x = param1.x;
            var_501.y = param1.y;
            var_501.z = param1.z;
            var_1656++;
         }
      }
      
      public function setDirection(param1:IVector3d) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(var_643.x != param1.x || var_643.y != param1.y || var_643.z != param1.z)
         {
            var_643.x = (param1.x % 360 + 360) % 360;
            var_643.y = (param1.y % 360 + 360) % 360;
            var_643.z = (param1.z % 360 + 360) % 360;
            var_1656++;
         }
      }
      
      public function setState(param1:int, param2:int) : Boolean
      {
         if(param2 >= 0 && param2 < var_2541.length)
         {
            if(var_2541[param2] != param1)
            {
               var_2541[param2] = param1;
               var_1656++;
            }
            return true;
         }
         return false;
      }
      
      public function setVisualization(param1:IRoomObjectVisualization) : void
      {
         if(param1 != _visualization)
         {
            if(_visualization != null)
            {
               _visualization.dispose();
            }
            _visualization = param1;
            if(_visualization != null)
            {
               _visualization.object = this;
            }
         }
      }
      
      public function setEventHandler(param1:IRoomObjectEventHandler) : void
      {
         if(param1 == var_2098)
         {
            return;
         }
         var _loc2_:IRoomObjectEventHandler = var_2098;
         if(_loc2_ != null)
         {
            var_2098 = null;
            _loc2_.object = null;
         }
         var_2098 = param1;
         if(var_2098 != null)
         {
            var_2098.object = this;
         }
      }
      
      public function getEventHandler() : IRoomObjectEventHandler
      {
         return var_2098;
      }
      
      public function getUpdateID() : int
      {
         return var_1656;
      }
      
      public function getMouseHandler() : IRoomObjectMouseHandler
      {
         return getEventHandler();
      }
      
      public function getAvatarLibraryAssetName() : String
      {
         if(!_avatarLibraryAssetName)
         {
            _avatarLibraryAssetName = "avatar_" + getId();
         }
         return _avatarLibraryAssetName;
      }
      
      public function tearDown() : void
      {
         if(var_2098)
         {
            var_2098.tearDown();
         }
      }
   }
}
