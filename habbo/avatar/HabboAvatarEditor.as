package com.sulake.habbo.avatar
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.habbo.avatar.common.AvatarEditorGridColorItem;
   import com.sulake.habbo.avatar.common.AvatarEditorGridPartItem;
   import com.sulake.habbo.avatar.common.CategoryData;
   import com.sulake.habbo.avatar.common.ISideContentModel;
   import com.sulake.habbo.avatar.common.class_3554;
   import com.sulake.habbo.avatar.effects.EffectsModel;
   import com.sulake.habbo.avatar.events.AvatarUpdateEvent;
   import com.sulake.habbo.avatar.figuredata.FigureData;
   import com.sulake.habbo.avatar.generic.BodyModel;
   import com.sulake.habbo.avatar.head.HeadModel;
   import com.sulake.habbo.avatar.hotlooks.HotLooksModel;
   import com.sulake.habbo.avatar.legs.LegsModel;
   import com.sulake.habbo.avatar.nft.NftAvatarsModel;
   import com.sulake.habbo.avatar.structure.class_3360;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import com.sulake.habbo.avatar.structure.figure.ISetType;
   import com.sulake.habbo.avatar.structure.figure.class_3418;
   import com.sulake.habbo.avatar.structure.figure.class_3445;
   import com.sulake.habbo.avatar.torso.TorsoModel;
   import com.sulake.habbo.avatar.wardrobe.NftOutfit;
   import com.sulake.habbo.avatar.wardrobe.WardrobeModel;
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   import com.sulake.habbo.communication.messages.outgoing.register.class_675;
   import com.sulake.habbo.communication.messages.incoming.nft.UserNftWardrobeSelectionMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.nft.SaveUserNftWardrobeMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.nft.class_757;
   
   public class HabboAvatarEditor
   {
      
      public static const DEFAULT_MALE_FIGURE:String = "hr-100.hd-180-7.ch-215-66.lg-270-79.sh-305-62.ha-1002-70.wa-2007";
      
      public static const DEFAULT_FEMALE_FIGURE:String = "hr-515-33.hd-600-1.ch-635-70.lg-716-66-62.sh-735-68";
      
      private static const MAX_COLOR_LAYERS:int = 2;
       
      
      private var var_3999:uint;
      
      private var var_480:HabboAvatarEditorManager;
      
      private var var_2849:class_3360;
      
      private var var_1631:AvatarEditorView;
      
      private var var_1618:Boolean = false;
      
      private var var_1357:Map;
      
      private var var_2526:Map;
      
      private var var_2522:Dictionary;
      
      private var var_129:String = "M";
      
      private var _figureString:String;
      
      private var var_2821:class_3468 = null;
      
      private var var_3633:Boolean = false;
      
      private var var_3919:Boolean = false;
      
      private var var_2312:NftOutfit = null;
      
      private var var_2945:int;
      
      private var var_4484:Boolean = false;
      
      private var var_3170:UserNftWardrobeSelectionMessageEvent;
      
      private var var_1491:String;
      
      private var var_4092:String = "hr-100.hd-180-7.ch-215-66.lg-270-79.sh-305-62.ha-1002-70.wa-2007";
      
      private var var_4354:String = "M";
      
      private var var_4338:String = "hr-100.hd-180-7.ch-215-66.lg-270-79.sh-305-62.ha-1002-70.wa-2007";
      
      private var var_4591:String = "M";
      
      public function HabboAvatarEditor(param1:uint, param2:HabboAvatarEditorManager, param3:Boolean = false)
      {
         super();
         var_3999 = param1;
         var_480 = param2;
         var_2849 = var_480.avatarRenderManager.getFigureData();
         var_4484 = param3;
      }
      
      public function dispose() : void
      {
         if(var_3170 != null)
         {
            var_480.communication.removeHabboConnectionMessageEvent(var_3170);
            var_3170 = null;
         }
         if(var_1357 != null)
         {
            for each(var _loc2_ in var_1357)
            {
               _loc2_.dispose();
               _loc2_ = null;
            }
            var_1357 = null;
         }
         if(var_2526 != null)
         {
            for each(var _loc1_ in var_2526)
            {
               _loc1_.dispose();
               _loc1_ = null;
            }
            var_2526 = null;
         }
         if(var_1631 != null)
         {
            var_1631.dispose();
            var_1631 = null;
         }
         var_2849 = null;
         var_2522 = null;
         var_2821 = null;
      }
      
      private function init(param1:Array = null) : void
      {
         if(var_1618)
         {
            return;
         }
         if(var_480.communication)
         {
            var_3170 = new UserNftWardrobeSelectionMessageEvent(onUserNftWardrobeMessage);
            var_480.communication.addHabboConnectionMessageEvent(var_3170);
            sendGetSelectedNftWardrobeOutfitMessage();
         }
         var_1357 = new Map();
         var_2526 = new Map();
         var_2526.add("wardrobe",new WardrobeModel(this));
         var_1631 = new AvatarEditorView(this,param1);
         var_2522 = new Dictionary();
         var_2522["M"] = new FigureData(this);
         var_2522["F"] = new FigureData(this);
         var _loc3_:FigureData = var_2522["M"];
         var _loc2_:FigureData = var_2522["F"];
         _loc3_.loadAvatarData("hr-100.hd-180-7.ch-215-66.lg-270-79.sh-305-62.ha-1002-70.wa-2007","M");
         _loc2_.loadAvatarData("hr-515-33.hd-600-1.ch-635-70.lg-716-66-62.sh-735-68","F");
         var_1357.add("generic",new BodyModel(this));
         var_1357.add("head",new HeadModel(this));
         var_1357.add("torso",new TorsoModel(this));
         var_1357.add("legs",new LegsModel(this));
         if(param1 == null || param1.indexOf("hotlooks") > -1)
         {
            var_1357.add("hotlooks",new HotLooksModel(this));
         }
         var_1357.add("effects",new EffectsModel(this));
         var_1357.add("nfts",new NftAvatarsModel(this));
         var_1618 = true;
      }
      
      private function sendGetSelectedNftWardrobeOutfitMessage() : void
      {
         if(var_480.communication)
         {
            var_480.communication.connection.send(new class_757());
         }
      }
      
      private function onUserNftWardrobeMessage(param1:UserNftWardrobeSelectionMessageEvent) : void
      {
         var_1491 = param1.getParser().currentTokenId;
         var_4092 = param1.getParser().fallbackFigureString;
         var_4354 = param1.getParser().fallbackFigureGender;
         if(hasNftOutfit() && var_1631.currentViewId != "nfts")
         {
            loadFallbackFigure();
         }
      }
      
      public function loadAvatarInEditor(param1:String, param2:String, param3:int = 0) : void
      {
         switch(param2)
         {
            case "M":
            case "m":
            case "M":
               param2 = "M";
               break;
            case "F":
            case "f":
            case "F":
               param2 = "F";
               break;
            default:
               param2 = "M";
         }
         this.clubMemberLevel = param3;
         var _loc4_:Boolean = false;
         var _loc5_:FigureData;
         if((_loc5_ = var_2522[param2]) == null)
         {
            return;
         }
         _loc5_.loadAvatarData(param1,param2);
         if(param2 != this.gender)
         {
            this.gender = param2;
            _loc4_ = true;
         }
         if(_figureString != param1)
         {
            _figureString = param1;
            _loc4_ = true;
         }
         if(var_1357 && _loc4_)
         {
            for each(var _loc6_ in var_1357)
            {
               _loc6_.reset();
            }
         }
         if(var_1631 != null)
         {
            var_1631.update();
         }
      }
      
      public function getFigureSetType(param1:String) : ISetType
      {
         if(var_2849 == null)
         {
            return null;
         }
         return var_2849.getSetType(param1);
      }
      
      public function getPalette(param1:int) : class_3445
      {
         if(var_2849 == null)
         {
            return null;
         }
         return var_2849.getPalette(param1);
      }
      
      public function openWindow(param1:class_3468, param2:Array = null, param3:Boolean = false, param4:String = null, param5:String = "generic") : class_3514
      {
         var_2821 = param1;
         var_3633 = param3;
         init(param2);
         selectDefaultCategory(param2,param5);
         return var_1631.getFrame(param2,param4);
      }
      
      public function embedToContext(param1:IWindowContainer = null, param2:class_3468 = null, param3:Array = null, param4:Boolean = false) : Boolean
      {
         var_2821 = param2;
         var_3633 = param4;
         init(param3);
         var_1631.embedToContext(param1,param3);
         selectDefaultCategory(param3);
         return true;
      }
      
      private function selectDefaultCategory(param1:Array, param2:String = "generic") : void
      {
         var _loc3_:Boolean = param1 != null && param1.length > 0;
         if(param2 != null && (!_loc3_ || param1.indexOf(param2) >= 0))
         {
            toggleAvatarEditorPage(param2);
         }
         else if(_loc3_)
         {
            toggleAvatarEditorPage(param1[0]);
         }
         else
         {
            toggleAvatarEditorPage("generic");
         }
      }
      
      public function get instanceId() : uint
      {
         return var_3999;
      }
      
      public function hide() : void
      {
         var_1631.hide();
      }
      
      public function getCategoryWindowContainer(param1:String) : IWindow
      {
         var _loc2_:class_3554 = var_1357.getValue(param1) as class_3554;
         if(_loc2_ != null)
         {
            return _loc2_.getWindowContainer();
         }
         return null;
      }
      
      public function activateCategory(param1:String) : void
      {
         var _loc2_:class_3554 = var_1357.getValue(param1) as class_3554;
         if(_loc2_)
         {
            _loc2_.switchCategory();
         }
      }
      
      public function getSideContentWindowContainer(param1:String) : IWindowContainer
      {
         var _loc2_:ISideContentModel = var_2526.getValue(param1) as ISideContentModel;
         if(_loc2_ != null)
         {
            return _loc2_.getWindowContainer();
         }
         return null;
      }
      
      public function toggleAvatarEditorPage(param1:String) : void
      {
         if(var_1631)
         {
            var_1631.toggleCategoryView(param1,false);
         }
      }
      
      public function useClubClothing() : void
      {
         if(var_1357 == null)
         {
            return;
         }
         update();
      }
      
      public function disableClubClothing() : void
      {
         if(var_1357 == null)
         {
            return;
         }
         update();
      }
      
      public function get figureData() : FigureData
      {
         return var_2522[var_129];
      }
      
      public function saveCurrentSelection() : void
      {
         var _loc1_:String = figureData.getFigureString();
         var _loc2_:String = figureData.gender;
         if(var_2821 != null)
         {
            var_2821.saveFigure(_loc1_,_loc2_);
         }
         else
         {
            if(var_480.communication)
            {
               if(var_2312 != null)
               {
                  var_480.communication.connection.send(new SaveUserNftWardrobeMessageComposer(var_2312.tokenId));
                  sendGetSelectedNftWardrobeOutfitMessage();
                  var_2312 = null;
               }
               else
               {
                  var_480.communication.connection.send(new class_675(_loc1_,_loc2_));
               }
            }
            if(hasNftOutfit())
            {
               var_1491 = null;
            }
            var_480.events.dispatchEvent(new AvatarUpdateEvent(_loc1_));
            if(var_3919)
            {
               if(figureData.avatarEffectType != -1)
               {
                  var_480.inventory.setEffectSelected(figureData.avatarEffectType);
               }
               else
               {
                  var_480.inventory.deselectAllEffects(true);
               }
            }
            var_3919 = false;
         }
      }
      
      public function generateDataContent(param1:class_3554, param2:String) : CategoryData
      {
         var _loc21_:int = 0;
         var _loc14_:class_3418 = null;
         var _loc9_:AvatarEditorGridPartItem = null;
         var _loc22_:ISetType = null;
         var _loc10_:class_3445 = null;
         var _loc13_:Array = null;
         var _loc12_:Array = null;
         var _loc19_:Boolean = false;
         var _loc11_:int = 0;
         var _loc15_:* = false;
         var _loc18_:AvatarEditorGridColorItem = null;
         var _loc26_:int = 0;
         var _loc30_:Array = null;
         var _loc17_:int = 0;
         var _loc32_:* = false;
         var _loc33_:BitmapDataAsset = null;
         var _loc25_:BitmapData = null;
         var _loc24_:IWindowContainer = null;
         var _loc29_:* = false;
         var _loc31_:Map = null;
         var _loc16_:int = 0;
         var _loc27_:int = 0;
         var _loc6_:Boolean = false;
         var _loc34_:* = false;
         var _loc3_:Boolean = false;
         var _loc20_:BitmapDataAsset = null;
         var _loc23_:BitmapData = null;
         var _loc7_:IWindowContainer = null;
         var _loc5_:Array = null;
         if(!param1)
         {
            return null;
         }
         if(!param2)
         {
            return null;
         }
         var _loc4_:Array = [];
         var _loc8_:Array = [];
         _loc21_ = 0;
         while(_loc21_ < 2)
         {
            _loc8_.push([]);
            _loc21_++;
         }
         if(!(_loc22_ = getFigureSetType(param2)))
         {
            return null;
         }
         if(_loc22_ != null)
         {
            if(!(_loc10_ = getPalette(_loc22_.paletteID)))
            {
               return null;
            }
            if(!(_loc13_ = figureData.getColourIds(param2)))
            {
               _loc13_ = [];
            }
            _loc12_ = new Array(_loc13_.length);
            _loc19_ = showClubItemsDimmedConfiguration();
            for each(var _loc28_ in _loc10_.colors)
            {
               if(_loc28_.isSelectable && (_loc19_ || clubMemberLevel >= _loc28_.clubLevel))
               {
                  _loc11_ = 0;
                  while(_loc11_ < 2)
                  {
                     _loc15_ = clubMemberLevel < _loc28_.clubLevel;
                     _loc18_ = new AvatarEditorGridColorItem(AvatarEditorView.COLOUR_WINDOW.clone() as IWindowContainer,param1,_loc28_,_loc15_);
                     _loc8_[_loc11_].push(_loc18_);
                     _loc11_++;
                  }
                  if(param2 != "hd")
                  {
                     _loc26_ = 0;
                     while(_loc26_ < _loc13_.length)
                     {
                        if(_loc28_.id == _loc13_[_loc26_])
                        {
                           _loc12_[_loc26_] = _loc28_;
                        }
                        _loc26_++;
                     }
                  }
               }
            }
            if(_loc19_)
            {
               _loc17_ = 2;
               _loc30_ = var_480.avatarRenderManager.getMandatoryAvatarPartSetIds(gender,_loc17_);
            }
            else
            {
               _loc30_ = var_480.avatarRenderManager.getMandatoryAvatarPartSetIds(gender,clubMemberLevel);
            }
            if(_loc32_ = _loc30_.indexOf(param2) == -1)
            {
               _loc25_ = ((_loc33_ = var_480.windowManager.assets.getAssetByName("avatar_editor_generic_remove_selection") as BitmapDataAsset).content as BitmapData).clone();
               (_loc24_ = AvatarEditorView.THUMB_WINDOW.clone() as IWindowContainer).name = "REMOVE_ITEM";
               (_loc9_ = new AvatarEditorGridPartItem(_loc24_,param1,null,null,false)).iconImage = _loc25_;
               _loc4_.push(_loc9_);
            }
            _loc29_ = param2 != "hd";
            _loc27_ = (_loc16_ = int((_loc31_ = _loc22_.partSets).length)) - 1;
            while(_loc27_ >= 0)
            {
               _loc14_ = _loc31_.getWithIndex(_loc27_);
               _loc6_ = false;
               if(_loc14_.gender == "U")
               {
                  _loc6_ = true;
               }
               else if(_loc14_.gender == gender)
               {
                  _loc6_ = true;
               }
               if(_loc14_.isSelectable && _loc6_ && (_loc19_ || clubMemberLevel >= _loc14_.clubLevel))
               {
                  _loc34_ = clubMemberLevel < _loc14_.clubLevel;
                  _loc3_ = true;
                  if(_loc14_.isSellable)
                  {
                     _loc3_ = manager.inventory && var_480.inventory.hasFigureSetIdInInventory(_loc14_.id) || isDevelopmentEditor();
                  }
                  if(_loc3_)
                  {
                     _loc9_ = new AvatarEditorGridPartItem(AvatarEditorView.THUMB_WINDOW.clone() as IWindowContainer,param1,_loc14_,_loc12_,_loc29_,_loc34_);
                     _loc4_.push(_loc9_);
                  }
               }
               _loc27_--;
            }
         }
         _loc4_.sort(showClubItemsFirst ? orderByClubDesc : orderByClubAsc);
         if(var_4484 || var_480.getBoolean("avatareditor.support.sellablefurni"))
         {
            _loc23_ = ((_loc20_ = var_480.windowManager.assets.getAssetByName("camera_zoom_in") as BitmapDataAsset).content as BitmapData).clone();
            (_loc7_ = AvatarEditorView.THUMB_WINDOW.clone() as IWindowContainer).name = "GET_MORE";
            (_loc9_ = new AvatarEditorGridPartItem(_loc7_,param1,null,null,false)).iconImage = _loc23_;
            _loc4_.push(_loc9_);
         }
         _loc21_ = 0;
         while(_loc21_ < 2)
         {
            (_loc5_ = _loc8_[_loc21_] as Array).sort(orderPaletteByClub);
            _loc21_++;
         }
         return new CategoryData(_loc4_,_loc8_);
      }
      
      public function isSideContentEnabled() : Boolean
      {
         return var_3633;
      }
      
      public function hasInvalidClubItems() : Boolean
      {
         var _loc1_:Boolean = false;
         for each(var _loc2_ in var_1357.getValues())
         {
            _loc1_ = _loc2_.hasClubItemsOverLevel(clubMemberLevel);
            if(_loc1_)
            {
               return true;
            }
         }
         return false;
      }
      
      public function hasInvalidSellableItems() : Boolean
      {
         var _loc1_:Boolean = false;
         for each(var _loc2_ in var_1357.getValues())
         {
            _loc1_ = _loc2_.hasInvalidSellableItems(var_480.inventory);
            if(_loc1_)
            {
               return true;
            }
         }
         return false;
      }
      
      public function stripClubItems() : void
      {
         for each(var _loc1_ in var_1357.getValues())
         {
            _loc1_.stripClubItemsOverLevel(clubMemberLevel);
         }
         figureData.updateView();
      }
      
      public function stripInvalidSellableItems() : void
      {
         for each(var _loc1_ in var_1357.getValues())
         {
            _loc1_.stripInvalidSellableItems();
         }
         figureData.updateView();
      }
      
      public function getDefaultColour(param1:String) : int
      {
         var _loc3_:class_3445 = null;
         var _loc2_:ISetType = getFigureSetType(param1);
         if(_loc2_ != null)
         {
            _loc3_ = getPalette(_loc2_.paletteID);
            for each(var _loc4_ in _loc3_.colors)
            {
               if(_loc4_.isSelectable && clubMemberLevel >= _loc4_.clubLevel)
               {
                  return _loc4_.id;
               }
            }
         }
         return -1;
      }
      
      private function orderByClubAsc(param1:AvatarEditorGridPartItem, param2:AvatarEditorGridPartItem) : Number
      {
         var _loc4_:Number = param1.partSet == null ? -1 : param1.partSet.clubLevel;
         var _loc5_:Number = param2.partSet == null ? -1 : param2.partSet.clubLevel;
         var _loc6_:Boolean = param1.partSet == null ? false : param1.partSet.isSellable;
         var _loc3_:Boolean = param2.partSet == null ? false : param2.partSet.isSellable;
         if(_loc6_ && !_loc3_)
         {
            return 1;
         }
         if(_loc3_ && !_loc6_)
         {
            return -1;
         }
         if(_loc4_ < _loc5_)
         {
            return -1;
         }
         if(_loc4_ > _loc5_)
         {
            return 1;
         }
         if(param1.partSet.id < param2.partSet.id)
         {
            return -1;
         }
         if(param1.partSet.id > param2.partSet.id)
         {
            return 1;
         }
         return 0;
      }
      
      private function orderByClubDesc(param1:AvatarEditorGridPartItem, param2:AvatarEditorGridPartItem) : Number
      {
         var _loc4_:Number = param1.partSet == null ? 9999999999 : param1.partSet.clubLevel;
         var _loc5_:Number = param2.partSet == null ? 9999999999 : param2.partSet.clubLevel;
         var _loc6_:Boolean = param1.partSet == null ? false : param1.partSet.isSellable;
         var _loc3_:Boolean = param2.partSet == null ? false : param2.partSet.isSellable;
         if(_loc6_ && !_loc3_)
         {
            return 1;
         }
         if(_loc3_ && !_loc6_)
         {
            return -1;
         }
         if(_loc4_ > _loc5_)
         {
            return -1;
         }
         if(_loc4_ < _loc5_)
         {
            return 1;
         }
         if(param1.partSet.id > param2.partSet.id)
         {
            return -1;
         }
         if(param1.partSet.id < param2.partSet.id)
         {
            return 1;
         }
         return 0;
      }
      
      private function orderPaletteByClub(param1:AvatarEditorGridColorItem, param2:AvatarEditorGridColorItem) : Number
      {
         var _loc3_:Number = param1.partColor == null ? -1 : param1.partColor.clubLevel as Number;
         var _loc4_:Number = param2.partColor == null ? -1 : param2.partColor.clubLevel as Number;
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(param1.partColor.index < param2.partColor.index)
         {
            return -1;
         }
         if(param1.partColor.index > param2.partColor.index)
         {
            return 1;
         }
         return 0;
      }
      
      public function get gender() : String
      {
         return var_129;
      }
      
      public function set gender(param1:String) : void
      {
         if(var_129 == param1)
         {
            return;
         }
         var_129 = param1;
         for each(var _loc2_ in var_1357)
         {
            _loc2_.reset();
         }
         if(var_1631 != null)
         {
            var_1631.update();
         }
      }
      
      public function get handler() : AvatarEditorMessageHandler
      {
         return var_480.handler;
      }
      
      public function get wardrobe() : WardrobeModel
      {
         if(!var_1618)
         {
            return null;
         }
         return var_2526.getValue("wardrobe");
      }
      
      public function get effects() : EffectsModel
      {
         if(!var_1618)
         {
            return null;
         }
         return var_1357.getValue("effects");
      }
      
      public function set clubMemberLevel(param1:int) : void
      {
         var_2945 = param1;
      }
      
      public function get clubMemberLevel() : int
      {
         if(!var_2945)
         {
            return var_480.sessionData.clubLevel;
         }
         return var_2945;
      }
      
      public function verifyClubLevel() : Boolean
      {
         return var_480.catalog.verifyClubLevel();
      }
      
      private function get showClubItemsFirst() : Boolean
      {
         return var_480.getBoolean("avatareditor.show.clubitems.first");
      }
      
      private function showClubItemsDimmedConfiguration() : Boolean
      {
         return var_480.getBoolean("avatareditor.show.clubitems.dimmed");
      }
      
      public function get manager() : HabboAvatarEditorManager
      {
         return var_480;
      }
      
      public function update() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         for each(_loc1_ in var_1357)
         {
            _loc1_.reset();
         }
         for each(_loc2_ in var_2526)
         {
            _loc2_.reset();
         }
         if(var_1631)
         {
            var_1631.update();
         }
      }
      
      public function setAvatarEffectType(param1:int) : void
      {
         figureData.avatarEffectType = param1;
         figureData.updateView();
         var_3919 = true;
      }
      
      public function setNftOutfit(param1:NftOutfit) : void
      {
         var_2312 = param1;
         var_4338 = figureData.getFigureString();
         var_4591 = figureData.gender;
      }
      
      public function hasSetNftOutfitInViewer() : Boolean
      {
         return var_2312 != null;
      }
      
      public function loadNftFigure() : void
      {
         var _loc1_:NftAvatarsModel = null;
         var _loc2_:NftOutfit = null;
         if(var_2312)
         {
            loadAvatarInEditor(var_2312.figure,var_2312.gender,var_2945);
         }
         else if(var_1491 != null)
         {
            _loc1_ = var_1357.getValue("nfts");
            if(_loc1_)
            {
               _loc2_ = _loc1_.getNftAvatarByTokenId(var_1491);
               if(_loc2_)
               {
                  setNftOutfit(_loc2_);
                  loadAvatarInEditor(_loc2_.figure,_loc2_.gender,var_2945);
               }
            }
         }
      }
      
      public function loadRollbackFigure() : void
      {
         if(var_2312)
         {
            loadAvatarInEditor(var_4338,var_4591,var_2945);
         }
      }
      
      public function loadFallbackFigure() : void
      {
         if(var_4092)
         {
            loadAvatarInEditor(var_4092,var_4354,var_2945);
         }
      }
      
      public function hasNftOutfit() : Boolean
      {
         return var_1491 != null;
      }
      
      public function get view() : AvatarEditorView
      {
         return var_1631;
      }
      
      public function openHabboClubAdWindow() : void
      {
         if(var_480.catalog)
         {
            var_480.catalog.openClubCenter();
         }
      }
      
      public function isDevelopmentEditor() : Boolean
      {
         return var_3999 == 3;
      }
   }
}
