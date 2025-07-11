package com.sulake.habbo.avatar.structure
{
   import flash.geom.Point;
   
   public class AvatarCanvas
   {
       
      
      private var var_280:String;
      
      private var _width:int;
      
      private var var_46:int;
      
      private var _offset:Point;
      
      private var _regPoint:Point;
      
      public function AvatarCanvas(param1:XML, param2:String)
      {
         super();
         var_280 = String(param1.@id);
         _width = parseInt(param1.@width);
         var_46 = parseInt(param1.@height);
         _offset = new Point(parseInt(param1.@dx),parseInt(param1.@dy));
         if(param2 == "h")
         {
            _regPoint = new Point((_width - 64) / 2,0);
         }
         else
         {
            _regPoint = new Point((_width - 32) / 2,0);
         }
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get height() : int
      {
         return var_46;
      }
      
      public function get offset() : Point
      {
         return _offset;
      }
      
      public function get id() : String
      {
         return var_280;
      }
      
      public function get regPoint() : Point
      {
         return _regPoint;
      }
   }
}
