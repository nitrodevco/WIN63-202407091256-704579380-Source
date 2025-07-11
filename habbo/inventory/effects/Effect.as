package com.sulake.habbo.inventory.effects
{
   import com.sulake.habbo.avatar.class_3600;
   import com.sulake.habbo.inventory.IThumbListDrawableItem;
   import com.sulake.habbo.inventory.class_3358;
   import com.sulake.habbo.ui.widget.memenu.class_3522;
   import flash.display.BitmapData;
   
   public class Effect implements class_3522, IThumbListDrawableItem, class_3600, class_3358
   {
       
      
      private var var_329:int;
      
      private var var_622:int;
      
      private var var_377:int;
      
      private var var_2704:int = 1;
      
      private var var_3357:int;
      
      private var var_927:Boolean = false;
      
      private var var_2341:Boolean = false;
      
      private var var_3588:Boolean = false;
      
      private var var_3703:Boolean = false;
      
      private var var_2298:BitmapData;
      
      private var var_4866:Date;
      
      public function Effect()
      {
         super();
      }
      
      public function get type() : int
      {
         return var_329;
      }
      
      public function get subType() : int
      {
         return var_622;
      }
      
      public function get duration() : int
      {
         return var_377;
      }
      
      public function get amountInInventory() : int
      {
         return var_2704;
      }
      
      public function get isPermanent() : Boolean
      {
         return var_927;
      }
      
      public function get isActive() : Boolean
      {
         return var_2341;
      }
      
      public function get isInUse() : Boolean
      {
         return var_3703;
      }
      
      public function get isSelected() : Boolean
      {
         return var_3588;
      }
      
      public function get icon() : BitmapData
      {
         return var_2298;
      }
      
      public function get iconImage() : BitmapData
      {
         return var_2298;
      }
      
      public function get secondsLeft() : int
      {
         var _loc1_:int = 0;
         if(var_2341)
         {
            _loc1_ = var_3357 - (new Date().valueOf() - var_4866.valueOf()) / 1000;
            _loc1_ = Math.floor(_loc1_);
            if(_loc1_ < 0)
            {
               _loc1_ = 0;
            }
            return _loc1_;
         }
         return var_3357;
      }
      
      public function set type(param1:int) : void
      {
         var_329 = param1;
      }
      
      public function set subType(param1:int) : void
      {
         var_622 = param1;
      }
      
      public function set duration(param1:int) : void
      {
         var_377 = param1;
      }
      
      public function set secondsLeft(param1:int) : void
      {
         var_3357 = param1;
      }
      
      public function set isPermanent(param1:Boolean) : void
      {
         var_927 = param1;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         var_3588 = param1;
      }
      
      public function set isInUse(param1:Boolean) : void
      {
         var_3703 = param1;
      }
      
      public function set iconImage(param1:BitmapData) : void
      {
         var_2298 = param1;
      }
      
      public function set amountInInventory(param1:int) : void
      {
         var_2704 = param1;
      }
      
      public function set isActive(param1:Boolean) : void
      {
         if(param1 && !var_2341)
         {
            var_4866 = new Date();
         }
         var_2341 = param1;
      }
      
      public function setOneEffectExpired() : void
      {
         var_2704--;
         if(var_2704 < 0)
         {
            var_2704 = 0;
         }
         var_3357 = var_377;
         var_2341 = false;
         var_3703 = false;
      }
   }
}
