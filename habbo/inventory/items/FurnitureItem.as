package com.sulake.habbo.inventory.items
{
   import com.sulake.habbo.room.IStuffData;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.class_1703;
   
   public class FurnitureItem implements class_3393
   {
       
      
      private var var_1234:int;
      
      private var var_801:Boolean;
      
      private var var_606:int;
      
      private var var_173:Boolean;
      
      private var var_280:int;
      
      private var var_3671:int;
      
      private var var_638:int;
      
      private var var_329:int;
      
      private var var_1091:IStuffData;
      
      private var var_724:Number;
      
      private var var_3925:Boolean;
      
      private var var_3705:Boolean;
      
      private var var_3894:Boolean;
      
      private var var_988:Boolean;
      
      private var var_583:int;
      
      private var var_1097:Boolean;
      
      private var var_1362:int;
      
      private var _creationMonth:int;
      
      private var var_1042:int;
      
      private var var_888:String;
      
      private var var_540:Boolean;
      
      private var _flatId:int;
      
      public function FurnitureItem(param1:class_1703)
      {
         super();
         var_280 = param1.itemId;
         var_329 = param1.itemTypeId;
         var_3671 = param1.roomItemId;
         var_638 = param1.category;
         var_3894 = param1.isGroupable && !param1.isRented;
         var_3705 = param1.isTradeable;
         var_3925 = param1.isRecyclable;
         var_988 = param1.isSellable;
         var_1091 = param1.stuffData;
         var_724 = param1.extra;
         var_583 = param1.secondsToExpiration;
         var_1234 = param1.expirationTimeStamp;
         var_1097 = param1.hasRentPeriodStarted;
         var_1362 = param1.creationDay;
         _creationMonth = param1.creationMonth;
         var_1042 = param1.creationYear;
         var_888 = param1.slotId;
         var_606 = param1.songId;
         _flatId = param1.flatId;
         var_540 = param1.isRented;
         var_801 = param1.isWallItem;
      }
      
      public function get isRented() : Boolean
      {
         return var_540;
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function get ref() : int
      {
         return var_3671;
      }
      
      public function get category() : int
      {
         return var_638;
      }
      
      public function get type() : int
      {
         return var_329;
      }
      
      public function get stuffData() : IStuffData
      {
         return var_1091;
      }
      
      public function set stuffData(param1:IStuffData) : void
      {
         var_1091 = param1;
      }
      
      public function get extra() : Number
      {
         return var_724;
      }
      
      public function get recyclable() : Boolean
      {
         return var_3925;
      }
      
      public function get tradeable() : Boolean
      {
         return var_3705;
      }
      
      public function get groupable() : Boolean
      {
         return var_3894;
      }
      
      public function get sellable() : Boolean
      {
         return var_988;
      }
      
      public function get secondsToExpiration() : int
      {
         if(var_583 == -1)
         {
            return -1;
         }
         var _loc1_:int = -1;
         if(var_1097)
         {
            _loc1_ = var_583 - (getTimer() - var_1234) / 1000;
            if(_loc1_ < 0)
            {
               _loc1_ = 0;
            }
         }
         else
         {
            _loc1_ = var_583;
         }
         return _loc1_;
      }
      
      public function get creationDay() : int
      {
         return var_1362;
      }
      
      public function get creationMonth() : int
      {
         return _creationMonth;
      }
      
      public function get creationYear() : int
      {
         return var_1042;
      }
      
      public function get slotId() : String
      {
         return var_888;
      }
      
      public function get songId() : int
      {
         return var_606;
      }
      
      public function get locked() : Boolean
      {
         return var_173;
      }
      
      public function set locked(param1:Boolean) : void
      {
         var_173 = param1;
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function get isWallItem() : Boolean
      {
         return var_801;
      }
      
      public function get hasRentPeriodStarted() : Boolean
      {
         return var_1097;
      }
      
      public function get expirationTimeStamp() : int
      {
         return var_1234;
      }
      
      public function update(param1:class_1703) : void
      {
         var_329 = param1.itemTypeId;
         var_3671 = param1.roomItemId;
         var_638 = param1.category;
         var_3894 = param1.isGroupable && !param1.isRented;
         var_3705 = param1.isTradeable;
         var_3925 = param1.isRecyclable;
         var_988 = param1.isSellable;
         var_1091 = param1.stuffData;
         var_724 = param1.extra;
         var_583 = param1.secondsToExpiration;
         var_1234 = param1.expirationTimeStamp;
         var_1097 = param1.hasRentPeriodStarted;
         var_1362 = param1.creationDay;
         _creationMonth = param1.creationMonth;
         var_1042 = param1.creationYear;
         var_888 = param1.slotId;
         var_606 = param1.songId;
         _flatId = param1.flatId;
         var_540 = param1.isRented;
         var_801 = param1.isWallItem;
      }
   }
}
