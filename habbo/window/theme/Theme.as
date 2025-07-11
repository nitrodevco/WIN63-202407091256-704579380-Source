package com.sulake.habbo.window.theme
{
   import com.sulake.core.window.theme.PropertyMap;
   
   public class Theme
   {
      
      public static const NONE:String = "None";
      
      public static const ICON:String = "Icon";
      
      public static const LEGACY_BORDER:String = "Legacy border";
      
      public static const VOLTER:String = "Volter";
      
      public static const UBUNTU:String = "Ubuntu";
      
      public static const ILLUMINA_LIGHT:String = "Illumina Light";
      
      public static const ILLUMINA_DARK:String = "Illumina Dark";
       
      
      private var _name:String;
      
      private var var_4381:Boolean;
      
      private var var_3944:uint;
      
      private var var_4153:uint;
      
      private var var_3375:PropertyMap;
      
      public function Theme(param1:String, param2:Boolean, param3:uint, param4:uint, param5:PropertyMap)
      {
         super();
         _name = param1;
         var_4381 = param2;
         var_3944 = param3;
         var_4153 = param4;
         var_3375 = param5;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get isReal() : Boolean
      {
         return var_4381;
      }
      
      public function get baseStyle() : uint
      {
         return var_3944;
      }
      
      public function get styleCount() : uint
      {
         return var_4153;
      }
      
      public function get propertyDefaults() : PropertyMap
      {
         return var_3375;
      }
      
      public function coversStyle(param1:uint) : Boolean
      {
         return param1 >= var_3944 && param1 < var_3944 + var_4153;
      }
   }
}
