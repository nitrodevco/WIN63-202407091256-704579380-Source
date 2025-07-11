package com.sulake.habbo.communication.encryption
{
   import com.hurlant.math.BigInteger;
   import com.sulake.core.communication.handshake.class_42;
   
   public class DiffieHellman implements class_42
   {
       
      
      private var _privateKey:BigInteger;
      
      private var _publicKey:BigInteger;
      
      private var _serverPublicKey:BigInteger;
      
      private var _sharedKey:BigInteger;
      
      private var _prime:BigInteger;
      
      private var var_1510:BigInteger;
      
      private var _minimumPublicKey:BigInteger;
      
      private var var_1240:BigInteger;
      
      public function DiffieHellman(param1:BigInteger, param2:BigInteger)
      {
         _minimumPublicKey = BigInteger.nbv(2);
         var_1240 = BigInteger.nbv(2);
         super();
         _prime = param1;
         var_1510 = param2;
      }
      
      public function init(param1:String, param2:uint = 16) : Boolean
      {
         _privateKey = new BigInteger();
         _privateKey.fromRadix(param1,param2);
         _publicKey = var_1510.modPow(_privateKey,_prime);
         return true;
      }
      
      public function generateSharedKey(param1:String, param2:uint = 16) : String
      {
         _serverPublicKey = new BigInteger();
         _serverPublicKey.fromRadix(param1,param2);
         _sharedKey = _serverPublicKey.modPow(_privateKey,_prime);
         return getSharedKey(param2);
      }
      
      public function getPublicKey(param1:uint = 16) : String
      {
         return _publicKey.toRadix(param1);
      }
      
      public function getSharedKey(param1:uint = 16) : String
      {
         return _sharedKey.toRadix(param1);
      }
      
      public function isValidServerPublicKey() : Boolean
      {
         return _serverPublicKey.compareTo(_minimumPublicKey) >= 0;
      }
      
      public function isValidSharedKey() : Boolean
      {
         return _sharedKey.compareTo(var_1240) >= 0;
      }
   }
}
