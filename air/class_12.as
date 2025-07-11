package com.sulake.air
{
    import assets.class_14

    import com.sulake.habbo.utils.IEncryptedLocalStorage;
   import flash.data.EncryptedLocalStore;
   import flash.utils.ByteArray;
   
   public class class_12 implements IEncryptedLocalStorage
   {
       
      
      public function class_12()
      {
         super();
      }
      
      public static function isSupported() : Boolean
      {
         try
         {
            return EncryptedLocalStore.isSupported;
         }
         catch(e:Error)
         {
            var _loc3_:Boolean = false;
         }
         return _loc3_;
      }
      
      public function reset() : void
      {
         if(EncryptedLocalStore.isSupported)
         {
            try
            {
               EncryptedLocalStore.reset();
            }
            catch(e:Error)
            {
               class_14.log("Error resetting the EncryptedLocalStore: " + e.toString());
            }
         }
      }
      
      public function storeString(param1:String, param2:String) : Boolean
      {
         var _loc3_:ByteArray = null;
         try
         {
            if(EncryptedLocalStore.isSupported)
            {
               _loc3_ = new ByteArray();
               if(param2 != null)
               {
                  _loc3_.writeUTF(param2);
               }
               EncryptedLocalStore.setItem(param1,_loc3_);
               return true;
            }
            return false;
         }
         catch(e:Error)
         {
            class_14.log("Error storing to the EncryptedLocalStore with key " + param1 + " and value " + param2 + ", error: " + e.toString());
            var _loc7_:Boolean = false;
         }
         return _loc7_;
      }
      
      public function restoreString(param1:String) : String
      {
         var _loc2_:ByteArray = null;
         try
         {
            if(EncryptedLocalStore.isSupported)
            {
               _loc2_ = EncryptedLocalStore.getItem(param1);
               if(_loc2_)
               {
                  return _loc2_.readUTF();
               }
            }
            return null;
         }
         catch(e:Error)
         {
            class_14.log("Error restoring from the EncryptedLocalStore with key " + param1 + ", error: " + e.toString());
            var _loc6_:* = null;
         }
         return _loc6_;
      }
   }
}
