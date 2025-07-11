package com.sulake.habbo.avatar.geometry
{
    import assets.class_14

    import com.sulake.habbo.avatar.class_3374;
   import com.sulake.habbo.avatar.structure.AvatarCanvas;
   import flash.utils.Dictionary;
   
   public class AvatarModelGeometry
   {
       
      
      private var var_4073:AvatarSet;
      
      private var var_2930:Dictionary;
      
      private var var_4032:Dictionary;
      
      private var var_2986:Matrix4x4;
      
      private var _camera:Vector3D;
      
      private var var_1845:Dictionary;
      
      public function AvatarModelGeometry(param1:XML)
      {
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc2_:* = null;
         var _loc10_:* = null;
         var _loc11_:AvatarCanvas = null;
         var _loc6_:String = null;
         var _loc4_:Dictionary = null;
         var _loc15_:* = null;
         var _loc7_:Dictionary = null;
         var _loc5_:Dictionary = null;
         var _loc3_:* = null;
         var _loc9_:GeometryBodyPart = null;
         _camera = new Vector3D(0,0,10);
         super();
         var_2986 = new Matrix4x4();
         var_2930 = new Dictionary();
         var_4032 = new Dictionary();
         var_4073 = new AvatarSet(param1.avatarset[0]);
         var_1845 = new Dictionary();
         var _loc8_:XML;
         if((_loc8_ = param1.camera[0]) != null)
         {
            _loc12_ = parseFloat(_loc8_.x.text());
            _loc13_ = parseFloat(_loc8_.y.text());
            _loc14_ = parseFloat(_loc8_.z.text());
            _camera.x = _loc12_;
            _camera.y = _loc13_;
            _camera.z = _loc14_;
         }
         for each(_loc2_ in param1.canvas)
         {
            _loc6_ = String(_loc2_.@scale);
            _loc4_ = new Dictionary();
            for each(_loc10_ in _loc2_.geometry)
            {
               _loc11_ = new AvatarCanvas(_loc10_,_loc6_);
               _loc4_[String(_loc10_.@id)] = _loc11_;
            }
            var_1845[_loc6_] = _loc4_;
         }
         for each(_loc15_ in param1.type)
         {
            _loc7_ = new Dictionary();
            _loc5_ = new Dictionary();
            for each(_loc3_ in _loc15_.bodypart)
            {
               _loc9_ = new GeometryBodyPart(_loc3_);
               _loc7_[String(_loc3_.@id)] = _loc9_;
               for each(var _loc16_ in _loc9_.getPartIds(null))
               {
                  _loc5_[_loc16_] = _loc9_;
               }
            }
            var_2930[String(_loc15_.@id)] = _loc7_;
            var_4032[String(_loc15_.@id)] = _loc5_;
         }
      }
      
      public function removeDynamicItems(param1:class_3374) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         for each(_loc2_ in var_2930)
         {
            for each(_loc3_ in _loc2_)
            {
               _loc3_.removeDynamicParts(param1);
            }
         }
      }
      
      public function getBodyPartIdsInAvatarSet(param1:String) : Array
      {
         var _loc3_:Array = [];
         var _loc2_:AvatarSet = var_4073.findAvatarSet(param1);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.getBodyParts();
         }
         return _loc3_;
      }
      
      public function isMainAvatarSet(param1:String) : Boolean
      {
         var _loc2_:AvatarSet = var_4073.findAvatarSet(param1);
         if(_loc2_ != null)
         {
            return _loc2_.isMain;
         }
         return false;
      }
      
      public function getCanvas(param1:String, param2:String) : AvatarCanvas
      {
         var _loc4_:AvatarCanvas = null;
         var _loc3_:Dictionary = var_1845[param1];
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_[param2] as AvatarCanvas;
         }
         return _loc4_;
      }
      
      private function typeExists(param1:String) : Boolean
      {
         return var_2930[param1] != null;
      }
      
      private function hasBodyPart(param1:String, param2:String) : Boolean
      {
         var _loc3_:Dictionary = null;
         if(typeExists(param1))
         {
            _loc3_ = var_2930[param1] as Dictionary;
            return _loc3_[param2] != null;
         }
         return false;
      }
      
      private function getBodyPartIDs(param1:String) : Array
      {
         var _loc4_:Dictionary = getBodyPartsOfType(param1);
         var _loc2_:Array = [];
         for(var _loc3_ in var_2930)
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      private function getBodyPartsOfType(param1:String) : Dictionary
      {
         if(typeExists(param1))
         {
            return var_2930[param1] as Dictionary;
         }
         return new Dictionary();
      }
      
      public function getBodyPart(param1:String, param2:String) : GeometryBodyPart
      {
         var _loc3_:Dictionary = getBodyPartsOfType(param1);
         return _loc3_[param2];
      }
      
      public function getBodyPartOfItem(param1:String, param2:String, param3:class_3374) : GeometryBodyPart
      {
         var _loc6_:GeometryBodyPart = null;
         var _loc5_:Dictionary = null;
         var _loc4_:Dictionary;
         if((_loc4_ = var_4032[param1]) != null)
         {
            if((_loc6_ = _loc4_[param2]) != null)
            {
               return _loc6_;
            }
            _loc5_ = getBodyPartsOfType(param1);
            for each(_loc6_ in _loc5_)
            {
               if(_loc6_.hasPart(param2,param3))
               {
                  return _loc6_;
               }
            }
         }
         return null;
      }
      
      private function getBodyPartsInAvatarSet(param1:Dictionary, param2:String) : Array
      {
         var _loc6_:GeometryBodyPart = null;
         var _loc4_:* = null;
         var _loc5_:Array = [];
         var _loc3_:Array = this.getBodyPartIdsInAvatarSet(param2);
         for each(_loc4_ in _loc3_)
         {
            if((_loc6_ = param1[_loc4_]) != null)
            {
               _loc5_.push(_loc6_);
            }
         }
         return _loc5_;
      }
      
      public function getBodyPartsAtAngle(param1:String, param2:uint, param3:String) : Array
      {
         var _loc10_:GeometryBodyPart = null;
         var _loc7_:Number = NaN;
         var _loc8_:* = null;
         if(param3 == null)
         {
            class_14.log("[AvatarModelGeometry] ERROR: Geometry ID not found for action: ");
            return [];
         }
         var _loc4_:Dictionary = getBodyPartsOfType(param3);
         var _loc6_:Array = getBodyPartsInAvatarSet(_loc4_,param1);
         var _loc9_:Array = [];
         var _loc5_:Array = [];
         var_2986 = Matrix4x4.getYRotationMatrix(param2);
         for each(_loc10_ in _loc6_)
         {
            _loc10_.applyTransform(var_2986);
            _loc7_ = _loc10_.getDistance(_camera);
            _loc9_.push([_loc7_,_loc10_]);
         }
         _loc9_.sort(orderByDistance);
         for each(_loc8_ in _loc9_)
         {
            _loc10_ = _loc8_[1] as GeometryBodyPart;
            _loc5_.push(_loc10_.id);
         }
         return _loc5_;
      }
      
      public function getParts(param1:String, param2:String, param3:uint, param4:Array, param5:class_3374) : Array
      {
         var _loc6_:GeometryBodyPart = null;
         if(hasBodyPart(param1,param2))
         {
            _loc6_ = getBodyPartsOfType(param1)[param2] as GeometryBodyPart;
            var_2986 = Matrix4x4.getYRotationMatrix(param3);
            return _loc6_.getParts(var_2986,_camera,param4,param5);
         }
         return [];
      }
      
      private function orderByDistance(param1:Array, param2:Array) : Number
      {
         var _loc3_:Number = param1[0] as Number;
         var _loc4_:Number = param2[0] as Number;
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         return 0;
      }
   }
}
