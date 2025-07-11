package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;
   import flash.display.BitmapData;
   
   public class InfoStandFurniData
   {
       
      
      private var var_280:int = 0;
      
      private var var_638:int = 0;
      
      private var _name:String = "";
      
      private var var_363:String = "";
      
      private var var_859:BitmapData;
      
      private var var_4357:int = -1;
      
      private var var_586:String = "";
      
      private var var_1091:IStuffData = null;
      
      private var _groupId:int;
      
      private var var_876:int = 0;
      
      private var _ownerName:String = "";
      
      private var var_4430:int = -1;
      
      private var var_4319:Boolean = false;
      
      public function InfoStandFurniData()
      {
         super();
      }
      
      public function set id(param1:int) : void
      {
         var_280 = param1;
      }
      
      public function set category(param1:int) : void
      {
         var_638 = param1;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function set description(param1:String) : void
      {
         var_363 = param1;
      }
      
      public function set image(param1:BitmapData) : void
      {
         var_859 = param1;
      }
      
      public function set purchaseOfferId(param1:int) : void
      {
         var_4357 = param1;
      }
      
      public function set extraParam(param1:String) : void
      {
         var_586 = param1;
      }
      
      public function set stuffData(param1:IStuffData) : void
      {
         var_1091 = param1;
      }
      
      public function set groupId(param1:int) : void
      {
         _groupId = param1;
      }
      
      public function set ownerId(param1:int) : void
      {
         var_876 = param1;
      }
      
      public function set ownerName(param1:String) : void
      {
         _ownerName = param1;
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function get category() : int
      {
         return var_638;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get description() : String
      {
         return var_363;
      }
      
      public function get image() : BitmapData
      {
         return var_859;
      }
      
      public function get purchaseOfferId() : int
      {
         return var_4357;
      }
      
      public function get extraParam() : String
      {
         return var_586;
      }
      
      public function get stuffData() : IStuffData
      {
         return var_1091;
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function get ownerId() : int
      {
         return var_876;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function get rentOfferId() : int
      {
         return var_4430;
      }
      
      public function set rentOfferId(param1:int) : void
      {
         var_4430 = param1;
      }
      
      public function get availableForBuildersClub() : Boolean
      {
         return var_4319;
      }
      
      public function setData(param1:RoomWidgetFurniInfoUpdateEvent) : void
      {
         id = param1.id;
         category = param1.category;
         name = param1.name;
         description = param1.description;
         image = param1.image;
         purchaseOfferId = param1.purchaseOfferId;
         extraParam = param1.extraParam;
         stuffData = param1.stuffData;
         groupId = param1.groupId;
         ownerName = param1.ownerName;
         ownerId = param1.ownerId;
         rentOfferId = param1.rentOfferId;
         var_4319 = param1.availableForBuildersClub;
      }
   }
}
