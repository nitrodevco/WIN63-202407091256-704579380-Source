package com.sulake.habbo.ui.widget.events
{
   import com.sulake.habbo.room.IStuffData;
   import flash.display.BitmapData;
   
   public class RoomWidgetFurniInfoUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const FURNI:String = "RWFIUE_FURNI";
       
      
      private var var_280:int = 0;
      
      private var var_638:int = 0;
      
      private var _name:String = "";
      
      private var var_363:String = "";
      
      private var var_859:BitmapData = null;
      
      private var var_801:Boolean = false;
      
      private var var_4828:Boolean = false;
      
      private var var_3421:Boolean = false;
      
      private var var_1518:int = 0;
      
      private var var_4530:Boolean = false;
      
      private var var_4814:int = -1;
      
      private var var_4991:int = -1;
      
      private var var_4357:int = -1;
      
      private var var_586:String = "";
      
      private var var_385:Boolean = false;
      
      private var var_1091:IStuffData = null;
      
      private var _groupId:int = 0;
      
      private var var_876:int = 0;
      
      private var _ownerName:String = "";
      
      private var var_1198:int = 0;
      
      private var var_4980:int = -1;
      
      private var var_4430:int = -1;
      
      private var _purchaseCouldBeUsedForBuyout:Boolean;
      
      private var _rentCouldBeUsedForBuyout:Boolean;
      
      private var var_4319:Boolean;
      
      private var var_4550:Boolean;
      
      public function RoomWidgetFurniInfoUpdateEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function set id(param1:int) : void
      {
         var_280 = param1;
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function set category(param1:int) : void
      {
         var_638 = param1;
      }
      
      public function get category() : int
      {
         return var_638;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set description(param1:String) : void
      {
         var_363 = param1;
      }
      
      public function get description() : String
      {
         return var_363;
      }
      
      public function set image(param1:BitmapData) : void
      {
         var_859 = param1;
      }
      
      public function get image() : BitmapData
      {
         return var_859;
      }
      
      public function set isWallItem(param1:Boolean) : void
      {
         var_801 = param1;
      }
      
      public function get isWallItem() : Boolean
      {
         return var_801;
      }
      
      public function set isStickie(param1:Boolean) : void
      {
         var_4828 = param1;
      }
      
      public function get isStickie() : Boolean
      {
         return var_4828;
      }
      
      public function set isRoomOwner(param1:Boolean) : void
      {
         var_3421 = param1;
      }
      
      public function get isRoomOwner() : Boolean
      {
         return var_3421;
      }
      
      public function set roomControllerLevel(param1:int) : void
      {
         var_1518 = param1;
      }
      
      public function get roomControllerLevel() : int
      {
         return var_1518;
      }
      
      public function set isAnyRoomController(param1:Boolean) : void
      {
         var_4530 = param1;
      }
      
      public function get isAnyRoomController() : Boolean
      {
         return var_4530;
      }
      
      public function set expiration(param1:int) : void
      {
         var_4814 = param1;
      }
      
      public function get expiration() : int
      {
         return var_4814;
      }
      
      public function set purchaseOfferId(param1:int) : void
      {
         var_4357 = param1;
      }
      
      public function get purchaseOfferId() : int
      {
         return var_4357;
      }
      
      public function set extraParam(param1:String) : void
      {
         var_586 = param1;
      }
      
      public function get extraParam() : String
      {
         return var_586;
      }
      
      public function set isOwner(param1:Boolean) : void
      {
         var_385 = param1;
      }
      
      public function get isOwner() : Boolean
      {
         return var_385;
      }
      
      public function set stuffData(param1:IStuffData) : void
      {
         var_1091 = param1;
      }
      
      public function get stuffData() : IStuffData
      {
         return var_1091;
      }
      
      public function set groupId(param1:int) : void
      {
         _groupId = param1;
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function set ownerId(param1:int) : void
      {
         var_876 = param1;
      }
      
      public function get ownerId() : int
      {
         return var_876;
      }
      
      public function set ownerName(param1:String) : void
      {
         _ownerName = param1;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function set usagePolicy(param1:int) : void
      {
         var_1198 = param1;
      }
      
      public function get usagePolicy() : int
      {
         return var_1198;
      }
      
      public function set rentOfferId(param1:int) : void
      {
         var_4430 = param1;
      }
      
      public function get rentOfferId() : int
      {
         return var_4430;
      }
      
      public function get purchaseCouldBeUsedForBuyout() : Boolean
      {
         return _purchaseCouldBeUsedForBuyout;
      }
      
      public function set purchaseCouldBeUsedForBuyout(param1:Boolean) : void
      {
         _purchaseCouldBeUsedForBuyout = param1;
      }
      
      public function get rentCouldBeUsedForBuyout() : Boolean
      {
         return _rentCouldBeUsedForBuyout;
      }
      
      public function set rentCouldBeUsedForBuyout(param1:Boolean) : void
      {
         _rentCouldBeUsedForBuyout = param1;
      }
      
      public function get availableForBuildersClub() : Boolean
      {
         return var_4319;
      }
      
      public function set availableForBuildersClub(param1:Boolean) : void
      {
         var_4319 = param1;
      }
      
      public function get isNft() : Boolean
      {
         return var_4550;
      }
      
      public function set isNft(param1:Boolean) : void
      {
         var_4550 = param1;
      }
   }
}
