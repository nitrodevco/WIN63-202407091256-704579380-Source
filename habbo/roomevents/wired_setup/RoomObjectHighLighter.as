package com.sulake.habbo.roomevents.wired_setup
{
    import assets.class_14
   import assets.furnitureFilter_pbj$5b51dd400f82d19cd3c27c61e8dd09011566352002

   import com.sulake.habbo.room.object.visualization.furniture.FurnitureVisualization;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.room.object.IRoomObject;
   import flash.display.Shader;
   import flash.filters.BitmapFilter;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.GlowFilter;
   import flash.filters.ShaderFilter;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class RoomObjectHighLighter
   {
       
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var _filterBW:Array;
      
      private var _filterBWWall:Array;
      
      private var var_4232:Array;
      
      public function RoomObjectHighLighter(param1:HabboUserDefinedRoomEvents)
      {
         var _loc4_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc15_:Array = null;
         var _loc6_:ColorMatrixFilter = null;
         var _loc11_:Class = null;
         var _loc10_:Shader = null;
         var _loc2_:ShaderFilter = null;
         var _loc3_:GlowFilter = null;
         var _loc7_:Array = null;
         var _loc8_:ColorMatrixFilter = null;
         var _loc5_:* = null;
         var _loc14_:* = null;
         super();
         _roomEvents = param1;
         _loc4_ = 154;
         _loc12_ = 0.75;
         _loc9_ = 25.5;
         _loc13_ = 25.5;
         _loc15_ = [1 - _loc12_,0,0,0,_loc12_ * _loc4_,0,1 - _loc12_,0,0,_loc12_ * _loc4_ + _loc9_,0,0,1 - _loc12_,0,_loc12_ * _loc4_ + _loc13_,0,0,0,1,0];
         _loc6_ = new ColorMatrixFilter(_loc15_);
         _loc11_ = furnitureFilter_pbj$5b51dd400f82d19cd3c27c61e8dd09011566352002;
         _loc10_ = new Shader(new _loc11_() as ByteArray);
         _loc2_ = new ShaderFilter(_loc10_);
         _filterBW = [_loc6_,_loc2_];
         _loc3_ = new GlowFilter(16777215,1,5,5,3,1,true,false);
         _filterBWWall = [_loc6_,_loc2_,_loc3_];
         _loc7_ = [0.9,0,0,0,0,0,1,0,0,40,0,0,1,0,80,0,0,0,0.8,0];
         var_4232 = [_loc8_ = new ColorMatrixFilter(_loc7_)];
      }
      
      public static function addFiltersToFurni(param1:IRoomObject, param2:Array, param3:Boolean = false) : void
      {
         var _loc4_:FurnitureVisualization = null;
         var _loc5_:Array = null;
         if(param1)
         {
            _loc4_ = param1.getVisualization() as FurnitureVisualization;
            class_14.log("Furni visualization: " + _loc4_);
            _loc5_ = _loc4_.filters == null ? [] : _loc4_.filters;
            _loc5_ = param3 ? param2.concat(_loc5_) : _loc5_.concat(param2);
            _loc4_.filters = _loc5_;
         }
      }
      
      public static function removeFiltersFromFurni(param1:IRoomObject, param2:Array) : void
      {
         var _loc4_:FurnitureVisualization = null;
         var _loc6_:Array = null;
         var _loc5_:int = 0;
         if(param1)
         {
            _loc4_ = param1.getVisualization() as FurnitureVisualization;
            class_14.log("Furni visualization: " + _loc4_);
            if(_loc4_.filters == null)
            {
               return;
            }
            _loc6_ = _loc4_.filters.slice();
            for each(var _loc3_ in param2)
            {
               if((_loc5_ = _loc6_.indexOf(_loc3_)) != -1)
               {
                  _loc6_.removeAt(_loc5_);
               }
            }
            _loc4_.filters = _loc6_;
         }
      }
      
      public function hide(param1:int) : void
      {
         inactivateFurni(getFurni(param1),param1 < 0);
      }
      
      public function hideAll(param1:Dictionary) : void
      {
         for(var _loc2_ in param1)
         {
            class_14.log("Show furni as unselected: " + _loc2_);
            inactivateFurni(getFurni(parseInt(_loc2_)),_loc2_ < 0);
         }
      }
      
      public function show(param1:int) : void
      {
         activateFurni(getFurni(param1),param1 < 0);
      }
      
      public function showAll(param1:Dictionary) : void
      {
         for(var _loc2_ in param1)
         {
            class_14.log("Show furni as selected: " + _loc2_);
            activateFurni(getFurni(parseInt(_loc2_)),_loc2_ < 0);
         }
      }
      
      private function getFurni(param1:int) : IRoomObject
      {
         if(param1 < 0)
         {
            param1 = -param1;
            return _roomEvents.roomEngine.getRoomObject(_roomEvents.roomId,param1,20);
         }
         return _roomEvents.roomEngine.getRoomObject(_roomEvents.roomId,param1,10);
      }
      
      public function highlightActiveWired(param1:int) : void
      {
         addFiltersToFurni(getFurni(param1),var_4232);
      }
      
      public function unhighlightActiveWired(param1:int) : void
      {
         removeFiltersFromFurni(getFurni(param1),var_4232);
      }
      
      private function activateFurni(param1:IRoomObject, param2:Boolean) : void
      {
         addFiltersToFurni(param1,param2 ? _filterBWWall : _filterBW,true);
      }
      
      private function inactivateFurni(param1:IRoomObject, param2:Boolean) : void
      {
         removeFiltersFromFurni(param1,param2 ? _filterBWWall : _filterBW);
      }
   }
}
