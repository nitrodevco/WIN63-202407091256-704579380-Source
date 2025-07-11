package com.sulake.habbo.moderation
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   
   public class PickedIssuesView implements IIssueBrowserView
   {
       
      
      private var var_3118:IssueManager;
      
      private var var_2693:IssueBrowser;
      
      private var _window:IWindowContainer;
      
      private var var_4486:IssueListView;
      
      public function PickedIssuesView(param1:IssueManager, param2:IssueBrowser, param3:IWindowContainer)
      {
         super();
         var_3118 = param1;
         var_2693 = param2;
         _window = param3;
         _window.visible = false;
         var _loc4_:IItemListWindow = _window.findChildByName("issue_list") as IItemListWindow;
         var_4486 = new IssueListView(param1,param2,_loc4_);
      }
      
      public function get view() : IWindowContainer
      {
         return _window;
      }
      
      public function set visible(param1:Boolean) : void
      {
         _window.visible = param1;
      }
      
      public function update() : void
      {
         var _loc1_:Array = var_3118.getBundles("issue_bundle_picked");
         var_4486.update(_loc1_);
      }
   }
}
