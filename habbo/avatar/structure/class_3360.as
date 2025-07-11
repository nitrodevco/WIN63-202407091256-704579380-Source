package com.sulake.habbo.avatar.structure
{
   import com.sulake.habbo.avatar.structure.figure.ISetType;
   import com.sulake.habbo.avatar.structure.figure.class_3418;
   import com.sulake.habbo.avatar.structure.figure.class_3445;
   
   public interface class_3360
   {
       
      
      function getSetType(param1:String) : ISetType;
      
      function getPalette(param1:int) : class_3445;
      
      function getFigurePartSet(param1:int) : class_3418;
   }
}
