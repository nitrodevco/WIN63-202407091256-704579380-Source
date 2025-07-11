package com.sulake.habbo.inventory.badges
{
    import assets.class_14

    import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.IInventoryModel;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.Event;
   import com.sulake.habbo.communication.messages.outgoing.inventory.badges.SetActivatedBadgesComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.badges.GetBadgesComposer;
   
   public class BadgesModel implements IInventoryModel
   {
      
      public static const BADGES_ALL:int = -1;
      
      public static const BADGES_INACTIVE:int = 0;
      
      public static const BADGES_ACTIVE:int = 1;
       
      
      private var var_319:HabboInventory;
      
      private var var_1631:BadgesView;
      
      private var var_121:Vector.<Badge>;
      
      private var var_2049:Vector.<Badge>;
      
      private var var_2021:Map;
      
      private var _assets:IAssetLibrary;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _disposed:Boolean = false;
      
      private const MAX_ACTIVE_BADGE_COUNT:int = 5;
      
      public function BadgesModel(param1:HabboInventory, param2:IHabboWindowManager, param3:IHabboCommunicationManager, param4:IAssetLibrary)
      {
         super();
         var_319 = param1;
         _windowManager = param2;
         var_121 = new Vector.<Badge>(0);
         var_2049 = new Vector.<Badge>(0);
         _assets = param4;
         _communication = param3;
         var_1631 = new BadgesView(this,param2,param4);
         var_2021 = new Map();
         initBadgeWindowAsset();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function initBadgeWindowAsset() : void
      {
         var _loc2_:IAsset = _assets.getAssetByName("inventory_thumb_xml");
         var _loc1_:XmlAsset = XmlAsset(_loc2_);
         if(Badge.var_3512 == null)
         {
            Badge.var_3512 = _windowManager.buildFromXML(XML(_loc1_.content)) as IWindowContainer;
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(Badge.var_3512 != null)
         {
            Badge.var_3512.dispose();
            Badge.var_3512 = null;
         }
         _disposed = true;
         var_319 = null;
         _windowManager = null;
         var_121 = null;
         var_2049 = null;
         if(var_2021)
         {
            var_2021.dispose();
            var_2021 = null;
         }
         if(var_1631 != null)
         {
            var_1631.dispose();
            var_1631 = null;
         }
         _assets = null;
         _communication = null;
      }
      
      public function requestInitialization() : void
      {
         _communication.connection.send(new GetBadgesComposer());
      }
      
      public function getMaxActiveCount() : int
      {
         return 5;
      }
      
      public function updateView() : void
      {
         if(var_1631 != null)
         {
            var_1631.updateAll(null);
         }
      }
      
      public function updateActionView() : void
      {
         var_1631.updateActionView();
      }
      
      private function startWearingBadge(param1:Badge) : void
      {
         var_2049.push(param1);
         param1.isInUse = true;
      }
      
      private function stopWearingBadge(param1:Badge) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < var_2049.length)
         {
            if(var_2049[_loc2_] == param1)
            {
               var_2049.splice(_loc2_,1);
               param1.isInUse = false;
               return;
            }
            _loc2_++;
         }
      }
      
      private function resetBadges() : void
      {
         if(var_2021)
         {
            var_2021.dispose();
            var_2021 = null;
         }
         if(var_121 != null)
         {
            for each(var _loc1_ in var_121)
            {
               _loc1_.dispose();
            }
            var_121 = null;
         }
         if(var_2049 != null)
         {
            var_2049 = null;
         }
      }
      
      public function initBadges(param1:Map) : void
      {
         var _loc3_:int = 0;
         var _loc6_:Boolean = false;
         var _loc5_:String = null;
         var _loc7_:String = null;
         var _loc2_:Badge = null;
         resetBadges();
         var_121 = new Vector.<Badge>(0);
         var_2049 = new Vector.<Badge>(0);
         var_2021 = new Map();
         for each(var _loc4_ in param1.getKeys())
         {
            _loc3_ = param1.getValue(_loc4_);
            if(_loc3_ > 0)
            {
               var_2021.add(_loc4_,_loc3_);
            }
            _loc6_ = var_319.unseenItemTracker.isUnseen(4,_loc3_);
            _loc5_ = String(controller.localization.getBadgeName(_loc4_));
            _loc7_ = String(controller.localization.getBadgeDesc(_loc4_));
            _loc2_ = new Badge(this,_loc4_,_loc5_,_loc7_,_loc6_);
            if(_loc6_)
            {
               var_121.unshift(_loc2_);
            }
            else
            {
               var_121.push(_loc2_);
            }
         }
      }
      
      public function updateBadge(param1:String, param2:Boolean, param3:int = 0) : void
      {
         var _loc7_:Boolean = false;
         var _loc6_:String = null;
         var _loc8_:String = null;
         var _loc4_:Badge = null;
         if(param3 > 0 && !var_2021.hasKey(param1))
         {
            var_2021.add(param1,param3);
         }
         var _loc5_:Badge;
         if((_loc5_ = getBadge(param1)) != null)
         {
            if(_loc5_.isInUse != param2)
            {
               if(param2)
               {
                  startWearingBadge(_loc5_);
               }
               else
               {
                  stopWearingBadge(_loc5_);
               }
            }
         }
         else
         {
            _loc7_ = var_319.unseenItemTracker.isUnseen(4,param3);
            _loc6_ = String(controller.localization.getBadgeName(param1));
            _loc8_ = String(controller.localization.getBadgeDesc(param1));
            _loc4_ = new Badge(this,param1,_loc6_,_loc8_,_loc7_);
            if(_loc7_)
            {
               var_121.unshift(_loc4_);
            }
            else
            {
               var_121.push(_loc4_);
            }
            if(param2)
            {
               startWearingBadge(_loc4_);
            }
         }
      }
      
      private function getBadge(param1:String) : Badge
      {
         var _loc3_:int = 0;
         var _loc2_:Badge = null;
         _loc3_ = 0;
         while(_loc3_ < var_121.length)
         {
            _loc2_ = var_121[_loc3_];
            if(_loc2_.badgeId == param1)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function removeBadge(param1:String) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Badge = null;
         _loc3_ = 0;
         while(_loc3_ < var_121.length)
         {
            _loc2_ = var_121[_loc3_];
            if(_loc2_.badgeId == param1)
            {
               var_121.splice(_loc3_,1);
               stopWearingBadge(_loc2_);
               updateView();
               return;
            }
            _loc3_++;
         }
      }
      
      public function toggleBadgeWearing(param1:String) : void
      {
         var _loc2_:Badge = getBadge(param1);
         if(_loc2_ != null)
         {
            if(_loc2_.isInUse)
            {
               stopWearingBadge(_loc2_);
            }
            else
            {
               startWearingBadge(_loc2_);
            }
            saveBadgeSelection();
         }
      }
      
      public function saveBadgeSelection() : void
      {
         var _loc4_:int = 0;
         var _loc2_:Badge = null;
         var _loc1_:SetActivatedBadgesComposer = new SetActivatedBadgesComposer();
         var _loc3_:Vector.<Badge> = getBadges(1);
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc2_ = _loc3_[_loc4_];
            _loc1_.addActivatedBadge(_loc2_.badgeId);
            _loc4_++;
         }
         _communication.connection.send(_loc1_);
      }
      
      public function setBadgeSelected(param1:String) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Badge = null;
         _loc3_ = 0;
         while(_loc3_ < var_121.length)
         {
            _loc2_ = var_121[_loc3_] as Badge;
            if(_loc2_ != null)
            {
               _loc2_.isSelected = _loc2_.badgeId == param1;
            }
            _loc3_++;
         }
         updateActionView();
      }
      
      public function forceSelection() : void
      {
         var _loc1_:Badge = getSelectedBadge();
         if(_loc1_ != null)
         {
            return;
         }
         var _loc3_:Vector.<Badge> = getBadges(0);
         if(_loc3_ != null && _loc3_.length > 0)
         {
            _loc1_ = _loc3_[0] as Badge;
            _loc1_.isSelected = true;
            updateView();
            return;
         }
         var _loc2_:Vector.<Badge> = getBadges(1);
         if(_loc2_ != null && _loc2_.length > 0)
         {
            _loc1_ = _loc2_[0] as Badge;
            _loc1_.isSelected = true;
            updateView();
         }
      }
      
      public function getSelectedBadge(param1:int = -1) : Badge
      {
         var _loc4_:int = 0;
         var _loc3_:Badge = null;
         var _loc2_:Vector.<Badge> = getBadges(param1);
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc4_];
            if(_loc3_.isSelected)
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function getBadges(param1:int = -1) : Vector.<Badge>
      {
         var _loc3_:* = undefined;
         switch(param1 - -1)
         {
            case 0:
               return var_121;
            case 1:
               _loc3_ = new Vector.<Badge>(0);
               for each(var _loc2_ in var_121)
               {
                  if(!_loc2_.isInUse)
                  {
                     _loc3_.push(_loc2_);
                  }
               }
               return _loc3_;
            case 2:
               return var_2049;
            default:
               class_14.log("Unexpected filter. Returning an empty array to maintain backward compatibility");
               return new Vector.<Badge>(0);
         }
      }
      
      public function getBadgeFromActive(param1:int) : Badge
      {
         return getItemInIndex(param1,1);
      }
      
      public function getBadgeFromInactive(param1:int) : Badge
      {
         return getItemInIndex(param1,0);
      }
      
      public function getItemInIndex(param1:int, param2:int = -1) : Badge
      {
         var _loc3_:Vector.<Badge> = getBadges(param2);
         if(param1 < 0 || param1 >= _loc3_.length)
         {
            return null;
         }
         return _loc3_[param1];
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         return var_1631.getWindowContainer();
      }
      
      public function closingInventoryView() : void
      {
         if(var_1631.isVisible)
         {
            resetUnseenItems();
         }
      }
      
      public function categorySwitch(param1:String) : void
      {
         if(param1 == "badges" && var_319.isVisible)
         {
            var_319.events.dispatchEvent(new Event("HABBO_INVENTORY_TRACKING_EVENT_BADGES"));
         }
      }
      
      public function subCategorySwitch(param1:String) : void
      {
      }
      
      public function get controller() : HabboInventory
      {
         return var_319;
      }
      
      public function resetUnseenItems() : void
      {
         if(!var_319.isMainViewActive)
         {
            return;
         }
         var_319.unseenItemTracker.resetCategory(4);
         for each(var _loc1_ in var_121)
         {
            _loc1_.isUnseen = false;
         }
         updateView();
         var_319.updateUnseenItemCounts();
      }
      
      public function selectItemById(param1:String) : void
      {
         setBadgeSelected(param1);
      }
      
      public function removeSelections() : void
      {
         for each(var _loc1_ in var_121)
         {
            _loc1_.isSelected = false;
         }
      }
   }
}
