package com.sulake.habbo.moderation
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   
   public class IssueBrowser
   {
       
      
      private const MY_ISSUES:String = "my_issues";
      
      private const OPEN_ISSUES:String = "open_issues";
      
      private const PICKED_ISSUES:String = "picked_issues";
      
      private const CLOSED_ISSUES:String = "closed_issues";
      
      private var var_3118:IssueManager;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _assets:IAssetLibrary;
      
      private var _window:class_3514;
      
      private var _tabContext:ITabContextWindow;
      
      private var var_2254:IIssueBrowserView;
      
      private var var_4346:IIssueBrowserView;
      
      private var var_4260:IIssueBrowserView;
      
      private var var_4524:PickedIssuesView;
      
      public function IssueBrowser(param1:IssueManager, param2:IHabboWindowManager, param3:IAssetLibrary)
      {
         super();
         var_3118 = param1;
         _windowManager = param2;
         _assets = param3;
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return _windowManager;
      }
      
      public function get assets() : IAssetLibrary
      {
         return _assets;
      }
      
      public function get issueManager() : IssueManager
      {
         return var_3118;
      }
      
      public function show() : void
      {
         if(_window == null)
         {
            createMainFrame();
         }
         _window.visible = true;
         _window.activate();
         update();
      }
      
      public function isOpen() : Boolean
      {
         return _window != null && Boolean(_window.visible);
      }
      
      private function createMainFrame() : void
      {
         var _loc1_:IWindow = null;
         var _loc5_:IWindow = null;
         var _loc6_:IWindow = null;
         var _loc2_:ITabButtonWindow = null;
         var _loc4_:int = 0;
         if(_window == null)
         {
            _window = createWindow("issue_browser_xml") as class_3514;
            if(_window == null)
            {
               return;
            }
            _loc1_ = _window.desktop;
            _window.x = _loc1_.width / 2 - _window.width / 2;
            _window.y = _loc1_.height / 2 - _window.height / 2;
            if((_loc5_ = _window.findChildByTag("close")) != null)
            {
               _loc5_.addEventListener("WME_CLICK",onClose);
            }
            if((_loc6_ = _window.findChildByName("auto_pick")) != null)
            {
               _loc6_.addEventListener("WME_CLICK",onAutoPick);
            }
            _tabContext = _window.findChildByName("tab_context") as ITabContextWindow;
            _loc4_ = 0;
            while(_loc4_ < _tabContext.numTabItems)
            {
               _loc2_ = _tabContext.getTabItemAt(_loc4_);
               _loc2_.addEventListener("WE_SELECTED",onTabSelected);
               _loc4_++;
            }
            var_4346 = new MyIssuesView(issueManager,this,_window.findChildByName("my_issues_prototype") as IWindowContainer);
            var_4260 = new OpenIssuesView(issueManager,this,_window.findChildByName("open_issues_prototype") as IWindowContainer);
            var_4524 = new PickedIssuesView(issueManager,this,_window.findChildByName("picked_issues_prototype") as IWindowContainer);
         }
         _tabContext = _window.findChildByName("tab_context") as ITabContextWindow;
         if(_tabContext == null || _tabContext.container == null)
         {
            return;
         }
         var _loc3_:ISelectableWindow = _tabContext.selector.getSelectableByName("open_issues");
         _tabContext.selector.setSelected(_loc3_);
      }
      
      private function selectView(param1:String) : void
      {
         var _loc2_:IIssueBrowserView = getView(param1);
         if(var_2254 == _loc2_)
         {
            return;
         }
         if(var_2254 != null)
         {
            var_2254.visible = false;
         }
         var_2254 = _loc2_;
         if(var_2254 == null)
         {
            return;
         }
         var_2254.view.width = _tabContext.container.width;
         var_2254.view.height = _tabContext.container.height;
         var_2254.visible = true;
         var_2254.update();
      }
      
      private function getView(param1:String) : IIssueBrowserView
      {
         switch(param1)
         {
            case "my_issues":
               return var_4346;
            case "open_issues":
               return var_4260;
            case "picked_issues":
               return var_4524;
            default:
               return null;
         }
      }
      
      private function onTabSelected(param1:WindowEvent) : void
      {
         if(param1 == null || param1.window == null)
         {
            return;
         }
         selectView(param1.window.name);
      }
      
      public function update() : void
      {
         if(_window == null || !_window.visible)
         {
            return;
         }
         if(var_2254 == null)
         {
            return;
         }
         var_2254.update();
      }
      
      public function createWindow(param1:String) : IWindow
      {
         if(_windowManager == null || _assets == null)
         {
            return null;
         }
         var _loc2_:XmlAsset = _assets.getAssetByName(param1) as XmlAsset;
         if(_loc2_ == null || _loc2_.content == null)
         {
            return null;
         }
         return _windowManager.buildFromXML(_loc2_.content as XML);
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         _window.visible = false;
      }
      
      private function onAutoPick(param1:WindowMouseEvent) : void
      {
         if(var_3118 != null)
         {
            var_3118.autoPick("issue browser pick next");
         }
      }
   }
}
