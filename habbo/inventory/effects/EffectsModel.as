package com.sulake.habbo.inventory.effects
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.IInventoryModel;
   import com.sulake.habbo.inventory.class_3358;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import com.sulake.habbo.communication.messages.outgoing.inventory.avatareffect.AvatarEffectSelectedComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.avatareffect.AvatarEffectActivatedComposer;
   
   public class EffectsModel implements IInventoryModel
   {
      
      public static const FILTER_NONE:int = -1;
      
      public static const FILTER_INCLUDE_INACTIVE:int = 0;
      
      public static const FILTER_INCLUDE_ACTIVE:int = 1;
       
      
      private var var_319:HabboInventory;
      
      private var var_1631:EffectsView;
      
      private var var_264:Array;
      
      private var _assets:IAssetLibrary;
      
      private var _communication:IHabboCommunicationManager;
      
      private var var_3423:EffectListProxy;
      
      private var var_3475:EffectListProxy;
      
      private var _disposed:Boolean = false;
      
      private var var_2333:int = -1;
      
      public function EffectsModel(param1:HabboInventory, param2:IHabboWindowManager, param3:IHabboCommunicationManager, param4:IAssetLibrary, param5:IHabboLocalizationManager)
      {
         super();
         var_319 = param1;
         var_264 = [];
         _assets = param4;
         _communication = param3;
         var_3423 = new EffectListProxy(this,1);
         var_3475 = new EffectListProxy(this,0);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get lastActivatedEffect() : int
      {
         return var_2333;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            var_319 = null;
            if(var_1631 != null)
            {
               var_1631.dispose();
            }
            if(var_3423 != null)
            {
               var_3423.dispose();
               var_3423 = null;
            }
            if(var_3475 != null)
            {
               var_3475.dispose();
               var_3475 = null;
            }
            _disposed = true;
         }
      }
      
      public function requestInitialization() : void
      {
      }
      
      public function categorySwitch(param1:String) : void
      {
      }
      
      public function addEffect(param1:Effect, param2:Boolean = true) : void
      {
         var _loc4_:BitmapDataAsset = null;
         var _loc3_:Effect = getEffect(param1.type);
         if(_loc3_ != null)
         {
            _loc3_.amountInInventory++;
         }
         else
         {
            if((_loc4_ = BitmapDataAsset(_assets.getAssetByName("fx_icon_" + param1.type + "_png"))) != null)
            {
               param1.iconImage = BitmapData(_loc4_.content);
            }
            var_264.push(param1);
         }
         if(param2)
         {
            refreshViews();
         }
      }
      
      private function getEffect(param1:int) : Effect
      {
         var _loc3_:int = 0;
         var _loc2_:Effect = null;
         _loc3_ = 0;
         while(_loc3_ < var_264.length)
         {
            _loc2_ = var_264[_loc3_];
            if(_loc2_.type == param1)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
      
      private function removeEffect(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Effect = null;
         _loc3_ = 0;
         while(_loc3_ < var_264.length)
         {
            _loc2_ = var_264[_loc3_];
            if(_loc2_.type == param1)
            {
               var_264.splice(_loc3_,1);
               refreshViews();
               return;
            }
            _loc3_++;
         }
      }
      
      public function refreshViews() : void
      {
         if(var_1631)
         {
            var_1631.updateListViews();
            var_1631.updateActionView();
         }
      }
      
      public function requestEffectActivated(param1:int) : void
      {
         var_319.communication.connection.send(new AvatarEffectActivatedComposer(param1));
      }
      
      public function setEffectActivated(param1:int) : void
      {
         var _loc2_:Effect = getEffect(param1);
         if(_loc2_ != null)
         {
            stopUsingAllEffects(false,false);
            _loc2_.isActive = true;
            _loc2_.isInUse = true;
            refreshViews();
         }
      }
      
      public function useEffect(param1:int) : void
      {
         stopUsingAllEffects(false,false,true);
         var _loc2_:Effect = getEffect(param1);
         if(_loc2_ == null)
         {
            return;
         }
         if(!_loc2_.isActive)
         {
            requestEffectActivated(_loc2_.type);
         }
         if(_loc2_.isInUse == false)
         {
            _loc2_.isInUse = true;
            var_319.communication.connection.send(new AvatarEffectSelectedComposer(param1));
            var_2333 = param1;
            refreshViews();
         }
      }
      
      public function stopUsingEffect(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:Effect = getEffect(param1);
         if(_loc3_ != null)
         {
            if(_loc3_.isInUse == true)
            {
               _loc3_.isInUse = false;
               if(param2)
               {
                  var_319.communication.connection.send(new AvatarEffectSelectedComposer(-1));
                  var_2333 = -1;
               }
               refreshViews();
            }
         }
      }
      
      public function stopUsingAllEffects(param1:Boolean = true, param2:Boolean = true, param3:Boolean = false) : void
      {
         var _loc5_:int = 0;
         var _loc4_:Effect = null;
         _loc5_ = 0;
         while(_loc5_ < var_264.length)
         {
            (_loc4_ = var_264[_loc5_]).isInUse = false;
            _loc5_++;
         }
         if(param1)
         {
            var_319.communication.connection.send(new AvatarEffectSelectedComposer(-1));
         }
         if(param2)
         {
            refreshViews();
         }
         if(param3)
         {
            var_2333 = -1;
         }
      }
      
      public function toggleEffectSelected(param1:int) : void
      {
         var _loc2_:Effect = getEffect(param1);
         if(_loc2_ != null)
         {
            if(_loc2_.isSelected)
            {
               setEffectDeselected(param1);
            }
            else
            {
               setEffectSelected(param1);
            }
            refreshViews();
         }
      }
      
      public function getEffectInterface(param1:int) : class_3358
      {
         return getEffect(param1) as class_3358;
      }
      
      public function setEffectSelected(param1:int) : void
      {
         var _loc2_:Effect = getEffect(param1);
         if(_loc2_ != null)
         {
            setAllEffectsDeselected(false);
            _loc2_.isSelected = true;
            refreshViews();
         }
      }
      
      public function setEffectDeselected(param1:int) : void
      {
         var _loc2_:Effect = getEffect(param1);
         if(_loc2_ != null)
         {
            _loc2_.isSelected = false;
            refreshViews();
         }
      }
      
      private function setAllEffectsDeselected(param1:Boolean = true) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Effect = null;
         _loc3_ = 0;
         while(_loc3_ < var_264.length)
         {
            _loc2_ = var_264[_loc3_];
            _loc2_.isSelected = false;
            _loc3_++;
         }
         if(param1)
         {
            refreshViews();
         }
      }
      
      public function getSelectedEffect(param1:int = -1) : Effect
      {
         var _loc4_:int = 0;
         var _loc3_:Effect = null;
         var _loc2_:Array = getEffects(param1);
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
      
      public function getEffects(param1:int = -1) : Array
      {
         var _loc4_:int = 0;
         var _loc3_:Effect = null;
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < var_264.length)
         {
            _loc3_ = var_264[_loc4_];
            if(_loc3_.isActive && param1 == 1 || !_loc3_.isActive && param1 == 0 || param1 == -1)
            {
               _loc2_.push(_loc3_);
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function setEffectExpired(param1:int) : void
      {
         var_2333 = -1;
         var _loc2_:Effect = getEffect(param1);
         if(_loc2_ != null)
         {
            if(_loc2_.amountInInventory > 1)
            {
               _loc2_.setOneEffectExpired();
               refreshViews();
            }
            else
            {
               removeEffect(_loc2_.type);
            }
         }
      }
      
      public function getItemInIndex(param1:int, param2:int = -1) : Effect
      {
         var _loc3_:Array = getEffects(param2);
         if(param1 < 0 || param1 >= _loc3_.length)
         {
            return null;
         }
         return _loc3_[param1];
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         return !!var_1631 ? var_1631.getWindowContainer() : null;
      }
      
      public function closingInventoryView() : void
      {
      }
      
      public function subCategorySwitch(param1:String) : void
      {
      }
      
      public function reactivateLastEffect() : void
      {
         if(var_2333 != -1)
         {
            useEffect(var_2333);
         }
      }
      
      public function updateView() : void
      {
         if(var_1631 && !var_1631.disposed)
         {
            var_1631.updateListViews();
            var_1631.updateActionView();
         }
      }
      
      public function selectItemById(param1:String) : void
      {
         setEffectSelected(int(param1));
      }
   }
}
