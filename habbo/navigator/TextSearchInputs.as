package com.sulake.habbo.navigator
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_3520;
   import com.sulake.core.window.events.WindowEvent;
   
   public class TextSearchInputs
   {
       
      
      private var _navigator:HabboNavigator;
      
      private var var_2570:TextFieldManager;
      
      private var var_982:class_3520;
      
      public function TextSearchInputs(param1:HabboNavigator, param2:IWindowContainer)
      {
         var _loc4_:Array = null;
         super();
         _navigator = param1;
         var _loc3_:ITextFieldWindow = ITextFieldWindow(param2.findChildByName("search_str"));
         var_2570 = new TextFieldManager(_navigator,_loc3_,35,searchRooms,_navigator.getText("navigator.search.info"));
         Util.setProc(param2,"search_but",onSearchButtonClick);
         var _loc5_:Boolean;
         if(_loc5_ = true)
         {
            var_982 = param2.findChildByName("search_type") as class_3520;
            (_loc4_ = []).push(_navigator.getText("${navigator.navisel.bydefault}"));
            _loc4_.push(_navigator.getText("${navigator.navisel.byowner}"));
            _loc4_.push(_navigator.getText("${navigator.navisel.byroomname}"));
            _loc4_.push(_navigator.getText("${navigator.navisel.bytag}"));
            _loc4_.push(_navigator.getText("${navigator.navisel.bygroupname}"));
            var_982.populate(_loc4_);
            var_982.selection = 0;
         }
      }
      
      public function dispose() : void
      {
         if(var_2570)
         {
            var_2570.dispose();
            var_2570 = null;
         }
         _navigator = null;
      }
      
      public function setText(param1:String, param2:int) : void
      {
         var_2570.setText(param1);
         if(var_982 != null)
         {
            switch(param2 - 8)
            {
               case 0:
                  var_982.selection = 0;
                  break;
               case 1:
                  var_982.selection = 3;
                  break;
               case 2:
                  var_982.selection = 2;
                  break;
               case 5:
                  var_982.selection = 4;
                  break;
               case 12:
                  var_982.selection = 1;
            }
         }
      }
      
      private function onSearchButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         searchRooms();
      }
      
      private function searchRooms() : void
      {
         var _loc1_:String = var_2570.getText();
         if(_loc1_ == "")
         {
            return;
         }
         if(var_982 != null)
         {
            switch(var_982.selection)
            {
               case 0:
                  _navigator.mainViewCtrl.startSearch(5,8,_loc1_);
                  break;
               case 1:
                  _navigator.mainViewCtrl.startSearch(5,20,_loc1_);
                  break;
               case 2:
                  _navigator.mainViewCtrl.startSearch(5,10,_loc1_);
                  break;
               case 3:
                  _navigator.mainViewCtrl.startSearch(5,9,_loc1_);
                  break;
               case 4:
                  _navigator.mainViewCtrl.startSearch(5,13,_loc1_);
            }
         }
         else
         {
            _navigator.mainViewCtrl.startSearch(5,8,_loc1_);
         }
         _navigator.trackNavigationDataPoint("Search","search",_loc1_);
      }
      
      public function get searchStr() : TextFieldManager
      {
         return var_2570;
      }
   }
}
