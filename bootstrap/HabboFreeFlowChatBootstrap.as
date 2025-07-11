package com.sulake.bootstrap
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.IContext;
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   
   public class HabboFreeFlowChatBootstrap extends HabboFreeFlowChat
   {
       
      
      public function HabboFreeFlowChatBootstrap(param1:IContext, param2:uint, param3:IAssetLibrary)
      {
         super(param1,param2,param3);
      }
   }
}
