package com.sulake.habbo.friendlist
{
   import com.sulake.core.window.IWindowContainer;
   import flash.events.Event;
   import flash.utils.Timer;
   
   public class OpenedToWebPopup
   {
       
      
      private var _friendList:HabboFriendList;
      
      private var var_2127:IWindowContainer;
      
      private var var_1883:Timer;
      
      public function OpenedToWebPopup(param1:HabboFriendList)
      {
         super();
         _friendList = param1;
      }
      
      public function show(param1:int, param2:int) : void
      {
         if(var_2127 != null)
         {
            close(null);
         }
         var_2127 = getOpenedToWebAlert();
         if(var_1883 != null)
         {
            var_1883.stop();
         }
         var_1883 = new Timer(2000,1);
         var_1883.addEventListener("timer",close);
         var_1883.start();
         var_2127.x = param1;
         var_2127.y = param2;
      }
      
      private function close(param1:Event) : void
      {
         var_2127.destroy();
         var_2127 = null;
      }
      
      private function getOpenedToWebAlert() : IWindowContainer
      {
         var _loc1_:IWindowContainer = IWindowContainer(_friendList.getXmlWindow("opened_to_web_popup"));
         _friendList.refreshButton(_loc1_,"opened_to_web",true,null,0);
         return _loc1_;
      }
   }
}
