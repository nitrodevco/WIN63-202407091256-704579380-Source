package com.sulake.habbo.navigator.domain
{
   import com.sulake.core.window.IWindowContainer;
   
   public class RoomLayout
   {
       
      
      private var var_360:int;
      
      private var var_4437:int;
      
      private var _name:String;
      
      private var var_1631:IWindowContainer;
      
      public function RoomLayout(param1:int, param2:int, param3:String)
      {
         super();
         var_360 = param1;
         var_4437 = param2;
         _name = param3;
      }
      
      public function get requiredClubLevel() : int
      {
         return var_360;
      }
      
      public function get tileSize() : int
      {
         return var_4437;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get view() : IWindowContainer
      {
         return var_1631;
      }
      
      public function set view(param1:IWindowContainer) : void
      {
         var_1631 = param1;
      }
   }
}
