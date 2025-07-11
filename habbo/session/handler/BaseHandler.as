package com.sulake.habbo.session.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.habbo.session.IRoomHandlerListener;
   
   public class BaseHandler implements IDisposable
   {
       
      
      private var var_26:IConnection;
      
      private var var_85:IRoomHandlerListener;
      
      private var _disposed:Boolean = false;
      
      public var var_1662:int;
      
      public function BaseHandler(param1:IConnection, param2:IRoomHandlerListener)
      {
         super();
         var_26 = param1;
         var_85 = param2;
      }
      
      public function dispose() : void
      {
         var_26 = null;
         var_85 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get connection() : IConnection
      {
         return var_26;
      }
      
      public function get listener() : IRoomHandlerListener
      {
         return var_85;
      }
   }
}
