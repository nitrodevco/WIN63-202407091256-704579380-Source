package com.sulake.habbo.quest.seasonalcalendar
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3437;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.quest.HabboQuestEngine;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.net.URLRequest;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.incoming.quest.class_1715;
   
   public class Calendar implements IDisposable, IUpdateReceiver
   {
      
      private static const BG_IMAGE_PREFIX:String = "background_";
      
      private static const ENTITY_IMAGE_PREFIX:String = "day";
      
      private static const ENTITY_IMAGE_UNCOMPLETE_POSTFIX:String = "_uncomplete";
      
      private static const ENTITY_IMAGE_COMPLETED_POSTFIX:String = "_completed";
      
      private static const SHOW_FUTURE_INACTIVE_ENTITIES_COUNT:int = 2;
      
      private static const const_877:int = 3;
      
      private static const ENTITY_SPACING:int = 80;
      
      private static const ENTITIES_LEFT_MARGIN:int = 37;
      
      private static const const_663:int = 7;
      
      private static const DAILY_REFRESH_DELAY_MINUTES:int = 5;
      
      private static const FLASH_PULSE_LENGHT_IN_MS:int = 2000;
      
      private static const FLASH_MAX_BRIGHTNESS:int = 100;
       
      
      private var _questEngine:HabboQuestEngine;
      
      private var var_1641:MainWindow;
      
      private var var_692:Array;
      
      private var _backgroundImageCache:Vector.<BitmapData>;
      
      private var _graphicEntityCache:Vector.<BitmapData>;
      
      private var var_3578:Map;
      
      private var _bgAssetNameArray:Array;
      
      private var var_4607:String;
      
      private var var_2025:class_3832;
      
      private var _entityWindows:Vector.<IWindowContainer>;
      
      private var _states:Array;
      
      private var var_2556:CalendarArrowButton;
      
      private var var_2740:CalendarArrowButton;
      
      private var var_1675:IWindowContainer;
      
      private var var_4178:IWindowContainer;
      
      private var var_2334:IBitmapWrapperWindow;
      
      private var var_1673:int = -1;
      
      private var var_2041:int = -1;
      
      private var _highestAvailableQuestIndex:int = -1;
      
      private var var_3859:int = 42;
      
      private var var_1850:Timer;
      
      private var _scrollOffset:int = 0;
      
      private var var_2717:int = 0;
      
      private var _scrollBgStartOffset:int = 0;
      
      private var var_2508:int = -1;
      
      private var var_3501:int;
      
      private var var_3918:int = -1;
      
      private var var_3907:Boolean = false;
      
      private var var_3928:Boolean = false;
      
      private var var_2884:Timer;
      
      private var var_3042:int = -1;
      
      public function Calendar(param1:HabboQuestEngine, param2:MainWindow)
      {
         super();
         _questEngine = param1;
         var_1641 = param2;
      }
      
      private static function adjustBrightness(param1:uint, param2:int) : uint
      {
         var _loc3_:int = Math.min(255,Math.max(0,(param1 >> 16 & 255) + param2));
         var _loc5_:int = Math.min(255,Math.max(0,(param1 >> 8 & 255) + param2));
         var _loc4_:int = Math.min(255,Math.max(0,(param1 & 255) + param2));
         return ((_loc3_ & 255) << 16) + ((_loc5_ & 255) << 8) + (_loc4_ & 255);
      }
      
      private function getImageGalleryHost() : String
      {
         return var_4607;
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            _questEngine.removeUpdateReceiver(this);
            cleanUpEntityWindows();
            if(var_2025 != null)
            {
               var_2025.dispose();
               var_2025 = null;
            }
            if(var_2556 != null)
            {
               var_2556.dispose();
               var_2556 = null;
            }
            if(var_2740 != null)
            {
               var_2740.dispose();
               var_2740 = null;
            }
            if(var_1850 != null)
            {
               var_1850.stop();
               var_1850 = null;
            }
            if(var_2884 != null)
            {
               var_2884.stop();
               var_2884 = null;
            }
            _backgroundImageCache = null;
            _graphicEntityCache = null;
            _states = null;
            var_3578 = null;
            _bgAssetNameArray = null;
            _questEngine = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _questEngine == null;
      }
      
      public function onQuests(param1:Array) : void
      {
         var _loc4_:Date;
         var_3042 = (_loc4_ = new Date()).getDate();
         var _loc2_:int = var_2041;
         var_692 = [];
         _highestAvailableQuestIndex = 0;
         var _loc3_:class_1715 = null;
         for each(_loc3_ in param1)
         {
            if(_questEngine.isSeasonalQuest(_loc3_))
            {
               var_692.push(_loc3_);
               if(_highestAvailableQuestIndex < _loc3_.sortOrder - 1)
               {
                  _highestAvailableQuestIndex = _loc3_.sortOrder - 1;
               }
            }
         }
         var_692.sortOn(["sortOrder"]);
         var_3859 = int(_questEngine.configuration.getProperty("seasonalQuestCalendar.maximum.entities"));
         var_2041 = Math.min(var_3859,_highestAvailableQuestIndex + 1 + 2);
         if(_loc2_ != -1 && var_2041 > _loc2_)
         {
            prepareImages();
         }
      }
      
      public function prepare(param1:class_3514) : void
      {
         var _loc2_:IBitmapWrapperWindow = null;
         var_4607 = var_1641.getCalendarImageGalleryHost();
         var_1675 = IWindowContainer(param1.findChildByName("calendar_cont"));
         var_2334 = IBitmapWrapperWindow(param1.findChildByName("background_slice"));
         var_4178 = IWindowContainer(param1.findChildByName("entity_template"));
         var_4178.visible = false;
         var_2025 = new class_3832();
         var_2556 = new CalendarArrowButton(_questEngine.assets,IBitmapWrapperWindow(param1.findChildByName("button_left")),0,scrollArrowProcedure);
         var_2740 = new CalendarArrowButton(_questEngine.assets,IBitmapWrapperWindow(param1.findChildByName("button_right")),1,scrollArrowProcedure);
         _loc2_ = IBitmapWrapperWindow(param1.findChildByName("stripe_mask_left"));
         _loc2_.bitmap = BitmapData(IAsset(_questEngine.assets.getAssetByName("stripe_mask_L")).content);
         _loc2_ = IBitmapWrapperWindow(param1.findChildByName("stripe_mask_right"));
         _loc2_.bitmap = BitmapData(IAsset(_questEngine.assets.getAssetByName("stripe_mask_R")).content);
         if(var_1673 == -1)
         {
            goToDay(var_1641.currentDay);
         }
         prepareImages();
         var _loc3_:Date = new Date();
         var_3042 = _loc3_.getDate();
         var_2884 = new Timer(60000 * 5);
         var_2884.addEventListener("timer",onDateRefreshTimer);
         var_2884.start();
         onDateRefreshTimer(new TimerEvent("timer"));
         _questEngine.registerUpdateReceiver(this,1);
         var_1850 = new Timer(10,10);
      }
      
      public function close() : void
      {
         cleanUpEntityWindows();
         if(var_2025 != null)
         {
            var_2025.initializeImageChain(new Vector.<BitmapData>());
         }
      }
      
      public function refresh() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         for each(var _loc3_ in var_692)
         {
            _loc1_ = _loc3_.sortOrder - 1;
            _loc2_ = int(_loc3_.completedCampaign ? 2 : _states[_loc1_]);
            if(_loc2_ != _states[_loc1_])
            {
               retrieveEntityImageAsset(_loc3_.sortOrder,_loc2_);
               updateEntityIndicatorPanel(_loc1_,false);
               if(_loc2_ == 2 && var_2508 == _loc1_)
               {
                  stopFlashing();
               }
            }
         }
         initializeBackgroundRendererIfAllImagesInCache();
         initializeEntitiesIfAllImagesInCache();
      }
      
      public function goToDay(param1:int) : void
      {
         scrollToIndex(Math.max(0,Math.min(param1 - 3,maxScrollRightIndex)));
      }
      
      private function prepareImages() : void
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:int = Math.ceil(var_2041 / 7) + 1;
         _bgAssetNameArray = new Array(_loc1_);
         _backgroundImageCache = new Vector.<BitmapData>(_loc1_);
         _graphicEntityCache = new Vector.<BitmapData>(var_2041);
         _states = new Array(var_2041);
         var _loc8_:Vector.<BitmapData> = new Vector.<BitmapData>();
         _loc6_ = 0;
         while(_loc6_ < _loc1_)
         {
            _loc8_.push(new BitmapData(640,320,false,16777215));
            _loc6_++;
         }
         var_2025.initializeImageChain(_loc8_);
         _loc4_ = firstBgIndex;
         while(_loc4_ <= lastBgIndex)
         {
            retrieveBackgroundImageAsset(_loc4_);
            _loc4_++;
         }
         var_3578 = new Map();
         for each(var _loc9_ in var_692)
         {
            if(_loc9_.sortOrder <= var_3859)
            {
               _loc7_ = _loc9_.completedCampaign ? 2 : 0;
               _loc2_ = _loc9_.sortOrder - 1 >= firstVisibleIndex && _loc9_.sortOrder - 1 <= lastVisibleIndex;
               retrieveEntityImageAsset(_loc9_.sortOrder,_loc7_,!_loc2_);
            }
         }
         if(var_692.length < var_2041)
         {
            _loc3_ = _highestAvailableQuestIndex + 1;
            while(_loc3_ < var_2041)
            {
               retrieveEntityImageAsset(_loc3_ + 1,1,_loc3_ > lastVisibleIndex);
               _loc3_++;
            }
         }
         _loc5_ = 0;
         while(_loc5_ < var_2041)
         {
            if(_states[_loc5_] == null)
            {
               retrieveEntityImageAsset(_loc5_ + 1,3,_loc5_ < firstVisibleIndex || _loc5_ > lastVisibleIndex);
            }
            _loc5_++;
         }
      }
      
      private function initializeBackgroundRendererIfAllImagesInCache() : void
      {
         var _loc2_:int = 0;
         var _loc1_:BitmapData = null;
         if(!areViewableBackgroundBitmapsInitialized())
         {
            return;
         }
         var _loc4_:Array = [];
         var _loc5_:Vector.<BitmapData> = new Vector.<BitmapData>();
         _loc2_ = 0;
         while(_loc2_ < _backgroundImageCache.length)
         {
            _loc1_ = _backgroundImageCache[_loc2_];
            if(_loc1_ != null)
            {
               _loc5_.push(_loc1_);
            }
            else
            {
               _loc5_.push(new BitmapData(640,320,false,16777215));
               _loc4_.push(_loc2_);
            }
            _loc2_++;
         }
         var_2025.initializeImageChain(_loc5_);
         assignCurrentBackgroundSlice();
         for each(var _loc3_ in _loc4_)
         {
            retrieveBackgroundImageAsset(_loc3_);
         }
      }
      
      private function cleanUpEntityWindows() : void
      {
         if(_entityWindows == null)
         {
            return;
         }
         for each(var _loc1_ in _entityWindows)
         {
            var_1675.removeChild(_loc1_);
            _loc1_.dispose();
         }
         _entityWindows = null;
      }
      
      private function initializeEntitiesIfAllImagesInCache() : void
      {
         var _loc8_:IWindowContainer = null;
         var _loc6_:int = 0;
         var _loc9_:IBitmapWrapperWindow = null;
         var _loc2_:IWindow = null;
         var _loc1_:IWindow = null;
         var _loc3_:IWindow = null;
         if(!areViewableEntityBitmapsInitialized())
         {
            return;
         }
         cleanUpEntityWindows();
         if(_entityWindows == null)
         {
            _entityWindows = new Vector.<IWindowContainer>();
         }
         var _loc5_:Array = [];
         for each(var _loc4_ in _graphicEntityCache)
         {
            _loc8_ = IWindowContainer(var_4178.clone());
            _loc6_ = int(_entityWindows.length);
            if(_loc4_ != null)
            {
               (_loc9_ = _loc8_.findChildByName("entity_bitmap") as IBitmapWrapperWindow).width = _loc4_.width;
               _loc9_.height = _loc4_.height;
               _loc9_.bitmap = _loc4_.clone();
            }
            else
            {
               _loc5_.push(_loc6_);
            }
            _loc2_ = _loc8_.findChildByName("entity_mouse_region");
            _loc2_.procedure = entityMouseRegionWindowProcedure;
            if(_states[_loc6_] == 1 || _states[_loc6_] == 2 || _states[_loc6_] == 3)
            {
               _loc2_.visible = false;
            }
            _loc8_.visible = true;
            var_1675.addChild(_loc8_);
            _entityWindows.push(_loc8_);
            updateEntityIndicatorPanel(_loc6_,false);
         }
         repositionEntityWrappers();
         updateEntityVisibilities();
         _loc1_ = var_1675.findChildByName("stripe_mask_left");
         var_1675.setChildIndex(_loc1_,var_1675.numChildren - 1);
         _loc1_ = var_1675.findChildByName("stripe_mask_right");
         var_1675.setChildIndex(_loc1_,var_1675.numChildren - 1);
         _loc3_ = var_1675.findChildByName("button_left");
         var_1675.setChildIndex(_loc3_,var_1675.numChildren - 1);
         _loc3_ = var_1675.findChildByName("button_right");
         var_1675.setChildIndex(_loc3_,var_1675.numChildren - 1);
         for each(var _loc7_ in _loc5_)
         {
            retrieveEntityImageAsset(_loc7_ + 1,_states[_loc7_]);
         }
         if(_states[var_1641.currentDay - 1] == 0)
         {
            startFlashingAtIndex(var_1641.currentDay - 1);
         }
      }
      
      private function get firstVisibleIndex() : int
      {
         var _loc1_:int = var_1673 - 1;
         return _loc1_ < 0 ? 0 : _loc1_;
      }
      
      private function get lastVisibleIndex() : int
      {
         var _loc2_:int = var_1673 + 7 + 1;
         var _loc1_:int = var_2041 - 1;
         return _loc2_ > _loc1_ ? _loc1_ : _loc2_;
      }
      
      private function areViewableEntityBitmapsInitialized() : Boolean
      {
         var _loc1_:int = 0;
         if(_graphicEntityCache == null)
         {
            return false;
         }
         _loc1_ = firstVisibleIndex;
         while(_loc1_ <= lastVisibleIndex)
         {
            if(_graphicEntityCache[_loc1_] == null)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      private function get firstBgIndex() : int
      {
         var _loc2_:int = getBackgroundSliceOffset(var_1673);
         var _loc1_:int = var_2025.getImageIndexForOffset(_loc2_);
         return _loc1_ < 0 ? 0 : _loc1_;
      }
      
      private function get lastBgIndex() : int
      {
         var _loc1_:int = getBackgroundSliceOffset(var_1673);
         return var_2025.getImageIndexForOffset(_loc1_ + 640);
      }
      
      private function areViewableBackgroundBitmapsInitialized() : Boolean
      {
         var _loc1_:int = 0;
         if(_backgroundImageCache == null)
         {
            return false;
         }
         var _loc2_:int = getBackgroundSliceOffset(var_1673);
         _loc1_ = firstBgIndex;
         while(_loc1_ <= lastBgIndex)
         {
            if(_backgroundImageCache[_loc1_] == null)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      private function updateEntityIndicatorPanel(param1:int, param2:Boolean) : void
      {
         var _loc6_:BitmapData = null;
         var _loc7_:String = null;
         if(_entityWindows == null || _entityWindows.length < param1 - 1)
         {
            return;
         }
         var _loc3_:class_3437 = class_3437(_entityWindows[param1].findChildByName("entity_indicator"));
         var _loc5_:uint = uint(CalendarEntityStateEnums.INDICATOR_COLOR[_states[param1]]);
         if(param2)
         {
            _loc5_ += 2105376;
         }
         if(var_2508 != param1)
         {
            _loc3_.color = _loc5_;
         }
         var _loc9_:IBitmapWrapperWindow = IBitmapWrapperWindow(_entityWindows[param1].findChildByName("entity_indicator_status"));
         if(_states[param1] == 2)
         {
            _loc6_ = BitmapData(_questEngine.assets.getAssetByName("calendar_quest_complete").content);
            _loc9_.width = _loc6_.width;
            _loc9_.height = _loc6_.height;
            _loc9_.bitmap = _loc6_.clone();
         }
         else
         {
            _loc9_.bitmap = null;
         }
         var _loc4_:ITextWindow = _loc3_.findChildByName("entity_indicator_text") as ITextWindow;
         var _loc8_:class_1715;
         if((_loc8_ = getQuestByEntityWindowIndex(param1)) != null)
         {
            _loc4_.text = _questEngine.getCampaignName(_loc8_);
         }
         else
         {
            _loc7_ = class_1715.getCampaignLocalizationKeyForCode(_questEngine.getSeasonalCampaignCodePrefix() + "_" + (param1 + 1));
            _loc4_.text = _questEngine.getCampaignNameByCode(_loc7_);
         }
      }
      
      private function retrieveEntityImageAsset(param1:int, param2:int, param3:Boolean = false) : void
      {
         var _loc4_:String = "day" + param1;
         switch(param2)
         {
            case 0:
            case 1:
            case 3:
               _loc4_ += "_uncomplete";
               break;
            case 2:
               _loc4_ += "_completed";
         }
         _states[param1 - 1] = param2;
         var_3578[_loc4_] = param1 - 1;
         var _loc5_:IAsset;
         if((_loc5_ = _questEngine.assets.getAssetByName(_loc4_)) != null)
         {
            assignEntityBitmapToCacheByAssetName(_loc4_);
            initializeEntitiesIfAllImagesInCache();
         }
         else if(!param3)
         {
            loadAssetFromImageGallery(_loc4_,onEntityImageAssetDownloaded);
         }
      }
      
      private function retrieveBackgroundImageAsset(param1:int) : void
      {
         var _loc2_:String = "background_" + (param1 + 1);
         _bgAssetNameArray[param1] = _loc2_;
         var _loc3_:IAsset = _questEngine.assets.getAssetByName(_loc2_);
         if(_loc3_ != null)
         {
            assignBackgroundBitmapToCacheByAssetName(_loc2_);
            initializeBackgroundRendererIfAllImagesInCache();
         }
         else
         {
            loadAssetFromImageGallery(_loc2_,onBackgroundImageAssetDownloaded);
         }
      }
      
      private function loadAssetFromImageGallery(param1:String, param2:Function) : void
      {
         var _loc5_:String = getImageGalleryHost() + param1 + ".png";
         var _loc3_:URLRequest = new URLRequest(_loc5_);
         var _loc4_:AssetLoaderStruct;
         if((_loc4_ = _questEngine.assets.loadAssetFromFile(param1,_loc3_,"image/png")) && !_loc4_.disposed)
         {
            _loc4_.addEventListener("AssetLoaderEventComplete",param2);
            _loc4_.addEventListener("AssetLoaderEventError",param2);
         }
      }
      
      private function onBackgroundImageAssetDownloaded(param1:AssetLoaderEvent) : void
      {
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc2_ != null)
         {
            assignBackgroundBitmapToCacheByAssetName(_loc2_.assetName);
         }
         initializeBackgroundRendererIfAllImagesInCache();
      }
      
      private function onEntityImageAssetDownloaded(param1:AssetLoaderEvent) : void
      {
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc2_ != null)
         {
            assignEntityBitmapToCacheByAssetName(_loc2_.assetName);
         }
         initializeEntitiesIfAllImagesInCache();
      }
      
      private function assignBackgroundBitmapToCacheByAssetName(param1:String) : void
      {
         var _loc2_:int = _bgAssetNameArray.indexOf(param1);
         if(_loc2_ == -1)
         {
            return;
         }
         var _loc3_:IAsset = _questEngine.assets.getAssetByName(param1);
         _backgroundImageCache[_loc2_] = _loc3_ != null ? _loc3_.content as BitmapData : new BitmapData(640,320);
      }
      
      private function assignEntityBitmapToCacheByAssetName(param1:String) : void
      {
         var _loc3_:IAsset = _questEngine.assets.getAssetByName(param1);
         var _loc2_:int = int(var_3578[param1]);
         if(_loc2_ == -1 || _loc2_ >= _graphicEntityCache.length)
         {
            return;
         }
         _graphicEntityCache[_loc2_] = _loc3_ != null ? _loc3_.content as BitmapData : new BitmapData(1,1,true,0);
      }
      
      private function repositionEntityWrappers() : void
      {
         var _loc1_:int = 0;
         if(_entityWindows == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < _entityWindows.length)
         {
            _entityWindows[_loc1_].x = (_loc1_ - var_1673) * 80 + _scrollOffset + 37;
            _loc1_++;
         }
      }
      
      private function getBackgroundSliceOffset(param1:int) : int
      {
         return param1 * 80;
      }
      
      private function assignCurrentBackgroundSlice() : void
      {
         var _loc1_:BitmapData = var_2025.getSlice(getBackgroundSliceOffset(var_1673),var_1675.width);
         var_2334.x = 0;
         var_2334.width = _loc1_.width;
         var_2334.height = _loc1_.height;
         var_2334.bitmap = _loc1_.clone();
      }
      
      private function assignScrollableBackgroundSlice(param1:int) : void
      {
         var _loc3_:BitmapData = null;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         if(param1 < var_1673)
         {
            _loc5_ = var_1673 - param1;
            _loc4_ = getBackgroundSliceOffset(param1);
            _loc3_ = var_2025.getSlice(_loc4_,var_1675.width + 80 * _loc5_);
            _scrollBgStartOffset = -(80 * _loc5_);
         }
         else
         {
            _loc2_ = param1 - var_1673;
            _loc6_ = 80 * _loc2_ + var_1675.width;
            _loc3_ = var_2025.getSlice(getBackgroundSliceOffset(var_1673),_loc6_);
            _scrollBgStartOffset = 0;
         }
         var_2334.x = _scrollBgStartOffset;
         if(_loc3_ != null)
         {
            var_2334.width = _loc3_.width;
            var_2334.height = _loc3_.height;
            var_2334.bitmap = _loc3_.clone();
         }
      }
      
      private function repositionBackgroundSlice() : void
      {
         var_2334.x = _scrollBgStartOffset + _scrollOffset;
      }
      
      private function scrollToIndex(param1:int) : void
      {
         if(param1 < 0 || param1 >= var_2041)
         {
            return;
         }
         if(var_1850 != null && var_1850.running)
         {
            return;
         }
         if(!areViewableEntityBitmapsInitialized())
         {
            var_1673 = param1;
            enableScrollArrowsByViewIndex();
            return;
         }
         var _loc2_:int = var_1673;
         var_1673 = param1;
         if(areViewableBackgroundBitmapsInitialized())
         {
            var_1673 = _loc2_;
            assignScrollableBackgroundSlice(param1);
            updateEntityVisibilities(true,param1 - var_1673);
            var_2717 = -(80 * (param1 - var_1673)) / 10;
            var_1850 = new Timer(10,10);
            var_1850.addEventListener("timer",onAnimateScroll);
            var_1850.addEventListener("timerComplete",onAnimateScroll);
            var_1850.start();
         }
         else
         {
            var_1673 = _loc2_;
         }
      }
      
      private function get maxScrollRightIndex() : int
      {
         return var_3859 - 7;
      }
      
      private function enableScrollArrowsByViewIndex() : void
      {
         if(var_1673 > 0)
         {
            var_2556.activate();
         }
         else
         {
            var_2556.deactivate();
         }
         if(var_1673 < Math.min(var_2041 - 3 - 1,maxScrollRightIndex))
         {
            var_2740.activate();
         }
         else
         {
            var_2740.deactivate();
         }
      }
      
      private function updateEntityVisibilities(param1:Boolean = false, param2:int = 0) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         if(_entityWindows != null)
         {
            _loc4_ = var_1673 - 1;
            if(param1 && param2 < 0)
            {
               _loc4_ += param2;
            }
            _loc3_ = var_1673 + 7 + 1;
            if(param1 && param2 > 0)
            {
               _loc3_ += param2;
            }
            _loc5_ = 0;
            while(_loc5_ < _entityWindows.length)
            {
               if(_loc5_ < _loc4_ || _loc5_ > _loc3_)
               {
                  _entityWindows[_loc5_].visible = false;
               }
               else
               {
                  _entityWindows[_loc5_].visible = true;
                  if(_loc5_ == _loc4_ || _loc5_ == _loc3_)
                  {
                     _entityWindows[_loc5_].getChildByName("entity_mouse_region").visible = false;
                  }
                  else if(_states[_loc5_] == 0)
                  {
                     _entityWindows[_loc5_].getChildByName("entity_mouse_region").visible = true;
                  }
               }
               _loc5_++;
            }
         }
      }
      
      private function onAnimateScroll(param1:TimerEvent) : void
      {
         switch(param1.type)
         {
            case "timer":
               _scrollOffset += var_2717;
               repositionBackgroundSlice();
               repositionEntityWrappers();
               break;
            case "timerComplete":
               _scrollOffset = 0;
               if(var_2717 > 0)
               {
                  var_1673 -= 1;
               }
               else
               {
                  var_1673 += 1;
               }
               assignCurrentBackgroundSlice();
               repositionEntityWrappers();
               enableScrollArrowsByViewIndex();
               updateEntityVisibilities();
               var_1850.removeEventListener("timer",onAnimateScroll);
               var_1850.removeEventListener("timerComplete",onAnimateScroll);
         }
      }
      
      private function scrollArrowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_DOWN")
         {
            switch(param2.name)
            {
               case "button_left":
                  var_3907 = true;
                  break;
               case "button_right":
                  var_3928 = true;
            }
         }
         if(param1.type == "WME_UP" || param1.type == "WME_UP_OUTSIDE")
         {
            var_3907 = false;
            var_3928 = false;
         }
      }
      
      private function entityMouseRegionWindowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:int = 0;
         var _loc4_:class_1715 = null;
         if(param2.name == "entity_mouse_region")
         {
            _loc3_ = _entityWindows.indexOf(param2.parent as IWindowContainer);
            if(param1.type == "WME_CLICK")
            {
               if((_loc4_ = getQuestByEntityWindowIndex(_loc3_)) != null)
               {
                  _questEngine.questController.questDetails.openDetails(_loc4_,true);
               }
            }
            if(param1.type == "WME_OVER")
            {
               updateEntityIndicatorPanel(_loc3_,true);
               var_3918 = _loc3_;
            }
            if(param1.type == "WME_OUT")
            {
               updateEntityIndicatorPanel(_loc3_,false);
               var_3918 = -1;
            }
         }
      }
      
      private function getQuestByEntityWindowIndex(param1:int) : class_1715
      {
         for each(var _loc2_ in var_692)
         {
            if(_loc2_.sortOrder - 1 == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function update(param1:uint) : void
      {
         var _loc5_:int = 0;
         var _loc4_:Number = NaN;
         var _loc2_:class_3437 = null;
         var _loc3_:Number = NaN;
         if(_entityWindows != null && var_2508 != -1)
         {
            _loc5_ = int(CalendarEntityStateEnums.INDICATOR_COLOR[_states[var_2508]]);
            _loc4_ = var_3501 % 2000 / 2000;
            _loc4_ = Math.abs(2 * (_loc4_ > 0.5 ? (_loc4_ -= 1) : _loc4_));
            _loc2_ = class_3437(_entityWindows[var_2508].findChildByName("entity_indicator"));
            if(_loc2_)
            {
               _loc3_ = _loc4_ * 100;
               if(var_3918 == var_2508)
               {
                  _loc3_ += 20;
               }
               _loc2_.color = adjustBrightness(_loc5_,_loc3_);
            }
            var_3501 += param1;
         }
         if(var_1850 != null)
         {
            if(var_3907 && !var_1850.running && _scrollOffset == 0)
            {
               if(var_1673 > 0 && !var_2556.isInactive())
               {
                  scrollToIndex(var_1673 - 1);
               }
            }
            if(var_3928 && !var_1850.running && _scrollOffset == 0)
            {
               if(var_1673 < _highestAvailableQuestIndex && !var_2740.isInactive())
               {
                  scrollToIndex(var_1673 + 1);
               }
            }
         }
      }
      
      private function startFlashingAtIndex(param1:int) : void
      {
         if(param1 < 0 || param1 >= var_2041)
         {
            return;
         }
         var_2508 = param1;
         var_3501 = 0;
      }
      
      private function stopFlashing() : void
      {
         var_2508 = -1;
      }
      
      private function onDateRefreshTimer(param1:TimerEvent) : void
      {
         var _loc2_:Date = new Date();
         if(var_3042 != _loc2_.getDate())
         {
            _questEngine.requestSeasonalQuests();
         }
         var_3042 = _loc2_.getDate();
      }
   }
}
