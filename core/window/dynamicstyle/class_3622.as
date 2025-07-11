package com.sulake.core.window.dynamicstyle
{
   import flash.utils.Dictionary;
   
   public class class_3622
   {
      
      private static var _styles:Dictionary;
       
      
      public function class_3622()
      {
         super();
      }
      
      public static function getStyle(param1:String) : DynamicStyle
      {
         if(!_styles)
         {
            fillStyleTable();
         }
         if(param1 in _styles)
         {
            return _styles[param1];
         }
         return new DynamicStyle();
      }
      
      private static function fillStyleTable() : void
      {
         _styles = new Dictionary();
         var _loc1_:DynamicStyle = new DynamicStyle("lifted_hover");
         _loc1_.defaultStyles = {};
         _loc1_.pressedSyles = {
            "offsetX":1,
            "colorTransform":[1,0.7,0.7,0.7,0,0,0,0]
         };
         _loc1_.var_3167 = {
            "offsetY":-1,
            "offsetX":-1
         };
         var _loc4_:DynamicStyle;
         (_loc4_ = new DynamicStyle()).defaultStyles = {
            "etchingColor":1207959552,
            "etchingPoint":[1,1]
         };
         _loc4_.var_3167 = {
            "etchingColor":2147483648,
            "etchingPoint":[2,2]
         };
         _loc4_.pressedSyles = {
            "etchingColor":1207959552,
            "etchingPoint":[-1,-1]
         };
         _loc1_.var_3172["#icon"] = _loc4_;
         var _loc2_:DynamicStyle = new DynamicStyle("brightness_and_shadow_under");
         _loc2_.defaultStyles = {};
         var _loc5_:DynamicStyle;
         (_loc5_ = new DynamicStyle()).defaultStyles = {
            "etchingColor":1207959552,
            "etchingPoint":[0,1]
         };
         _loc5_.pressedSyles = {
            "etchingColor":2147483648,
            "etchingPoint":[0,-1],
            "offsetY":-1,
            "colorTransform":[0.7,0.7,0.7,1,0,0,0,0]
         };
         _loc5_.var_3167 = {
            "etchingColor":1207959552,
            "etchingPoint":[0,1],
            "colorTransform":[1,1,1,1,77,77,77,0]
         };
         _loc2_.var_3172["#icon"] = _loc5_;
         var _loc3_:DynamicStyle = new DynamicStyle();
         _loc3_.defaultStyles = {
            "etchingColor":1207959552,
            "etchingPoint":[0,1]
         };
         _loc3_.pressedSyles = {
            "etchingColor":2147483648,
            "etchingPoint":[0,0],
            "colorTransform":[0.9,0.9,0.9,1,0,0,0,0]
         };
         _loc3_.var_3167 = {
            "etchingColor":1207959552,
            "etchingPoint":[0,1],
            "colorTransform":[1,1,1,1,77,77,77,0]
         };
         _loc3_.var_4228 = {"colorTransform":[0.5,0.5,0.5,0.7,0,0,0,0]};
         _loc2_.var_3172["#bg"] = _loc3_;
         _styles["lifted_hover"] = _loc1_;
         _styles["brightness_and_shadow_under"] = _loc2_;
      }
   }
}
