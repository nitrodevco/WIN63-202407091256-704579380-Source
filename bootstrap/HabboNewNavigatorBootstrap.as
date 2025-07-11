package com.sulake.bootstrap
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.IContext;
   import com.sulake.habbo.navigator.HabboNewNavigator;
   
   public class HabboNewNavigatorBootstrap extends HabboNewNavigator
   {
       
      
      public function HabboNewNavigatorBootstrap(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         super(param1,param2,param3);
      }
   }
}
