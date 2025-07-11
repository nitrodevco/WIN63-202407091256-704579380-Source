package com.sulake.habbo.ui.widget.furniture.contextmenu
{
   import com.sulake.habbo.ui.widget.contextmenu.ButtonMenuView;
   import com.sulake.habbo.ui.widget.contextmenu.class_3386;
   import com.sulake.room.object.IRoomObject;
   
   public class FurnitureContextInfoView extends ButtonMenuView
   {
       
      
      protected var var_2060:IRoomObject;
      
      protected var var_617:String;
      
      public function FurnitureContextInfoView(param1:class_3386)
      {
         super(param1);
      }
      
      public static function setup(param1:FurnitureContextInfoView, param2:IRoomObject, param3:String = "") : void
      {
         param1.var_2060 = param2;
         param1.var_617 = param3;
         setupContext(param1);
      }
      
      protected function get roomObject() : IRoomObject
      {
         return var_2060;
      }
      
      override public function dispose() : void
      {
         var_2060 = null;
         super.dispose();
      }
   }
}
