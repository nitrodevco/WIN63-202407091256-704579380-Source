package com.sulake.habbo.avatar
{
    import assets.class_14

    import com.sulake.habbo.avatar.actions.class_3576;
   import com.sulake.habbo.avatar.structure.animation.AnimationFrame;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import flash.geom.ColorTransform;
   
   public class AvatarImagePartContainer
   {
       
      
      private var var_4100:String;
      
      private var var_3796:String;
      
      private var var_4436:String;
      
      private var var_1482:String;
      
      private var _color:IPartColor;
      
      private var var_1862:Array;
      
      private var _action:class_3576;
      
      private var var_3248:Boolean;
      
      private var var_4686:Boolean;
      
      private var var_4351:ColorTransform;
      
      private var var_4569:int;
      
      public function AvatarImagePartContainer(param1:String, param2:String, param3:String, param4:IPartColor, param5:Array, param6:class_3576, param7:Boolean, param8:int, param9:String = "", param10:Boolean = false, param11:Number = 1)
      {
         super();
         var_4100 = param1;
         var_3796 = param2;
         var_1482 = param3;
         _color = param4;
         var_1862 = param5;
         _action = param6;
         var_3248 = param7;
         var_4569 = param8;
         var_4436 = param9;
         var_4686 = param10;
         var_4351 = new ColorTransform(1,1,1,param11);
         if(var_1862 == null)
         {
            class_14.log("Null frame list");
         }
         if(var_3796 == "ey")
         {
            var_3248 = false;
         }
      }
      
      public function getFrameIndex(param1:int) : int
      {
         var _loc3_:AnimationFrame = null;
         if(!var_1862 || var_1862.length == 0)
         {
            return 0;
         }
         var _loc2_:int = param1 % var_1862.length;
         if(var_1862[_loc2_] is AnimationFrame)
         {
            _loc3_ = var_1862[_loc2_];
            return _loc3_.number;
         }
         return _loc2_;
      }
      
      public function getFrameDefinition(param1:int) : AnimationFrame
      {
         var _loc2_:int = param1 % var_1862.length;
         if(var_1862 && var_1862.length > _loc2_)
         {
            if(var_1862[_loc2_] is AnimationFrame)
            {
               return var_1862[_loc2_] as AnimationFrame;
            }
         }
         return null;
      }
      
      public function getCacheableKey(param1:int) : String
      {
         var _loc3_:AnimationFrame = null;
         var _loc2_:int = param1 % var_1862.length;
         if(var_1862 && var_1862.length > _loc2_)
         {
            if(var_1862[_loc2_] is AnimationFrame)
            {
               _loc3_ = var_1862[_loc2_] as AnimationFrame;
               return partId + ":" + _loc3_.assetPartDefinition + ":" + _loc3_.number;
            }
         }
         return partId + ":" + _loc2_;
      }
      
      public function get bodyPartId() : String
      {
         return var_4100;
      }
      
      public function get partType() : String
      {
         return var_3796;
      }
      
      public function get partId() : String
      {
         return var_1482;
      }
      
      public function get color() : IPartColor
      {
         return _color;
      }
      
      public function get action() : class_3576
      {
         return _action;
      }
      
      public function set isColorable(param1:Boolean) : void
      {
         var_3248 = param1;
      }
      
      public function get isColorable() : Boolean
      {
         return var_3248;
      }
      
      public function get paletteMapId() : int
      {
         return var_4569;
      }
      
      public function get flippedPartType() : String
      {
         return var_4436;
      }
      
      public function get isBlendable() : Boolean
      {
         return var_4686;
      }
      
      public function get blendTransform() : ColorTransform
      {
         return var_4351;
      }
      
      public function toString() : String
      {
         return [var_4100,var_3796,var_1482].join(":");
      }
   }
}
