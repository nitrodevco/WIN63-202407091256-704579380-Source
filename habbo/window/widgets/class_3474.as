package com.sulake.habbo.window.widgets
{
   import flash.utils.Dictionary;
   
   public class class_3474
   {
      
      public static var var_1728:Dictionary = new Dictionary();
      
      public static var WIDGET_TYPES:Array = [];
      
      private static var key:String;
      
      {
         var_1728["avatar_image"] = AvatarImageWidget;
         var_1728["badge_image"] = BadgeImageWidget;
         var_1728["balloon"] = BalloonWidget;
         var_1728["countdown"] = CountdownWidget;
         var_1728["hover_bitmap"] = HoverBitmapWidget;
         var_1728["illumina_border"] = IlluminaBorderWidget;
         var_1728["illumina_chat_bubble"] = IlluminaChatBubbleWidget;
         var_1728["illumina_input"] = IlluminaInputWidget;
         var_1728["progress_indicator"] = ProgressIndicatorWidget;
         var_1728["limited_item_overlay_grid"] = LimitedItemGridOverlayWidget;
         var_1728["limited_item_overlay_preview"] = LimitedItemPreviewOverlayWidget;
         var_1728["limited_item_overlay_supply"] = LimitedItemSupplyLeftOverlayWidget;
         var_1728["rarity_item_overlay_grid"] = RarityItemGridOverlayWidget;
         var_1728["rarity_item_overlay_preview"] = RarityItemPreviewOverlayWidget;
         var_1728["separator"] = SeparatorWidget;
         var_1728["updating_timestamp"] = UpdatingTimeStampWidget;
         var_1728["running_number"] = RunningNumberWidget;
         var_1728["pet_image"] = PetImageWidget;
         var_1728["furniture_image"] = FurnitureImageWidget;
         var_1728["room_previewer"] = RoomPreviewerWidget;
         var_1728["pixel_limit"] = PixelLimitWidget;
         var_1728["room_thumbnail"] = RoomThumbnailWidget;
         var_1728["room_user_count"] = RoomUserCountWidget;
         for(key in var_1728)
         {
            WIDGET_TYPES.push(key);
         }
         WIDGET_TYPES.sort();
      }
      
      public function class_3474()
      {
         super();
      }
   }
}
