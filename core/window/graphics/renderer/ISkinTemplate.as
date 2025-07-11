package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.window.utils.IChildEntityArray;
   import com.sulake.core.window.utils.class_3488;
   
   public interface ISkinTemplate extends IChildEntityArray, class_3488
   {
       
      
      function get asset() : IAsset;
      
      function dispose() : void;
   }
}
