package com.sulake.habbo.avatar
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.common.AvatarEditorGridView;
   import com.sulake.habbo.avatar.common.class_3643;
   import com.sulake.habbo.avatar.effects.AvatarEditorGridViewEffects;
   import com.sulake.habbo.avatar.view.AvatarEditorNameChangeView;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class AvatarEditorView
   {
      
      public static var THUMB_WINDOW:IWindowContainer;
      
      public static var COLOUR_WINDOW:IWindowContainer;
      
      public static var TAB_BACKGROUND_COLOUR:int = 6710886;
      
      private static const SAVE_TIMEOUT_MS:int = 1500;
      
      private static const DEFAULT_LOCATION:Point = new Point(100,30);
       
      
      private var var_1651:HabboAvatarEditor;
      
      private var var_1658:IWindowContainer;
      
      private var var_3827:String;
      
      private var var_1952:ITabContextWindow;
      
      private var var_1711:class_3514;
      
      private var var_2535:IWindowContainer;
      
      private var var_2227:Timer;
      
      private var var_3269:int = 4;
      
      private var var_3931:String;
      
      private var _showWardrobeOnUpdate:Boolean = true;
      
      private var var_3523:Array;
      
      private var var_2972:Array;
      
      private var _categoryContainers:Dictionary;
      
      private var var_1803:class_3643;
      
      private var var_4629:class_3643;
      
      private var var_3795:AvatarEditorNameChangeView;
      
      public function AvatarEditorView(param1:HabboAvatarEditor, param2:Array)
      {
         var_3523 = [];
         var_2972 = ["generic","head","torso","legs","hotlooks","wardrobe","nfts"];
         super();
         var_1651 = param1;
         var_2227 = new Timer(1500,1);
         var_2227.addEventListener("timer",onUpdate);
         if(param1.manager.getBoolean("effects.in.avatar.editor"))
         {
            var_2972.push("effects");
         }
         if(param2 == null)
         {
            param2 = var_2972;
         }
         for each(var _loc3_ in param2)
         {
            var_3523.push(_loc3_);
         }
         createWindow();
      }
      
      public function dispose() : void
      {
         var _loc3_:IWindowContainer = null;
         var _loc2_:IWindowContainer = null;
         var _loc1_:IWindowContainer = null;
         if(var_2227 != null)
         {
            var_2227.stop();
            var_2227.removeEventListener("timer",onUpdate);
            var_2227 = null;
         }
         if(var_1952)
         {
            var_1952.dispose();
            var_1952 = null;
         }
         if(var_1658)
         {
            var_1658.dispose();
            var_1658 = null;
         }
         if(var_2535 != null)
         {
            var_2535.dispose();
            var_2535 = null;
         }
         if(var_1711)
         {
            var_1711.dispose();
            var_1711 = null;
         }
         if(var_1658 != null)
         {
            _loc3_ = var_1658.findChildByName("figureContainer") as IWindowContainer;
            if(_loc3_ != null)
            {
               while(_loc3_.numChildren > 0)
               {
                  _loc3_.removeChildAt(0);
               }
            }
            _loc2_ = var_1658.findChildByName("contentArea") as IWindowContainer;
            if(_loc2_ != null)
            {
               while(_loc2_.numChildren > 0)
               {
                  _loc2_.removeChildAt(0);
               }
            }
            _loc1_ = var_1658.findChildByName("sideContainer") as IWindowContainer;
            if(_loc1_ != null)
            {
               while(_loc1_.numChildren > 0)
               {
                  _loc1_.removeChildAt(0);
               }
            }
            var_1651 = null;
         }
      }
      
      public function getFrame(param1:Array, param2:String = null) : class_3514
      {
         if(var_1711)
         {
            var_1711.visible = true;
            var_1711.activate();
            return var_1711;
         }
         if(var_1711)
         {
            var_1711.dispose();
            var_1711 = null;
         }
         var _loc3_:XmlAsset = var_1651.manager.assets.getAssetByName("AvatarEditorFrame") as XmlAsset;
         if(_loc3_)
         {
            var_1711 = var_1651.manager.windowManager.buildFromXML(_loc3_.content as XML) as class_3514;
         }
         if(var_1711 == null)
         {
            return null;
         }
         var _loc4_:IWindowContainer = var_1711.findChildByName("maincontent") as IWindowContainer;
         if(!embedToContext(_loc4_,param1))
         {
            var_1711.dispose();
            var_1711 = null;
            return null;
         }
         if(param2 && var_1711.header != null)
         {
            var_1711.header.title.text = param2;
         }
         var_1711.position = DEFAULT_LOCATION;
         var_1711.findChildByName("header_button_close").procedure = windowEventProc;
         return var_1711;
      }
      
      public function embedToContext(param1:IWindowContainer, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         if(!validateAvailableCategories(param2))
         {
            return false;
         }
         if(param1)
         {
            _loc3_ = int(param1.getChildIndex(var_1658));
            if(_loc3_)
            {
               param1.removeChildAt(_loc3_);
            }
            param1.addChild(var_1658);
         }
         else
         {
            if(var_2535 == null)
            {
               var_2535 = var_1651.manager.windowManager.createWindow("avatarEditorContainer","",4,3,131072 | 1,new Rectangle(0,0,2,2),null,0) as IWindowContainer;
               var_2535.addChild(var_1658);
            }
            _loc3_ = int(var_2535.getChildIndex(var_1658));
            if(_loc3_)
            {
               param1.removeChildAt(_loc3_);
            }
            var_2535.visible = true;
         }
         return true;
      }
      
      public function validateAvailableCategories(param1:Array) : Boolean
      {
         if(param1 == null)
         {
            return validateAvailableCategories(var_2972);
         }
         if(param1.length != var_3523.length)
         {
            return false;
         }
         for each(var _loc2_ in param1)
         {
            if(var_3523.indexOf(_loc2_) < 0)
            {
               return false;
            }
         }
         return true;
      }
      
      private function onUpdate(param1:Event = null) : void
      {
         var_2227.stop();
         if(var_1658)
         {
            var_1658.findChildByName("save").enable();
         }
      }
      
      public function show() : void
      {
         if(var_1711)
         {
            var_1711.visible = true;
         }
         else if(var_1658)
         {
            var_1658.visible = true;
         }
      }
      
      public function hide() : void
      {
         if(var_1711)
         {
            var_1711.visible = false;
         }
         else if(var_1658)
         {
            var_1658.visible = false;
         }
      }
      
      private function createWindow() : void
      {
         var _loc4_:int = 0;
         var _loc3_:ITabButtonWindow = null;
         var _loc5_:int = 0;
         var _loc7_:IWindow = null;
         if(var_1658 == null)
         {
            var_1658 = var_1651.manager.windowManager.buildFromXML((var_1651.manager.assets.getAssetByName("AvatarEditorContent") as XmlAsset).content as XML) as IWindowContainer;
         }
         if(THUMB_WINDOW == null)
         {
            THUMB_WINDOW = var_1658.findChildByName("thumb_template") as IWindowContainer;
            if(THUMB_WINDOW)
            {
               var_1658.removeChild(THUMB_WINDOW);
            }
         }
         if(COLOUR_WINDOW == null)
         {
            COLOUR_WINDOW = var_1658.findChildByName("palette_template") as IWindowContainer;
            if(COLOUR_WINDOW)
            {
               var_1658.removeChild(COLOUR_WINDOW);
            }
         }
         if(var_1651.manager != null && var_1651.manager.sessionData != null)
         {
            var_1658.findChildByName("avatar_name").caption = var_1651.manager.sessionData.userName;
            if(var_1651.manager.getBoolean("premium.name.change.enabled"))
            {
               var_1658.findChildByName("avatar_name_change").visible = true;
            }
         }
         var_1658.procedure = windowEventProc;
         var_1952 = var_1658.findChildByName("mainTabs") as ITabContextWindow;
         var _loc1_:Vector.<String> = new Vector.<String>(0);
         _loc4_ = var_1952.numTabItems - 1;
         while(_loc4_ >= 0)
         {
            _loc3_ = var_1952.getTabItemAt(_loc4_);
            _loc1_.push(_loc3_.name);
            if(_loc3_ != null && var_3523.indexOf(_loc3_.name) < 0)
            {
               var_1952.removeTabItem(_loc3_);
               _loc5_ = _loc4_ + 1;
               while(_loc5_ < var_1952.numTabItems)
               {
                  var_1952.getTabItemAt(_loc5_).x = var_1952.getTabItemAt(_loc5_).x - _loc3_.width;
                  _loc5_++;
               }
            }
            _loc4_--;
         }
         _categoryContainers = new Dictionary();
         var _loc2_:IWindowContainer = var_1658.findChildByName("contentArea") as IWindowContainer;
         for each(var _loc6_ in _loc1_)
         {
            if(_loc7_ = _loc2_.findChildByName(_loc6_ + "_content"))
            {
               _categoryContainers[_loc6_] = _loc2_.removeChild(_loc7_);
            }
         }
         var_1803 = new AvatarEditorGridView(var_1658.findChildByName("grid_container") as IWindowContainer);
         var_4629 = new AvatarEditorGridViewEffects(var_1658.findChildByName("grid_container") as IWindowContainer);
         var_1952.selector.setSelected(var_1952.getTabItemAt(0));
         update();
      }
      
      public function update() : void
      {
         var _loc1_:IWindow = var_1658.findChildByName("wardrobeButtonContainer") as IWindow;
         if(_loc1_ && var_1651.manager.sessionData)
         {
            _loc1_.visible = var_1651.manager.sessionData.hasClub && var_1651.isSideContentEnabled();
            _loc1_.visible = var_1651.isSideContentEnabled();
         }
         var _loc2_:String = "nothing";
         if(var_3931 == "wardrobe" || _showWardrobeOnUpdate)
         {
            _loc2_ = "wardrobe";
         }
         if(!var_1651.isSideContentEnabled())
         {
            _loc2_ = "nothing";
         }
         if(var_1651.hasInvalidClubItems())
         {
            var_1651.stripClubItems();
            var_1651.disableClubClothing();
         }
         if(var_1651.hasInvalidSellableItems())
         {
            var_1651.stripInvalidSellableItems();
         }
         setSideContent(_loc2_);
         setViewToCategory(var_3827);
      }
      
      public function toggleCategoryView(param1:String, param2:Boolean = false) : void
      {
         if(param2)
         {
         }
         setViewToCategory(param1);
      }
      
      private function toggleWardrobe() : void
      {
         if(var_3931 == "wardrobe")
         {
            _showWardrobeOnUpdate = false;
            setSideContent("nothing");
         }
         else
         {
            setSideContent("wardrobe");
         }
      }
      
      private function setSideContent(param1:String) : void
      {
         var _loc5_:int = 0;
         if(var_3931 == param1)
         {
            return;
         }
         var _loc2_:IWindowContainer = var_1658.findChildByName("sideContainer") as IWindowContainer;
         if(!_loc2_)
         {
            return;
         }
         var _loc4_:IWindow = null;
         switch(param1)
         {
            case "nothing":
               break;
            case "wardrobe":
               _loc4_ = var_1651.getSideContentWindowContainer("wardrobe");
         }
         var _loc3_:IWindow = _loc2_.removeChildAt(0);
         if(_loc3_)
         {
            var_1658.width -= _loc3_.width;
         }
         if(_loc4_)
         {
            _loc2_.addChild(_loc4_);
            _loc4_.visible = true;
            _loc2_.width = _loc4_.width;
         }
         else
         {
            _loc2_.width = 0;
         }
         var_3931 = param1;
         if(var_1711)
         {
            _loc5_ = 8;
            var_1711.content.width = var_1658.width + _loc5_;
         }
      }
      
      private function setViewToCategory(param1:String) : void
      {
         if(param1 == null || param1 == "")
         {
            return;
         }
         var _loc2_:IWindowContainer = var_1658.findChildByName("contentArea") as IWindowContainer;
         if(_loc2_ == null)
         {
            return;
         }
         effectsParamViewContainer.visible = param1 == "effects";
         if("nfts" == param1)
         {
            _showWardrobeOnUpdate = false;
            var_1658.findChildByName("wardrobe").disable();
            setSideContent("nothing");
         }
         else
         {
            var_1658.findChildByName("wardrobe").enable();
         }
         var _loc4_:IWindow = _loc2_.getChildAt(0);
         _loc2_.removeChild(_loc4_);
         _loc2_.invalidate();
         var _loc3_:IWindow = var_1651.getCategoryWindowContainer(param1);
         if(_loc3_ == null)
         {
            return;
         }
         var_1803.window.visible = false;
         _loc3_.visible = true;
         _loc2_.addChild(_loc3_);
         var_1651.activateCategory(param1);
         var_3827 = param1;
         var_1952.selector.setSelected(var_1952.getTabItemByName(param1));
      }
      
      public function windowEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:String = null;
         var _loc6_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         if(param1.type == "WE_SELECTED")
         {
            _loc3_ = String((param2 as ITabContextWindow).selector.getSelected().name);
            if(_loc3_ != var_3827)
            {
               _loc6_ = false;
               _loc4_ = false;
               _loc5_ = false;
               if(_loc3_ != "effects" && _loc3_ != "hotlooks")
               {
                  if(var_1651.hasNftOutfit() && "nfts" == _loc3_)
                  {
                     _loc5_ = true;
                  }
                  else if(var_1651.hasNftOutfit() && _loc3_ != "nfts")
                  {
                     _loc6_ = true;
                  }
                  else if(editor.hasSetNftOutfitInViewer() && _loc3_ != "nfts")
                  {
                     _loc4_ = true;
                  }
               }
               if(var_1651.hasNftOutfit() && _loc3_ == "effects")
               {
                  _loc5_ = true;
               }
               var_1651.toggleAvatarEditorPage(_loc3_);
               if(_loc6_)
               {
                  var_1651.loadFallbackFigure();
               }
               else if(_loc4_)
               {
                  var_1651.loadRollbackFigure();
               }
               else if(_loc5_)
               {
                  var_1651.loadNftFigure();
               }
            }
         }
         else if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "save":
                  if(!var_1651.isDevelopmentEditor() && var_1651.hasInvalidSellableItems())
                  {
                     startSellablePurchase();
                     var_2227.start();
                     var_1658.findChildByName("save").disable();
                     return;
                  }
                  if(!var_1651.isDevelopmentEditor() && var_1651.hasInvalidClubItems())
                  {
                     var_1651.openHabboClubAdWindow();
                     var_2227.start();
                     var_1658.findChildByName("save").disable();
                     return;
                  }
                  var_2227.start();
                  var_1658.findChildByName("save").disable();
                  var_1651.saveCurrentSelection();
                  var_1651.manager.close(var_1651.instanceId);
                  break;
               case "cancel":
               case "header_button_close":
                  if(var_1651.hasInvalidClubItems())
                  {
                     var_1651.stripClubItems();
                     var_1651.disableClubClothing();
                  }
                  var_1651.manager.close(var_1651.instanceId);
                  break;
               case "rotate_avatar":
                  var_3269++;
                  if(var_3269 > 7)
                  {
                     var_3269 = 0;
                  }
                  var_1651.figureData.direction = var_3269;
                  break;
               case "wardrobe":
                  toggleWardrobe();
                  break;
               case "avatar_name_change":
                  if(var_3795 != null)
                  {
                     var_3795.focus();
                  }
                  else
                  {
                     var_3795 = new AvatarEditorNameChangeView(this,var_1658.x + var_1658.width,var_1658.y);
                  }
            }
         }
      }
      
      private function startSellablePurchase() : void
      {
         if(var_1651.manager.catalog)
         {
            var_1651.manager.catalog.openCatalogPage(var_1651.manager.getProperty("catalog.clothes.page"));
         }
      }
      
      public function get effectsParamViewContainer() : IWindowContainer
      {
         return IWindowContainer(var_1658.findChildByName("effectParamsContainer"));
      }
      
      public function getCategoryContainer(param1:String) : IWindow
      {
         return _categoryContainers[param1];
      }
      
      public function get gridView() : class_3643
      {
         return var_1803;
      }
      
      public function getFigureContainer() : IWidgetWindow
      {
         return var_1658.findChildByName("avatarWidget") as IWidgetWindow;
      }
      
      public function get effectsGridView() : class_3643
      {
         return var_4629;
      }
      
      public function get editor() : HabboAvatarEditor
      {
         return var_1651;
      }
      
      public function get avatarEditorNameChangeView() : AvatarEditorNameChangeView
      {
         return var_3795;
      }
      
      public function get currentViewId() : String
      {
         return var_3827;
      }
   }
}
