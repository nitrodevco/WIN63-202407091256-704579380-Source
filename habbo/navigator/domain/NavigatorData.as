package com.sulake.habbo.navigator.domain
{
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1653;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1656;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1662;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1663;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1665;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1675;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1680;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1691;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1727;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1735;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1742;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1751;
   import com.sulake.habbo.communication.messages.parser.navigator.FavouritesEventParser;
   import com.sulake.habbo.navigator.*;
   import com.sulake.habbo.navigator.roomsettings.class_3637;
   import flash.utils.Dictionary;
   import package_12.*;
   import package_135.*;
   import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageEventParser;

   public class NavigatorData
   {

      private static const MAX_HISTORY_LENGTH:int = 10;

      private var _navigator:HabboNavigator;

      private var _lastMsg:class_1662;

      private var var_2697:class_1680;

      private var var_4782:Boolean;

      private var var_3960:Boolean;

      private var var_2586:Boolean;

      private var var_1632:int;

      private var var_894:int;

      private var _enteredGuestRoom:class_1675;

      private var var_4766:Boolean;

      private var var_4709:int;

      private var _hotRoomPopupOpen:Boolean;

      private var var_964:int;

      private var var_4281:Boolean;

      private var var_2972:Array;

      private var var_3541:Array;

      private var var_3530:Array;

      private var var_3494:Array;

      private var var_4910:int;

      private var var_3716:int;

      private var var_3017:Dictionary;

      private var var_2404:Boolean;

      private var var_4662:int;

      private var var_1557:Boolean;

      private var var_4654:Boolean;

      private var var_4594:int = 0;

      private var var_1370:class_1653;

      private var _promotedRooms:class_1691;

      private var _friendList:class_3637;

      private var var_3605:RoomSessionTags;

      private var var_4658:class_1665;

      public function NavigatorData(param1:HabboNavigator)
      {
         var_2972 = [];
         var_3541 = [];
         var_3530 = [];
         var_3494 = [];
         var_3017 = new Dictionary();
         _friendList = new class_3637();
         super();
         _navigator = param1;
      }

      public function get canAddFavourite():Boolean
      {
         return _enteredGuestRoom != null && !var_2586;
      }

      public function get canEditRoomSettings():Boolean
      {
         return _enteredGuestRoom != null && (var_2586 || _navigator.sessionData.hasSecurity(5));
      }

      public function onRoomEnter(param1:RoomEntryInfoMessageEventParser):void
      {
         _enteredGuestRoom = null;
         var_2586 = false;
         var_2586 = param1.owner;
         var_1632 = param1.guestRoomId;
      }

      public function onRoomExit():void
      {
         if (var_2697 != null)
         {
            var_2697.dispose();
            var_2697 = null;
         }
         if (_enteredGuestRoom != null)
         {
            _enteredGuestRoom.dispose();
            _enteredGuestRoom = null;
         }
         var_2586 = false;
      }

      public function set enteredRoom(param1:class_1675):void
      {
         if (_enteredGuestRoom != null)
         {
            _enteredGuestRoom.dispose();
         }
         _enteredGuestRoom = param1;
      }

      public function set roomEventData(param1:class_1680):void
      {
         if (var_2697 != null)
         {
            var_2697.dispose();
         }
         var_2697 = param1;
      }

      public function get popularTagsArrived():Boolean
      {
         return _lastMsg != null && _lastMsg as class_1727 != null;
      }

      public function get guestRoomSearchArrived():Boolean
      {
         return _lastMsg != null && _lastMsg as class_1742 != null;
      }

      public function get officialRoomsArrived():Boolean
      {
         return _lastMsg != null && _lastMsg as class_1663 != null;
      }

      public function get categoriesWithUserCountArrived():Boolean
      {
         return _lastMsg != null && _lastMsg as class_1751 != null;
      }

      public function set guestRoomSearchResults(param1:class_1742):void
      {
         disposeCurrentMsg();
         _lastMsg = param1;
         var_1370 = param1.ad;
         var_2404 = false;
      }

      public function set popularTags(param1:class_1727):void
      {
         disposeCurrentMsg();
         _lastMsg = param1;
         var_2404 = false;
      }

      public function set officialRooms(param1:class_1663):void
      {
         disposeCurrentMsg();
         _lastMsg = param1;
         var_2404 = false;
      }

      public function set categoriesWithVisitorData(param1:class_1751):void
      {
         disposeCurrentMsg();
         _lastMsg = param1;
         var_2404 = false;
      }

      private function disposeCurrentMsg():void
      {
         if (_lastMsg == null)
         {
            return;
         }
         _lastMsg.dispose();
         _lastMsg = null;
      }

      public function set adRoom(param1:class_1653):void
      {
         var_1370 = param1;
      }

      public function set promotedRooms(param1:class_1691):void
      {
         _promotedRooms = param1;
      }

      public function get adRoom():class_1653
      {
         return var_1370;
      }

      public function get guestRoomSearchResults():class_1742
      {
         return _lastMsg as class_1742;
      }

      public function get popularTags():class_1727
      {
         return _lastMsg as class_1727;
      }

      public function get officialRooms():class_1663
      {
         return _lastMsg as class_1663;
      }

      public function get categoriesWithVisitorData():class_1751
      {
         return _lastMsg as class_1751;
      }

      public function get promotedRooms():class_1691
      {
         return _promotedRooms;
      }

      public function get roomEventData():class_1680
      {
         return var_2697;
      }

      public function get avatarId():int
      {
         return var_894;
      }

      public function get eventMod():Boolean
      {
         return var_4782;
      }

      public function get roomPicker():Boolean
      {
         return var_3960;
      }

      public function get currentRoomOwner():Boolean
      {
         return var_2586;
      }

      public function get enteredGuestRoom():class_1675
      {
         return _enteredGuestRoom;
      }

      public function get hcMember():Boolean
      {
         return var_4766;
      }

      public function get createdFlatId():int
      {
         return var_4709;
      }

      public function get homeRoomId():int
      {
         return var_964;
      }

      public function get hotRoomPopupOpen():Boolean
      {
         return _hotRoomPopupOpen;
      }

      public function get currentRoomRating():int
      {
         return var_4662;
      }

      public function get canRate():Boolean
      {
         return var_1557;
      }

      public function get settingsReceived():Boolean
      {
         return var_4281;
      }

      public function get adIndex():int
      {
         return var_4594;
      }

      public function get currentRoomIsStaffPick():Boolean
      {
         return var_4654;
      }

      public function get currentRoomId():int
      {
         return var_1632;
      }

      public function set avatarId(param1:int):void
      {
         var_894 = param1;
      }

      public function set createdFlatId(param1:int):void
      {
         var_4709 = param1;
      }

      public function set hcMember(param1:Boolean):void
      {
         var_4766 = param1;
      }

      public function set eventMod(param1:Boolean):void
      {
         var_4782 = param1;
      }

      public function set roomPicker(param1:Boolean):void
      {
         var_3960 = param1;
      }

      public function set hotRoomPopupOpen(param1:Boolean):void
      {
         _hotRoomPopupOpen = param1;
      }

      public function set homeRoomId(param1:int):void
      {
         var_964 = param1;
      }

      public function set currentRoomRating(param1:int):void
      {
         var_4662 = param1;
      }

      public function set canRate(param1:Boolean):void
      {
         var_1557 = param1;
      }

      public function set settingsReceived(param1:Boolean):void
      {
         var_4281 = param1;
      }

      public function set adIndex(param1:int):void
      {
         var_4594 = param1;
      }

      public function set currentRoomIsStaffPick(param1:Boolean):void
      {
         var_4654 = param1;
      }

      public function set categories(param1:Array):void
      {
         var_2972 = param1;
         var_3541 = [];
         for each (var _loc2_ in var_2972)
         {
            if (_loc2_.visible)
            {
               var_3541.push(_loc2_);
            }
         }
      }

      public function get allCategories():Array
      {
         return var_2972;
      }

      public function get visibleCategories():Array
      {
         return var_3541;
      }

      public function getCategoryById(param1:int):class_1735
      {
         for each (var _loc2_ in var_2972)
         {
            if (_loc2_.nodeId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }

      public function set eventCategories(param1:Array):void
      {
         var_3530 = param1;
         var_3494 = [];
         for each (var _loc2_ in var_3530)
         {
            if (_loc2_.visible)
            {
               var_3494.push(_loc2_);
            }
         }
      }

      public function get allEventCategories():Array
      {
         return var_3530;
      }

      public function get visibleEventCategories():Array
      {
         return var_3494;
      }

      public function getEventCategoryById(param1:int):class_1656
      {
         for each (var _loc2_ in var_2972)
         {
            if (_loc2_.categoryId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }

      public function onFavourites(param1:FavouritesEventParser):void
      {
         this.var_4910 = param1.limit;
         this.var_3716 = param1.favouriteRoomIds.length;
         this.var_3017 = new Dictionary();
         for each (var _loc2_ in param1.favouriteRoomIds)
         {
            this.var_3017[_loc2_] = "yes";
         }
      }

      public function favouriteChanged(param1:int, param2:Boolean):void
      {
         var_3017[param1] = param2 ? "yes" : null;
         var_3716 += param2 ? 1 : -1;
      }

      public function isCurrentRoomFavourite():Boolean
      {
         var _loc1_:int = _enteredGuestRoom.flatId;
         return var_3017[_loc1_] != null;
      }

      public function isCurrentRoomHome():Boolean
      {
         if (_enteredGuestRoom == null)
         {
            return false;
         }
         var _loc1_:int = _enteredGuestRoom.flatId;
         return this.var_964 == _loc1_;
      }

      public function isRoomFavourite(param1:int):Boolean
      {
         return var_3017[param1] != null;
      }

      public function isFavouritesFull():Boolean
      {
         return var_3716 >= var_4910;
      }

      public function isRoomHome(param1:int):Boolean
      {
         return param1 == var_964;
      }

      public function startLoading():void
      {
         this.var_2404 = true;
      }

      public function isLoading():Boolean
      {
         return this.var_2404;
      }

      public function get friendList():class_3637
      {
         return _friendList;
      }

      public function getAndResetSessionTags():RoomSessionTags
      {
         var _loc1_:RoomSessionTags = var_3605;
         var_3605 = null;
         return _loc1_;
      }

      public function set roomSessionTags(param1:RoomSessionTags):void
      {
         var_3605 = param1;
      }

      public function get competitionRoomsData():class_1665
      {
         return var_4658;
      }

      public function set competitionRoomsData(param1:class_1665):void
      {
         var_4658 = param1;
      }
   }
}
