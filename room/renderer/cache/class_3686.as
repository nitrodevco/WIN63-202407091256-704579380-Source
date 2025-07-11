package com.sulake.room.renderer.cache
{
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   [SecureSWF(rename="true")]
   public class class_3686
   {
       
      
      private var var_4416:String = "";
      
      private var var_3848:int = -1;
      
      private var var_4488:int = -1;
      
      private var var_3581:Vector3d;
      
      private var var_2143:Vector3d = null;
      
      private var var_4867:Boolean = false;
      
      public function class_3686(param1:String)
      {
         var_3581 = new Vector3d();
         super();
         var_4416 = param1;
         var_2143 = new Vector3d();
      }
      
      public function get locationChanged() : Boolean
      {
         return var_4867;
      }
      
      public function dispose() : void
      {
         var_2143 = null;
      }
      
      public function getScreenLocation(param1:IRoomObject, param2:IRoomGeometry) : IVector3d
      {
         var _loc8_:IVector3d = null;
         var _loc3_:Number = NaN;
         var _loc4_:Vector3d = null;
         var _loc6_:IVector3d = null;
         if(param1 == null || param2 == null)
         {
            return null;
         }
         var _loc5_:Boolean = false;
         var _loc7_:IVector3d = param1.getLocation();
         if(param2.updateId != var_3848 || param1.getUpdateID() != var_4488)
         {
            var_4488 = param1.getUpdateID();
            if(param2.updateId != var_3848 || _loc7_.x != var_3581.x || _loc7_.y != var_3581.y || _loc7_.z != var_3581.z)
            {
               var_3848 = param2.updateId;
               var_3581.assign(_loc7_);
               _loc5_ = true;
            }
         }
         var_4867 = _loc5_;
         if(_loc5_)
         {
            if((_loc8_ = param2.getScreenPosition(_loc7_)) == null)
            {
               return null;
            }
            _loc3_ = Number(param1.getModel().getNumber(var_4416));
            if(isNaN(_loc3_) || _loc3_ == 0)
            {
               if((_loc4_ = new Vector3d(Math.round(_loc7_.x),Math.round(_loc7_.y),_loc7_.z)).x != _loc7_.x || _loc4_.y != _loc7_.y)
               {
                  _loc6_ = param2.getScreenPosition(_loc4_);
                  var_2143.assign(_loc8_);
                  if(_loc6_ != null)
                  {
                     var_2143.z = _loc6_.z;
                  }
               }
               else
               {
                  var_2143.assign(_loc8_);
               }
            }
            else
            {
               var_2143.assign(_loc8_);
            }
            var_2143.x = Math.round(var_2143.x);
            var_2143.y = Math.round(var_2143.y);
         }
         return var_2143;
      }
   }
}
