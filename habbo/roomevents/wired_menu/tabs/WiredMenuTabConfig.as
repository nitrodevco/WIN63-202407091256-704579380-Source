package com.sulake.habbo.roomevents.wired_menu.tabs
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   
   public class WiredMenuTabConfig
   {
       
      
      private var var_280:String;
      
      private var var_4049:Class;
      
      private var var_4712:Boolean;
      
      private var var_4491:Boolean;
      
      private var var_1479:Boolean;
      
      public function WiredMenuTabConfig(param1:String, param2:Class, param3:Boolean = true, param4:Boolean = true, param5:Boolean = true)
      {
         super();
         var_280 = param1;
         var_4049 = param2;
         var_4712 = param3;
         var_4491 = param4;
         var_1479 = param5;
      }
      
      public function get id() : String
      {
         return var_280;
      }
      
      public function get tabButtonName() : String
      {
         return "top_view_" + var_280 + "_button";
      }
      
      public function get containerName() : String
      {
         return var_280 + "_container";
      }
      
      public function get titleLocalizationKey() : String
      {
         return "wiredmenu." + var_280 + ".title";
      }
      
      public function createTab(param1:WiredMenuController, param2:IWindowContainer) : class_3627
      {
         return new var_4049(param1,param2);
      }
      
      public function get isCreateImmediately() : Boolean
      {
         return var_4712;
      }
      
      public function get isReusable() : Boolean
      {
         return var_4491;
      }
      
      public function get isEnabled() : Boolean
      {
         return var_1479;
      }
   }
}
