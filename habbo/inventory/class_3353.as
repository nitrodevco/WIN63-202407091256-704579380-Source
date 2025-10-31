package com.sulake.habbo.inventory
{
   import assets.class_14;

   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.inventory.badges.BadgesModel;
   import com.sulake.habbo.inventory.bots.BotsModel;
   import com.sulake.habbo.inventory.effects.Effect;
   import com.sulake.habbo.inventory.effects.EffectsModel;
   import com.sulake.habbo.inventory.events.HabboInventoryFurniListParsedEvent;
   import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
   import com.sulake.habbo.inventory.furni.FurniModel;
   import com.sulake.habbo.inventory.items.FurnitureItem;
   import com.sulake.habbo.inventory.items.GroupItem;
   import com.sulake.habbo.inventory.marketplace.MarketplaceModel;
   import com.sulake.habbo.inventory.pets.PetsModel;
   import com.sulake.habbo.inventory.trading.TradingModel;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.class_3490;
   import com.sulake.habbo.session.furniture.class_3365;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementsScoreEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.badges.BadgeReceivedEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.badges.BadgesEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.badges.BadgePointLimitsEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.OpenConnectionMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.FlatAccessDeniedMessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.class_1119;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.class_1125;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.class_1195;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.class_1336;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.class_1347;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.class_1415;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.class_1420;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.class_1504;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.class_1549;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.class_1550;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceItemStatsEventParser;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceConfigurationEventParser;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceMakeOfferResult;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceCanMakeOfferResult;
   import com.sulake.habbo.communication.messages.parser.users.ScrSendUserInfoEventParser;
   import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectActivatedMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectExpiredMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectAddedMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectsMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.navigator.FlatAccessDeniedMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetAddedToInventoryEventParser;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetInventoryEventParser;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetRemovedFromInventoryEventParser;
   import com.sulake.habbo.communication.messages.incoming.inventory.pets.GoToBreedingNestFailureEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetAddedToInventoryEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetInventoryEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetRemovedFromInventoryEvent;
   import com.sulake.habbo.communication.messages.parser.notifications.HabboAchievementNotificationMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgeReceivedEventParser;
   import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgesEventParser;
   import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgePointLimitsEventParser;
   import com.sulake.habbo.communication.messages.parser.inventory.badges.class_1647;
   import com.sulake.habbo.communication.messages.parser.inventory.furni.PostItPlacedEventParser;
   import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListAddOrUpdateEventParser;
   import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListEventParser;
   import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListRemoveEventParser;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingOpenEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.class_1704;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingConfirmationEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingOtherNotAllowedEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingAcceptEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingYouAreNotAllowedEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradeSilverFeeMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingNotOpenEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCloseEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCompletedEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradeSilverSetMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradeOpenFailedEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingItemListEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.bots.BotRemovedFromInventoryEventParser;
   import com.sulake.habbo.communication.messages.parser.inventory.bots.BotAddedToInventoryEventParser;
   import com.sulake.habbo.communication.messages.parser.inventory.bots.BotInventoryEventParser;
   import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementsScoreEventParser;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.class_1707;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.PostItPlacedEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListInvalidateEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListAddOrUpdateEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListRemoveEvent;
   import com.sulake.habbo.communication.messages.incoming.users.ScrSendUserInfoEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HabboUserBadgesMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectActivatedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.class_1689;
   import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectAddedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectExpiredMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceConfigurationEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceItemStatsEvent;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceMakeOfferResult;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceCanMakeOfferResult;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.bots.BotRemovedFromInventoryEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.bots.BotInventoryEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.bots.BotAddedToInventoryEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.NotEnoughBalanceMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.clothing.FigureSetIdsEvent;

   [SecureSWF(rename="true")]
   public class class_3353
   {

      private static const GROUPED_FURNI_TYPE:String = "credit_groupitem_type_id";

      private var _inventory:HabboInventory;

      private var _com:IHabboCommunicationManager;

      private var var_3568:Vector.<Map>;

      private var var_3320:Vector.<Map>;

      private var var_4974:Vector.<Map>;

      private var var_3540:Vector.<Map>;

      private var var_1801:int;

      public function class_3353(param1:HabboInventory)
      {
         super();
         _inventory = param1;
         _com = _inventory.communication;
         _com.addHabboConnectionMessageEvent(new OpenConnectionMessageEvent(onRoomLeft));
         _com.addHabboConnectionMessageEvent(new MarketplaceItemStatsEvent(onMarketplaceItemStats));
         _com.addHabboConnectionMessageEvent(new UserRightsMessageEvent(onUserRights));
         _com.addHabboConnectionMessageEvent(new FlatAccessDeniedMessageEvent(onFlatAccessDenied));
         _com.addHabboConnectionMessageEvent(new AvatarEffectsMessageEvent(onAvatarEffects));
         _com.addHabboConnectionMessageEvent(new HabboAchievementNotificationMessageEvent(onAchievementReceived));
         _com.addHabboConnectionMessageEvent(new FurniListRemoveEvent(onFurniListRemove));
         _com.addHabboConnectionMessageEvent(new FurniListEvent(onFurniList));
         _com.addHabboConnectionMessageEvent(new AvatarEffectExpiredMessageEvent(onAvatarEffectExpired));
         _com.addHabboConnectionMessageEvent(new TradingCompletedEvent(onTradingCompleted));
         _com.addHabboConnectionMessageEvent(new AchievementsScoreEvent(onAchievementsScore));
         _com.addHabboConnectionMessageEvent(new CloseConnectionMessageEvent(onRoomLeft));
         _com.addHabboConnectionMessageEvent(new GoToBreedingNestFailureEvent(onGoToBreedingNestFailure));
         _com.addHabboConnectionMessageEvent(new BotAddedToInventoryEvent(onBotAdded));
         _com.addHabboConnectionMessageEvent(new MarketplaceCanMakeOfferResult(onMarketplaceCanMakeOfferResult));
         _com.addHabboConnectionMessageEvent(new BadgePointLimitsEvent(onBadgePointLimits));
         _com.addHabboConnectionMessageEvent(new BotRemovedFromInventoryEvent(onBotRemoved));
         _com.addHabboConnectionMessageEvent(new TradingAcceptEvent(onTradingAccepted));
         _com.addHabboConnectionMessageEvent(new ScrSendUserInfoEvent(onClubStatus));
         _com.addHabboConnectionMessageEvent(new FurniListAddOrUpdateEvent(onFurnitureAddOrUpdate));
         _com.addHabboConnectionMessageEvent(new FurniListInvalidateEvent(onFurniListInvalidate));
         _com.addHabboConnectionMessageEvent(new TradingYouAreNotAllowedEvent(onTradingYouAreNotAllowed));
         _com.addHabboConnectionMessageEvent(new TradingConfirmationEvent(onTradingConfirmation));
         _com.addHabboConnectionMessageEvent(new PostItPlacedEvent(onPostItPlaced));
         _com.addHabboConnectionMessageEvent(new TradingOtherNotAllowedEvent(onTradingOtherNotAllowed));
         _com.addHabboConnectionMessageEvent(new HabboUserBadgesMessageEvent(onUserBadges));
         _com.addHabboConnectionMessageEvent(new TradingNotOpenEvent(onTradingNotOpen));
         _com.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
         _com.addHabboConnectionMessageEvent(new TradeSilverFeeMessageEvent(onTradeSilverFee));
         _com.addHabboConnectionMessageEvent(new BotInventoryEvent(onBots));
         _com.addHabboConnectionMessageEvent(new TradingCloseEvent(onTradingClose));
         _com.addHabboConnectionMessageEvent(new TradingOpenEvent(onTradingOpen));
         _com.addHabboConnectionMessageEvent(new FigureSetIdsEvent(onFigureSetIds));
         _com.addHabboConnectionMessageEvent(new NotEnoughBalanceMessageEvent(onNotEnoughCredits));
         _com.addHabboConnectionMessageEvent(new TradeSilverSetMessageEvent(onTradeSilverSet));
         _com.addHabboConnectionMessageEvent(new TradeOpenFailedEvent(onTradingOpenFailed));
         _com.addHabboConnectionMessageEvent(new MarketplaceConfigurationEvent(onMarketplaceConfiguration));
         _com.addHabboConnectionMessageEvent(new PetInventoryEvent(onPets));
         _com.addHabboConnectionMessageEvent(new AvatarEffectActivatedMessageEvent(onAvatarEffectActivated));
         _com.addHabboConnectionMessageEvent(new BadgeReceivedEvent(onBadgeReceived));
         _com.addHabboConnectionMessageEvent(new PetRemovedFromInventoryEvent(onPetRemoved));
         _com.addHabboConnectionMessageEvent(new AvatarEffectAddedMessageEvent(onAvatarEffectAdded));
         _com.addHabboConnectionMessageEvent(new TradingItemListEvent(onTradingItemList));
         _com.addHabboConnectionMessageEvent(new MarketplaceMakeOfferResult(onMarketplaceMakeOfferResult));
         _com.addHabboConnectionMessageEvent(new BadgesEvent(onBadges));
         _com.addHabboConnectionMessageEvent(new PetAddedToInventoryEvent(onPetAdded));
      }

      public function dispose():void
      {
         _inventory = null;
         _com = null;
      }

      public function onFurniList(param1:FurniListEvent):void
      {
         var _loc4_:FurniListEventParser;
         if ((_loc4_ = param1.getParser()) == null)
         {
            return;
         }
         if (!_inventory.isMainViewInitialized)
         {
            _inventory.initializeFurniturePage();
         }
         var _loc2_:FurniModel = _inventory.furniModel;
         if (_loc2_ == null)
         {
            return;
         }
         if (var_3320 == null)
         {
            var_3320 = new Vector.<Map>(_loc4_.totalFragments, true);
         }
         var _loc5_:Map;
         (_loc5_ = new Map()).concatenate(_loc4_.furniFragment);
         var _loc3_:Map = addMessageFragment(_loc5_, _loc4_.totalFragments, _loc4_.fragmentNo, var_3320);
         if (!_loc3_)
         {
            return;
         }
         _loc2_.insertFurniture(_loc3_);
         var_3320 = null;
         _inventory.events.dispatchEvent(new HabboInventoryFurniListParsedEvent("furni"));
      }

      public function onFurnitureAddOrUpdate(param1:IMessageEvent):void
      {
         var _loc2_:FurnitureItem = null;
         var _loc5_:GroupItem = null;
         var _loc3_:FurniListAddOrUpdateEventParser = (param1 as FurniListAddOrUpdateEvent).getParser();
         if (_loc3_ == null)
         {
            return;
         }
         var _loc7_:FurniModel;
         if ((_loc7_ = _inventory.furniModel) == null || !_loc7_.isListInited())
         {
            return;
         }
         var _loc6_:Vector.<class_1707> = _loc3_.getFurni();
         for each (var _loc4_ in _loc6_)
         {
            if (_loc5_ = _loc7_.getItemWithStripId(_loc4_.itemId))
            {
               _loc2_ = _loc5_.getItem(_loc4_.itemId);
               if (_loc2_)
               {
                  _loc2_.update(_loc4_);
                  _loc5_.hasUnseenItems = true;
               }
            }
            else
            {
               _loc2_ = new FurnitureItem(_loc4_);
               _loc7_.addOrUpdateItem(_loc2_, false);
            }
         }
         _loc7_.setViewToState();
         _loc7_.updateView();
      }

      public function onFurniListRemove(param1:IMessageEvent):void
      {
         var _loc2_:FurniListRemoveEventParser = (param1 as FurniListRemoveEvent).getParser();
         if (_loc2_ == null)
         {
            return;
         }
         var _loc5_:FurniModel;
         if ((_loc5_ = _inventory.furniModel) == null)
         {
            return;
         }
         var _loc4_:int = _loc2_.stripId;
         var _loc3_:GroupItem = _loc5_.removeFurni(_loc4_);
         if (_loc3_)
         {
            _loc5_.resetUnseenItems();
         }
      }

      public function onFurniListInvalidate(param1:IMessageEvent):void
      {
         _inventory.setInventoryCategoryInit("furni", false);
         _inventory.setInventoryCategoryInit("rentables", false);
      }

      public function onPostItPlaced(param1:IMessageEvent):void
      {
         var _loc2_:PostItPlacedEventParser = (param1 as PostItPlacedEvent).getParser();
         if (_loc2_ == null)
         {
            return;
         }
         var _loc3_:FurniModel = _inventory.furniModel;
         if (_loc3_ == null)
         {
            return;
         }
         var _loc4_:int = _loc2_.id;
         var _loc5_:int = _loc2_.itemsLeft;
         _loc3_.updatePostItCount(_loc4_, _loc5_);
      }

      public function onAvatarEffects(param1:IMessageEvent):void
      {
         var _loc5_:int = 0;
         var _loc4_:class_1689 = null;
         var _loc7_:Effect = null;
         if (_inventory == null)
         {
            return;
         }
         var _loc6_:EffectsModel;
         if ((_loc6_ = _inventory.effectsModel) == null)
         {
            return;
         }
         var _loc3_:AvatarEffectsMessageEventParser = (param1 as AvatarEffectsMessageEvent).getParser();
         if (_loc3_ == null)
         {
            return;
         }
         var _loc2_:Array = _loc3_.effects;
         _loc5_ = 0;
         while (_loc5_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc5_] as class_1689;
            (_loc7_ = new Effect()).type = _loc4_.type;
            _loc7_.subType = _loc4_.subType;
            _loc7_.duration = _loc4_.duration;
            _loc7_.isPermanent = _loc4_.isPermanent;
            _loc7_.amountInInventory = _loc4_.inactiveEffectsInInventory;
            if (_loc4_.secondsLeftIfActive >= 0)
            {
               _loc7_.isActive = true;
               _loc7_.secondsLeft = _loc4_.secondsLeftIfActive;
               _loc7_.amountInInventory++;
            }
            else if (_loc4_.secondsLeftIfActive == -1)
            {
               _loc7_.isActive = false;
               _loc7_.secondsLeft = _loc4_.duration;
            }
            _loc6_.addEffect(_loc7_, false);
            _loc5_++;
         }
         _inventory.setInventoryCategoryInit("effects");
         _loc6_.refreshViews();
         _inventory.notifyChangedEffects();
      }

      public function onAvatarEffectAdded(param1:IMessageEvent):void
      {
         var _loc5_:EffectsModel;
         if ((_loc5_ = _inventory.effectsModel) == null)
         {
            return;
         }
         var _loc2_:AvatarEffectAddedMessageEventParser = (param1 as AvatarEffectAddedMessageEvent).getParser();
         if (_loc2_ == null)
         {
            return;
         }
         var _loc7_:int = _loc2_.type;
         var _loc6_:int = _loc2_.subType;
         var _loc8_:int = _loc2_.duration;
         var _loc3_:Boolean = _loc2_.isPermanent;
         var _loc4_:Effect;
         (_loc4_ = new Effect()).type = _loc7_;
         _loc4_.subType = _loc6_;
         _loc4_.duration = _loc8_;
         _loc4_.isPermanent = _loc3_;
         _loc4_.secondsLeft = _loc8_;
         _loc5_.addEffect(_loc4_);
         _inventory.notifyChangedEffects();
      }

      public function onAvatarEffectActivated(param1:IMessageEvent):void
      {
         var _loc3_:EffectsModel = _inventory.effectsModel;
         if (_loc3_ == null)
         {
            return;
         }
         var _loc2_:AvatarEffectActivatedMessageEventParser = (param1 as AvatarEffectActivatedMessageEvent).getParser();
         if (_loc2_ == null)
         {
            return;
         }
         var _loc4_:int = _loc2_.type;
         _loc3_.setEffectActivated(_loc4_);
         _inventory.notifyChangedEffects();
      }

      public function onAvatarEffectExpired(param1:IMessageEvent):void
      {
         var _loc3_:EffectsModel = _inventory.effectsModel;
         if (_loc3_ == null)
         {
            return;
         }
         var _loc2_:AvatarEffectExpiredMessageEventParser = (param1 as AvatarEffectExpiredMessageEvent).getParser();
         if (_loc2_ == null)
         {
            return;
         }
         var _loc4_:int = _loc2_.type;
         _loc3_.setEffectExpired(_loc4_);
         _inventory.notifyChangedEffects();
      }

      public function onClubStatus(param1:IMessageEvent):void
      {
         var _loc2_:ScrSendUserInfoEventParser = (param1 as ScrSendUserInfoEvent).getParser();
         if (_loc2_.productName == "habbo_club" || _loc2_.productName == "club_habbo")
         {
            _inventory.setClubStatus(_loc2_.periodsSubscribedAhead, _loc2_.daysToPeriodEnd, _loc2_.hasEverBeenMember, _loc2_.isVIP, _loc2_.responseType == 3, _loc2_.responseType == 4, _loc2_.minutesUntilExpiration, _loc2_.minutesSinceLastModified);
            _inventory.events.dispatchEvent(new HabboInventoryHabboClubEvent());
         }
      }

      public function onBadges(param1:IMessageEvent):void
      {
         var _loc3_:BadgesEventParser = (param1 as BadgesEvent).getParser();
         if (_loc3_ == null)
         {
            return;
         }
         var _loc4_:BadgesModel;
         if ((_loc4_ = _inventory.badgesModel) == null)
         {
            return;
         }
         if (var_3540 == null)
         {
            var_1801 = getTimer();
            var_3540 = new Vector.<Map>(_loc3_.totalFragments, true);
         }
         var _loc5_:Map;
         (_loc5_ = new Map()).concatenate(_loc3_.currentFragment);
         var _loc2_:Map = addMessageFragment(_loc5_, _loc3_.totalFragments, _loc3_.fragmentNo, var_3540);
         if (!_loc2_)
         {
            return;
         }
         var_3540 = null;
         var _loc6_:int = getTimer() - var_1801;
         var_1801 = 0;
         class_14.log("Parsing badges took: " + _loc6_ + "ms");
         var_1801 = getTimer();
         _loc4_.initBadges(_loc2_);
         _loc6_ = getTimer() - var_1801;
         var_1801 = 0;
         class_14.log("Initializing badges took: " + _loc6_ + "ms");
         _loc4_.updateView();
         _inventory.setInventoryCategoryInit("badges");
      }

      public function onBadgePointLimits(param1:IMessageEvent):void
      {
         var _loc2_:BadgePointLimitsEventParser = (param1 as BadgePointLimitsEvent).getParser();
         for each (var _loc3_ in _loc2_.data)
         {
            _inventory.localization.setBadgePointLimit(_loc3_.badgeId, _loc3_.limit);
         }
      }

      public function onUserBadges(param1:IMessageEvent):void
      {
         var _loc3_:HabboUserBadgesMessageEvent = param1 as HabboUserBadgesMessageEvent;
         if (_loc3_.userId != _inventory.sessionData.userId)
         {
            return;
         }
         var _loc4_:BadgesModel;
         if ((_loc4_ = _inventory.badgesModel) == null)
         {
            return;
         }
         var_1801 = getTimer();
         for each (var _loc2_ in _loc3_.badges)
         {
            _loc4_.updateBadge(_loc2_, true);
         }
         var _loc5_:int = getTimer() - var_1801;
         var_1801 = 0;
         class_14.log("Updating badges " + _loc3_.badges.length + "took: " + _loc5_ + "ms");
         var_1801 = getTimer();
         _loc4_.updateView();
         _loc5_ = getTimer() - var_1801;
         var_1801 = 0;
         class_14.log("Updating badge view took: " + _loc5_ + "ms");
      }

      public function onAchievementReceived(param1:IMessageEvent):void
      {
         var _loc4_:HabboAchievementNotificationMessageEvent;
         var _loc3_:HabboAchievementNotificationMessageEventParser = (_loc4_ = param1 as HabboAchievementNotificationMessageEvent).getParser();
         var _loc2_:BadgesModel = _inventory.badgesModel;
         if (_loc2_ != null)
         {
            _loc2_.updateBadge(_loc3_.data.badgeCode, false, _loc3_.data.badgeId);
            _loc2_.removeBadge(_loc3_.data.removedBadgeCode);
            _loc2_.updateView();
         }
      }

      public function onBadgeReceived(param1:IMessageEvent):void
      {
         var _loc3_:BadgeReceivedEventParser = BadgeReceivedEvent(param1).getParser();
         var _loc2_:BadgesModel = _inventory.badgesModel;
         if (_loc2_ != null)
         {
            _loc2_.updateBadge(_loc3_.badgeCode, false, _loc3_.badgeId);
            _loc2_.updateView();
         }
      }

      public function onAchievementsScore(param1:IMessageEvent):void
      {
         var _loc2_:AchievementsScoreEvent = param1 as AchievementsScoreEvent;
         var _loc3_:AchievementsScoreEventParser = _loc2_.getParser() as AchievementsScoreEventParser;
         if (_loc3_ == null)
         {
            return;
         }
         _inventory.localization.registerParameter("achievements_score_description", "score", _loc3_.score.toString());
      }

      private function onTradingOpen(param1:IMessageEvent):void
      {
         var _loc13_:* = 0;
         if (!_inventory)
         {
            ErrorReportStorage.addDebugData("IncomingEvent", "Trading open - inventory is null!");
            return;
         }
         var _loc2_:ISessionDataManager = _inventory.sessionData;
         var _loc16_:IRoomSession = _inventory.roomSession;
         if (!_loc2_)
         {
            ErrorReportStorage.addDebugData("IncomingEvent", "Trading open - sessionData not available!");
            return;
         }
         if (!_loc16_)
         {
            ErrorReportStorage.addDebugData("IncomingEvent", "Trading open - roomSession not available!");
            return;
         }
         _inventory.toggleInventorySubPage("trading");
         var _loc5_:TradingOpenEvent;
         if (!(_loc5_ = param1 as TradingOpenEvent))
         {
            ErrorReportStorage.addDebugData("IncomingEvent", "event is of unknown type:" + param1 + "!");
            return;
         }
         var _loc8_:* = _loc5_.userID;
         var _loc3_:class_3490 = _loc16_.userDataManager.getUserData(_loc8_);
         if (!_loc3_)
         {
            ErrorReportStorage.addDebugData("IncomingEvent", "Trading open - failed to retrieve own user data!");
            return;
         }
         var _loc6_:* = _loc3_.name;
         var _loc4_:* = _loc5_.userCanTrade > 0;
         var _loc14_:* = _loc5_.otherUserID;
         var _loc15_:class_3490;
         if (!(_loc15_ = _loc16_.userDataManager.getUserData(_loc14_)))
         {
            ErrorReportStorage.addDebugData("IncomingEvent", "Trading open - failed to retrieve other user data!");
            return;
         }
         var _loc11_:* = _loc15_.name;
         var _loc10_:* = _loc5_.otherUserCanTrade > 0;
         if (_loc14_ == _loc2_.userId)
         {
            _loc13_ = _loc8_;
            var _loc9_:* = _loc6_;
            var _loc7_:* = _loc4_;
            _loc8_ = _loc14_;
            _loc6_ = _loc11_;
            _loc4_ = _loc10_;
            _loc14_ = _loc13_;
            _loc11_ = _loc9_;
            _loc10_ = _loc7_;
         }
         var _loc12_:TradingModel;
         if ((_loc12_ = _inventory.tradingModel) != null)
         {
            _loc12_.startTrading(_loc8_, _loc6_, _loc4_, _loc14_, _loc11_, _loc10_);
         }
      }

      private function onTradingOpenFailed(param1:IMessageEvent):void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if (_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }

      private function onTradingClose(param1:IMessageEvent):void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if (_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }

      private function onTradingCompleted(param1:IMessageEvent):void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if (_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }

      private function onTradingAccepted(param1:IMessageEvent):void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if (_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }

      private function onTradeSilverFee(param1:IMessageEvent):void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if (_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }

      private function onTradeSilverSet(param1:IMessageEvent):void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if (_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }

      private function onTradingConfirmation(param1:IMessageEvent):void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if (_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }

      private function onTradingItemList(param1:IMessageEvent):void
      {
         var _loc8_:GroupItem = null;
         var _loc2_:TradingItemListEvent = param1 as TradingItemListEvent;
         var _loc4_:Map = new Map();
         var _loc5_:Map = new Map();
         var _loc6_:int = _inventory.sessionData.userId;
         var _loc3_:FurniModel = _inventory.furniModel;
         if (_loc3_ == null)
         {
            return;
         }
         if (_inventory.getBoolean("trading.warning.enabled") && _loc2_.secondUserNumCredits > 0)
         {
            _loc8_ = _inventory.furniModel.createCreditGroupItem(_loc2_.secondUserNumCredits);
            _loc5_.add("credit_groupitem_type_id", _loc8_);
         }
         populateItemGroups(_loc2_.firstUserItemArray, _loc4_, _loc2_.firstUserID == _loc6_);
         populateItemGroups(_loc2_.secondUserItemArray, _loc5_, _loc2_.secondUserID == _loc6_);
         var _loc7_:TradingModel;
         if ((_loc7_ = _inventory.tradingModel) != null)
         {
            _loc7_.updateItemGroupMaps(_loc2_, _loc4_, _loc5_);
         }
      }

      private function populateItemGroups(param1:Array, param2:Map, param3:Boolean):void
      {
         var _loc9_:GroupItem = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:String = null;
         var _loc4_:class_1704 = null;
         var _loc6_:int = 0;
         var _loc10_:uint = param1.length;
         _loc6_ = 0;
         while (_loc6_ < _loc10_)
         {
            _loc7_ = (_loc4_ = param1[_loc6_] as class_1704).itemTypeId;
            _loc8_ = _loc4_.category;
            _loc5_ = _loc4_.itemType + String(_loc7_);
            if (!_loc4_.isGroupable || isFurniExternalImage(_loc4_.itemTypeId))
            {
               _loc5_ = "itemid" + _loc4_.itemId;
            }
            if (_loc4_.category == 6)
            {
               _loc5_ = String(_loc7_) + "poster" + _loc4_.stuffData.getLegacyString();
            }
            else if (_loc4_.category == 17)
            {
               _loc5_ = TradingModel.getGuildFurniType(_loc7_, _loc4_.stuffData);
            }
            if ((_loc9_ = _loc4_.isGroupable && !isFurniExternalImage(_loc4_.itemTypeId) ? param2.getValue(_loc5_) as GroupItem : null) == null)
            {
               _loc9_ = _inventory.furniModel.createGroupItem(_loc7_, _loc8_, _loc4_.stuffData);
               param2.add(_loc5_, _loc9_);
            }
            _loc9_.push(new FurnitureItem(_loc4_));
            _loc6_++;
         }
      }

      private function isFurniExternalImage(param1:int):Boolean
      {
         var _loc2_:class_3365 = _inventory.getFurnitureData(param1, "i");
         return _loc2_ && _loc2_.isExternalImageType;
      }

      private function onTradingNotOpen(param1:IMessageEvent):void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if (_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }

      private function onTradingOtherNotAllowed(param1:IMessageEvent):void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if (_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }

      private function onTradingYouAreNotAllowed(param1:IMessageEvent):void
      {
         var _loc2_:TradingModel = _inventory.tradingModel;
         if (_loc2_ != null)
         {
            _loc2_.handleMessageEvent(param1);
         }
      }

      private function onRoomLeft(param1:IMessageEvent):void
      {
         _inventory.closeView();
         _inventory.furniModel.roomLeft();
      }

      private function onFlatAccessDenied(param1:IMessageEvent):void
      {
         var _loc2_:FlatAccessDeniedMessageEventParser = (param1 as FlatAccessDeniedMessageEvent).getParser();
         if (_inventory.sessionData == null || _loc2_.userName != _inventory.sessionData.userName)
         {
            return;
         }
         _inventory.closeView();
         _inventory.furniModel.roomLeft();
      }

      private function onPets(param1:PetInventoryEvent):void
      {
         if (param1 == null || _inventory == null)
         {
            return;
         }
         var _loc4_:PetsModel;
         if ((_loc4_ = _inventory.petsModel) == null)
         {
            return;
         }
         var _loc3_:PetInventoryEventParser = param1.getParser();
         if (var_3568 == null)
         {
            var_3568 = new Vector.<Map>(_loc3_.totalFragments, true);
         }
         var _loc5_:Map;
         (_loc5_ = new Map()).concatenate(_loc3_.petListFragment);
         var _loc2_:Map = addMessageFragment(_loc5_, _loc3_.totalFragments, _loc3_.fragmentNo, var_3568);
         if (!_loc2_)
         {
            return;
         }
         _inventory.petsModel.updatePets(_loc2_);
         var_3568 = null;
      }

      private function onPetAdded(param1:PetAddedToInventoryEvent):void
      {
         if (param1 == null || _inventory == null)
         {
            return;
         }
         var _loc3_:PetsModel = _inventory.petsModel;
         if (_loc3_ == null)
         {
            return;
         }
         var _loc2_:PetAddedToInventoryEventParser = param1.getParser();
         _loc3_.addPet(_loc2_.pet);
         if (_loc2_.openInventory())
         {
         }
      }

      private function onGoToBreedingNestFailure(param1:GoToBreedingNestFailureEvent):void
      {
         if (param1 == null || _inventory == null)
         {
            return;
         }
         var _loc2_:String = "${gotobreedingnestfailure.getnest}";
         var _loc3_:Function = getNest;
         if (param1.getParser().reason == 6)
         {
            _loc2_ = "${gotobreedingnestfailure.getfood}";
            _loc3_ = getFood;
         }
         _inventory.windowManager.simpleAlert("${gotobreedingnestfailure.caption}", "${gotobreedingnestfailure.subtitle}", "${gotobreedingnestfailure.message." + param1.getParser().reason + "}", _loc2_, "", null, null, _loc3_);
      }

      private function getNest():void
      {
         var _loc1_:String = _inventory.getProperty("gotobreedingnestfailure.catalogpage.nests");
         _inventory.catalog.openCatalogPage(_loc1_);
      }

      private function getFood():void
      {
         var _loc1_:String = _inventory.getProperty("gotobreedingnestfailure.catalogpage.food");
         _inventory.catalog.openCatalogPage(_loc1_);
      }

      private function onPetRemoved(param1:PetRemovedFromInventoryEvent):void
      {
         if (param1 == null || _inventory == null)
         {
            return;
         }
         var _loc3_:PetsModel = _inventory.petsModel;
         if (_loc3_ == null)
         {
            return;
         }
         var _loc2_:PetRemovedFromInventoryEventParser = param1.getParser();
         _loc3_.removePet(_loc2_.petId);
      }

      private function onBots(param1:BotInventoryEvent):void
      {
         if (param1 == null || _inventory == null)
         {
            return;
         }
         var _loc3_:BotsModel = _inventory.botsModel;
         if (_loc3_ == null)
         {
            return;
         }
         var _loc2_:BotInventoryEventParser = param1.getParser();
         _loc3_.updateItems(_loc2_.items);
         _inventory.setInventoryCategoryInit("bots");
         _loc3_.setListInitialized();
      }

      private function onBotRemoved(param1:BotRemovedFromInventoryEvent):void
      {
         if (param1 == null || _inventory == null)
         {
            return;
         }
         var _loc3_:BotsModel = _inventory.botsModel;
         if (_loc3_ == null)
         {
            return;
         }
         var _loc2_:BotRemovedFromInventoryEventParser = param1.getParser();
         _loc3_.removeItem(_loc2_.itemId);
      }

      private function onBotAdded(param1:BotAddedToInventoryEvent):void
      {
         if (param1 == null || _inventory == null)
         {
            return;
         }
         var _loc3_:BotsModel = _inventory.botsModel;
         if (_loc3_ == null)
         {
            return;
         }
         if (_loc3_.items.length >= _inventory.botsMax)
         {
            return;
         }
         var _loc2_:BotAddedToInventoryEventParser = param1.getParser();
         _loc3_.addItem(_loc2_.item);
      }

      private function onMarketplaceConfiguration(param1:MarketplaceConfigurationEvent):void
      {
         if (param1 == null || _inventory == null)
         {
            return;
         }
         var _loc4_:MarketplaceModel;
         if ((_loc4_ = _inventory.marketplaceModel) == null)
         {
            return;
         }
         var _loc3_:MarketplaceConfigurationEventParser = param1.getParser();
         _loc4_.isEnabled = _loc3_.isEnabled;
         _loc4_.commission = _loc3_.commission;
         _loc4_.tokenBatchPrice = _loc3_.tokenBatchPrice;
         _loc4_.tokenBatchSize = _loc3_.tokenBatchSize;
         _loc4_.offerMinPrice = _loc3_.offerMinPrice;
         _loc4_.offerMaxPrice = _loc3_.offerMaxPrice;
         _loc4_.expirationHours = _loc3_.expirationHours;
         _loc4_.averagePricePeriod = _loc3_.averagePricePeriod;
         _loc4_.sellingFeePercentage = _loc3_.sellingFeePercentage;
         _loc4_.revenueLimit = _loc3_.revenueLimit;
         _loc4_.halfTaxLimit = _loc3_.halfTaxLimit;
         _inventory.setInventoryCategoryInit("marketplace");
         var _loc2_:FurniModel = _inventory.furniModel;
         if (_loc2_ != null)
         {
            _loc2_.updateView();
         }
      }

      private function onMarketplaceCanMakeOfferResult(param1:MarketplaceCanMakeOfferResult):void
      {
         if (param1 == null || _inventory == null)
         {
            return;
         }
         var _loc3_:MarketplaceModel = _inventory.marketplaceModel;
         if (_loc3_ == null)
         {
            return;
         }
         var _loc2_:MarketplaceCanMakeOfferResult = param1.getParser();
         _loc3_.proceedOfferMaking(_loc2_.resultCode, _loc2_.tokenCount);
      }

      private function onMarketplaceMakeOfferResult(param1:MarketplaceMakeOfferResult):void
      {
         if (param1 == null || _inventory == null)
         {
            return;
         }
         var _loc3_:MarketplaceModel = _inventory.marketplaceModel;
         if (_loc3_ == null)
         {
            return;
         }
         var _loc2_:MarketplaceMakeOfferResult = param1.getParser();
         _loc3_.endOfferMaking(_loc2_.result);
      }

      private function onMarketplaceItemStats(param1:MarketplaceItemStatsEvent):void
      {
         if (param1 == null || _inventory == null)
         {
            return;
         }
         var _loc3_:MarketplaceModel = _inventory.marketplaceModel;
         if (_loc3_ == null)
         {
            return;
         }
         var _loc2_:MarketplaceItemStatsEventParser = param1.getParser();
         _loc3_.setAveragePrice(_loc2_.furniCategoryId, _loc2_.furniTypeId, _loc2_.averagePrice);
      }

      private function onNotEnoughCredits(param1:NotEnoughBalanceMessageEvent):void
      {
         if (!param1 || !_inventory)
         {
            return;
         }
         var _loc2_:MarketplaceModel = _inventory.marketplaceModel;
         if (_loc2_ == null)
         {
            return;
         }
         _loc2_.onNotEnoughCredits();
      }

      private function onUserRights(param1:IMessageEvent):void
      {
         var _loc2_:MarketplaceModel = null;
         if (_inventory.isInventoryCategoryInit("marketplace"))
         {
            _loc2_ = _inventory.marketplaceModel;
            if (_loc2_ == null)
            {
               return;
            }
            _loc2_.requestInitialization();
         }
      }

      private function onFigureSetIds(param1:FigureSetIdsEvent):void
      {
         _inventory.updatePurchasedFigureSetIds(param1.getParser().figureSetIds, param1.getParser().boundFurnitureNames);
      }

      private function onRoomEnter(param1:IMessageEvent):void
      {
         if (_inventory.getBoolean("effects.reactivate.on.room.entry"))
         {
            _inventory.effectsModel.reactivateLastEffect();
         }
         _inventory.furniModel.roomEntered();
      }

      private function addMessageFragment(param1:Map, param2:int, param3:int, param4:Vector.<Map>):Map
      {
         if (param2 == 1)
         {
            return param1;
         }
         param4[param3] = param1;
         for each (var _loc5_ in param4)
         {
            if (_loc5_ == null)
            {
               return null;
            }
         }
         var _loc6_:Map = new Map();
         for each (var _loc7_ in param4)
         {
            _loc6_.concatenate(_loc7_);
            _loc7_.dispose();
         }
         param4 = null;
         return _loc6_;
      }
   }
}
