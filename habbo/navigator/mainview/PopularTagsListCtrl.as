package com.sulake.habbo.navigator.mainview
{
   import com.sulake.core.window.*;
   import com.sulake.core.window.components.*;
   import com.sulake.core.window.enum.*;
   import com.sulake.core.window.events.*;
   import com.sulake.habbo.navigator.*;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1767;
   
   public class PopularTagsListCtrl implements IViewCtrl
   {
       
      
      private var _navigator:HabboNavigator;
      
      private var _content:IWindowContainer;
      
      private var var_19:IItemListWindow;
      
      private var var_4979:int;
      
      private var var_2899:TagRenderer;
      
      public function PopularTagsListCtrl(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
         var_2899 = new TagRenderer(_navigator);
      }
      
      public function dispose() : void
      {
         if(var_2899)
         {
            var_2899.dispose();
            var_2899 = null;
         }
      }
      
      public function set content(param1:IWindowContainer) : void
      {
         _content = param1;
         var_19 = !!_content ? IItemListWindow(_content.findChildByName("item_list")) : null;
      }
      
      public function get content() : IWindowContainer
      {
         return _content;
      }
      
      public function refresh() : void
      {
         var _loc3_:int = 0;
         var _loc1_:class_1767 = null;
         var_2899.useHashTags = true;
         var _loc4_:Array = _navigator.data.popularTags.tags;
         var _loc2_:IWindowContainer = IWindowContainer(var_19.getListItemAt(0));
         if(_loc2_ == null)
         {
            _loc2_ = IWindowContainer(_navigator.getXmlWindow("grs_popular_tag_row"));
            var_19.addListItem(_loc2_);
         }
         Util.hideChildren(_loc2_);
         _loc3_ = 0;
         while(_loc3_ < _navigator.data.popularTags.tags.length)
         {
            _loc1_ = _navigator.data.popularTags.tags[_loc3_];
            var_2899.refreshTag(_loc2_,_loc3_,_loc1_.tagName);
            _loc3_++;
         }
         Util.layoutChildrenInArea(_loc2_,_loc2_.width,18,3);
         _loc2_.height = Util.getLowestPoint(_loc2_);
         _content.findChildByName("no_tags_found").visible = _loc4_.length < 1;
      }
      
      private function refreshTagName(param1:IWindowContainer, param2:class_1767) : void
      {
         var _loc3_:String = "txt";
         var _loc4_:ITextWindow = ITextWindow(param1.findChildByName(_loc3_));
         if(param2 == null)
         {
            return;
         }
         _loc4_.visible = true;
         _loc4_.text = param2.tagName;
      }
   }
}
