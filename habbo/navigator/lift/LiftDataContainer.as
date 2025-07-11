package com.sulake.habbo.navigator.lift
{
   import com.sulake.habbo.navigator.HabboNewNavigator;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.class_1695;
   
   public class LiftDataContainer
   {
      
      private static const DEFAULT_IMAGE:String = "${image.library.url}officialrooms_hq/nav_teaser_wl.png";
       
      
      private var _navigator:HabboNewNavigator;
      
      private var _liftedRooms:Vector.<class_1695>;
      
      public function LiftDataContainer(param1:HabboNewNavigator)
      {
         _liftedRooms = new Vector.<class_1695>(0);
         super();
         _navigator = param1;
      }
      
      public function setLiftedRooms(param1:Vector.<class_1695>) : void
      {
         _liftedRooms = param1;
      }
      
      public function get liftedRooms() : Vector.<class_1695>
      {
         return _liftedRooms;
      }
      
      public function getUrlForLiftImageAtIndex(param1:int) : String
      {
         if(param1 < 0 || param1 > _liftedRooms.length - 1)
         {
            return "";
         }
         if(_liftedRooms[param1].image == "")
         {
            return "${image.library.url}officialrooms_hq/nav_teaser_wl.png";
         }
         return _navigator.imageLibraryBaseUrl + _liftedRooms[param1].image;
      }
   }
}
