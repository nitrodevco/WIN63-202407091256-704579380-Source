package com.sulake.core.window.graphics.renderer
{
   import flash.geom.Rectangle;
   
   public class SkinTemplateEntity implements ISkinTemplateEntity
   {
       
      
      protected var var_280:uint;
      
      protected var _name:String;
      
      protected var var_329:String;
      
      protected var var_3496:Rectangle;
      
      public function SkinTemplateEntity(param1:String, param2:String, param3:uint, param4:Rectangle)
      {
         super();
         var_280 = param3;
         _name = param1;
         var_329 = param2;
         var_3496 = param4;
      }
      
      public function get id() : uint
      {
         return var_280;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get type() : String
      {
         return var_329;
      }
      
      public function get region() : Rectangle
      {
         return var_3496;
      }
   }
}
