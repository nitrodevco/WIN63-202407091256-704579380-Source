package com.sulake.habbo.catalog.viewer
{
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_3377;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.class_3499;
   import com.sulake.habbo.session.furniture.class_3365;
   
   public class FurniProductContainer extends ProductContainer
   {
       
      
      private var var_2047:class_3365;
      
      public function FurniProductContainer(param1:class_3377, param2:Vector.<class_3388>, param3:HabboCatalog, param4:class_3365)
      {
         super(param1,param2,param3);
         var_2047 = param4;
      }
      
      override public function initProductIcon(param1:IRoomEngine, param2:IStuffData = null) : void
      {
         var _loc3_:class_3499 = null;
         switch(var_2047.type)
         {
            case "s":
               _loc3_ = catalog.roomEngine.getFurnitureIcon(var_2047.id,this);
               break;
            case "i":
               _loc3_ = catalog.roomEngine.getWallItemIcon(var_2047.id,this);
         }
         if(_loc3_)
         {
            setIconImage(_loc3_.data,true);
         }
      }
      
      override public function activate() : void
      {
         super.activate();
         if(var_2047.rentOfferId > -1 && catalog.catalogType != "BUILDERS_CLUB")
         {
            catalog.sendGetProductOffer(var_2047.rentOfferId);
         }
         else
         {
            catalog.sendGetProductOffer(var_2047.purchaseOfferId);
         }
      }
      
      override public function get isLazy() : Boolean
      {
         return true;
      }
   }
}
