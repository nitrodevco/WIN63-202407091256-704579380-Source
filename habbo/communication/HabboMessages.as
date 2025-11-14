package com.sulake.habbo.communication
{
    import com.sulake.core.communication.messages.IMessageConfiguration;
    import com.sulake.core.utils.Map;
    import com.sulake.core.utils.class_885;
    import com.sulake.habbo.communication.messages.incoming.availability.LoginFailedHotelClosedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.availability.MaintenanceStatusMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.availability.AvailabilityStatusMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.availability.class_636;
    import com.sulake.habbo.communication.messages.incoming.availability.InfoHotelClosingMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.availability.InfoHotelClosedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.avatar.FigureUpdateEvent;
    import com.sulake.habbo.communication.messages.incoming.avatar.WardrobeMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.avatar.ChangeUserNameResultMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.avatar.CheckUserNameResultMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.callforhelp.CfhTopicsInitMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.callforhelp.SanctionStatusEvent;
    import com.sulake.habbo.communication.messages.incoming.callforhelp.CfhSanctionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.camera.CameraPurchaseOKMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.camera.CameraStorageUrlMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.camera.CameraPublishStatusMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.camera.CompetitionStatusMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.camera.InitCameraMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.camera.ThumbnailStatusMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.campaign.CampaignCalendarDataMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.campaign.CampaignCalendarDoorOpenedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.catalog.SnowWarGameTokensMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.catalog.TargetedOfferEvent;

    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.catalog.BonusRareInfoMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.catalog.class_149;

    import com.sulake.habbo.communication.messages.incoming.catalog.BuildersClubSubscriptionStatusMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.catalog.class_195;

    import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseErrorMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.catalog.VoucherRedeemOkMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.catalog.SellablePetPalettesMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogIndexMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.catalog.LimitedEditionSoldOutEvent;

    import com.sulake.habbo.communication.messages.incoming.catalog.GiftWrappingConfigurationEvent;

    import com.sulake.habbo.communication.messages.incoming.catalog.class_545;

    import com.sulake.habbo.communication.messages.incoming.catalog.RoomAdPurchaseInfoEvent;

    import com.sulake.habbo.communication.messages.incoming.catalog.HabboClubOffersMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.catalog.class_652;

    import com.sulake.habbo.communication.messages.incoming.catalog.NotEnoughBalanceMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.catalog.VoucherRedeemErrorMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.catalog.SeasonalCalendarDailyOfferMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageWithEarliestExpiryMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.catalog.LimitedOfferAppearingNextMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.catalog.GiftReceiverNotFoundEvent;

    import com.sulake.habbo.communication.messages.incoming.catalog.TargetedOfferNotFoundEvent;

    import com.sulake.habbo.communication.messages.incoming.catalog.HabboClubExtendOfferMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPublishedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.catalog.BundleDiscountRulesetMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.catalog.ProductOfferEvent;

    import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseNotAllowedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.catalog.ClubGiftInfoEvent;

    import com.sulake.habbo.communication.messages.incoming.catalog.ClubGiftSelectedEvent;

    import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseOKMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.collectibles.NftCollectionsScoreMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.collectibles.CollectibleMintTokenOffersMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.collectibles.CollectibleMintableItemResultMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.collectibles.EmeraldBalanceMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.collectibles.CollectibleMintingEnabledMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.collectibles.NftTransferFeeMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.collectibles.NftCollectionsMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.collectibles.CollectibleMintTokenCountMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.collectibles.NftRewardItemClaimResultMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.collectibles.NftBonusItemClaimResultMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.collectibles.CollectableMintableItemTypesMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.collectibles.NftTransferAssetsResultMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.collectibles.SilverBalanceMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.collectibles.CollectibleWalletAddressesMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.competition.NoOwnedRoomsAlertMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.competition.CompetitionVotingInfoMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.competition.SecondsUntilMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.competition.CurrentTimingCodeMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.competition.IsUserPartOfCompetitionMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.competition.CompetitionEntrySubmitResultMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.crafting.CraftableProductsMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.crafting.CraftingRecipesAvailableMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.crafting.CraftingRecipeMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.crafting.CraftingResultMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.error.ErrorReportEvent;

    import com.sulake.habbo.communication.messages.incoming.friendfurni.FriendFurniOtherLockConfirmedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.friendfurni.FriendFurniStartConfirmationMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.friendfurni.FriendFurniCancelLockMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendNotificationEvent;

    import com.sulake.habbo.communication.messages.incoming.friendlist.RoomInviteErrorEvent;

    import com.sulake.habbo.communication.messages.incoming.friendlist.FollowFriendFailedEvent;

    import com.sulake.habbo.communication.messages.incoming.friendlist.RoomInviteEvent;

    import com.sulake.habbo.communication.messages.incoming.friendlist.AcceptFriendResultEvent;

    import com.sulake.habbo.communication.messages.incoming.friendlist.NewFriendRequestEvent;

    import com.sulake.habbo.communication.messages.incoming.friendlist.HabboSearchResultEvent;

    import com.sulake.habbo.communication.messages.incoming.friendlist.class_307;

    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListFragmentMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListUpdateEvent;

    import com.sulake.habbo.communication.messages.incoming.friendlist.InstantMessageErrorEvent;

    import com.sulake.habbo.communication.messages.incoming.friendlist.ConsoleMessageHistoryEvent;

    import com.sulake.habbo.communication.messages.incoming.friendlist.MessengerErrorEvent;

    import com.sulake.habbo.communication.messages.incoming.friendlist.NewConsoleMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.friendlist.FindFriendsProcessResultEvent;

    import com.sulake.habbo.communication.messages.incoming.friendlist.class_756;

    import com.sulake.habbo.communication.messages.incoming.friendlist.MessengerInitEvent;

    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestsEvent;

    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2AccountGameStatusMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2GameCancelledMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2GameDirectoryStatusMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2GameNotFoundMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2InArenaQueueMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2JoiningGameFailedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2StartCounterMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2StartingGameFailedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2StopCounterMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2UserBlockedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2UserLeftGameMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2GameStartedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2UserJoinedGameMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2GameLongDataMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2GameCreatedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.lobby.UserGameAchievementsMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.lobby.AchievementResolutionCompletedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.lobby.AchievementResolutionProgressMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.lobby.AchievementResolutionsMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.score.Game2FriendsLeaderboardEvent;

    import com.sulake.habbo.communication.messages.incoming.game.score.Game2TotalGroupLeaderboardEvent;

    import com.sulake.habbo.communication.messages.incoming.game.score.Game2TotalLeaderboardEvent;

    import com.sulake.habbo.communication.messages.incoming.game.score.Game2WeeklyFriendsLeaderboardEvent;

    import com.sulake.habbo.communication.messages.incoming.game.score.Game2WeeklyGroupLeaderboardEvent;

    import com.sulake.habbo.communication.messages.incoming.game.score.Game2WeeklyLeaderboardEvent;

    import com.sulake.habbo.communication.messages.incoming.game.score.WeeklyCompetitiveFriendsLeaderboardEvent;

    import com.sulake.habbo.communication.messages.incoming.game.score.WeeklyCompetitiveLeaderboardEvent;

    import com.sulake.habbo.communication.messages.incoming.game.score.WeeklyGameRewardEvent;

    import com.sulake.habbo.communication.messages.incoming.game.score.WeeklyGameRewardWinnersEvent;

    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2StageRunningMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2GameEndingMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2ArenaEnteredMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2PlayerRematchesMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2EnterArenaFailedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2PlayerExitedGameArenaMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2StageEndingMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2EnterArenaMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2StageStillLoadingMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2StageStartingMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2GameRejoinMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2StageLoadMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2GameChatFromPlayerMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.snowwar.ingame.Game2FullGameStatusMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.game.snowwar.ingame.Game2GameStatusMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.gifts.TryVerificationCodeResultMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.gifts.TryPhoneNumberResultMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.gifts.PhoneCollectionStateMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.groupforums.ThreadMessagesMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.groupforums.UpdateThreadMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.groupforums.UpdateMessageMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.groupforums.ForumsListMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.groupforums.ForumDataMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.groupforums.ForumThreadsMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.groupforums.UnreadForumsCountMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.groupforums.PostThreadMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.groupforums.PostMessageMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.handshake.NoobnessLevelMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.handshake.CompleteDiffieHandshakeEvent;

    import com.sulake.habbo.communication.messages.incoming.handshake.IdentityAccountsEvent;

    import com.sulake.habbo.communication.messages.incoming.handshake.InitDiffieHandshakeEvent;

    import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.handshake.UniqueMachineIDEvent;

    import com.sulake.habbo.communication.messages.incoming.handshake.PingMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.handshake.DisconnectReasonEvent;

    import com.sulake.habbo.communication.messages.incoming.handshake.IsFirstLoginOfDayEvent;

    import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.handshake.GenericErrorEvent;

    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;

    import com.sulake.habbo.communication.messages.incoming.help.CallForHelpPendingCallsMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.help.CallForHelpReplyMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.help.class_135;

    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionErrorMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionStartedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.help.CallForHelpDisabledNotifyMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.help.GuideTicketCreationResultMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionMessageMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.help.GuideOnDutyStatusMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.help.ChatReviewSessionStartedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.help.ChatReviewSessionOfferedToGuideMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionRequesterRoomMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.help.GuideReportingStatusMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionPartnerIsTypingMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.help.class_579;

    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionInvitedToGuideRoomMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.help.ChatReviewSessionVotingStatusMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.help.ChatReviewSessionResultsMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.help.GuideTicketResolutionMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.help.IssueCloseNotificationMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.help.class_673;

    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionEndedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.help.class_784;

    import com.sulake.habbo.communication.messages.incoming.help.CallForHelpResultMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.help.QuizDataMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.help.class_819;

    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionDetachedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionAttachedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.help.class_895;

    import com.sulake.habbo.communication.messages.incoming.help.CallForHelpPendingCallsDeletedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.help.ChatReviewSessionDetachedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.help.QuizResultsMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.hotlooks.HotLooksMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementsScoreEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementsEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectsMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectActivatedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectSelectedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectAddedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectExpiredMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.badges.BadgeReceivedEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.badges.BadgesEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.badges.BadgePointLimitsEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.badges.IsBadgeRequestFulfilledEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.bots.BotRemovedFromInventoryEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.bots.class_258;

    import com.sulake.habbo.communication.messages.incoming.inventory.bots.BotInventoryEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.bots.BotAddedToInventoryEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.clothing.FigureSetIdsEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.clothing.class_401;

    import com.sulake.habbo.communication.messages.incoming.inventory.clothing.class_456;

    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.furni.PostItPlacedEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListInvalidateEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListAddOrUpdateEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListRemoveEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.pets.ConfirmBreedingResultEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.pets.GoToBreedingNestFailureEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetAddedToInventoryEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetBreedingEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetReceivedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.pets.NestBreedingSuccessEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetInventoryEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.pets.ConfirmBreedingRequestEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetRemovedFromInventoryEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.purse.CreditBalanceEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingOpenEvent;

    import com.sulake.habbo.communication.messages.incoming.inventory.trading.class_144;

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

    import com.sulake.habbo.communication.messages.incoming.landingview.PromoArticlesMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.landingview.votes.CommunityVoteReceivedEvent;

    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceBuyOfferResultEvent;

    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceConfigurationEvent;

    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceItemStatsEvent;

    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOwnOffersEvent;

    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOffersEvent;

    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceMakeOfferResult;

    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceCancelOfferResultEvent;

    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceCanMakeOfferResult;

    import com.sulake.habbo.communication.messages.incoming.moderation.RoomVisitsEvent;

    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorInitMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.moderation.IssueInfoMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.moderation.UserBannedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.moderation.CfhChatlogEvent;

    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorUserInfoEvent;

    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorActionResultMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.moderation.IssuePickFailedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.moderation.IssueDeletedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorRoomInfoEvent;

    import com.sulake.habbo.communication.messages.incoming.moderation.UserChatlogEvent;

    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorCautionEvent;

    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorToolPreferencesEvent;

    import com.sulake.habbo.communication.messages.incoming.moderation.RoomChatlogEvent;

    import com.sulake.habbo.communication.messages.incoming.mysterybox.ShowMysteryBoxWaitMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.mysterybox.MysteryBoxKeysMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.mysterybox.CancelMysteryBoxWaitMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.mysterybox.GotMysteryBoxPrizeMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.navigator.FlatAccessDeniedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.navigator.ConvertedRoomIdEvent;

    import com.sulake.habbo.communication.messages.incoming.navigator.FavouritesEvent;

    import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomsEvent;

    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomSearchResultEvent;

    import com.sulake.habbo.communication.messages.incoming.navigator.CategoriesWithVisitorCountEvent;

    import com.sulake.habbo.communication.messages.incoming.navigator.RoomInfoUpdatedEvent;

    import com.sulake.habbo.communication.messages.incoming.navigator.NavigatorSettingsEvent;

    import com.sulake.habbo.communication.messages.incoming.navigator.UserEventCatsEvent;

    import com.sulake.habbo.communication.messages.incoming.navigator.CompetitionRoomsDataMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.navigator.class_590;

    import com.sulake.habbo.communication.messages.incoming.navigator.UserFlatCatsEvent;

    import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventEvent;

    import com.sulake.habbo.communication.messages.incoming.navigator.CanCreateRoomEventEvent;

    import com.sulake.habbo.communication.messages.incoming.navigator.RoomRatingEvent;

    import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventCancelEvent;

    import com.sulake.habbo.communication.messages.incoming.navigator.FavouriteChangedEvent;

    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCreatedEvent;

    import com.sulake.habbo.communication.messages.incoming.navigator.DoorbellMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.navigator.GetGuestRoomResultEvent;

    import com.sulake.habbo.communication.messages.incoming.navigator.PopularRoomTagsResultEvent;

    import com.sulake.habbo.communication.messages.incoming.navigator.CanCreateRoomEvent;

    import com.sulake.habbo.communication.messages.incoming.newnavigator.class_151;

    import com.sulake.habbo.communication.messages.incoming.newnavigator.class_348;

    import com.sulake.habbo.communication.messages.incoming.newnavigator.class_364;

    import com.sulake.habbo.communication.messages.incoming.newnavigator.class_713;

    import com.sulake.habbo.communication.messages.incoming.newnavigator.class_760;

    import com.sulake.habbo.communication.messages.incoming.newnavigator.class_954;

    import com.sulake.habbo.communication.messages.incoming.nft.UserNftWardrobeMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.nft.UserNftChatStylesMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.nft.UserNftWardrobeSelectionMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.notifications.ClubGiftNotificationEvent;

    import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementNotificationMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.notifications.HabboBroadcastMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.notifications.ActivityPointsMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.notifications.MOTDNotificationEvent;

    import com.sulake.habbo.communication.messages.incoming.notifications.HabboActivityPointNotificationMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.notifications.NotificationDialogMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.notifications.UnseenItemsEvent;

    import com.sulake.habbo.communication.messages.incoming.notifications.OfferRewardDeliveredMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.notifications.ElementPointerMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.notifications.InfoFeedEnableMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.notifications.PetLevelNotificationEvent;

    import com.sulake.habbo.communication.messages.incoming.notifications.RestoreClientMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.nux.NewUserExperienceNotCompleteEvent;

    import com.sulake.habbo.communication.messages.incoming.nux.SelectInitialRoomEvent;

    import com.sulake.habbo.communication.messages.incoming.nux.NewUserExperienceGiftOfferEvent;

    import com.sulake.habbo.communication.messages.incoming.perk.CitizenshipVipOfferPromoEnabledEvent;

    import com.sulake.habbo.communication.messages.incoming.perk.PerkAllowancesMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.poll.PollContentsEvent;

    import com.sulake.habbo.communication.messages.incoming.poll.QuestionEvent;

    import com.sulake.habbo.communication.messages.incoming.poll.PollErrorEvent;

    import com.sulake.habbo.communication.messages.incoming.poll.QuestionFinishedEvent;

    import com.sulake.habbo.communication.messages.incoming.poll.QuestionAnsweredEvent;

    import com.sulake.habbo.communication.messages.incoming.poll.PollOfferEvent;

    import com.sulake.habbo.communication.messages.incoming.preferences.AccountPreferencesEvent;

    import com.sulake.habbo.communication.messages.incoming.quest.QuestCancelledMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.quest.QuestCompletedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.quest.SeasonalQuestsMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalProgressMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.quest.EpicPopupMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.quest.ConcurrentUsersGoalProgressMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.quest.QuestsMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.quest.class_931;

    import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalHallOfFameMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.quest.QuestDailyMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.action.SleepMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.action.DanceMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.action.CarryObjectMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.action.ExpressionMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.action.AvatarEffectMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.action.UseObjectMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.bots.BotCommandConfigurationEvent;

    import com.sulake.habbo.communication.messages.incoming.room.bots.BotForceOpenContextMenuEvent;

    import com.sulake.habbo.communication.messages.incoming.room.bots.BotSkillListUpdateEvent;

    import com.sulake.habbo.communication.messages.incoming.room.bots.BotErrorEvent;

    import com.sulake.habbo.communication.messages.incoming.room.camera.class_380;

    import com.sulake.habbo.communication.messages.incoming.room.chat.UserTypingMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.chat.RemainingMutePeriodEvent;

    import com.sulake.habbo.communication.messages.incoming.room.chat.ChatMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.chat.WhisperMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.chat.ShoutMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.chat.RoomFilterSettingsMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.chat.RoomChatSettingsMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.chat.FloodControlMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.UserUpdateMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.WiredMovementsMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomPropertyMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemUpdateMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectRemoveMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.HeightMapMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectDataUpdateMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectAddMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.SpecialRoomEffectMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.UserChangeMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.BuildersClubPlacementWarningMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectRemoveConfirmMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.FurnitureAliasesMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.FavoriteMembershipUpdateMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectsDataUpdateMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.UserRemoveMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.UsersMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.HeightMapUpdateMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectsMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemRemoveMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemDataUpdateMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectUpdateMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectRemoveMultipleMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.FloorHeightMapMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.SlideObjectBundleMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemsStateUpdateMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemStateUpdateMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemAddMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemsMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomVisualizationSettingsEvent;

    import com.sulake.habbo.communication.messages.incoming.room.furniture.YoutubeControlVideoMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.furniture.DiceValueMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.furniture.PresentOpenedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.furniture.CustomUserNotificationMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.furniture.FurniRentOrBuyoutOfferMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.furniture.AreaHideMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.furniture.YoutubeDisplayVideoMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.furniture.RentableSpaceRentOkMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.furniture.RentableSpaceRentFailedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.furniture.RoomMessageNotificationMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.furniture.OneWayDoorStatusMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.furniture.RequestSpamWallPostItMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.furniture.CustomStackingHeightUpdateMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.furniture.OpenPetPackageRequestedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.furniture.RentableSpaceStatusMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.furniture.OpenPetPackageResultMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.furniture.GuildFurniContextMenuInfoMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.furniture.RoomDimmerPresetsMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.furniture.YoutubeDisplayPlaylistsMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.layout.RoomOccupiedTilesMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.layout.RoomEntryTileMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.permissions.YouAreOwnerMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.permissions.YouAreNotControllerMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.permissions.YouAreControllerMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.pets.PetCommandsMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.pets.PetLevelUpdateEvent;

    import com.sulake.habbo.communication.messages.incoming.room.pets.PetRespectFailedEvent;

    import com.sulake.habbo.communication.messages.incoming.room.pets.PetExperienceEvent;

    import com.sulake.habbo.communication.messages.incoming.room.pets.PetFigureUpdateEvent;

    import com.sulake.habbo.communication.messages.incoming.room.pets.PetInfoMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.pets.PetBreedingResultEvent;

    import com.sulake.habbo.communication.messages.incoming.room.pets.PetStatusUpdateEvent;

    import com.sulake.habbo.communication.messages.incoming.room.pets.PetPlacingErrorEvent;

    import com.sulake.habbo.communication.messages.incoming.room.session.HanditemConfigurationMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.session.OpenConnectionMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.session.RoomForwardMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.session.FlatAccessibleMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.session.GamePlayerValueMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.session.YouAreNotSpectatorMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.session.YouAreSpectatorMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.session.CantConnectMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.session.YouArePlayingGameMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.session.RoomReadyMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.room.session.RoomQueueStatusMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.roomsettings.ShowEnforceRoomCategoryDialogEvent;

    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerAddedEvent;

    import com.sulake.habbo.communication.messages.incoming.roomsettings.UserUnbannedFromRoomEvent;

    import com.sulake.habbo.communication.messages.incoming.roomsettings.NoSuchFlatEvent;

    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsErrorEvent;

    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsSavedEvent;

    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllersEvent;

    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsDataEvent;

    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerRemovedEvent;

    import com.sulake.habbo.communication.messages.incoming.roomsettings.BannedUsersFromRoomEvent;

    import com.sulake.habbo.communication.messages.incoming.roomsettings.MuteAllInRoomEvent;

    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsSaveErrorEvent;

    import com.sulake.habbo.communication.messages.incoming.sound.TraxSongInfoMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.sound.JukeboxSongDisksMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.sound.UserSongDisksInventoryMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.sound.PlayListSongAddedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.sound.NowPlayingMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.sound.PlayListMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.sound.OfficialSongIdMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.sound.JukeboxPlayListFullMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.talent.TalentTrackLevelMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.talent.TalentLevelUpMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.talent.TalentTrackMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.tracking.LatencyPingResponseMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.userclassification.UserClassificationMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniConditionEvent;

    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredSaveSuccessEvent;

    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.OpenEvent;

    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniTriggerEvent;

    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredRewardResultMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniSelectorEvent;

    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniActionEvent;

    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniAddonEvent;

    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredValidationErrorEvent;

    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniVariableEvent;

    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredRoomStatsEvent;

    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredPermissionsEvent;

    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredRoomSettingsEvent;

    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredAllVariablesHashEvent;

    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredVariablesForObjectEvent;

    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredAllVariablesDiffsEvent;

    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredMenuErrorEvent;

    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredErrorLogsEvent;

    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredAllVariableHoldersEvent;

    import com.sulake.habbo.communication.messages.incoming.users.GuildEditorDataMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.users.ScrSendUserInfoEvent;

    import com.sulake.habbo.communication.messages.incoming.users.ExtendedProfileChangedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.users.PetRespectNotificationEvent;

    import com.sulake.habbo.communication.messages.incoming.users.GroupDetailsChangedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipRejectedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.users.HandItemReceivedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.users.UserNameChangedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.users.AccountSafetyLockStatusChangeMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.users.GuildMembersMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupJoinFailedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.users.GuildEditInfoMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDeactivatedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.users.GuildCreationInfoMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipUpdatedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.users.ScrSendKickbackInfoMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.users.GuildMemberFurniCountInHQMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.users.RelationshipStatusInfoEvent;

    import com.sulake.habbo.communication.messages.incoming.users.IgnoreResultMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.users.EmailStatusResultEvent;

    import com.sulake.habbo.communication.messages.incoming.users.ApproveNameMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipsMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupBadgesMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.users.PetSupplementedNotificationEvent;

    import com.sulake.habbo.communication.messages.incoming.users.GuildMemberMgmtFailedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.users.IgnoredUsersMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.users.ChangeEmailResultEvent;

    import com.sulake.habbo.communication.messages.incoming.users.GuildCreatedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.users.RespectNotificationMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.users.GuildEditFailedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.users.HabboUserBadgesMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.users.GroupMembershipRequestedMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.users.InClientLinkMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.users.ExtendedProfileMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.vault.CreditVaultStatusMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.vault.IncomeRewardClaimResponseMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.vault.IncomeRewardStatusMessageEvent;

    import com.sulake.habbo.communication.messages.outgoing.camera.PurchasePhotoMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.camera.PublishPhotoMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.camera.RenderRoomMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.camera.RenderRoomThumbnailMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.camera.RequestCameraConfigurationMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.camera.PhotoCompetitionMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.campaign.OpenCampaignCalendarDoorAsStaffComposer;

    import com.sulake.habbo.communication.messages.outgoing.campaign.OpenCampaignCalendarDoorComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.GetRoomAdPurchaseInfoComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.GetSnowWarGameTokensOfferComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseSnowWarGameTokensOfferComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.GetClubOffersMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.BuildersClubQueryFurniCountMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.GetCatalogPageWithEarliestExpiryComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.BuildersClubPlaceRoomItemMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.class_272;

    import com.sulake.habbo.communication.messages.outgoing.catalog.GetSeasonalCalendarDailyComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.class_367;

    import com.sulake.habbo.communication.messages.outgoing.catalog.GetLimitedOfferAppearingNextComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.RedeemVoucherMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.GetSellablePetPalettesComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.ShopTargetedOfferViewedComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseRoomAdMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.GetIsOfferGiftableComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.GetBundleDiscountRulesetComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.GetCatalogIndexComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseBasicMembershipExtensionComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.SelectClubGiftComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.GetBonusRareInfoMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.SetTargetedOfferStateComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.GetClubGiftMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.RoomAdPurchaseInitiatedComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.class_807;

    import com.sulake.habbo.communication.messages.outgoing.catalog.BuildersClubPlaceWallItemMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseFromCatalogComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.MarkCatalogNewAdditionsPageOpenedComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.GetProductOfferComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.GetGiftWrappingConfigurationComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.GetNextTargetedOfferComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseTargetedOfferComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.GetHabboClubExtendOfferMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseFromCatalogAsGiftComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseVipMembershipExtensionComposer;

    import com.sulake.habbo.communication.messages.outgoing.catalog.class_951;

    import com.sulake.habbo.communication.messages.outgoing.catalog.GetCatalogPageComposer;

    import com.sulake.habbo.communication.messages.outgoing.crafting.CraftComposer;

    import com.sulake.habbo.communication.messages.outgoing.crafting.GetCraftableProductsComposer;

    import com.sulake.habbo.communication.messages.outgoing.crafting.CraftSecretComposer;

    import com.sulake.habbo.communication.messages.outgoing.crafting.GetCraftingRecipesAvailableComposer;

    import com.sulake.habbo.communication.messages.outgoing.crafting.GetCraftingRecipeComposer;

    import com.sulake.habbo.communication.messages.outgoing.friendlist.SetRelationshipStatusMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.friendlist.SendRoomInviteMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.friendlist.DeclineFriendMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.friendlist.RemoveFriendMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.friendlist.FriendListUpdateMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.friendlist.SendMsgMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.friendlist.GetFriendRequestsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.friendlist.FindNewFriendsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.friendlist.FollowFriendMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.friendlist.GetMessengerHistoryComposer;

    import com.sulake.habbo.communication.messages.outgoing.friendlist.MessengerInitMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.friendlist.HabboSearchMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.friendlist.VisitUserMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.friendlist.RequestFriendMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.friendlist.AcceptFriendMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.handshake.DisconnectMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.handshake.PongMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.handshake.CompleteDiffieHandshakeMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.handshake.VersionCheckMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.handshake.ClientHelloMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.handshake.UniqueIDMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.handshake.InitDiffieHandshakeMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.handshake.InfoRetrieveMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.handshake.SSOTicketMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.help.ChatReviewGuideDetachedMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.help.class_1035;

    import com.sulake.habbo.communication.messages.outgoing.help.GetQuizQuestionsComposer;

    import com.sulake.habbo.communication.messages.outgoing.help.class_1050;

    import com.sulake.habbo.communication.messages.outgoing.help.class_1054;

    import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionRequesterCancelsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromSelfieMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.help.GetCfhStatusMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.help.PostQuizAnswersComposer;

    import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionResolvedMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionInviteRequesterMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.help.ChatReviewSessionCreateMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.help.class_303;

    import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionReportMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionOnDutyUpdateMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.help.ChatReviewGuideDecidesOnOfferMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromForumThreadMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromForumMessageMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionGuideDecidesMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.help.ChatReviewGuideVoteMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.help.DeletePendingCallsForHelpMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromPhotoMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.help.GetPendingCallsForHelpMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.help.GetGuideReportingStatusMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.help.class_580;

    import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionCreateMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromIMMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionGetRequesterRoomMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionFeedbackMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionMessageMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionIsTypingMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.inventory.achievements.GetAchievementsComposer;

    import com.sulake.habbo.communication.messages.outgoing.inventory.avatareffect.AvatarEffectSelectedComposer;

    import com.sulake.habbo.communication.messages.outgoing.inventory.avatareffect.AvatarEffectActivatedComposer;

    import com.sulake.habbo.communication.messages.outgoing.inventory.badges.GetBadgePointLimitsComposer;

    import com.sulake.habbo.communication.messages.outgoing.inventory.badges.GetBadgesComposer;

    import com.sulake.habbo.communication.messages.outgoing.inventory.badges.RequestABadgeComposer;

    import com.sulake.habbo.communication.messages.outgoing.inventory.badges.SetActivatedBadgesComposer;

    import com.sulake.habbo.communication.messages.outgoing.inventory.badges.GetIsBadgeRequestFulfilledComposer;

    import com.sulake.habbo.communication.messages.outgoing.inventory.furni.RequestFurniInventoryComposer;

    import com.sulake.habbo.communication.messages.outgoing.inventory.furni.RequestFurniInventoryWhenNotInRoomComposer;

    import com.sulake.habbo.communication.messages.outgoing.inventory.furni.RequestRoomPropertySet;

    import com.sulake.habbo.communication.messages.outgoing.inventory.purse.GetCreditsInfoComposer;

    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.SilverFeeMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.AddItemsToTradeComposer;

    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.OpenTradingComposer;

    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.ConfirmAcceptTradingComposer;

    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.CloseTradingComposer;

    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.RemoveItemFromTradeComposer;

    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.ConfirmDeclineTradingComposer;

    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.UnacceptTradingComposer;

    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.AddItemToTradeComposer;

    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.AcceptTradingComposer;

    import com.sulake.habbo.communication.messages.outgoing.landingview.GetPromoArticlesMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.moderator.GetCfhChatlogMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.moderator.PickIssuesMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.moderator.ModKickMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.moderator.ModMessageMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.moderator.ModBanMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.moderator.ModMuteMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.moderator.ReleaseIssuesMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.moderator.GetModeratorUserInfoMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.moderator.DefaultSanctionMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.moderator.ModTradingLockMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.moderator.CloseIssuesMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.moderator.ModToolPreferencesComposer;

    import com.sulake.habbo.communication.messages.outgoing.moderator.GetModeratorRoomInfoMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.moderator.GetRoomChatlogMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.moderator.GetUserChatlogMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.moderator.ModToolSanctionComposer;

    import com.sulake.habbo.communication.messages.outgoing.moderator.ModeratorActionMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.moderator.CloseIssueDefaultActionMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.moderator.ModerateRoomMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.moderator.ModAlertMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.moderator.GetRoomVisitsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.ConvertGlobalRoomIdMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.DeleteFavouriteRoomMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.class_1081;

    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomAdEventTabViewedComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.RateFlatMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.GetPopularRoomTagsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.EditEventMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomsWithHighestScoreSearchMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.CompetitionRoomsSearchMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.MyRoomRightsSearchMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.MyRecommendedRoomsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.GuildBaseSearchMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.GetOfficialRoomsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.ToggleStaffPickMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.ForwardToSomeRoomMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomAdSearchMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.MyFavouriteRoomsSearchMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.ForwardToARandomPromotedRoomMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.CreateFlatMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.RemoveOwnRoomRightsRoomMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.PopularRoomsSearchMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.CanCreateRoomMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.GetGuestRoomMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.MyRoomHistorySearchMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.MyRoomsSearchMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomTextSearchMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.MyGuildBasesSearchMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.AddFavouriteRoomMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.MyFriendsRoomsSearchMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.GetUserFlatCatsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.MyFrequentRoomHistorySearchMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.SetRoomSessionTagsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomsWhereMyFriendsAreSearchMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.CancelEventMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.class_977;

    import com.sulake.habbo.communication.messages.outgoing.navigator.UpdateHomeRoomMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomAdEventTabAdClickedComposer;

    import com.sulake.habbo.communication.messages.outgoing.navigator.GetUserEventCatsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.poll.PollStartComposer;

    import com.sulake.habbo.communication.messages.outgoing.poll.PollAnswerComposer;

    import com.sulake.habbo.communication.messages.outgoing.poll.PollRejectComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.action.BanUserWithDurationMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.action.KickUserMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.action.MuteUserMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.action.LetUserInMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.action.AmbassadorAlertMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.action.UnmuteUserMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.action.RemoveRightsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.action.AssignRightsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.action.RemoveAllRightsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.action.MuteAllInRoomComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.action.UnbanUserFromRoomMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.avatar.AvatarExpressionMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.avatar.CustomizeAvatarWithFurniMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.avatar.DropCarryItemMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.avatar.PassCarryItemToPetMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.avatar.SignMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.avatar.LookToMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.avatar.DanceMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.avatar.ChangeMottoMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.avatar.PassCarryItemMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.avatar.ChangePostureMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.chat.ChatMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.chat.ShoutMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.chat.CancelTypingMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.chat.WhisperMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.chat.StartTypingMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.engine.ClickFurniMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.engine.RemoveItemMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.engine.TogglePetRidingPermissionMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.engine.MountPetMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.engine.PlaceBotMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.engine.HarvestPetMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.engine.RemovePetFromFlatMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.engine.SetItemDataMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.engine.CompostPlantMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.engine.PickupObjectMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.engine.MoveAvatarMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.engine.GetItemDataMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.engine.RemoveBotFromFlatMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.engine.TogglePetBreedingPermissionMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.engine.MovePetMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.engine.SetClothingChangeDataMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.engine.RemoveSaddleFromPetMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.engine.UseFurnitureMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.engine.MoveObjectMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.engine.GetFurnitureAliasesMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.engine.SetObjectDataMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.engine.PlaceObjectMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.engine.GiveSupplementToPetMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.engine.PlacePetMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.engine.MoveWallItemMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.engine.UseWallItemMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.engine.GetHeightMapMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.engine.GetPetCommandsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.ExtendRentOrBuyoutFurniMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.CreditFurniRedeemMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.ThrowDiceMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.SetYoutubeDisplayPlaylistMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.EnterOneWayDoorMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.RentableSpaceCancelRentMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.RentableSpaceRentMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.GetRentOrBuyoutOfferMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.OpenPetPackageMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.DiceOffMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.SpinWheelOfFortuneMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.ControlYoutubeDisplayPlaybackMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.AddSpamWallPostItMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.OpenMysteryTrophyMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.SetAreaHideDataComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.RoomDimmerChangeStateMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.ExtendRentOrBuyoutStripItemMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.GetYoutubeDisplayStatusMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.RentableSpaceStatusMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.RoomDimmerGetPresetsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.SetRandomStateMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.PlacePostItMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.PresentOpenMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.RoomDimmerSavePresetMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.SetMannequinFigureComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.SetRoomBackgroundColorDataComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.SetCustomStackingHeightComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.GetGuildFurniContextMenuInfoMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.furniture.SetMannequinNameComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.session.ChangeQueueMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.session.QuitMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.session.OpenFlatConnectionMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.roomsettings.GetBannedUsersFromRoomMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.roomsettings.UpdateRoomCategoryAndTradeSettingsComposer;

    import com.sulake.habbo.communication.messages.outgoing.roomsettings.GetRoomSettingsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.roomsettings.UpdateRoomFilterMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.roomsettings.GetCustomRoomFilterMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.roomsettings.SaveRoomSettingsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.roomsettings.DeleteRoomMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.roomsettings.GetFlatControllersMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateSelectorMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateConditionMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateTriggerMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateAddonMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateActionMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.ApplySnapshotMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.OpenMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateVariableMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.AddAdminRightsToMemberMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.UpdateGuildColorsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.GetUserNftChatStylesMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.DeactivateGuildMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.RejectMembershipRequestMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileByNameMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.GetEmailStatusComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.GetGuildMembersMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.GetGuildEditInfoMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.GetGuildEditorDataMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.SelectFavouriteHabboGroupMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.ApproveMembershipRequestMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.CreateGuildMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.ApproveNameMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.ApproveAllMembershipRequestsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.JoinHabboGroupMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.UnignoreUserMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.ScrGetKickbackInfoMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.GetMOTDMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.IgnoreUserMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupBadgesMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.RemoveAdminRightsFromMemberMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.class_606;

    import com.sulake.habbo.communication.messages.outgoing.users.ChangeEmailComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.GiveStarGemToUserMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.GetIgnoredUsersMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.GetRelationshipStatusInfoMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.ScrGetUserInfoMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.GetGuildMembershipsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.GetGuildCreationInfoMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.DeselectFavouriteHabboGroupMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.UpdateGuildBadgeMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.GetSelectedBadgesMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.UpdateGuildSettingsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.KickMemberMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.UnblockGroupMemberMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.UpdateGuildIdentityMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.users.GetMemberGuildItemCountMessageComposer;

    import package_1.*;

    import com.sulake.habbo.communication.messages.outgoing.marketplace.RedeemMarketplaceOfferCreditsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceOffersMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceConfigurationMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.marketplace.BuyMarketplaceTokensMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.marketplace.CancelMarketplaceOfferMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceItemStatsComposer;

    import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceOwnOffersMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceCanMakeOfferMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.marketplace.BuyMarketplaceOfferMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.marketplace.MakeOfferMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.inventory.pets.ConfirmPetBreedingComposer;

    import com.sulake.habbo.communication.messages.outgoing.inventory.pets.GetPetInventoryComposer;

    import com.sulake.habbo.communication.messages.outgoing.inventory.pets.CancelPetBreedingComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.layout.GetRoomEntryTileMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.layout.GetOccupiedTilesMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.layout.UpdateFloorPropertiesMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.roomdirectory.RoomNetworkOpenConnectionMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.hotlooks.GetHotLooksMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.register.UpdateFigureDataMessageComposer;

    import package_113.*;

    import com.sulake.habbo.communication.messages.outgoing.mysterybox.MysteryBoxWaitingCanceledMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.landingview.votes.CommunityGoalVoteMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.inventory.bots.GetBotInventoryComposer;

    import package_120.*;

    import package_121.*;

    import package_14.*;

    import com.sulake.habbo.communication.messages.outgoing.sound.GetUserSongDisksMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.sound.AddJukeboxDiskComposer;

    import com.sulake.habbo.communication.messages.outgoing.sound.GetNowPlayingMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.sound.GetOfficialSongIdMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.sound.GetJukeboxPlayListMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.sound.GetSoundMachinePlayListMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.sound.GetSoundSettingsComposer;

    import com.sulake.habbo.communication.messages.outgoing.sound.GetSongInfoMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.sound.RemoveJukeboxDiskComposer;

    import package_2.*;

    import com.sulake.habbo.communication.messages.outgoing.preferences.SetChatStylePreferenceComposer;

    import com.sulake.habbo.communication.messages.outgoing.preferences.SetChatPreferencesMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.preferences.SetUIFlagsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.preferences.SetNewNavigatorWindowPreferencesMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.preferences.SetSoundSettingsComposer;

    import com.sulake.habbo.communication.messages.outgoing.preferences.SetRoomCameraPreferencesMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.preferences.SetIgnoreRoomInvitesMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.groupforums.GetForumStatsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.groupforums.GetMessagesMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.groupforums.ModerateThreadMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.groupforums.GetThreadsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.groupforums.GetUnreadForumsCountMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.groupforums.PostMessageMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.groupforums.GetForumsListMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.groupforums.UpdateThreadMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.groupforums.UpdateForumReadMarkerMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.groupforums.ModerateMessageMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.groupforums.UpdateForumSettingsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.groupforums.GetThreadMessageComposer;

    import package_22.*;

    import package_23.*;

    import package_24.*;

    import package_3.*;

    import package_30.*;

    import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2CheckGameDirectoryStatusMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2GetAccountGameStatusMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2StartSnowWarMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2QuickJoinGameMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2LeaveGameMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.game.lobby.GetUserGameAchievementsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.game.lobby.class_165;

    import com.sulake.habbo.communication.messages.outgoing.game.lobby.GetResolutionAchievementsMessageComposer;

    import package_34.*;

    import com.sulake.habbo.communication.messages.outgoing.advertisement.InterstitialShownMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.advertisement.GetInterstitialMessageComposer;

    import package_36.*;

    import package_37.*;

    import com.sulake.habbo.communication.messages.outgoing.game.score.Game2GetFriendsLeaderboardComposer;

    import com.sulake.habbo.communication.messages.outgoing.game.score.Game2GetTotalGroupLeaderboardComposer;

    import com.sulake.habbo.communication.messages.outgoing.game.score.Game2GetTotalLeaderboardComposer;

    import com.sulake.habbo.communication.messages.outgoing.game.score.Game2GetWeeklyFriendsLeaderboardComposer;

    import com.sulake.habbo.communication.messages.outgoing.game.score.Game2GetWeeklyGroupLeaderboardComposer;

    import com.sulake.habbo.communication.messages.outgoing.game.score.Game2GetWeeklyLeaderboardComposer;

    import com.sulake.habbo.communication.messages.outgoing.game.score.GetFriendsWeeklyCompetitiveLeaderboardComposer;

    import com.sulake.habbo.communication.messages.outgoing.game.score.GetWeeklyCompetitiveLeaderboardComposer;

    import com.sulake.habbo.communication.messages.outgoing.game.score.GetWeeklyGameRewardComposer;

    import com.sulake.habbo.communication.messages.outgoing.game.score.GetWeeklyGameRewardWinnersComposer;

    import com.sulake.habbo.communication.messages.outgoing.competition.class_1011;

    import com.sulake.habbo.communication.messages.outgoing.competition.ForwardToASubmittableRoomMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.competition.VoteForRoomMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.competition.ForwardToACompetitionRoomMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.competition.GetSecondsUntilMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.competition.GetIsUserPartOfCompetitionMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.competition.ForwardToRandomCompetitionRoomMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.competition.SubmitRoomToCompetitionMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.competition.RoomCompetitionInitMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.newnavigator.NavigatorRemoveCollapsedCategoryMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.newnavigator.NavigatorSetSearchCodeViewModeMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.newnavigator.NavigatorAddSavedSearchComposer;

    import com.sulake.habbo.communication.messages.outgoing.newnavigator.NavigatorDeleteSavedSearchComposer;

    import com.sulake.habbo.communication.messages.outgoing.newnavigator.NavigatorAddCollapsedCategoryMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.newnavigator.NewNavigatorSearchComposer;

    import com.sulake.habbo.communication.messages.outgoing.newnavigator.NewNavigatorInitComposer;

    import com.sulake.habbo.communication.messages.outgoing.vault.CreditVaultStatusMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.vault.WithdrawCreditVaultMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.vault.IncomeRewardStatusMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.vault.IncomeRewardClaimMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.nux.NewUserExperienceGetGiftsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.nux.NewUserExperienceScriptProceedComposer;

    import com.sulake.habbo.communication.messages.outgoing.nux.SelectInitialRoomComposer;

    import com.sulake.habbo.communication.messages.outgoing.gifts.class_200;

    import com.sulake.habbo.communication.messages.outgoing.gifts.SetPhoneNumberVerificationStatusMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.gifts.VerifyCodeMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.gifts.ResetPhoneNumberStateMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.gifts.TryPhoneNumberMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.notifications.ResetUnseenItemIdsComposer;

    import com.sulake.habbo.communication.messages.outgoing.notifications.ResetUnseenItemsComposer;

    import com.sulake.habbo.communication.messages.outgoing.game.arena.Game2ExitGameMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.game.arena.Game2GameChatMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.game.arena.Game2LoadStageReadyMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.game.arena.Game2PlayAgainMessageComposer;

    import package_51.*;

    import com.sulake.habbo.communication.messages.outgoing.tracking.PerformanceLogMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.tracking.LagWarningReportMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.tracking.LatencyPingRequestMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.tracking.LatencyPingReportMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.quest.GetConcurrentUsersGoalProgressMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.quest.GetDailyQuestMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.quest.GetConcurrentUsersRewardMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.quest.GetCommunityGoalHallOfFameMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.quest.ActivateQuestMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.quest.OpenQuestTrackerMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.quest.AcceptQuestMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.quest.GetSeasonalQuestsOnlyMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.quest.class_493;

    import com.sulake.habbo.communication.messages.outgoing.quest.GetQuestsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.quest.FriendRequestQuestCompleteMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.quest.class_735;

    import com.sulake.habbo.communication.messages.outgoing.quest.StartCampaignMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.quest.GetCommunityGoalProgressMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.quest.CancelQuestMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.quest.RejectQuestMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.collectibles.GetNftTransferFeeMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.collectibles.GetCollectibleWalletAddressesMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.collectibles.GetCollectibleMintableItemTypesMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.collectibles.GetCollectibleMintTokensMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.collectibles.NftTransferAssetsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.collectibles.MintItemMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.collectibles.GetCollectorScoreMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.collectibles.GetCollectibleMintingEnabledMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.collectibles.GetMintTokenOffersMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.collectibles.NftCollectiblesClaimBonusItemMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.collectibles.NftCollectiblesClaimRewardItemMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.collectibles.GetNftCollectionsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.collectibles.PurchaseMintTokenMessageComposer;

    import package_62.*;

    import package_65.*;

    import com.sulake.habbo.communication.messages.outgoing.avatar.CheckUserNameMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.avatar.ChangeUserNameInRoomMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.avatar.ChangeUserNameMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.avatar.SaveWardrobeOutfitMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.avatar.GetWardrobeMessageComposer;

    import package_72.*;

    import package_73.*;

    import com.sulake.habbo.communication.messages.outgoing.game.ingame.Game2MakeSnowballMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.game.ingame.Game2RequestFullStatusUpdateMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.game.ingame.Game2SetUserMoveTargetMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.game.ingame.Game2ThrowSnowballAtHumanMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.game.ingame.Game2ThrowSnowballAtPositionMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredGetAllVariableHoldersMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredGetErrorLogsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredGetRoomSettingsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredClearErrorLogsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredGetAllVariablesHashMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredGetVariablesForObjectMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredSetPreferencesMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredSetRoomSettingsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredSetObjectVariableValueMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredGetRoomStatsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredGetAllVariablesDiffsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.pets.PetSelectedMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.pets.GetPetInfoMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.pets.BreedPetsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.pets.CustomizePetWithFurniComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.pets.RespectPetMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.nft.GetNftCreditsMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.nft.GetSilverMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.nft.GetUserNftWardrobeMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.nft.SaveUserNftWardrobeMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.nft.GetSelectedNftWardrobeOutfitMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.talent.GetTalentTrackMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.talent.GetTalentTrackLevelMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.talent.GuideAdvertisementReadMessageComposer;

    import package_84.*;

    import com.sulake.habbo.communication.messages.incoming.advertisement.InterstitialMessageEvent;

    import com.sulake.habbo.communication.messages.incoming.advertisement.RoomAdErrorEvent;

    import com.sulake.habbo.communication.messages.outgoing.userclassification.RoomUsersClassificationMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.userclassification.PeerUsersClassificationMessageComposer;

    import package_91.*;

    import package_92.*;

    import com.sulake.habbo.communication.messages.outgoing.friendfurni.FriendFurniConfirmLockMessageComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.bots.GetBotCommandConfigurationDataComposer;

    import com.sulake.habbo.communication.messages.outgoing.room.bots.CommandBotComposer;

    [SecureSWF(rename="true")]
    public class HabboMessages implements IMessageConfiguration
    {

        private static const _events:Map = new class_885();

        private static const _composers:Map = new class_885();

        {
            _composers[1005] = Game2QuickJoinGameMessageComposer;
            _composers[1009] = GetRoomAdPurchaseInfoComposer;
            _composers[1012] = GetBadgePointLimitsComposer;
            _composers[1015] = GetRelationshipStatusInfoMessageComposer;
            _composers[102] = PhotoCompetitionMessageComposer;
            _composers[1032] = ForwardToACompetitionRoomMessageComposer;
            _composers[1034] = class_735;
            _composers[1037] = GetExtendedProfileByNameMessageComposer;
            _composers[1039] = UpdateActionMessageComposer;
            _composers[1046] = RejectMembershipRequestMessageComposer;
            _composers[1047] = GetBadgesComposer;
            _composers[1049] = PollStartComposer;
            _composers[1050] = NewUserExperienceGetGiftsMessageComposer;
            _composers[106] = ForwardToASubmittableRoomMessageComposer;
            _composers[1061] = BanUserWithDurationMessageComposer;
            _composers[1076] = PassCarryItemToPetMessageComposer;
            _composers[108] = RemoveRightsMessageComposer;
            _composers[1104] = GetMarketplaceConfigurationMessageComposer;
            _composers[1105] = RoomsWhereMyFriendsAreSearchMessageComposer;
            _composers[1108] = NavigatorSetSearchCodeViewModeMessageComposer;
            _composers[1113] = DisconnectMessageComposer;
            _composers[1116] = GetConcurrentUsersGoalProgressMessageComposer;
            _composers[1127] = CustomizePetWithFurniComposer;
            _composers[1139] = CallForHelpFromForumMessageMessageComposer;
            _composers[1152] = CallForHelpFromSelfieMessageComposer;
            _composers[1154] = GetRoomVisitsMessageComposer;
            _composers[1171] = SetItemDataMessageComposer;
            _composers[1176] = ModBanMessageComposer;
            _composers[1179] = SetChatPreferencesMessageComposer;
            _composers[1189] = RemoveOwnRoomRightsRoomMessageComposer;
            _composers[1199] = RoomAdEventTabAdClickedComposer;
            _composers[1200] = GetCustomRoomFilterMessageComposer;
            _composers[1201] = WiredGetAllVariablesDiffsMessageComposer;
            _composers[1210] = ToggleStaffPickMessageComposer;
            _composers[1225] = class_1054;
            _composers[1227] = GetSellablePetPalettesComposer;
            _composers[1229] = SetTargetedOfferStateComposer;
            _composers[124] = GetCommunityGoalProgressMessageComposer;
            _composers[1249] = AddJukeboxDiskComposer;
            _composers[1251] = UnmuteUserMessageComposer;
            _composers[1267] = SetActivatedBadgesComposer;
            _composers[127] = UpdateForumSettingsMessageComposer;
            _composers[1294] = GetGuildMembersMessageComposer;
            _composers[1297] = HarvestPetMessageComposer;
            _composers[1313] = GetResolutionAchievementsMessageComposer;
            _composers[1326] = GetProductOfferComposer;
            _composers[1330] = RentableSpaceStatusMessageComposer;
            _composers[1355] = WithdrawCreditVaultMessageComposer;
            _composers[1360] = Game2GetTotalGroupLeaderboardComposer;
            _composers[1373] = Game2LoadStageReadyMessageComposer;
            _composers[1376] = PurchaseSnowWarGameTokensOfferComposer;
            _composers[1378] = HabboSearchMessageComposer;
            _composers[1390] = UniqueIDMessageComposer;
            _composers[1393] = AvatarEffectSelectedComposer;
            _composers[1394] = PublishPhotoMessageComposer;
            _composers[1398] = GetBotCommandConfigurationDataComposer;
            _composers[1399] = FriendListUpdateMessageComposer;
            _composers[1409] = RenderRoomThumbnailMessageComposer;
            _composers[141] = NavigatorRemoveCollapsedCategoryMessageComposer;
            _composers[1417] = RedeemMarketplaceOfferCreditsMessageComposer;
            _composers[1419] = GetBonusRareInfoMessageComposer;
            _composers[1425] = CallForHelpMessageComposer;
            _composers[1430] = NftTransferAssetsMessageComposer;
            _composers[1434] = GetMemberGuildItemCountMessageComposer;
            _composers[1441] = GetMOTDMessageComposer;
            _composers[1459] = RoomDimmerSavePresetMessageComposer;
            _composers[1469] = ModMuteMessageComposer;
            _composers[147] = UseFurnitureMessageComposer;
            _composers[1472] = RoomAdEventTabViewedComposer;
            _composers[1477] = GetSoundMachinePlayListMessageComposer;
            _composers[1487] = NftCollectiblesClaimRewardItemMessageComposer;
            _composers[1503] = RequestCameraConfigurationMessageComposer;
            _composers[1511] = ForwardToRandomCompetitionRoomMessageComposer;
            _composers[1521] = ForwardToARandomPromotedRoomMessageComposer;
            _composers[1526] = RoomAdSearchMessageComposer;
            _composers[1538] = GetCatalogPageComposer;
            _composers[1539] = GetCfhStatusMessageComposer;
            _composers[1554] = CreditFurniRedeemMessageComposer;
            _composers[1560] = ModMessageMessageComposer;
            _composers[1561] = GetGuestRoomMessageComposer;
            _composers[1565] = ReleaseIssuesMessageComposer;
            _composers[157] = GetTalentTrackLevelMessageComposer;
            _composers[1575] = SilverFeeMessageComposer;
            _composers[1598] = NftCollectiblesClaimBonusItemMessageComposer;
            _composers[16] = GetOccupiedTilesMessageComposer;
            _composers[1601] = GetIgnoredUsersMessageComposer;
            _composers[161] = AssignRightsMessageComposer;
            _composers[1614] = RoomAdPurchaseInitiatedComposer;
            _composers[1616] = CancelPetBreedingComposer;
            _composers[1617] = GetMarketplaceItemStatsComposer;
            _composers[1622] = ApproveAllMembershipRequestsMessageComposer;
            _composers[1626] = ConfirmDeclineTradingComposer;
            _composers[1630] = GetHabboGroupDetailsMessageComposer;
            _composers[1633] = GetNextTargetedOfferComposer;
            _composers[1637] = GuideSessionOnDutyUpdateMessageComposer;
            _composers[1645] = RequestFriendMessageComposer;
            _composers[1666] = SetRelationshipStatusMessageComposer;
            _composers[1670] = SetCustomStackingHeightComposer;
            _composers[1679] = GetUserEventCatsMessageComposer;
            _composers[1684] = CancelEventMessageComposer;
            _composers[1686] = MyRecommendedRoomsMessageComposer;
            _composers[17] = GetDailyQuestMessageComposer;
            _composers[1704] = GetCommunityGoalHallOfFameMessageComposer;
            _composers[1709] = RemoveItemFromTradeComposer;
            _composers[171] = PlaceObjectMessageComposer;
            _composers[172] = class_200;
            _composers[1732] = MuteAllInRoomComposer;
            _composers[1733] = class_272;
            _composers[1739] = Game2ThrowSnowballAtPositionMessageComposer;
            _composers[1746] = AcceptTradingComposer;
            _composers[1753] = GetNowPlayingMessageComposer;
            _composers[1773] = class_1081;
            _composers[1779] = UnacceptTradingComposer;
            _composers[1781] = CloseTradingComposer;
            _composers[1783] = GuideSessionGetRequesterRoomMessageComposer;
            _composers[180] = PlaceBotMessageComposer;
            _composers[1807] = FriendRequestQuestCompleteMessageComposer;
            _composers[1814] = GetMarketplaceOffersMessageComposer;
            _composers[1819] = class_580;
            _composers[1833] = GiveStarGemToUserMessageComposer;
            _composers[1843] = EnterOneWayDoorMessageComposer;
            _composers[1847] = UpdateRoomFilterMessageComposer;
            _composers[1852] = PurchaseFromCatalogComposer;
            _composers[1865] = PlacePostItMessageComposer;
            _composers[1880] = OpenMysteryTrophyMessageComposer;
            _composers[1881] = ExtendRentOrBuyoutStripItemMessageComposer;
            _composers[1883] = ModTradingLockMessageComposer;
            _composers[1890] = RoomsWithHighestScoreSearchMessageComposer;
            _composers[1897] = UpdateGuildIdentityMessageComposer;
            _composers[1898] = GetThreadsMessageComposer;
            _composers[1909] = ScrGetUserInfoMessageComposer;
            _composers[1912] = SetNewNavigatorWindowPreferencesMessageComposer;
            _composers[1914] = UpdateGuildSettingsMessageComposer;
            _composers[1918] = ConfirmAcceptTradingComposer;
            _composers[1923] = SetClothingChangeDataMessageComposer;
            _composers[193] = MarkCatalogNewAdditionsPageOpenedComposer;
            _composers[1931] = IncomeRewardClaimMessageComposer;
            _composers[1935] = GetHeightMapMessageComposer;
            _composers[1947] = GetUserSongDisksMessageComposer;
            _composers[1948] = GetCollectorScoreMessageComposer;
            _composers[195] = DeactivateGuildMessageComposer;
            _composers[1951] = RemoveAllRightsMessageComposer;
            _composers[1952] = GetOfficialSongIdMessageComposer;
            _composers[1956] = GetCraftableProductsComposer;
            _composers[1959] = Game2GetFriendsLeaderboardComposer;
            _composers[1967] = GetPetInventoryComposer;
            _composers[1976] = ModerateThreadMessageComposer;
            _composers[1990] = GetSilverMessageComposer;
            _composers[20] = OpenPetPackageMessageComposer;
            _composers[2007] = GetRoomChatlogMessageComposer;
            _composers[201] = UpdateRoomCategoryAndTradeSettingsComposer;
            _composers[2011] = SubmitRoomToCompetitionMessageComposer;
            _composers[2020] = GetNftTransferFeeMessageComposer;
            _composers[2046] = KickUserMessageComposer;
            _composers[2049] = Game2GetWeeklyLeaderboardComposer;
            _composers[2057] = ChatMessageComposer;
            _composers[2064] = GetFurnitureAliasesMessageComposer;
            _composers[2065] = WhisperMessageComposer;
            _composers[2068] = GetConcurrentUsersRewardMessageComposer;
            _composers[2077] = TryPhoneNumberMessageComposer;
            _composers[2080] = RateFlatMessageComposer;
            _composers[2085] = PickupObjectMessageComposer;
            _composers[2087] = WiredClearErrorLogsMessageComposer;
            _composers[2089] = GetOfficialRoomsMessageComposer;
            _composers[2109] = CheckUserNameMessageComposer;
            _composers[2114] = GetRentOrBuyoutOfferMessageComposer;
            _composers[2123] = GetMarketplaceCanMakeOfferMessageComposer;
            _composers[2131] = DeselectFavouriteHabboGroupMessageComposer;
            _composers[2137] = GetIsBadgeRequestFulfilledComposer;
            _composers[2141] = GetFlatControllersMessageComposer;
            _composers[2159] = UpdateSelectorMessageComposer;
            _composers[2162] = RemoveAdminRightsFromMemberMessageComposer;
            _composers[2168] = PollRejectComposer;
            _composers[2171] = MyFriendsRoomsSearchMessageComposer;
            _composers[2182] = GetJukeboxPlayListMessageComposer;
            _composers[2185] = DanceMessageComposer;
            _composers[2188] = UpdateHomeRoomMessageComposer;
            _composers[2197] = SetRoomBackgroundColorDataComposer;
            _composers[2200] = Game2RequestFullStatusUpdateMessageComposer;
            _composers[2205] = MintItemMessageComposer;
            _composers[2209] = SetUIFlagsMessageComposer;
            _composers[222] = UpdateFloorPropertiesMessageComposer;
            _composers[2244] = SetMannequinFigureComposer;
            _composers[2249] = IgnoreUserMessageComposer;
            _composers[2250] = GetQuizQuestionsComposer;
            _composers[2253] = PostMessageMessageComposer;
            _composers[2265] = Game2GameChatMessageComposer;
            _composers[2269] = PresentOpenMessageComposer;
            _composers[2270] = GiveSupplementToPetMessageComposer;
            _composers[2290] = class_367;
            _composers[2293] = RemoveSaddleFromPetMessageComposer;
            _composers[2297] = EventLogMessageComposer;
            _composers[2302] = RemovePetFromFlatMessageComposer;
            _composers[2304] = LagWarningReportMessageComposer;
            _composers[2305] = BuyMarketplaceOfferMessageComposer;
            _composers[2307] = RedeemVoucherMessageComposer;
            _composers[2317] = GetHabboGroupBadgesMessageComposer;
            _composers[2321] = RentableSpaceCancelRentMessageComposer;
            _composers[2325] = GetSeasonalQuestsOnlyMessageComposer;
            _composers[2327] = GetItemDataMessageComposer;
            _composers[2331] = PongMessageComposer;
            _composers[2338] = ChatReviewGuideVoteMessageComposer;
            _composers[2339] = PlacePetMessageComposer;
            _composers[2346] = VoteForRoomMessageComposer;
            _composers[2348] = ThrowDiceMessageComposer;
            _composers[2351] = MoveObjectMessageComposer;
            _composers[2362] = GetYoutubeDisplayStatusMessageComposer;
            _composers[2363] = MoveAvatarMessageComposer;
            _composers[2370] = GetQuestsMessageComposer;
            _composers[2374] = ModToolPreferencesComposer;
            _composers[2404] = ChangeMottoMessageComposer;
            _composers[2418] = GetGiftWrappingConfigurationComposer;
            _composers[2428] = OpenMessageComposer;
            _composers[2443] = RenderRoomMessageComposer;
            _composers[2446] = FollowFriendMessageComposer;
            _composers[245] = InfoRetrieveMessageComposer;
            _composers[2460] = ChangeEmailComposer;
            _composers[2470] = Game2SetUserMoveTargetMessageComposer;
            _composers[2473] = FriendFurniConfirmLockMessageComposer;
            _composers[2476] = GetRoomEntryTileMessageComposer;
            _composers[2477] = IncomeRewardStatusMessageComposer;
            _composers[2481] = class_1011;
            _composers[2496] = ScrGetKickbackInfoMessageComposer;
            _composers[250] = GetCollectibleWalletAddressesMessageComposer;
            _composers[2508] = ApplySnapshotMessageComposer;
            _composers[2513] = ModAlertMessageComposer;
            _composers[2534] = GetPetCommandsMessageComposer;
            _composers[2549] = RoomUsersClassificationMessageComposer;
            _composers[255] = class_1035;
            _composers[2558] = GetAchievementsComposer;
            _composers[2578] = VisitUserMessageComposer;
            _composers[2582] = GetGuideReportingStatusMessageComposer;
            _composers[2593] = GetSongInfoMessageComposer;
            _composers[2595] = CommandBotComposer;
            _composers[2602] = VersionCheckMessageComposer;
            _composers[2603] = RoomCompetitionInitMessageComposer;
            _composers[2611] = GetThreadMessageComposer;
            _composers[2616] = CompleteDiffieHandshakeMessageComposer;
            _composers[2619] = CallForHelpFromIMMessageComposer;
            _composers[2624] = UpdateThreadMessageComposer;
            _composers[2631] = RespectPetMessageComposer;
            _composers[2636] = PetSelectedMessageComposer;
            _composers[2639] = RemoveItemMessageComposer;
            _composers[264] = SetSoundSettingsComposer;
            _composers[2641] = UpdateConditionMessageComposer;
            _composers[2663] = GetGuildEditorDataMessageComposer;
            _composers[2666] = ExtendRentOrBuyoutFurniMessageComposer;
            _composers[2673] = MyFavouriteRoomsSearchMessageComposer;
            _composers[2678] = StartTypingMessageComposer;
            _composers[268] = GetSeasonalCalendarDailyComposer;
            _composers[2681] = CraftComposer;
            _composers[2703] = Game2StartSnowWarMessageComposer;
            _composers[2708] = AcceptQuestMessageComposer;
            _composers[271] = class_977;
            _composers[2714] = BuildersClubQueryFurniCountMessageComposer;
            _composers[2718] = OpenQuestTrackerMessageComposer;
            _composers[2722] = QuitMessageComposer;
            _composers[2729] = OpenFlatConnectionMessageComposer;
            _composers[2749] = GetMarketplaceOwnOffersMessageComposer;
            _composers[2760] = BuyMarketplaceTokensMessageComposer;
            _composers[2765] = ResetPhoneNumberStateMessageComposer;
            _composers[2775] = PurchaseRoomAdMessageComposer;
            _composers[2781] = GetUserGameAchievementsMessageComposer;
            _composers[2798] = GetUnreadForumsCountMessageComposer;
            _composers[2800] = SendMsgMessageComposer;
            _composers[2806] = GuildBaseSearchMessageComposer;
            _composers[2809] = SetMannequinNameComposer;
            _composers[283] = MyRoomRightsSearchMessageComposer;
            _composers[2837] = UpdateForumReadMarkerMessageComposer;
            _composers[2839] = AddItemsToTradeComposer;
            _composers[2841] = GetUserChatlogMessageComposer;
            _composers[2844] = SelectInitialRoomComposer;
            _composers[2845] = GetExtendedProfileMessageComposer;
            _composers[2847] = ControlYoutubeDisplayPlaybackMessageComposer;
            _composers[2862] = GetSelectedNftWardrobeOutfitMessageComposer;
            _composers[2863] = WiredSetObjectVariableValueMessageComposer;
            _composers[2877] = MountPetMessageComposer;
            _composers[2889] = ConvertGlobalRoomIdMessageComposer;
            _composers[2897] = CanCreateRoomMessageComposer;
            _composers[2899] = MovePetMessageComposer;
            _composers[2901] = UpdateTriggerMessageComposer;
            _composers[2905] = class_1050;
            _composers[2959] = WiredGetRoomSettingsMessageComposer;
            _composers[296] = MuteUserMessageComposer;
            _composers[2972] = TogglePetBreedingPermissionMessageComposer;
            _composers[2982] = RequestRoomPropertySet;
            _composers[2998] = GuideAdvertisementReadMessageComposer;
            _composers[300] = LookToMessageComposer;
            _composers[3007] = GetGuildFurniContextMenuInfoMessageComposer;
            _composers[3013] = UnbanUserFromRoomMessageComposer;
            _composers[3032] = NewNavigatorInitComposer;
            _composers[3040] = OpenTradingComposer;
            _composers[3041] = Game2PlayAgainMessageComposer;
            _composers[3046] = ConfirmPetBreedingComposer;
            _composers[306] = ChangeUserNameInRoomMessageComposer;
            _composers[3066] = NewUserExperienceScriptProceedComposer;
            _composers[3074] = SetYoutubeDisplayPlaylistMessageComposer;
            _composers[3082] = ResetUnseenItemIdsComposer;
            _composers[311] = SignMessageComposer;
            _composers[3118] = GetGuildEditInfoMessageComposer;
            _composers[3130] = GetSoundSettingsComposer;
            _composers[315] = GetUserFlatCatsMessageComposer;
            _composers[3154] = GetBundleDiscountRulesetComposer;
            _composers[3162] = NavigatorDeleteSavedSearchComposer;
            _composers[3165] = OpenCampaignCalendarDoorComposer;
            _composers[3171] = CancelQuestMessageComposer;
            _composers[3172] = CloseIssueDefaultActionMessageComposer;
            _composers[3173] = ChangeQueueMessageComposer;
            _composers[3175] = ChangeUserNameMessageComposer;
            _composers[3177] = GuideSessionGuideDecidesMessageComposer;
            _composers[3181] = RequestFurniInventoryComposer;
            _composers[3186] = SetAreaHideDataComposer;
            _composers[3188] = GetCreditsInfoComposer;
            _composers[320] = GetNftCreditsMessageComposer;
            _composers[3207] = SetPhoneNumberVerificationStatusMessageComposer;
            _composers[3210] = GetClubGiftMessageComposer;
            _composers[3216] = MysteryBoxWaitingCanceledMessageComposer;
            _composers[3236] = RoomTextSearchMessageComposer;
            _composers[324] = PopularRoomsSearchMessageComposer;
            _composers[3240] = CallForHelpFromForumThreadMessageComposer;
            _composers[3241] = PurchaseVipMembershipExtensionComposer;
            _composers[3266] = WiredGetAllVariableHoldersMessageComposer;
            _composers[3271] = Game2LeaveGameMessageComposer;
            _composers[3274] = ModerateMessageMessageComposer;
            _composers[3280] = OpenCampaignCalendarDoorAsStaffComposer;
            _composers[3282] = GetCfhChatlogMessageComposer;
            _composers[3288] = WiredGetVariablesForObjectMessageComposer;
            _composers[3308] = DeclineFriendMessageComposer;
            _composers[3312] = Game2GetWeeklyGroupLeaderboardComposer;
            _composers[3335] = ModKickMessageComposer;
            _composers[3340] = KickMemberMessageComposer;
            _composers[3343] = ResetUnseenItemsComposer;
            _composers[3351] = GetIsUserPartOfCompetitionMessageComposer;
            _composers[3357] = UnblockGroupMemberMessageComposer;
            _composers[3363] = CallForHelpFromPhotoMessageComposer;
            _composers[3373] = SpinWheelOfFortuneMessageComposer;
            _composers[3392] = MyRoomHistorySearchMessageComposer;
            _composers[3401] = PurchaseBasicMembershipExtensionComposer;
            _composers[3404] = DeletePendingCallsForHelpMessageComposer;
            _composers[3452] = WiredGetRoomStatsMessageComposer;
            _composers[346] = class_165;
            _composers[3468] = RequestFurniInventoryWhenNotInRoomComposer;
            _composers[3472] = AddItemToTradeComposer;
            _composers[3473] = FindNewFriendsMessageComposer; // FindNewFriendsMessageComposer
            _composers[3477] = WiredSetRoomSettingsMessageComposer;
            _composers[3478] = ApproveMembershipRequestMessageComposer;
            _composers[3484] = RemoveJukeboxDiskComposer;
            _composers[3487] = GetCollectibleMintableItemTypesMessageComposer; // GetCollectibleMintableItemTypesMessageComposer
            _composers[3492] = GetUserNftChatStylesMessageComposer;
            _composers[3507] = GetMessagesMessageComposer;
            _composers[3510] = GuideSessionInviteRequesterMessageComposer;
            _composers[3519] = GetPromoArticlesMessageComposer;
            _composers[3523] = GetForumStatsMessageComposer;
            _composers[3526] = CreateFlatMessageComposer;
            _composers[3530] = MyGuildBasesSearchMessageComposer;
            _composers[3534] = PurchaseMintTokenMessageComposer;
            _composers[3540] = MyRoomsSearchMessageComposer;
            _composers[355] = GetMintTokenOffersMessageComposer;
            _composers[3560] = GetNftCollectionsMessageComposer;
            _composers[3566] = SelectFavouriteHabboGroupMessageComposer;
            _composers[3575] = TogglePetRidingPermissionMessageComposer;
            _composers[3578] = CompetitionRoomsSearchMessageComposer;
            _composers[3580] = BuildersClubPlaceWallItemMessageComposer;
            _composers[3596] = GetEmailStatusComposer;
            _composers[3600] = WiredGetErrorLogsMessageComposer;
            _composers[3623] = PurchaseTargetedOfferComposer;
            _composers[3625] = ChatReviewSessionCreateMessageComposer;
            _composers[3632] = ActivateQuestMessageComposer;
            _composers[3638] = LatencyPingRequestMessageComposer;
            _composers[3651] = ShopTargetedOfferViewedComposer;
            _composers[3654] = Game2GetTotalLeaderboardComposer;
            _composers[3657] = GuideSessionResolvedMessageComposer;
            _composers[366] = SendRoomInviteMessageComposer;
            _composers[3681] = GetBannedUsersFromRoomMessageComposer;
            _composers[3692] = CreateGuildMessageComposer;
            _composers[3695] = GetUserNftWardrobeMessageComposer;
            _composers[3698] = GetInterstitialMessageComposer;
            _composers[3706] = DefaultSanctionMessageComposer;
            _composers[372] = UpdateVariableMessageComposer;
            _composers[3727] = AddAdminRightsToMemberMessageComposer;
            _composers[3734] = Game2GetWeeklyFriendsLeaderboardComposer;
            _composers[3736] = GuideSessionRequesterCancelsMessageComposer;
            _composers[3746] = SetIgnoreRoomInvitesMessageComposer;
            _composers[3747] = GetModeratorRoomInfoMessageComposer;
            _composers[3750] = GuideSessionFeedbackMessageComposer;
            _composers[3755] = Game2ExitGameMessageComposer;
            _composers[3758] = RemoveBotFromFlatMessageComposer;
            _composers[3760] = DeleteRoomMessageComposer;
            _composers[3768] = MakeOfferMessageComposer;
            _composers[3783] = MyFrequentRoomHistorySearchMessageComposer;
            _composers[3785] = GetModeratorUserInfoMessageComposer;
            _composers[3789] = GetFriendsWeeklyCompetitiveLeaderboardComposer;
            _composers[3794] = AvatarExpressionMessageComposer;
            _composers[380] = ShoutMessageComposer;
            _composers[3806] = GetPetInfoMessageComposer;
            _composers[3809] = CancelMarketplaceOfferMessageComposer;
            _composers[381] = ChatReviewGuideDetachedMessageComposer;
            _composers[3814] = GetCollectibleMintTokensMessageComposer;
            _composers[3833] = GetPendingCallsForHelpMessageComposer;
            _composers[3835] = LatencyPingReportMessageComposer;
            _composers[3852] = ModerateRoomMessageComposer;
            _composers[386] = GetGuildCreationInfoMessageComposer;
            _composers[3878] = CancelTypingMessageComposer;
            _composers[3881] = UnignoreUserMessageComposer;
            _composers[3894] = GetWeeklyCompetitiveLeaderboardComposer;
            _composers[3899] = class_493;
            _composers[3900] = GetPopularRoomTagsMessageComposer;
            _composers[3914] = AmbassadorAlertMessageComposer;
            _composers[3915] = SelectClubGiftComposer;
            _composers[3919] = PickIssuesMessageComposer;
            _composers[3920] = GetCatalogIndexComposer;
            _composers[3933] = UpdateGuildColorsMessageComposer;
            _composers[3942] = class_951;
            _composers[3948] = GuideSessionReportMessageComposer;
            _composers[3949] = GetSnowWarGameTokensOfferComposer;
            _composers[3959] = UpdateGuildBadgeMessageComposer;
            _composers[3962] = LetUserInMessageComposer;
            _composers[3965] = CommunityGoalVoteMessageComposer;
            _composers[3967] = Game2GetAccountGameStatusMessageComposer;
            _composers[3975] = WiredSetPreferencesMessageComposer;
            _composers[4000] = ClientHelloMessageComposer;
            _composers[403] = NavigatorAddSavedSearchComposer;
            _composers[406] = GetFriendRequestsMessageComposer;
            _composers[411] = GetClubOffersMessageComposer;
            _composers[417] = RemoveFriendMessageComposer;
            _composers[421] = CloseIssuesMessageComposer;
            _composers[422] = class_807;
            _composers[43] = MoveWallItemMessageComposer;
            _composers[433] = BreedPetsMessageComposer;
            _composers[459] = GetCraftingRecipeComposer;
            _composers[463] = GetSecondsUntilMessageComposer;
            _composers[472] = MessengerInitMessageComposer;
            _composers[478] = BuildersClubPlaceRoomItemMessageComposer;
            _composers[483] = UpdateFigureDataMessageComposer;
            _composers[485] = class_606;
            _composers[494] = NavigatorAddCollapsedCategoryMessageComposer;
            _composers[505] = DiceOffMessageComposer;
            _composers[506] = GetForumsListMessageComposer;
            _composers[509] = InterstitialShownMessageComposer;
            _composers[51] = JoinHabboGroupMessageComposer;
            _composers[511] = class_303;
            _composers[520] = RequestABadgeComposer;
            _composers[521] = RentableSpaceRentMessageComposer;
            _composers[524] = ForwardToSomeRoomMessageComposer;
            _composers[526] = CraftSecretComposer;
            _composers[53] = SSOTicketMessageComposer;
            _composers[541] = GetBotInventoryComposer;
            _composers[573] = RejectQuestMessageComposer;
            _composers[583] = Game2MakeSnowballMessageComposer;
            _composers[584] = GetRoomSettingsMessageComposer;
            _composers[586] = InitDiffieHandshakeMessageComposer;
            _composers[599] = PassCarryItemMessageComposer;
            _composers[604] = ChatReviewGuideDecidesOnOfferMessageComposer;
            _composers[613] = SaveUserNftWardrobeMessageComposer;
            _composers[616] = DropCarryItemMessageComposer;
            _composers[625] = RoomNetworkOpenConnectionMessageComposer;
            _composers[626] = SetRandomStateMessageComposer;
            _composers[630] = GetHabboClubExtendOfferMessageComposer;
            _composers[644] = PurchaseFromCatalogAsGiftComposer;
            _composers[657] = NewNavigatorSearchComposer;
            _composers[661] = RoomDimmerChangeStateMessageComposer;
            _composers[663] = PeerUsersClassificationMessageComposer;
            _composers[672] = VerifyCodeMessageComposer;
            _composers[68] = GetSelectedBadgesMessageComposer;
            _composers[683] = AddSpamWallPostItMessageComposer;
            _composers[692] = EditEventMessageComposer;
            _composers[700] = Game2CheckGameDirectoryStatusMessageComposer;
            _composers[701] = GuideSessionMessageMessageComposer;
            _composers[710] = GetWeeklyGameRewardWinnersComposer;
            _composers[712] = GetCraftingRecipesAvailableComposer;
            _composers[726] = PostQuizAnswersComposer;
            _composers[737] = ApproveNameMessageComposer;
            _composers[740] = Game2ThrowSnowballAtHumanMessageComposer;
            _composers[747] = PerformanceLogMessageComposer;
            _composers[754] = StartCampaignMessageComposer;
            _composers[757] = ClickFurniMessageComposer;
            _composers[758] = CreditVaultStatusMessageComposer;
            _composers[76] = AcceptFriendMessageComposer;
            _composers[766] = SetChatStylePreferenceComposer;
            _composers[768] = GetLimitedOfferAppearingNextComposer;
            _composers[772] = GetWardrobeMessageComposer;
            _composers[79] = DeleteFavouriteRoomMessageComposer;
            _composers[790] = SetRoomSessionTagsMessageComposer;
            _composers[795] = PurchasePhotoMessageComposer;
            _composers[799] = GetMessengerHistoryComposer;
            _composers[805] = GetIsOfferGiftableComposer;
            _composers[813] = GetGuildMembershipsMessageComposer;
            _composers[818] = GetWeeklyGameRewardComposer;
            _composers[833] = PollAnswerComposer;
            _composers[842] = RoomDimmerGetPresetsMessageComposer;
            _composers[843] = UseWallItemMessageComposer;
            _composers[850] = GetCollectibleMintingEnabledMessageComposer; // GetCollectibleMintingEnabledMessageComposer
            _composers[852] = ModToolSanctionComposer;
            _composers[856] = CompostPlantMessageComposer;
            _composers[864] = ModeratorActionMessageComposer;
            _composers[872] = GetHotLooksMessageComposer;
            _composers[874] = SetRoomCameraPreferencesMessageComposer;
            _composers[885] = SetObjectDataMessageComposer;
            _composers[90] = AvatarEffectActivatedComposer;
            _composers[905] = GetTalentTrackMessageComposer;
            _composers[91] = GuideSessionIsTypingMessageComposer;
            _composers[915] = AddFavouriteRoomMessageComposer;
            _composers[917] = ChangePostureMessageComposer;
            _composers[920] = CustomizeAvatarWithFurniMessageComposer;
            _composers[935] = GuideSessionCreateMessageComposer;
            _composers[94] = WiredGetAllVariablesHashMessageComposer;
            _composers[954] = UpdateAddonMessageComposer;
            _composers[966] = SaveRoomSettingsMessageComposer;
            _composers[976] = SaveWardrobeOutfitMessageComposer;
            _composers[997] = GetCatalogPageWithEarliestExpiryComposer;
            _events[1] = TradingOpenEvent;
            _events[1002] = IsUserPartOfCompetitionMessageEvent;
            _events[1005] = TargetedOfferEvent;
            _events[1008] = RoomAdPurchaseInfoEvent;
            _events[1009] = HanditemConfigurationMessageEvent;
            _events[1011] = TradingAcceptEvent;
            _events[1013] = IncomeRewardClaimResponseMessageEvent;
            _events[1018] = BundleDiscountRulesetMessageEvent;
            _events[104] = UserChatlogEvent;
            _events[106] = YoutubeControlVideoMessageEvent;
            _events[1061] = CameraPublishStatusMessageEvent;
            _events[1069] = ShowEnforceRoomCategoryDialogEvent;
            _events[1076] = CallForHelpDisabledNotifyMessageEvent;
            _events[1084] = WiredVariablesForObjectEvent;
            _events[1093] = ItemRemoveMessageEvent;
            _events[1110] = GoToBreedingNestFailureEvent;
            _events[1118] = CompetitionVotingInfoMessageEvent;
            _events[1119] = AvatarEffectsMessageEvent;
            _events[1122] = FindFriendsProcessResultEvent;
            _events[1124] = HabboGroupJoinFailedMessageEvent;
            _events[1128] = PetBreedingResultEvent;
            _events[1134] = class_713;
            _events[1135] = GotMysteryBoxPrizeMessageEvent;
            _events[114] = InfoFeedEnableMessageEvent;
            _events[1142] = FriendListFragmentMessageEvent;
            _events[1145] = ChatReviewSessionStartedMessageEvent;
            _events[1154] = PurchaseNotAllowedMessageEvent;
            _events[1156] = RoomChatSettingsMessageEvent;
            _events[1164] = YoutubeDisplayPlaylistsMessageEvent;
            _events[118] = class_456;
            _events[1183] = RoomRatingEvent;
            _events[1196] = AchievementsScoreEvent;
            _events[1205] = UserNftChatStylesMessageEvent;
            _events[1207] = NewFriendRequestEvent;
            _events[1209] = CollectibleWalletAddressesMessageEvent;
            _events[1227] = HabboClubOffersMessageEvent;
            _events[1245] = class_151;
            _events[1252] = class_784;
            _events[1254] = AchievementResolutionProgressMessageEvent;
            _events[1256] = Game2StageStartingMessageEvent;
            _events[1266] = BotRemovedFromInventoryEvent;
            _events[1267] = CameraPurchaseOKMessageEvent;
            _events[1270] = FloorHeightMapMessageEvent;
            _events[1271] = TraxSongInfoMessageEvent;
            _events[1278] = Game2StageLoadMessageEvent;
            _events[1287] = HabboAchievementNotificationMessageEvent;
            _events[1296] = RoomSettingsDataEvent;
            _events[1297] = CatalogPageWithEarliestExpiryMessageEvent;
            _events[1299] = CarryObjectMessageEvent;
            _events[1306] = class_652;
            _events[131] = OneWayDoorStatusMessageEvent;
            _events[1310] = class_348;
            _events[1318] = PetCommandsMessageEvent;
            _events[1330] = PerkAllowancesMessageEvent;
            _events[134] = AchievementResolutionCompletedMessageEvent;
            _events[1343] = CraftingResultMessageEvent;
            _events[1346] = PetAddedToInventoryEvent;
            _events[1349] = GuideOnDutyStatusMessageEvent;
            _events[137] = AreaHideMessageEvent;
            _events[1373] = WiredSaveSuccessEvent;
            _events[1376] = TradingCompletedEvent;
            _events[1395] = TradeSilverFeeMessageEvent;
            _events[1396] = class_954;
            _events[1397] = LimitedOfferAppearingNextMessageEvent;
            _events[1411] = CatalogPublishedMessageEvent;
            _events[1412] = ProductOfferEvent;
            _events[1416] = UserRightsMessageEvent;
            _events[1417] = IdentityAccountsEvent;
            _events[1419] = ClubGiftInfoEvent;
            _events[1423] = NoSuchFlatEvent;
            _events[1429] = RespectNotificationMessageEvent;
            _events[1432] = TalentTrackMessageEvent;
            _events[1438] = ChatReviewSessionResultsMessageEvent;
            _events[1440] = SpecialRoomEffectMessageEvent;
            _events[1444] = HabboClubExtendOfferMessageEvent;
            _events[145] = SecondsUntilMessageEvent;
            _events[1454] = IssuePickFailedMessageEvent;
            _events[146] = WiredFurniVariableEvent;
            _events[1485] = GuideSessionStartedMessageEvent;
            _events[1487] = PollErrorEvent;
            _events[1489] = FlatCreatedEvent;
            _events[1492] = class_673;
            _events[1519] = AchievementEvent;
            _events[1527] = BotErrorEvent;
            _events[1546] = DoorbellMessageEvent;
            _events[1552] = IssueDeletedMessageEvent;
            _events[1564] = TradingConfirmationEvent;
            _events[1569] = HabboGroupDetailsMessageEvent;
            _events[1572] = ObjectsMessageEvent;
            _events[1575] = GuildEditorDataMessageEvent;
            _events[1578] = MarketPlaceOffersEvent;
            _events[1580] = RoomEntryTileMessageEvent;
            _events[1593] = GuildMembershipUpdatedMessageEvent;
            _events[1604] = CreditBalanceEvent;
            _events[1623] = MessengerInitEvent;
            _events[1632] = ChatMessageEvent;
            _events[1646] = ChatReviewSessionVotingStatusMessageEvent;
            _events[1654] = UnseenItemsEvent;
            _events[1661] = SlideObjectBundleMessageEvent;
            _events[1673] = QuestCancelledMessageEvent;
            _events[1674] = OpenEvent;
            _events[1682] = ApproveNameMessageEvent;
            _events[1683] = JukeboxPlayListFullMessageEvent;
            _events[1699] = GuideSessionRequesterRoomMessageEvent;
            _events[1714] = Game2StopCounterMessageEvent;
            _events[1722] = CanCreateRoomEventEvent;
            _events[173] = HabboActivityPointNotificationMessageEvent;
            _events[1730] = BadgePointLimitsEvent;
            _events[1751] = AvatarEffectExpiredMessageEvent;
            _events[1753] = Game2GameLongDataMessageEvent;
            _events[1758] = WiredRewardResultMessageEvent;
            _events[1764] = VoucherRedeemOkMessageEvent;
            _events[1767] = AvatarEffectMessageEvent;
            _events[1772] = GuideTicketCreationResultMessageEvent;
            _events[1773] = RoomInfoUpdatedEvent;
            _events[1774] = QuestionFinishedEvent;
            _events[1780] = UserTypingMessageEvent;
            _events[1795] = Game2GameRejoinMessageEvent;
            _events[1796] = WiredMenuErrorEvent;
            _events[1797] = GuideSessionDetachedMessageEvent;
            _events[180] = EmeraldBalanceMessageEvent;
            _events[1819] = ConsoleMessageHistoryEvent;
            _events[1820] = GuildEditFailedMessageEvent;
            _events[1823] = MOTDNotificationEvent;
            _events[183] = RoomFilterSettingsMessageEvent;
            _events[1875] = PromoArticlesMessageEvent;
            _events[1879] = CallForHelpPendingCallsDeletedMessageEvent;
            _events[1906] = FlatAccessDeniedMessageEvent;
            _events[1916] = NoobnessLevelMessageEvent;
            _events[1923] = WiredAllVariableHoldersEvent;
            _events[1928] = FriendNotificationEvent;
            _events[1940] = GuildMemberFurniCountInHQMessageEvent;
            _events[1961] = GuideTicketResolutionMessageEvent;
            _events[1993] = BadgesEvent;
            _events[200] = NewUserExperienceNotCompleteEvent;
            _events[2014] = WiredRoomSettingsEvent;
            _events[2016] = NftCollectionsScoreMessageEvent;
            _events[2021] = GuildCreatedMessageEvent;
            _events[2029] = GuildMembersMessageEvent;
            _events[2034] = PetRespectNotificationEvent;
            _events[2039] = IsBadgeRequestFulfilledEvent;
            _events[2044] = GuideSessionAttachedMessageEvent;
            _events[2048] = GetGuestRoomResultEvent;
            _events[2049] = TradeOpenFailedEvent;
            _events[2055] = UserNftWardrobeSelectionMessageEvent;
            _events[2067] = Game2UserBlockedMessageEvent;
            _events[207] = ElementPointerMessageEvent;
            _events[2095] = TalentTrackLevelMessageEvent;
            _events[2101] = ItemUpdateMessageEvent;
            _events[2111] = YouAreNotSpectatorMessageEvent;
            _events[2117] = PollContentsEvent;
            _events[2130] = GuideSessionInvitedToGuideRoomMessageEvent;
            _events[2141] = CallForHelpReplyMessageEvent;
            _events[2146] = CollectibleMintableItemResultMessageEvent;
            _events[215] = OfficialRoomsEvent;
            _events[2152] = class_195;
            _events[2154] = GuideSessionMessageMessageEvent;
            _events[2161] = BotInventoryEvent;
            _events[2190] = RoomForwardMessageEvent;
            _events[2193] = UserRemoveMessageEvent;
            _events[2194] = AvatarEffectAddedMessageEvent;
            _events[2196] = GuildMembershipsMessageEvent;
            _events[2200] = NotEnoughBalanceMessageEvent;
            _events[2210] = InfoHotelClosingMessageEvent;
            _events[2217] = GuildMembershipRejectedMessageEvent;
            _events[2239] = ConcurrentUsersGoalProgressMessageEvent;
            _events[2240] = RentableSpaceRentOkMessageEvent;
            _events[2258] = GroupMembershipRequestedMessageEvent;
            _events[226] = ModeratorUserInfoEvent;
            _events[2260] = HabboGroupDeactivatedMessageEvent;
            _events[228] = Game2GameNotFoundMessageEvent;
            _events[2288] = CraftingRecipeMessageEvent;
            _events[2308] = CatalogPageMessageEvent;
            _events[2318] = ModeratorRoomInfoEvent;
            _events[2319] = CfhChatlogEvent;
            _events[2323] = AuthenticationOKMessageEvent;
            _events[2327] = PetInventoryEvent;
            _events[234] = FavoriteMembershipUpdateMessageEvent;
            _events[2342] = CustomUserNotificationMessageEvent;
            _events[2346] = ConfirmBreedingRequestEvent;
            _events[237] = AchievementResolutionsMessageEvent;
            _events[2376] = GamePlayerValueMessageEvent;
            _events[2383] = class_545;
            _events[2386] = FurniListInvalidateEvent;
            _events[2389] = Game2UserJoinedGameMessageEvent;
            _events[2405] = PostItPlacedEvent;
            _events[2417] = MarketplaceCancelOfferResultEvent;
            _events[2422] = ChatReviewSessionOfferedToGuideMessageEvent;
            _events[2425] = MarketPlaceOwnOffersEvent;
            _events[2429] = CraftingRecipesAvailableMessageEvent;
            _events[2437] = InClientLinkMessageEvent;
            _events[2439] = OfficialSongIdMessageEvent;
            _events[2449] = class_149;
            _events[2455] = PetSupplementedNotificationEvent;
            _events[2457] = BannedUsersFromRoomEvent;
            _events[2464] = RentableSpaceStatusMessageEvent;
            _events[2472] = PetExperienceEvent;
            _events[2474] = Game2TotalGroupLeaderboardEvent;
            _events[2495] = YouArePlayingGameMessageEvent;
            _events[2498] = TradingNotOpenEvent;
            _events[25] = Game2GameStatusMessageEvent;
            _events[2508] = FollowFriendFailedEvent;
            _events[2514] = RoomInviteEvent;
            _events[2518] = BonusRareInfoMessageEvent;
            _events[2551] = UpdateMessageMessageEvent;
            _events[2557] = CraftableProductsMessageEvent;
            _events[2559] = Game2ArenaEnteredMessageEvent;
            _events[2590] = Game2GameStartedMessageEvent;
            _events[261] = MarketplaceItemStatsEvent;
            _events[2619] = PetInfoMessageEvent;
            _events[2621] = BotCommandConfigurationEvent;
            _events[2627] = MarketplaceMakeOfferResult;
            _events[263] = InitCameraMessageEvent;
            _events[2641] = AccountPreferencesEvent;
            _events[2657] = PetPlacingErrorEvent;
            _events[2661] = Game2GameChatFromPlayerMessageEvent;
            _events[2662] = PurchaseOKMessageEvent;
            _events[2670] = CitizenshipVipOfferPromoEnabledEvent;
            _events[2674] = MarketplaceBuyOfferResultEvent;
            _events[2675] = UseObjectMessageEvent;
            _events[2676] = FavouritesEvent;
            _events[2677] = Game2GameEndingMessageEvent;
            _events[2680] = UserChangeMessageEvent;
            _events[2689] = DiceValueMessageEvent;
            _events[2691] = ChatReviewSessionDetachedMessageEvent;
            _events[2709] = ModeratorMessageEvent;
            _events[2741] = ModeratorActionResultMessageEvent;
            _events[2771] = PetReceivedMessageEvent;
            _events[279] = class_756; // MiniMailNewMessageEvent
            _events[2791] = RoomEntryInfoMessageEvent;
            _events[2798] = HabboGroupBadgesMessageEvent;
            _events[2799] = YouAreSpectatorMessageEvent;
            _events[2802] = RoomOccupiedTilesMessageEvent;
            _events[2805] = PlayListSongAddedMessageEvent;
            _events[2807] = TradingItemListEvent;
            _events[2813] = Game2InArenaQueueMessageEvent;
            _events[2814] = GuideSessionEndedMessageEvent;
            _events[2834] = WhisperMessageEvent;
            _events[2835] = Game2GameDirectoryStatusMessageEvent;
            _events[2843] = BotAddedToInventoryEvent;
            _events[2846] = UsersMessageEvent;
            _events[2850] = RoomAdErrorEvent;
            _events[2854] = Game2StageRunningMessageEvent;
            _events[2861] = CreditVaultStatusMessageEvent;
            _events[2869] = UserUnbannedFromRoomEvent;
            _events[2875] = ActivityPointsMessageEvent;
            _events[2879] = UserNameChangedMessageEvent;
            _events[2893] = CloseConnectionMessageEvent;
            _events[2920] = NftBonusItemClaimResultMessageEvent;
            _events[2923] = GiftReceiverNotFoundEvent;
            _events[2930] = CfhSanctionMessageEvent;
            _events[2935] = NewConsoleMessageEvent;
            _events[2936] = IgnoreResultMessageEvent;
            _events[2948] = HeightMapUpdateMessageEvent;
            _events[295] = WeeklyGameRewardEvent;
            _events[2957] = PetFigureUpdateEvent;
            _events[2962] = Game2StageEndingMessageEvent;
            _events[2965] = WeeklyCompetitiveFriendsLeaderboardEvent;
            _events[2969] = ScrSendKickbackInfoMessageEvent;
            _events[297] = class_144;
            _events[2976] = TargetedOfferNotFoundEvent;
            _events[298] = UserBannedMessageEvent;
            _events[30] = ModeratorInitMessageEvent;
            _events[3000] = WiredMovementsMessageEvent;
            _events[3002] = PetRespectFailedEvent;
            _events[3006] = PetBreedingEvent;
            _events[3007] = ObjectDataUpdateMessageEvent;
            _events[3011] = ItemDataUpdateMessageEvent;
            _events[3012] = BotForceOpenContextMenuEvent;
            _events[3024] = RoomReadyMessageEvent;
            _events[3031] = FlatControllersEvent;
            _events[3037] = RoomEventEvent;
            _events[3040] = CompetitionEntrySubmitResultMessageEvent;
            _events[3043] = WiredRoomStatsEvent;
            _events[3048] = UserObjectEvent;
            _events[3053] = CheckUserNameResultMessageEvent;
            _events[3054] = Game2FullGameStatusMessageEvent;
            _events[3059] = VoucherRedeemErrorMessageEvent;
            _events[3060] = GiftWrappingConfigurationEvent;
            _events[3063] = CustomStackingHeightUpdateMessageEvent;
            _events[3075] = ObjectUpdateMessageEvent;
            _events[3077] = IssueInfoMessageEvent;
            _events[3079] = CollectibleMintTokenOffersMessageEvent;
            _events[308] = TradingCloseEvent;
            _events[3088] = RoomQueueStatusMessageEvent;
            _events[3097] = class_579;
            _events[3104] = WiredFurniConditionEvent;
            _events[3108] = CampaignCalendarDataMessageEvent;
            _events[3113] = Game2PlayerExitedGameArenaMessageEvent;
            _events[3116] = YouAreControllerMessageEvent;
            _events[3117] = NftRewardItemClaimResultMessageEvent;
            _events[3122] = ObjectAddMessageEvent;
            _events[3125] = AcceptFriendResultEvent;
            _events[3126] = MaintenanceStatusMessageEvent;
            _events[3129] = IsFirstLoginOfDayEvent;
            _events[3134] = CameraStorageUrlMessageEvent;
            _events[3139] = ClubGiftNotificationEvent;
            _events[3140] = BuildersClubPlacementWarningMessageEvent;
            _events[3158] = AvatarEffectSelectedMessageEvent;
            _events[316] = ItemsStateUpdateMessageEvent;
            _events[3160] = RoomChatlogEvent;
            _events[3169] = YoutubeDisplayVideoMessageEvent;
            _events[3172] = class_590;
            _events[3187] = SeasonalQuestsMessageEvent;
            _events[3199] = ForumThreadsMessageEvent;
            _events[32] = ObjectRemoveMultipleMessageEvent;
            _events[320] = GuideReportingStatusMessageEvent;
            _events[3208] = FurniRentOrBuyoutOfferMessageEvent;
            _events[3210] = PopularRoomTagsResultEvent;
            _events[3214] = Game2WeeklyFriendsLeaderboardEvent;
            _events[3224] = WeeklyCompetitiveLeaderboardEvent;
            _events[3226] = SilverBalanceMessageEvent;
            _events[3229] = HotLooksMessageEvent;
            _events[3230] = RoomSettingsSaveErrorEvent;
            _events[3233] = ObjectRemoveMessageEvent;
            _events[3259] = FlatControllerRemovedEvent;
            _events[3260] = Game2GameCancelledMessageEvent;
            _events[3262] = CatalogIndexMessageEvent;
            _events[327] = OpenConnectionMessageEvent;
            _events[3270] = UnreadForumsCountMessageEvent;
            _events[3288] = class_258;
            _events[3299] = NftTransferFeeMessageEvent;
            _events[33] = IncomeRewardStatusMessageEvent;
            _events[3313] = FriendRequestsEvent;
            _events[3314] = ObjectRemoveConfirmMessageEvent;
            _events[3326] = IgnoredUsersMessageEvent;
            _events[334] = ModeratorToolPreferencesEvent;
            _events[3343] = CollectableMintableItemTypesMessageEvent;
            _events[3348] = FriendFurniOtherLockConfirmedMessageEvent;
            _events[3382] = CurrentTimingCodeMessageEvent;
            _events[3383] = AvatarEffectActivatedMessageEvent;
            _events[3392] = Game2WeeklyLeaderboardEvent;
            _events[34] = GuestRoomSearchResultEvent;
            _events[3405] = RemainingMutePeriodEvent;
            _events[3407] = RoomVisualizationSettingsEvent;
            _events[3408] = PlayListMessageEvent;
            _events[341] = GroupDetailsChangedMessageEvent;
            _events[3410] = ExtendedProfileChangedMessageEvent;
            _events[3414] = CollectibleMintTokenCountMessageEvent;
            _events[3415] = ItemStateUpdateMessageEvent;
            _events[3430] = InterstitialMessageEvent;
            _events[3437] = FlatControllerAddedEvent;
            _events[3442] = UserNftWardrobeMessageEvent;
            _events[3444] = WiredPermissionsEvent;
            _events[3447] = RoomSettingsSavedEvent;
            _events[3449] = AvailabilityStatusMessageEvent;
            _events[3453] = Game2EnterArenaFailedMessageEvent;
            _events[3464] = Game2WeeklyGroupLeaderboardEvent;
            _events[3471] = HabboSearchResultEvent;
            _events[3478] = QuestsMessageEvent;
            _events[3481] = Game2EnterArenaMessageEvent;
            _events[3490] = UserGameAchievementsMessageEvent;
            _events[3492] = HeightMapMessageEvent;
            _events[3498] = InstantMessageErrorEvent;
            _events[3502] = class_401;
            _events[3504] = LoginFailedHotelClosedMessageEvent;
            _events[3505] = OpenPetPackageResultMessageEvent;
            _events[3506] = PetRemovedFromInventoryEvent;
            _events[351] = MysteryBoxKeysMessageEvent;
            _events[3514] = ItemsMessageEvent;
            _events[3517] = RentableSpaceRentFailedMessageEvent;
            _events[3518] = PostThreadMessageEvent;
            _events[352] = CommunityGoalProgressMessageEvent;
            _events[3523] = FavouriteChangedEvent;
            _events[3525] = RestoreClientMessageEvent;
            _events[3536] = CallForHelpResultMessageEvent;
            _events[3538] = RelationshipStatusInfoEvent;
            _events[3550] = FurniListEvent;
            _events[3551] = NftCollectionsMessageEvent;
            _events[3554] = ShoutMessageEvent;
            _events[3555] = NftTransferAssetsResultMessageEvent;
            _events[3573] = Game2FriendsLeaderboardEvent;
            _events[3579] = UpdateThreadMessageEvent;
            _events[358] = CommunityGoalHallOfFameMessageEvent;
            _events[3580] = class_819;
            _events[3581] = QuizResultsMessageEvent;
            _events[3583] = NewUserExperienceGiftOfferEvent;
            _events[3585] = FloodControlMessageEvent;
            _events[3595] = FurniListAddOrUpdateEvent;
            _events[3598] = RoomDimmerPresetsMessageEvent;
            _events[3603] = IssueCloseNotificationMessageEvent;
            _events[3610] = WardrobeMessageEvent;
            _events[3613] = RoomSettingsErrorEvent;
            _events[3619] = RoomVisitsEvent;
            _events[3627] = CanCreateRoomEvent;
            _events[3628] = QuizDataMessageEvent;
            _events[3633] = RoomPropertyMessageEvent;
            _events[3635] = WiredAllVariablesDiffsEvent;
            _events[365] = CompetitionStatusMessageEvent;
            _events[3658] = class_364;
            _events[3661] = Game2AccountGameStatusMessageEvent;
            _events[3669] = PostMessageMessageEvent;
            _events[367] = WiredFurniAddonEvent;
            _events[3675] = LimitedEditionSoldOutEvent;
            _events[3679] = ThumbnailStatusMessageEvent;
            _events[369] = WiredAllVariablesHashEvent;
            _events[3691] = FurniListRemoveEvent;
            _events[3693] = SelectInitialRoomEvent;
            _events[3696] = SanctionStatusEvent;
            _events[3718] = class_760;
            _events[3720] = SnowWarGameTokensMessageEvent;
            _events[3722] = class_931;
            _events[3731] = GuildCreationInfoMessageEvent;
            _events[3732] = ChangeUserNameResultMessageEvent;
            _events[3748] = BotSkillListUpdateEvent;
            _events[3758] = NestBreedingSuccessEvent;
            _events[3764] = TalentLevelUpMessageEvent;
            _events[3766] = WiredValidationErrorEvent;
            _events[3769] = Game2TotalLeaderboardEvent;
            _events[3774] = Game2PlayerRematchesMessageEvent;
            _events[3775] = QuestDailyMessageEvent;
            _events[3777] = CompleteDiffieHandshakeEvent;
            _events[3778] = CfhTopicsInitMessageEvent;
            _events[3806] = PhoneCollectionStateMessageEvent;
            _events[381] = MarketplaceConfigurationEvent;
            _events[3812] = UserClassificationMessageEvent;
            _events[3819] = CancelMysteryBoxWaitMessageEvent;
            _events[382] = FurnitureAliasesMessageEvent;
            _events[3825] = QuestionAnsweredEvent;
            _events[3844] = OpenPetPackageRequestedMessageEvent;
            _events[3855] = ExpressionMessageEvent;
            _events[3856] = class_307; // MiniMailUnreadCountEvent
            _events[3859] = NowPlayingMessageEvent;
            _events[3874] = HabboBroadcastMessageEvent;
            _events[3884] = WeeklyGameRewardWinnersEvent;
            _events[3892] = InfoHotelClosedMessageEvent;
            _events[3907] = BuildersClubSubscriptionStatusMessageEvent;
            _events[3911] = UserUpdateMessageEvent;
            _events[3915] = YouAreOwnerMessageEvent;
            _events[3920] = PresentOpenedMessageEvent;
            _events[3929] = TryVerificationCodeResultMessageEvent;
            _events[3959] = EpicPopupMessageEvent;
            _events[3960] = TradingYouAreNotAllowedEvent;
            _events[3961] = PollOfferEvent;
            _events[3966] = FriendListUpdateEvent;
            _events[3968] = QuestMessageEvent;
            _events[3974] = UniqueMachineIDEvent;
            _events[3975] = HabboUserBadgesMessageEvent;
            _events[3983] = ModeratorCautionEvent;
            _events[3988] = SellablePetPalettesMessageEvent;
            _events[3994] = RoomInviteErrorEvent;
            _events[4000] = DisconnectReasonEvent;
            _events[403] = TradingOtherNotAllowedEvent;
            _events[404] = AchievementsEvent;
            _events[431] = FlatAccessibleMessageEvent;
            _events[440] = NotificationDialogMessageEvent;
            _events[442] = BadgeReceivedEvent;
            _events[45] = FriendFurniCancelLockMessageEvent;
            _events[464] = FigureSetIdsEvent;
            _events[472] = SeasonalCalendarDailyOfferMessageEvent;
            _events[473] = ObjectsDataUpdateMessageEvent;
            _events[481] = PurchaseErrorMessageEvent;
            _events[497] = QuestionEvent;
            _events[502] = CampaignCalendarDoorOpenedMessageEvent;
            _events[517] = UserSongDisksInventoryMessageEvent;
            _events[523] = UserFlatCatsEvent;
            _events[529] = GuideSessionPartnerIsTypingMessageEvent;
            _events[541] = PetStatusUpdateEvent;
            _events[553] = class_135;
            _events[558] = DanceMessageEvent;
            _events[573] = CollectibleMintingEnabledMessageEvent;
            _events[574] = ConvertedRoomIdEvent;
            _events[585] = FriendFurniStartConfirmationMessageEvent;
            _events[586] = ChangeEmailResultEvent;
            _events[588] = WiredFurniSelectorEvent;
            _events[598] = GenericErrorEvent;
            _events[619] = ForumDataMessageEvent;
            _events[623] = class_636;
            _events[63] = MuteAllInRoomEvent;
            _events[631] = GuildFurniContextMenuInfoMessageEvent;
            _events[633] = PetLevelUpdateEvent;
            _events[647] = ThreadMessagesMessageEvent;
            _events[652] = WiredErrorLogsEvent;
            _events[654] = AccountSafetyLockStatusChangeMessageEvent;
            _events[657] = ErrorReportEvent;
            _events[658] = PingMessageEvent;
            _events[668] = Game2JoiningGameFailedMessageEvent;
            _events[674] = Game2GameCreatedMessageEvent;
            _events[675] = PetLevelNotificationEvent;
            _events[677] = QuestCompletedMessageEvent;
            _events[679] = ClubGiftSelectedEvent;
            _events[684] = ItemAddMessageEvent;
            _events[687] = MessengerErrorEvent;
            _events[692] = ShowMysteryBoxWaitMessageEvent;
            _events[695] = MarketplaceCanMakeOfferResult;
            _events[712] = EmailStatusResultEvent;
            _events[713] = GuideSessionErrorMessageEvent;
            _events[731] = RoomMessageNotificationMessageEvent;
            _events[739] = CompetitionRoomsDataMessageEvent;
            _events[770] = NoOwnedRoomsAlertMessageEvent;
            _events[771] = InitDiffieHandshakeEvent;
            _events[791] = Game2StageStillLoadingMessageEvent;
            _events[795] = Game2UserLeftGameMessageEvent;
            _events[804] = UserEventCatsEvent;
            _events[805] = RoomEventCancelEvent;
            _events[807] = SleepMessageEvent;
            _events[816] = ForumsListMessageEvent;
            _events[817] = YouAreNotControllerMessageEvent;
            _events[836] = FigureUpdateEvent;
            _events[840] = OfferRewardDeliveredMessageEvent;
            _events[845] = TryPhoneNumberResultMessageEvent;
            _events[847] = JukeboxSongDisksMessageEvent;
            _events[85] = class_895;
            _events[853] = GuildMemberMgmtFailedMessageEvent;
            _events[858] = CantConnectMessageEvent;
            _events[865] = Game2StartingGameFailedMessageEvent;
            _events[867] = CommunityVoteReceivedEvent;
            _events[873] = Game2StartCounterMessageEvent;
            _events[878] = CallForHelpPendingCallsMessageEvent;
            _events[889] = HandItemReceivedMessageEvent;
            _events[893] = WiredFurniTriggerEvent;
            _events[895] = NavigatorSettingsEvent;
            _events[919] = ExtendedProfileMessageEvent;
            _events[929] = ConfirmBreedingResultEvent;
            _events[931] = LatencyPingResponseMessageEvent;
            _events[937] = ScrSendUserInfoEvent;
            _events[939] = TradeSilverSetMessageEvent;
            _events[965] = CategoriesWithVisitorCountEvent;
            _events[968] = GuildEditInfoMessageEvent;
            _events[972] = class_380;
            _events[975] = RequestSpamWallPostItMessageEvent;
            _events[996] = WiredFurniActionEvent;
        }

        public function HabboMessages()
        {
            super();
        }

        public function get events():Map
        {
            return _events;
        }

        public function get composers():Map
        {
            return _composers;
        }
    }
}
