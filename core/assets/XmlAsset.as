package com.sulake.core.assets
{
   import flash.system.System;
   import flash.utils.ByteArray;
   
   public class XmlAsset implements ILazyAsset
   {
       
      
      private var _disposed:Boolean = false;
      
      private var var_17:Object;
      
      private var _content:XML;
      
      private var _decl:AssetTypeDeclaration;
      
      private var var_96:String;
      
      public function XmlAsset(param1:AssetTypeDeclaration, param2:String = null)
      {
         super();
         _decl = param1;
         var_96 = param2;
      }
      
      public function get url() : String
      {
         return var_96;
      }
      
      public function get content() : Object
      {
         if(!_content)
         {
            prepareLazyContent();
         }
         return _content;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get declaration() : AssetTypeDeclaration
      {
         return _decl;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _disposed = true;
            System.disposeXML(_content);
            _content = null;
            var_17 = null;
            _decl = null;
            var_96 = null;
         }
      }
      
      public function setUnknownContent(param1:Object) : void
      {
         _content = null;
         var_17 = param1;
      }
      
      public function prepareLazyContent() : void
      {
         var _loc1_:ByteArray = null;
         if(var_17 is Class)
         {
            _loc1_ = new (var_17 as Class)() as ByteArray;
            _content = new XML(_loc1_.readUTFBytes(_loc1_.length));
            return;
         }
         if(var_17 is ByteArray)
         {
            _loc1_ = var_17 as ByteArray;
            _content = new XML(_loc1_.readUTFBytes(_loc1_.length));
            return;
         }
         if(var_17 is String)
         {
            _content = new XML(var_17 as String);
            return;
         }
         if(var_17 is XML)
         {
            _content = var_17 as XML;
            return;
         }
         if(var_17 is XmlAsset)
         {
            _content = XmlAsset(var_17)._content;
            return;
         }
      }
      
      public function setFromOtherAsset(param1:IAsset) : void
      {
         if(param1 is XmlAsset)
         {
            _content = XmlAsset(param1)._content;
            return;
         }
         throw Error("Provided asset is not of type XmlAsset!");
      }
      
      public function setParamsDesc(param1:XMLList) : void
      {
      }
      
      public function toString() : String
      {
         var _loc1_:String = "XmlAsset";
         _loc1_ += " _url:" + var_96;
         _loc1_ += " _content:" + _content;
         return _loc1_ + (" _unknown:" + var_17);
      }
   }
}
