package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_3377;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   
   public class MultiProductContainer extends SingleProductContainer
   {
       
      
      public function MultiProductContainer(param1:class_3377, param2:Vector.<class_3388>, param3:HabboCatalog)
      {
         super(param1,param2,param3);
      }
      
      override public function initProductIcon(param1:IRoomEngine, param2:IStuffData = null) : void
      {
         super.initProductIcon(param1);
         var _loc3_:IWindow = var_1631.findChildByName("multiContainer");
         if(_loc3_)
         {
            _loc3_.visible = true;
         }
         var _loc4_:ITextWindow;
         if(_loc4_ = var_1631.findChildByName("multiCounter") as ITextWindow)
         {
            _loc4_.text = "x" + firstProduct.productCount;
         }
         this.setClubIconLevel(offer.clubLevel);
      }
   }
}
