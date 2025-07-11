package com.sulake.habbo.navigator.mainview
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IScrollbarWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.IViewCtrl;
   import com.sulake.habbo.navigator.UserCountRenderer;
   import com.sulake.habbo.navigator.Util;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1735;
   
   public class CategoryListCtrl implements IViewCtrl
   {
      
      private static const CATEGORY_SPACING:int = 5;
       
      
      private var var_2977:UserCountRenderer;
      
      private var _navigator:HabboNavigator;
      
      private var _content:IWindowContainer;
      
      private var var_19:IItemListWindow;
      
      private var var_2196:IScrollbarWindow;
      
      public function CategoryListCtrl(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
         var_2977 = new UserCountRenderer(_navigator);
      }
      
      public function dispose() : void
      {
         if(var_2977)
         {
            var_2977.dispose();
            var_2977 = null;
         }
      }
      
      public function refresh() : void
      {
         var _loc4_:int = 0;
         var _loc1_:class_1735 = null;
         var _loc10_:IWindowContainer = null;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:Array = _navigator.data.allCategories;
         var _loc7_:Map = _navigator.data.categoriesWithVisitorData.categoryToCurrentUserCountMap;
         var _loc8_:Map = _navigator.data.categoriesWithVisitorData.categoryToMaxUserCountMap;
         var _loc9_:IWindowContainer = IWindowContainer(var_19.getListItemAt(0));
         _loc4_ = 0;
         while(_loc4_ < _loc6_.length)
         {
            _loc1_ = _loc6_[_loc4_];
            if(_loc1_.visible)
            {
               if((_loc10_ = getCategoryContainer(_loc9_,_loc4_)) == null)
               {
                  (_loc10_ = createEntry(_loc4_)).id = _loc4_;
                  _loc9_.addChild(_loc10_);
               }
               _loc2_ = _loc7_.getValue(_loc1_.nodeId);
               _loc5_ = _loc8_.getValue(_loc1_.nodeId);
               refreshEntry(_loc10_,_loc1_,_loc2_,_loc5_);
               _loc10_.y = _loc3_;
               _loc3_ += _loc10_.height + 5;
               _loc10_.visible = true;
               _loc9_.height = Util.getLowestPoint(_loc9_) > 0 ? Util.getLowestPoint(_loc9_) + 5 : 0;
            }
            _loc4_++;
         }
         if(var_2196 != null)
         {
            var_2196.scrollV = 0;
            var_2196.visible = true;
         }
      }
      
      public function refreshEntry(param1:IWindowContainer, param2:class_1735, param3:int, param4:int) : void
      {
         param1.findChildByName("category_name_txt").caption = param2.visibleName;
         param1.findChildByName("arrow_right_icon").visible = true;
         var_2977.refreshUserCount(param4,IWindowContainer(param1.findChildByName("enter_category_button")),param3,"${navigator.usercounttooltip.users}",297,35);
      }
      
      public function createEntry(param1:int) : IWindowContainer
      {
         var _loc2_:IWindowContainer = IWindowContainer(_navigator.getXmlWindow("grs_category_selector"));
         setProcedureAndId(_loc2_,param1,"enter_category_button",onSelectCategory);
         _navigator.refreshButton(_loc2_,"navi_room_icon",true,null,0);
         return _loc2_;
      }
      
      private function onSelectCategory(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:class_1735 = null;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = _navigator.data.allCategories[param2.id];
            _navigator.mainViewCtrl.startSearch(2,1,"" + _loc3_.nodeId);
         }
      }
      
      private function getCategoryContainer(param1:IWindowContainer, param2:int) : IWindowContainer
      {
         return IWindowContainer(param1.getChildByID(param2));
      }
      
      private function setProcedureAndId(param1:IWindowContainer, param2:int, param3:String, param4:Function) : void
      {
         param1.findChildByName(param3).procedure = param4;
         param1.findChildByName(param3).id = param2;
      }
      
      public function set content(param1:IWindowContainer) : void
      {
         _content = param1;
         var_19 = !!_content ? IItemListWindow(_content.findChildByName("item_list_category")) : null;
         var_2196 = !!_content ? IScrollbarWindow(_content.findChildByName("scroller")) : null;
      }
      
      public function get content() : IWindowContainer
      {
         return _content;
      }
   }
}
