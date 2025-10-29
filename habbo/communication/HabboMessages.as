package com.sulake.habbo.communication {
    import com.sulake.core.communication.messages.IMessageConfiguration
    import com.sulake.core.utils.Map
    import com.sulake.core.utils.class_885
    import com.sulake.habbo.communication.messages.incoming.availability.LoginFailedHotelClosedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.availability.MaintenanceStatusMessageEvent
    import com.sulake.habbo.communication.messages.incoming.availability.AvailabilityStatusMessageEvent
    import com.sulake.habbo.communication.messages.incoming.availability.class_636
    import com.sulake.habbo.communication.messages.incoming.availability.InfoHotelClosingMessageEvent
    import com.sulake.habbo.communication.messages.incoming.availability.InfoHotelClosedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.avatar.FigureUpdateEvent
    import com.sulake.habbo.communication.messages.incoming.avatar.WardrobeMessageEvent
    import com.sulake.habbo.communication.messages.incoming.avatar.ChangeUserNameResultMessageEvent
    import com.sulake.habbo.communication.messages.incoming.avatar.CheckUserNameResultMessageEvent
    import com.sulake.habbo.communication.messages.incoming.callforhelp.CfhTopicsInitMessageEvent
    import com.sulake.habbo.communication.messages.incoming.callforhelp.SanctionStatusEvent
    import com.sulake.habbo.communication.messages.incoming.callforhelp.CfhSanctionMessageEvent
    import com.sulake.habbo.communication.messages.incoming.camera.CameraPurchaseOKMessageEvent
    import com.sulake.habbo.communication.messages.incoming.camera.CameraStorageUrlMessageEvent
    import com.sulake.habbo.communication.messages.incoming.camera.CameraPublishStatusMessageEvent
    import com.sulake.habbo.communication.messages.incoming.camera.CompetitionStatusMessageEvent
    import com.sulake.habbo.communication.messages.incoming.camera.InitCameraMessageEvent
    import com.sulake.habbo.communication.messages.incoming.camera.ThumbnailStatusMessageEvent
    import com.sulake.habbo.communication.messages.incoming.campaign.CampaignCalendarDataMessageEvent
    import com.sulake.habbo.communication.messages.incoming.campaign.CampaignCalendarDoorOpenedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.SnowWarGameTokensMessageEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.TargetedOfferEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.BonusRareInfoMessageEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.class_149
    import com.sulake.habbo.communication.messages.incoming.catalog.BuildersClubSubscriptionStatusMessageEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.class_195
    import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseErrorMessageEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.VoucherRedeemOkMessageEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.SellablePetPalettesMessageEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogIndexMessageEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.LimitedEditionSoldOutEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.GiftWrappingConfigurationEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.class_545
    import com.sulake.habbo.communication.messages.incoming.catalog.RoomAdPurchaseInfoEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.HabboClubOffersMessageEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.class_652
    import com.sulake.habbo.communication.messages.incoming.catalog.NotEnoughBalanceMessageEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.VoucherRedeemErrorMessageEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.SeasonalCalendarDailyOfferMessageEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageWithEarliestExpiryMessageEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.LimitedOfferAppearingNextMessageEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.GiftReceiverNotFoundEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.TargetedOfferNotFoundEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.HabboClubExtendOfferMessageEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPublishedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.BundleDiscountRulesetMessageEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.ProductOfferEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseNotAllowedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.ClubGiftInfoEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.ClubGiftSelectedEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseOKMessageEvent
    import com.sulake.habbo.communication.messages.incoming.collectibles.NftCollectionsScoreMessageEvent
    import com.sulake.habbo.communication.messages.incoming.collectibles.CollectibleMintTokenOffersMessageEvent
    import com.sulake.habbo.communication.messages.incoming.collectibles.CollectibleMintableItemResultMessageEvent
    import com.sulake.habbo.communication.messages.incoming.collectibles.EmeraldBalanceMessageEvent
    import com.sulake.habbo.communication.messages.incoming.collectibles.CollectibleMintingEnabledMessageEvent
    import com.sulake.habbo.communication.messages.incoming.collectibles.NftTransferFeeMessageEvent
    import com.sulake.habbo.communication.messages.incoming.collectibles.NftCollectionsMessageEvent
    import com.sulake.habbo.communication.messages.incoming.collectibles.CollectibleMintTokenCountMessageEvent
    import com.sulake.habbo.communication.messages.incoming.collectibles.NftRewardItemClaimResultMessageEvent
    import com.sulake.habbo.communication.messages.incoming.collectibles.NftBonusItemClaimResultMessageEvent
    import com.sulake.habbo.communication.messages.incoming.collectibles.CollectableMintableItemTypesMessageEvent
    import com.sulake.habbo.communication.messages.incoming.collectibles.NftTransferAssetsResultMessageEvent
    import com.sulake.habbo.communication.messages.incoming.collectibles.SilverBalanceMessageEvent
    import com.sulake.habbo.communication.messages.incoming.collectibles.CollectibleWalletAddressesMessageEvent
    import com.sulake.habbo.communication.messages.incoming.competition.NoOwnedRoomsAlertMessageEvent
    import com.sulake.habbo.communication.messages.incoming.competition.CompetitionVotingInfoMessageEvent
    import com.sulake.habbo.communication.messages.incoming.competition.SecondsUntilMessageEvent
    import com.sulake.habbo.communication.messages.incoming.competition.CurrentTimingCodeMessageEvent
    import com.sulake.habbo.communication.messages.incoming.competition.IsUserPartOfCompetitionMessageEvent
    import com.sulake.habbo.communication.messages.incoming.competition.CompetitionEntrySubmitResultMessageEvent
    import com.sulake.habbo.communication.messages.incoming.crafting.CraftableProductsMessageEvent
    import com.sulake.habbo.communication.messages.incoming.crafting.CraftingRecipesAvailableMessageEvent
    import com.sulake.habbo.communication.messages.incoming.crafting.CraftingRecipeMessageEvent
    import com.sulake.habbo.communication.messages.incoming.crafting.CraftingResultMessageEvent
    import com.sulake.habbo.communication.messages.incoming.error.ErrorReportEvent
    import com.sulake.habbo.communication.messages.incoming.friendfurni.FriendFurniOtherLockConfirmedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.friendfurni.FriendFurniStartConfirmationMessageEvent
    import com.sulake.habbo.communication.messages.incoming.friendfurni.FriendFurniCancelLockMessageEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendNotificationEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.RoomInviteErrorEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.FollowFriendFailedEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.RoomInviteEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.AcceptFriendResultEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.NewFriendRequestEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.HabboSearchResultEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.class_307
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListFragmentMessageEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListUpdateEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.InstantMessageErrorEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.ConsoleMessageHistoryEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.MessengerErrorEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.NewConsoleMessageEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.FindFriendsProcessResultEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.class_756
    import com.sulake.habbo.communication.messages.incoming.friendlist.MessengerInitEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestsEvent
    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2AccountGameStatusMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2GameCancelledMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2GameDirectoryStatusMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2GameNotFoundMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2InArenaQueueMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2JoiningGameFailedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2StartCounterMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2StartingGameFailedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2StopCounterMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2UserBlockedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2UserLeftGameMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2GameStartedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2UserJoinedGameMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2GameLongDataMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.directory.Game2GameCreatedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.lobby.UserGameAchievementsMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.lobby.AchievementResolutionCompletedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.lobby.AchievementResolutionProgressMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.lobby.AchievementResolutionsMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.score.Game2FriendsLeaderboardEvent
    import com.sulake.habbo.communication.messages.incoming.game.score.Game2TotalGroupLeaderboardEvent
    import com.sulake.habbo.communication.messages.incoming.game.score.Game2TotalLeaderboardEvent
    import com.sulake.habbo.communication.messages.incoming.game.score.Game2WeeklyFriendsLeaderboardEvent
    import com.sulake.habbo.communication.messages.incoming.game.score.Game2WeeklyGroupLeaderboardEvent
    import com.sulake.habbo.communication.messages.incoming.game.score.Game2WeeklyLeaderboardEvent
    import com.sulake.habbo.communication.messages.incoming.game.score.WeeklyCompetitiveFriendsLeaderboardEvent
    import com.sulake.habbo.communication.messages.incoming.game.score.WeeklyCompetitiveLeaderboardEvent
    import com.sulake.habbo.communication.messages.incoming.game.score.WeeklyGameRewardEvent
    import com.sulake.habbo.communication.messages.incoming.game.score.WeeklyGameRewardWinnersEvent
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2StageRunningMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2GameEndingMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2ArenaEnteredMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2PlayerRematchesMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2EnterArenaFailedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2PlayerExitedGameArenaMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2StageEndingMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2EnterArenaMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2StageStillLoadingMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2StageStartingMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2GameRejoinMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2StageLoadMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.Game2GameChatFromPlayerMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.ingame.Game2FullGameStatusMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.ingame.Game2GameStatusMessageEvent
    import com.sulake.habbo.communication.messages.incoming.gifts.TryVerificationCodeResultMessageEvent
    import com.sulake.habbo.communication.messages.incoming.gifts.TryPhoneNumberResultMessageEvent
    import com.sulake.habbo.communication.messages.incoming.gifts.PhoneCollectionStateMessageEvent
    import com.sulake.habbo.communication.messages.incoming.groupforums.ThreadMessagesMessageEvent
    import com.sulake.habbo.communication.messages.incoming.groupforums.UpdateThreadMessageEvent
    import com.sulake.habbo.communication.messages.incoming.groupforums.UpdateMessageMessageEvent
    import com.sulake.habbo.communication.messages.incoming.groupforums.ForumsListMessageEvent
    import com.sulake.habbo.communication.messages.incoming.groupforums.ForumDataMessageEvent
    import com.sulake.habbo.communication.messages.incoming.groupforums.ForumThreadsMessageEvent
    import com.sulake.habbo.communication.messages.incoming.groupforums.UnreadForumsCountMessageEvent
    import com.sulake.habbo.communication.messages.incoming.groupforums.PostThreadMessageEvent
    import com.sulake.habbo.communication.messages.incoming.groupforums.PostMessageMessageEvent
    import com.sulake.habbo.communication.messages.incoming.handshake.NoobnessLevelMessageEvent
    import com.sulake.habbo.communication.messages.incoming.handshake.CompleteDiffieHandshakeEvent
    import com.sulake.habbo.communication.messages.incoming.handshake.IdentityAccountsEvent
    import com.sulake.habbo.communication.messages.incoming.handshake.InitDiffieHandshakeEvent
    import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent
    import com.sulake.habbo.communication.messages.incoming.handshake.UniqueMachineIDEvent
    import com.sulake.habbo.communication.messages.incoming.handshake.PingMessageEvent
    import com.sulake.habbo.communication.messages.incoming.handshake.DisconnectReasonEvent
    import com.sulake.habbo.communication.messages.incoming.handshake.IsFirstLoginOfDayEvent
    import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent
    import com.sulake.habbo.communication.messages.incoming.handshake.GenericErrorEvent
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent
    import com.sulake.habbo.communication.messages.incoming.help.CallForHelpPendingCallsMessageEvent
    import com.sulake.habbo.communication.messages.incoming.help.CallForHelpReplyMessageEvent
    import com.sulake.habbo.communication.messages.incoming.help.class_135
    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionErrorMessageEvent
    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionStartedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.help.CallForHelpDisabledNotifyMessageEvent
    import com.sulake.habbo.communication.messages.incoming.help.GuideTicketCreationResultMessageEvent
    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionMessageMessageEvent
    import com.sulake.habbo.communication.messages.incoming.help.GuideOnDutyStatusMessageEvent
    import com.sulake.habbo.communication.messages.incoming.help.ChatReviewSessionStartedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.help.ChatReviewSessionOfferedToGuideMessageEvent
    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionRequesterRoomMessageEvent
    import com.sulake.habbo.communication.messages.incoming.help.GuideReportingStatusMessageEvent
    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionPartnerIsTypingMessageEvent
    import com.sulake.habbo.communication.messages.incoming.help.class_579
    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionInvitedToGuideRoomMessageEvent
    import com.sulake.habbo.communication.messages.incoming.help.ChatReviewSessionVotingStatusMessageEvent
    import com.sulake.habbo.communication.messages.incoming.help.ChatReviewSessionResultsMessageEvent
    import com.sulake.habbo.communication.messages.incoming.help.GuideTicketResolutionMessageEvent
    import com.sulake.habbo.communication.messages.incoming.help.IssueCloseNotificationMessageEvent
    import com.sulake.habbo.communication.messages.incoming.help.class_673
    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionEndedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.help.class_784
    import com.sulake.habbo.communication.messages.incoming.help.CallForHelpResultMessageEvent
    import com.sulake.habbo.communication.messages.incoming.help.QuizDataMessageEvent
    import com.sulake.habbo.communication.messages.incoming.help.class_819
    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionDetachedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionAttachedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.help.class_895
    import com.sulake.habbo.communication.messages.incoming.help.CallForHelpPendingCallsDeletedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.help.ChatReviewSessionDetachedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.help.QuizResultsMessageEvent
    import com.sulake.habbo.communication.messages.incoming.hotlooks.HotLooksMessageEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementsScoreEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementsEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectsMessageEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectActivatedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectSelectedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectAddedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectExpiredMessageEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.badges.BadgeReceivedEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.badges.BadgesEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.badges.BadgePointLimitsEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.badges.IsBadgeRequestFulfilledEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.bots.BotRemovedFromInventoryEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.bots.class_258
    import com.sulake.habbo.communication.messages.incoming.inventory.bots.BotInventoryEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.bots.BotAddedToInventoryEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.clothing.FigureSetIdsEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.clothing.class_401
    import com.sulake.habbo.communication.messages.incoming.inventory.clothing.class_456
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.PostItPlacedEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListInvalidateEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListAddOrUpdateEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListRemoveEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.ConfirmBreedingResultEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.GoToBreedingNestFailureEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetAddedToInventoryEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetBreedingEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetReceivedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.NestBreedingSuccessEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetInventoryEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.ConfirmBreedingRequestEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetRemovedFromInventoryEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.purse.CreditBalanceEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingOpenEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.class_144
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingConfirmationEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingOtherNotAllowedEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingAcceptEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingYouAreNotAllowedEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradeSilverFeeMessageEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingNotOpenEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCloseEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCompletedEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradeSilverSetMessageEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradeOpenFailedEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingItemListEvent
    import com.sulake.habbo.communication.messages.incoming.landingview.PromoArticlesMessageEvent
    import com.sulake.habbo.communication.messages.incoming.landingview.votes.CommunityVoteReceivedEvent
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceBuyOfferResultEvent
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceConfigurationEvent
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceItemStatsEvent
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOwnOffersEvent
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOffersEvent
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceMakeOfferResult
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceCancelOfferResultEvent
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceCanMakeOfferResult
    import com.sulake.habbo.communication.messages.incoming.moderation.RoomVisitsEvent
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorInitMessageEvent
    import com.sulake.habbo.communication.messages.incoming.moderation.IssueInfoMessageEvent
    import com.sulake.habbo.communication.messages.incoming.moderation.UserBannedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.moderation.CfhChatlogEvent
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorMessageEvent
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorUserInfoEvent
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorActionResultMessageEvent
    import com.sulake.habbo.communication.messages.incoming.moderation.IssuePickFailedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.moderation.IssueDeletedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorRoomInfoEvent
    import com.sulake.habbo.communication.messages.incoming.moderation.UserChatlogEvent
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorCautionEvent
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorToolPreferencesEvent
    import com.sulake.habbo.communication.messages.incoming.moderation.RoomChatlogEvent
    import com.sulake.habbo.communication.messages.incoming.mysterybox.ShowMysteryBoxWaitMessageEvent
    import com.sulake.habbo.communication.messages.incoming.mysterybox.MysteryBoxKeysMessageEvent
    import com.sulake.habbo.communication.messages.incoming.mysterybox.CancelMysteryBoxWaitMessageEvent
    import com.sulake.habbo.communication.messages.incoming.mysterybox.GotMysteryBoxPrizeMessageEvent
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatAccessDeniedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.navigator.ConvertedRoomIdEvent
    import com.sulake.habbo.communication.messages.incoming.navigator.class_129
    import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomsEvent
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomSearchResultEvent
    import com.sulake.habbo.communication.messages.incoming.navigator.CategoriesWithVisitorCountEvent
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomInfoUpdatedEvent
    import com.sulake.habbo.communication.messages.incoming.navigator.class_491
    import com.sulake.habbo.communication.messages.incoming.navigator.UserEventCatsEvent
    import com.sulake.habbo.communication.messages.incoming.navigator.CompetitionRoomsDataMessageEvent
    import com.sulake.habbo.communication.messages.incoming.navigator.class_590
    import com.sulake.habbo.communication.messages.incoming.navigator.UserFlatCatsEvent
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventEvent
    import com.sulake.habbo.communication.messages.incoming.navigator.CanCreateRoomEventEvent
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomRatingEvent
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventCancelEvent
    import com.sulake.habbo.communication.messages.incoming.navigator.FavouriteChangedEvent
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCreatedEvent
    import com.sulake.habbo.communication.messages.incoming.navigator.DoorbellMessageEvent
    import com.sulake.habbo.communication.messages.incoming.navigator.GetGuestRoomResultEvent
    import com.sulake.habbo.communication.messages.incoming.navigator.PopularRoomTagsResultEvent
    import com.sulake.habbo.communication.messages.incoming.navigator.CanCreateRoomEvent
    import com.sulake.habbo.communication.messages.incoming.newnavigator.class_151
    import com.sulake.habbo.communication.messages.incoming.newnavigator.class_348
    import com.sulake.habbo.communication.messages.incoming.newnavigator.class_364
    import com.sulake.habbo.communication.messages.incoming.newnavigator.class_713
    import com.sulake.habbo.communication.messages.incoming.newnavigator.class_760
    import com.sulake.habbo.communication.messages.incoming.newnavigator.class_954
    import com.sulake.habbo.communication.messages.incoming.nft.UserNftWardrobeMessageEvent
    import com.sulake.habbo.communication.messages.incoming.nft.UserNftChatStylesMessageEvent
    import com.sulake.habbo.communication.messages.incoming.nft.UserNftWardrobeSelectionMessageEvent
    import com.sulake.habbo.communication.messages.incoming.notifications.ClubGiftNotificationEvent
    import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementNotificationMessageEvent
    import com.sulake.habbo.communication.messages.incoming.notifications.HabboBroadcastMessageEvent
    import com.sulake.habbo.communication.messages.incoming.notifications.ActivityPointsMessageEvent
    import com.sulake.habbo.communication.messages.incoming.notifications.MOTDNotificationEvent
    import com.sulake.habbo.communication.messages.incoming.notifications.HabboActivityPointNotificationMessageEvent
    import com.sulake.habbo.communication.messages.incoming.notifications.NotificationDialogMessageEvent
    import com.sulake.habbo.communication.messages.incoming.notifications.UnseenItemsEvent
    import com.sulake.habbo.communication.messages.incoming.notifications.OfferRewardDeliveredMessageEvent
    import com.sulake.habbo.communication.messages.incoming.notifications.ElementPointerMessageEvent
    import com.sulake.habbo.communication.messages.incoming.notifications.InfoFeedEnableMessageEvent
    import com.sulake.habbo.communication.messages.incoming.notifications.PetLevelNotificationEvent
    import com.sulake.habbo.communication.messages.incoming.notifications.RestoreClientMessageEvent
    import com.sulake.habbo.communication.messages.incoming.nux.NewUserExperienceNotCompleteEvent
    import com.sulake.habbo.communication.messages.incoming.nux.SelectInitialRoomEvent
    import com.sulake.habbo.communication.messages.incoming.nux.NewUserExperienceGiftOfferEvent
    import com.sulake.habbo.communication.messages.incoming.perk.CitizenshipVipOfferPromoEnabledEvent
    import com.sulake.habbo.communication.messages.incoming.perk.PerkAllowancesMessageEvent
    import com.sulake.habbo.communication.messages.incoming.poll.PollContentsEvent
    import com.sulake.habbo.communication.messages.incoming.poll.QuestionEvent
    import com.sulake.habbo.communication.messages.incoming.poll.PollErrorEvent
    import com.sulake.habbo.communication.messages.incoming.poll.QuestionFinishedEvent
    import com.sulake.habbo.communication.messages.incoming.poll.QuestionAnsweredEvent
    import com.sulake.habbo.communication.messages.incoming.poll.PollOfferEvent
    import com.sulake.habbo.communication.messages.incoming.preferences.AccountPreferencesEvent
    import com.sulake.habbo.communication.messages.incoming.quest.QuestCancelledMessageEvent
    import com.sulake.habbo.communication.messages.incoming.quest.QuestCompletedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.quest.SeasonalQuestsMessageEvent
    import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalProgressMessageEvent
    import com.sulake.habbo.communication.messages.incoming.quest.EpicPopupMessageEvent
    import com.sulake.habbo.communication.messages.incoming.quest.ConcurrentUsersGoalProgressMessageEvent
    import com.sulake.habbo.communication.messages.incoming.quest.QuestsMessageEvent
    import com.sulake.habbo.communication.messages.incoming.quest.class_931
    import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalHallOfFameMessageEvent
    import com.sulake.habbo.communication.messages.incoming.quest.QuestDailyMessageEvent
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.action.SleepMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.action.DanceMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.action.CarryObjectMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.action.ExpressionMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.action.AvatarEffectMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.action.UseObjectMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.bots.BotCommandConfigurationEvent
    import com.sulake.habbo.communication.messages.incoming.room.bots.BotForceOpenContextMenuEvent
    import com.sulake.habbo.communication.messages.incoming.room.bots.BotSkillListUpdateEvent
    import com.sulake.habbo.communication.messages.incoming.room.bots.BotErrorEvent
    import com.sulake.habbo.communication.messages.incoming.room.camera.class_380
    import com.sulake.habbo.communication.messages.incoming.room.chat.UserTypingMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.chat.RemainingMutePeriodEvent
    import com.sulake.habbo.communication.messages.incoming.room.chat.ChatMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.chat.WhisperMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.chat.ShoutMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.chat.RoomFilterSettingsMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.chat.RoomChatSettingsMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.chat.FloodControlMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserUpdateMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.WiredMovementsMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomPropertyMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemUpdateMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectRemoveMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.HeightMapMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectDataUpdateMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectAddMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.SpecialRoomEffectMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserChangeMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.BuildersClubPlacementWarningMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectRemoveConfirmMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.FurnitureAliasesMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.FavoriteMembershipUpdateMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectsDataUpdateMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserRemoveMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.UsersMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.HeightMapUpdateMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectsMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemRemoveMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemDataUpdateMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectUpdateMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectRemoveMultipleMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.FloorHeightMapMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.SlideObjectBundleMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemsStateUpdateMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemStateUpdateMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemAddMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemsMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomVisualizationSettingsEvent
    import com.sulake.habbo.communication.messages.incoming.room.furniture.YoutubeControlVideoMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.furniture.DiceValueMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.furniture.PresentOpenedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.furniture.CustomUserNotificationMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.furniture.FurniRentOrBuyoutOfferMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.furniture.AreaHideMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.furniture.YoutubeDisplayVideoMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.furniture.RentableSpaceRentOkMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.furniture.RentableSpaceRentFailedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.furniture.RoomMessageNotificationMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.furniture.OneWayDoorStatusMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.furniture.RequestSpamWallPostItMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.furniture.CustomStackingHeightUpdateMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.furniture.OpenPetPackageRequestedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.furniture.RentableSpaceStatusMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.furniture.OpenPetPackageResultMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.furniture.GuildFurniContextMenuInfoMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.furniture.RoomDimmerPresetsMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.furniture.YoutubeDisplayPlaylistsMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.layout.RoomOccupiedTilesMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.layout.RoomEntryTileMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.permissions.YouAreOwnerMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.permissions.YouAreNotControllerMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.permissions.YouAreControllerMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetCommandsMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetLevelUpdateEvent
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetRespectFailedEvent
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetExperienceEvent
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetFigureUpdateEvent
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetInfoMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetBreedingResultEvent
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetStatusUpdateEvent
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetPlacingErrorEvent
    import com.sulake.habbo.communication.messages.incoming.room.session.HanditemConfigurationMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.session.OpenConnectionMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.session.RoomForwardMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.session.FlatAccessibleMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.session.GamePlayerValueMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.session.YouAreNotSpectatorMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.session.YouAreSpectatorMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.session.CantConnectMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.session.YouArePlayingGameMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.session.RoomReadyMessageEvent
    import com.sulake.habbo.communication.messages.incoming.room.session.RoomQueueStatusMessageEvent
    import com.sulake.habbo.communication.messages.incoming.roomsettings.ShowEnforceRoomCategoryDialogEvent
    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerAddedEvent
    import com.sulake.habbo.communication.messages.incoming.roomsettings.UserUnbannedFromRoomEvent
    import com.sulake.habbo.communication.messages.incoming.roomsettings.NoSuchFlatEvent
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsErrorEvent
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsSavedEvent
    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllersEvent
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsDataEvent
    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerRemovedEvent
    import com.sulake.habbo.communication.messages.incoming.roomsettings.BannedUsersFromRoomEvent
    import com.sulake.habbo.communication.messages.incoming.roomsettings.MuteAllInRoomEvent
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsSaveErrorEvent
    import com.sulake.habbo.communication.messages.incoming.sound.TraxSongInfoMessageEvent
    import com.sulake.habbo.communication.messages.incoming.sound.JukeboxSongDisksMessageEvent
    import com.sulake.habbo.communication.messages.incoming.sound.UserSongDisksInventoryMessageEvent
    import com.sulake.habbo.communication.messages.incoming.sound.PlayListSongAddedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.sound.NowPlayingMessageEvent
    import com.sulake.habbo.communication.messages.incoming.sound.PlayListMessageEvent
    import com.sulake.habbo.communication.messages.incoming.sound.OfficialSongIdMessageEvent
    import com.sulake.habbo.communication.messages.incoming.sound.JukeboxPlayListFullMessageEvent
    import com.sulake.habbo.communication.messages.incoming.talent.TalentTrackLevelMessageEvent
    import com.sulake.habbo.communication.messages.incoming.talent.TalentLevelUpMessageEvent
    import com.sulake.habbo.communication.messages.incoming.talent.TalentTrackMessageEvent
    import com.sulake.habbo.communication.messages.incoming.tracking.LatencyPingResponseMessageEvent
    import com.sulake.habbo.communication.messages.incoming.userclassification.UserClassificationMessageEvent
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniConditionEvent
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredSaveSuccessEvent
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.OpenEvent
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniTriggerEvent
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredRewardResultMessageEvent
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniSelectorEvent
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniActionEvent
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniAddonEvent
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredValidationErrorEvent
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniVariableEvent
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredRoomStatsEvent
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredPermissionsEvent
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredRoomSettingsEvent
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredAllVariablesHashEvent
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredVariablesForObjectEvent
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredAllVariablesDiffsEvent
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredMenuErrorEvent
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredErrorLogsEvent
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredAllVariableHoldersEvent
    import com.sulake.habbo.communication.messages.incoming.users.GuildEditorDataMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.ScrSendUserInfoEvent
    import com.sulake.habbo.communication.messages.incoming.users.ExtendedProfileChangedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.PetRespectNotificationEvent
    import com.sulake.habbo.communication.messages.incoming.users.GroupDetailsChangedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipRejectedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.HandItemReceivedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.UserNameChangedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.AccountSafetyLockStatusChangeMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.GuildMembersMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupJoinFailedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.GuildEditInfoMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDeactivatedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.GuildCreationInfoMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipUpdatedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.ScrSendKickbackInfoMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.GuildMemberFurniCountInHQMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.RelationshipStatusInfoEvent
    import com.sulake.habbo.communication.messages.incoming.users.IgnoreResultMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.EmailStatusResultEvent
    import com.sulake.habbo.communication.messages.incoming.users.ApproveNameMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipsMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupBadgesMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.PetSupplementedNotificationEvent
    import com.sulake.habbo.communication.messages.incoming.users.GuildMemberMgmtFailedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.IgnoredUsersMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.ChangeEmailResultEvent
    import com.sulake.habbo.communication.messages.incoming.users.GuildCreatedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.RespectNotificationMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.GuildEditFailedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.HabboUserBadgesMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.GroupMembershipRequestedMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.InClientLinkMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.ExtendedProfileMessageEvent
    import com.sulake.habbo.communication.messages.incoming.vault.CreditVaultStatusMessageEvent
    import com.sulake.habbo.communication.messages.incoming.vault.IncomeRewardClaimResponseMessageEvent
    import com.sulake.habbo.communication.messages.incoming.vault.IncomeRewardStatusMessageEvent
    import com.sulake.habbo.communication.messages.outgoing.camera.class_1004
    import com.sulake.habbo.communication.messages.outgoing.camera.PublishPhotoMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.camera.class_728
    import com.sulake.habbo.communication.messages.outgoing.camera.RenderRoomThumbnailMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.camera.class_914
    import com.sulake.habbo.communication.messages.outgoing.camera.PhotoCompetitionMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.campaign.class_375
    import com.sulake.habbo.communication.messages.outgoing.campaign.class_631
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetRoomAdPurchaseInfoComposer
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetSnowWarGameTokensOfferComposer
    import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseSnowWarGameTokensOfferComposer
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_1099
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_156
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetCatalogPageWithEarliestExpiryComposer
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_270
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_272
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_282
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_367
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_421
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_428
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetSellablePetPalettesComposer
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_496
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_503
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_512
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_520
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_521
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_594
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_600
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetBonusRareInfoMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.catalog.SetTargetedOfferStateComposer
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_752
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_801
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_807
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_852
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_855
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_881
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetProductOfferComposer
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_887
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_902
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_909
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_930
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_933
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_939
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_951
    import com.sulake.habbo.communication.messages.outgoing.catalog.class_976
    import com.sulake.habbo.communication.messages.outgoing.crafting.CraftComposer
    import com.sulake.habbo.communication.messages.outgoing.crafting.GetCraftableProductsComposer
    import com.sulake.habbo.communication.messages.outgoing.crafting.class_890
    import com.sulake.habbo.communication.messages.outgoing.crafting.class_891
    import com.sulake.habbo.communication.messages.outgoing.crafting.class_972
    import com.sulake.habbo.communication.messages.outgoing.friendlist.SetRelationshipStatusMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.friendlist.SendRoomInviteMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.friendlist.DeclineFriendMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.friendlist.RemoveFriendMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.friendlist.FriendListUpdateMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.friendlist.SendMsgMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.friendlist.GetFriendRequestsMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.friendlist.FindNewFriendsMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.friendlist.FollowFriendMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.friendlist.GetMessengerHistoryComposer
    import com.sulake.habbo.communication.messages.outgoing.friendlist.MessengerInitMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.friendlist.HabboSearchMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.friendlist.VisitUserMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.friendlist.RequestFriendMessageEvent
    import com.sulake.habbo.communication.messages.outgoing.friendlist.AcceptFriendMessageEvent
    import com.sulake.habbo.communication.messages.outgoing.handshake.DisconnectMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.handshake.PongMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.handshake.class_385
    import com.sulake.habbo.communication.messages.outgoing.handshake.class_489
    import com.sulake.habbo.communication.messages.outgoing.handshake.ClientHelloMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.handshake.UniqueIDMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.handshake.class_622
    import com.sulake.habbo.communication.messages.outgoing.handshake.class_840
    import com.sulake.habbo.communication.messages.outgoing.handshake.class_941
    import com.sulake.habbo.communication.messages.outgoing.help.class_1015
    import com.sulake.habbo.communication.messages.outgoing.help.class_1035
    import com.sulake.habbo.communication.messages.outgoing.help.class_1046
    import com.sulake.habbo.communication.messages.outgoing.help.class_1050
    import com.sulake.habbo.communication.messages.outgoing.help.class_1054
    import com.sulake.habbo.communication.messages.outgoing.help.class_1091
    import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromSelfieMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.help.class_275
    import com.sulake.habbo.communication.messages.outgoing.help.class_279
    import com.sulake.habbo.communication.messages.outgoing.help.class_291
    import com.sulake.habbo.communication.messages.outgoing.help.class_294
    import com.sulake.habbo.communication.messages.outgoing.help.class_300
    import com.sulake.habbo.communication.messages.outgoing.help.class_303
    import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionReportMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.help.class_328
    import com.sulake.habbo.communication.messages.outgoing.help.class_354
    import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.help.class_371
    import com.sulake.habbo.communication.messages.outgoing.help.CallForHelpFromForumMessageMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.help.class_397
    import com.sulake.habbo.communication.messages.outgoing.help.class_424
    import com.sulake.habbo.communication.messages.outgoing.help.class_436
    import com.sulake.habbo.communication.messages.outgoing.help.class_475
    import com.sulake.habbo.communication.messages.outgoing.help.class_531
    import com.sulake.habbo.communication.messages.outgoing.help.class_561
    import com.sulake.habbo.communication.messages.outgoing.help.class_580
    import com.sulake.habbo.communication.messages.outgoing.help.GuideSessionCreateMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.help.class_658
    import com.sulake.habbo.communication.messages.outgoing.help.class_678
    import com.sulake.habbo.communication.messages.outgoing.help.class_773
    import com.sulake.habbo.communication.messages.outgoing.help.class_813
    import com.sulake.habbo.communication.messages.outgoing.help.class_874
    import com.sulake.habbo.communication.messages.outgoing.inventory.achievements.class_1095
    import com.sulake.habbo.communication.messages.outgoing.inventory.avatareffect.AvatarEffectSelectedComposer
    import com.sulake.habbo.communication.messages.outgoing.inventory.avatareffect.class_206
    import com.sulake.habbo.communication.messages.outgoing.inventory.badges.GetBadgePointLimitsComposer
    import com.sulake.habbo.communication.messages.outgoing.inventory.badges.GetBadgesComposer
    import com.sulake.habbo.communication.messages.outgoing.inventory.badges.class_1062
    import com.sulake.habbo.communication.messages.outgoing.inventory.badges.SetActivatedBadgesComposer
    import com.sulake.habbo.communication.messages.outgoing.inventory.badges.class_441
    import com.sulake.habbo.communication.messages.outgoing.inventory.furni.RequestFurniInventoryComposer
    import com.sulake.habbo.communication.messages.outgoing.inventory.furni.RequestFurniInventoryWhenNotInRoomComposer
    import com.sulake.habbo.communication.messages.outgoing.inventory.furni.class_984
    import com.sulake.habbo.communication.messages.outgoing.inventory.purse.class_1045
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.SilverFeeMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.class_376
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.class_409
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.class_511
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.class_519
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.class_669
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.class_720
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.class_791
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.class_822
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.class_845
    import com.sulake.habbo.communication.messages.outgoing.landingview.class_816
    import com.sulake.habbo.communication.messages.outgoing.moderator.class_1033
    import com.sulake.habbo.communication.messages.outgoing.moderator.class_1063
    import com.sulake.habbo.communication.messages.outgoing.moderator.class_1089
    import com.sulake.habbo.communication.messages.outgoing.moderator.class_229
    import com.sulake.habbo.communication.messages.outgoing.moderator.ModBanMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.moderator.ModMuteMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.moderator.class_344
    import com.sulake.habbo.communication.messages.outgoing.moderator.class_360
    import com.sulake.habbo.communication.messages.outgoing.moderator.class_363
    import com.sulake.habbo.communication.messages.outgoing.moderator.class_389
    import com.sulake.habbo.communication.messages.outgoing.moderator.class_502
    import com.sulake.habbo.communication.messages.outgoing.moderator.class_570
    import com.sulake.habbo.communication.messages.outgoing.moderator.class_672
    import com.sulake.habbo.communication.messages.outgoing.moderator.class_734
    import com.sulake.habbo.communication.messages.outgoing.moderator.class_780
    import com.sulake.habbo.communication.messages.outgoing.moderator.class_781
    import com.sulake.habbo.communication.messages.outgoing.moderator.class_824
    import com.sulake.habbo.communication.messages.outgoing.moderator.class_834
    import com.sulake.habbo.communication.messages.outgoing.moderator.class_912
    import com.sulake.habbo.communication.messages.outgoing.moderator.class_925
    import com.sulake.habbo.communication.messages.outgoing.moderator.GetRoomVisitsMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.navigator.ConvertGlobalRoomIdMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_1061
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_1081
    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomAdEventTabViewedComposer
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_130
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_136
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_139
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_194
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_202
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_244
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_260
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_305
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_359
    import com.sulake.habbo.communication.messages.outgoing.navigator.ToggleStaffPickMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_387
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_413
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_458
    import com.sulake.habbo.communication.messages.outgoing.navigator.ForwardToARandomPromotedRoomMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_517
    import com.sulake.habbo.communication.messages.outgoing.navigator.RemoveOwnRoomRightsRoomMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_546
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_550
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_553
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_560
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_646
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_648
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_764
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_771
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_804
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_831
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_864
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_868
    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomsWhereMyFriendsAreSearchMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_937
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_977
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_991
    import com.sulake.habbo.communication.messages.outgoing.navigator.RoomAdEventTabAdClickedComposer
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_998
    import com.sulake.habbo.communication.messages.outgoing.poll.PollStartComposer
    import com.sulake.habbo.communication.messages.outgoing.poll.class_163
    import com.sulake.habbo.communication.messages.outgoing.poll.class_753
    import com.sulake.habbo.communication.messages.outgoing.room.action.BanUserWithDurationMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.room.action.class_1041
    import com.sulake.habbo.communication.messages.outgoing.room.action.class_234
    import com.sulake.habbo.communication.messages.outgoing.room.action.LetUserInMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.room.action.class_482
    import com.sulake.habbo.communication.messages.outgoing.room.action.UnmuteUserMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.room.action.RemoveRightsMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.room.action.class_595
    import com.sulake.habbo.communication.messages.outgoing.room.action.class_814
    import com.sulake.habbo.communication.messages.outgoing.room.action.class_938
    import com.sulake.habbo.communication.messages.outgoing.room.action.class_999
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.class_1053
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.CustomizeAvatarWithFurniMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.class_331
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.PassCarryItemToPetMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.class_582
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.class_656
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.class_724
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.class_739
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.class_742
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.ChangePostureMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.room.chat.class_698
    import com.sulake.habbo.communication.messages.outgoing.room.chat.class_817
    import com.sulake.habbo.communication.messages.outgoing.room.chat.class_838
    import com.sulake.habbo.communication.messages.outgoing.room.chat.class_847
    import com.sulake.habbo.communication.messages.outgoing.room.chat.class_993
    import com.sulake.habbo.communication.messages.outgoing.room.engine.ClickFurniMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.room.engine.class_1023
    import com.sulake.habbo.communication.messages.outgoing.room.engine.class_1028
    import com.sulake.habbo.communication.messages.outgoing.room.engine.class_1047
    import com.sulake.habbo.communication.messages.outgoing.room.engine.class_1101
    import com.sulake.habbo.communication.messages.outgoing.room.engine.HarvestPetMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.room.engine.class_146
    import com.sulake.habbo.communication.messages.outgoing.room.engine.SetItemDataMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.room.engine.class_191
    import com.sulake.habbo.communication.messages.outgoing.room.engine.class_216
    import com.sulake.habbo.communication.messages.outgoing.room.engine.class_218
    import com.sulake.habbo.communication.messages.outgoing.room.engine.class_230
    import com.sulake.habbo.communication.messages.outgoing.room.engine.class_290
    import com.sulake.habbo.communication.messages.outgoing.room.engine.class_417
    import com.sulake.habbo.communication.messages.outgoing.room.engine.class_452
    import com.sulake.habbo.communication.messages.outgoing.room.engine.class_508
    import com.sulake.habbo.communication.messages.outgoing.room.engine.class_513
    import com.sulake.habbo.communication.messages.outgoing.room.engine.UseFurnitureMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.room.engine.class_617
    import com.sulake.habbo.communication.messages.outgoing.room.engine.class_645
    import com.sulake.habbo.communication.messages.outgoing.room.engine.class_661
    import com.sulake.habbo.communication.messages.outgoing.room.engine.class_663
    import com.sulake.habbo.communication.messages.outgoing.room.engine.class_740
    import com.sulake.habbo.communication.messages.outgoing.room.engine.class_755
    import com.sulake.habbo.communication.messages.outgoing.room.engine.class_788
    import com.sulake.habbo.communication.messages.outgoing.room.engine.class_842
    import com.sulake.habbo.communication.messages.outgoing.room.engine.class_865
    import com.sulake.habbo.communication.messages.outgoing.room.engine.class_956
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_1003
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_1059
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_1070
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_154
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_203
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_213
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_273
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_287
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_383
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_400
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_420
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_443
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_530
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_555
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_565
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_571
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_584
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_598
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.RentableSpaceStatusMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_665
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_704
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_731
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_768
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.RoomDimmerSavePresetMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_820
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_825
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_870
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_966
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_967
    import com.sulake.habbo.communication.messages.outgoing.room.session.class_155
    import com.sulake.habbo.communication.messages.outgoing.room.session.class_325
    import com.sulake.habbo.communication.messages.outgoing.room.session.class_974
    import com.sulake.habbo.communication.messages.outgoing.roomsettings.class_1007
    import com.sulake.habbo.communication.messages.outgoing.roomsettings.class_1025
    import com.sulake.habbo.communication.messages.outgoing.roomsettings.class_1094
    import com.sulake.habbo.communication.messages.outgoing.roomsettings.class_166
    import com.sulake.habbo.communication.messages.outgoing.roomsettings.GetCustomRoomFilterMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.roomsettings.SaveRoomSettingsMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.roomsettings.class_862
    import com.sulake.habbo.communication.messages.outgoing.roomsettings.class_876
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateSelectorMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.class_1086
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.class_227
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateAddonMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateActionMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.class_599
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.class_833
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.class_995
    import com.sulake.habbo.communication.messages.outgoing.users.AddAdminRightsToMemberMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.users.class_1010
    import com.sulake.habbo.communication.messages.outgoing.users.class_1017
    import com.sulake.habbo.communication.messages.outgoing.users.class_1037
    import com.sulake.habbo.communication.messages.outgoing.users.RejectMembershipRequestMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileByNameMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.users.class_1056
    import com.sulake.habbo.communication.messages.outgoing.users.GetGuildMembersMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.users.class_131
    import com.sulake.habbo.communication.messages.outgoing.users.class_142
    import com.sulake.habbo.communication.messages.outgoing.users.class_197
    import com.sulake.habbo.communication.messages.outgoing.users.class_201
    import com.sulake.habbo.communication.messages.outgoing.users.class_224
    import com.sulake.habbo.communication.messages.outgoing.users.class_251
    import com.sulake.habbo.communication.messages.outgoing.users.class_304
    import com.sulake.habbo.communication.messages.outgoing.users.class_312
    import com.sulake.habbo.communication.messages.outgoing.users.class_320
    import com.sulake.habbo.communication.messages.outgoing.users.class_322
    import com.sulake.habbo.communication.messages.outgoing.users.class_342
    import com.sulake.habbo.communication.messages.outgoing.users.class_346
    import com.sulake.habbo.communication.messages.outgoing.users.GetMOTDMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.users.class_352
    import com.sulake.habbo.communication.messages.outgoing.users.class_575
    import com.sulake.habbo.communication.messages.outgoing.users.class_585
    import com.sulake.habbo.communication.messages.outgoing.users.class_606
    import com.sulake.habbo.communication.messages.outgoing.users.class_607
    import com.sulake.habbo.communication.messages.outgoing.users.class_664
    import com.sulake.habbo.communication.messages.outgoing.users.class_715
    import com.sulake.habbo.communication.messages.outgoing.users.GetRelationshipStatusInfoMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.users.class_737
    import com.sulake.habbo.communication.messages.outgoing.users.class_779
    import com.sulake.habbo.communication.messages.outgoing.users.class_793
    import com.sulake.habbo.communication.messages.outgoing.users.class_806
    import com.sulake.habbo.communication.messages.outgoing.users.UpdateGuildBadgeMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.users.class_896
    import com.sulake.habbo.communication.messages.outgoing.users.class_906
    import com.sulake.habbo.communication.messages.outgoing.users.class_911
    import com.sulake.habbo.communication.messages.outgoing.users.class_915
    import com.sulake.habbo.communication.messages.outgoing.users.class_935
    import com.sulake.habbo.communication.messages.outgoing.users.GetMemberGuildItemCountMessageComposer

    import package_1.*

    import com.sulake.habbo.communication.messages.outgoing.marketplace.RedeemMarketplaceOfferCreditsMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.marketplace.class_127
    import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceConfigurationMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.marketplace.class_268
    import com.sulake.habbo.communication.messages.outgoing.marketplace.class_370
    import com.sulake.habbo.communication.messages.outgoing.marketplace.class_403
    import com.sulake.habbo.communication.messages.outgoing.marketplace.class_406
    import com.sulake.habbo.communication.messages.outgoing.marketplace.class_505
    import com.sulake.habbo.communication.messages.outgoing.marketplace.class_802
    import com.sulake.habbo.communication.messages.outgoing.marketplace.class_928

    import com.sulake.habbo.communication.messages.outgoing.inventory.pets.class_445
    import com.sulake.habbo.communication.messages.outgoing.inventory.pets.class_964
    import com.sulake.habbo.communication.messages.outgoing.inventory.pets.class_989

    import com.sulake.habbo.communication.messages.outgoing.room.layout.class_563
    import com.sulake.habbo.communication.messages.outgoing.room.layout.class_821
    import com.sulake.habbo.communication.messages.outgoing.room.layout.class_932

    import com.sulake.habbo.communication.messages.outgoing.roomdirectory.class_589

    import com.sulake.habbo.communication.messages.outgoing.hotlooks.class_632

    import com.sulake.habbo.communication.messages.outgoing.register.class_675

    import package_113.*

    import com.sulake.habbo.communication.messages.outgoing.mysterybox.class_711

    import com.sulake.habbo.communication.messages.outgoing.landingview.votes.CommunityGoalVoteMessageComposer

    import com.sulake.habbo.communication.messages.outgoing.inventory.bots.class_1022

    import package_120.*

    import package_121.*

    import package_14.*

    import com.sulake.habbo.communication.messages.outgoing.sound.class_1009
    import com.sulake.habbo.communication.messages.outgoing.sound.AddJukeboxDiskComposer
    import com.sulake.habbo.communication.messages.outgoing.sound.class_183
    import com.sulake.habbo.communication.messages.outgoing.sound.class_188
    import com.sulake.habbo.communication.messages.outgoing.sound.class_667
    import com.sulake.habbo.communication.messages.outgoing.sound.GetSoundMachinePlayListMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.sound.class_700
    import com.sulake.habbo.communication.messages.outgoing.sound.class_775
    import com.sulake.habbo.communication.messages.outgoing.sound.class_934

    import package_2.*

    import com.sulake.habbo.communication.messages.outgoing.preferences.class_152
    import com.sulake.habbo.communication.messages.outgoing.preferences.SetChatPreferencesMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.preferences.class_433
    import com.sulake.habbo.communication.messages.outgoing.preferences.class_435
    import com.sulake.habbo.communication.messages.outgoing.preferences.class_525
    import com.sulake.habbo.communication.messages.outgoing.preferences.class_542
    import com.sulake.habbo.communication.messages.outgoing.preferences.class_856

    import com.sulake.habbo.communication.messages.outgoing.groupforums.class_1002
    import com.sulake.habbo.communication.messages.outgoing.groupforums.class_1013
    import com.sulake.habbo.communication.messages.outgoing.groupforums.class_1036
    import com.sulake.habbo.communication.messages.outgoing.groupforums.class_153
    import com.sulake.habbo.communication.messages.outgoing.groupforums.class_171
    import com.sulake.habbo.communication.messages.outgoing.groupforums.class_472
    import com.sulake.habbo.communication.messages.outgoing.groupforums.class_539
    import com.sulake.habbo.communication.messages.outgoing.groupforums.class_569
    import com.sulake.habbo.communication.messages.outgoing.groupforums.class_614
    import com.sulake.habbo.communication.messages.outgoing.groupforums.class_650
    import com.sulake.habbo.communication.messages.outgoing.groupforums.UpdateForumSettingsMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.groupforums.class_917

    import package_22.*

    import package_23.*

    import package_24.*

    import package_3.*

    import package_30.*

    import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2CheckGameDirectoryStatusMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2GetAccountGameStatusMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.game.directory.class_365
    import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2QuickJoinGameMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.game.directory.class_647

    import com.sulake.habbo.communication.messages.outgoing.game.lobby.GetUserGameAchievementsMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.game.lobby.class_165
    import com.sulake.habbo.communication.messages.outgoing.game.lobby.GetResolutionAchievementsMessageComposer

    import package_34.*

    import com.sulake.habbo.communication.messages.outgoing.advertisement.class_168
    import com.sulake.habbo.communication.messages.outgoing.advertisement.class_703

    import package_36.*

    import package_37.*

    import com.sulake.habbo.communication.messages.outgoing.game.score.Game2GetFriendsLeaderboardComposer
    import com.sulake.habbo.communication.messages.outgoing.game.score.Game2GetTotalGroupLeaderboardComposer
    import com.sulake.habbo.communication.messages.outgoing.game.score.Game2GetTotalLeaderboardComposer
    import com.sulake.habbo.communication.messages.outgoing.game.score.Game2GetWeeklyFriendsLeaderboardComposer
    import com.sulake.habbo.communication.messages.outgoing.game.score.Game2GetWeeklyGroupLeaderboardComposer
    import com.sulake.habbo.communication.messages.outgoing.game.score.Game2GetWeeklyLeaderboardComposer
    import com.sulake.habbo.communication.messages.outgoing.game.score.GetFriendsWeeklyCompetitiveLeaderboardComposer
    import com.sulake.habbo.communication.messages.outgoing.game.score.GetWeeklyCompetitiveLeaderboardComposer
    import com.sulake.habbo.communication.messages.outgoing.game.score.GetWeeklyGameRewardComposer
    import com.sulake.habbo.communication.messages.outgoing.game.score.GetWeeklyGameRewardWinnersComposer

    import com.sulake.habbo.communication.messages.outgoing.competition.class_1011
    import com.sulake.habbo.communication.messages.outgoing.competition.ForwardToASubmittableRoomMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.competition.class_157
    import com.sulake.habbo.communication.messages.outgoing.competition.ForwardToACompetitionRoomMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.competition.class_180
    import com.sulake.habbo.communication.messages.outgoing.competition.class_463
    import com.sulake.habbo.communication.messages.outgoing.competition.class_490
    import com.sulake.habbo.communication.messages.outgoing.competition.class_749
    import com.sulake.habbo.communication.messages.outgoing.competition.class_913

    import com.sulake.habbo.communication.messages.outgoing.newnavigator.NavigatorRemoveCollapsedCategoryMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.newnavigator.NavigatorSetSearchCodeViewModeMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.newnavigator.class_179
    import com.sulake.habbo.communication.messages.outgoing.newnavigator.class_225
    import com.sulake.habbo.communication.messages.outgoing.newnavigator.class_687
    import com.sulake.habbo.communication.messages.outgoing.newnavigator.class_901
    import com.sulake.habbo.communication.messages.outgoing.newnavigator.class_990

    import com.sulake.habbo.communication.messages.outgoing.vault.class_186
    import com.sulake.habbo.communication.messages.outgoing.vault.WithdrawCreditVaultMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.vault.class_763
    import com.sulake.habbo.communication.messages.outgoing.vault.class_982

    import com.sulake.habbo.communication.messages.outgoing.nux.NewUserExperienceGetGiftsMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.nux.class_805
    import com.sulake.habbo.communication.messages.outgoing.nux.class_873

    import com.sulake.habbo.communication.messages.outgoing.gifts.class_200
    import com.sulake.habbo.communication.messages.outgoing.gifts.class_457
    import com.sulake.habbo.communication.messages.outgoing.gifts.class_478
    import com.sulake.habbo.communication.messages.outgoing.gifts.class_706
    import com.sulake.habbo.communication.messages.outgoing.gifts.class_859

    import com.sulake.habbo.communication.messages.outgoing.notifications.class_204
    import com.sulake.habbo.communication.messages.outgoing.notifications.class_554

    import com.sulake.habbo.communication.messages.outgoing.game.arena.Game2ExitGameMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.game.arena.Game2GameChatMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.game.arena.Game2LoadStageReadyMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.game.arena.Game2PlayAgainMessageComposer

    import package_51.*

    import com.sulake.habbo.communication.messages.outgoing.tracking.class_207
    import com.sulake.habbo.communication.messages.outgoing.tracking.class_253
    import com.sulake.habbo.communication.messages.outgoing.tracking.class_448
    import com.sulake.habbo.communication.messages.outgoing.tracking.LatencyPingReportMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer

    import com.sulake.habbo.communication.messages.outgoing.quest.GetConcurrentUsersGoalProgressMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.quest.class_1052
    import com.sulake.habbo.communication.messages.outgoing.quest.class_214
    import com.sulake.habbo.communication.messages.outgoing.quest.class_391
    import com.sulake.habbo.communication.messages.outgoing.quest.class_429
    import com.sulake.habbo.communication.messages.outgoing.quest.class_461
    import com.sulake.habbo.communication.messages.outgoing.quest.class_471
    import com.sulake.habbo.communication.messages.outgoing.quest.class_479
    import com.sulake.habbo.communication.messages.outgoing.quest.class_493
    import com.sulake.habbo.communication.messages.outgoing.quest.class_577
    import com.sulake.habbo.communication.messages.outgoing.quest.FriendRequestQuestCompleteMessageEvent
    import com.sulake.habbo.communication.messages.outgoing.quest.class_735
    import com.sulake.habbo.communication.messages.outgoing.quest.class_748
    import com.sulake.habbo.communication.messages.outgoing.quest.GetCommunityGoalProgressMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.quest.class_823
    import com.sulake.habbo.communication.messages.outgoing.quest.class_978

    import com.sulake.habbo.communication.messages.outgoing.collectibles.class_215
    import com.sulake.habbo.communication.messages.outgoing.collectibles.class_405
    import com.sulake.habbo.communication.messages.outgoing.collectibles.class_425
    import com.sulake.habbo.communication.messages.outgoing.collectibles.class_562
    import com.sulake.habbo.communication.messages.outgoing.collectibles.NftTransferAssetsMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.collectibles.class_626
    import com.sulake.habbo.communication.messages.outgoing.collectibles.class_643
    import com.sulake.habbo.communication.messages.outgoing.collectibles.class_727
    import com.sulake.habbo.communication.messages.outgoing.collectibles.class_815
    import com.sulake.habbo.communication.messages.outgoing.collectibles.class_827
    import com.sulake.habbo.communication.messages.outgoing.collectibles.NftCollectiblesClaimRewardItemMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.collectibles.class_969
    import com.sulake.habbo.communication.messages.outgoing.collectibles.class_985

    import package_62.*

    import package_65.*

    import com.sulake.habbo.communication.messages.outgoing.avatar.class_242
    import com.sulake.habbo.communication.messages.outgoing.avatar.class_249
    import com.sulake.habbo.communication.messages.outgoing.avatar.class_390
    import com.sulake.habbo.communication.messages.outgoing.avatar.SaveWardrobeOutfitMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.avatar.class_798

    import package_72.*

    import package_73.*

    import com.sulake.habbo.communication.messages.outgoing.game.ingame.Game2MakeSnowballMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.game.ingame.Game2RequestFullStatusUpdateMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.game.ingame.Game2SetUserMoveTargetMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.game.ingame.Game2ThrowSnowballAtHumanMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.game.ingame.Game2ThrowSnowballAtPositionMessageComposer

    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.class_1040
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.class_286
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.class_412
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.class_437
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredGetAllVariablesHashMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.class_488
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredSetPreferencesMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.class_736
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.class_759
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.class_777
    import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredGetAllVariablesDiffsMessageComposer

    import com.sulake.habbo.communication.messages.outgoing.room.pets.class_308
    import com.sulake.habbo.communication.messages.outgoing.room.pets.class_666
    import com.sulake.habbo.communication.messages.outgoing.room.pets.class_717
    import com.sulake.habbo.communication.messages.outgoing.room.pets.CustomizePetWithFurniComposer
    import com.sulake.habbo.communication.messages.outgoing.room.pets.class_850

    import com.sulake.habbo.communication.messages.outgoing.nft.GetNftCreditsMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.nft.GetSilverMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.nft.GetUserNftWardrobeMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.nft.SaveUserNftWardrobeMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.nft.class_757

    import com.sulake.habbo.communication.messages.outgoing.talent.class_1018
    import com.sulake.habbo.communication.messages.outgoing.talent.class_330
    import com.sulake.habbo.communication.messages.outgoing.talent.class_639

    import package_84.*

    import com.sulake.habbo.communication.messages.incoming.advertisement.InterstitialMessageEvent
    import com.sulake.habbo.communication.messages.incoming.advertisement.RoomAdErrorEvent

    import com.sulake.habbo.communication.messages.outgoing.userclassification.class_368
    import com.sulake.habbo.communication.messages.outgoing.userclassification.class_942

    import package_91.*

    import package_92.*

    import com.sulake.habbo.communication.messages.outgoing.friendfurni.class_395

    import com.sulake.habbo.communication.messages.outgoing.room.bots.GetBotCommandConfigurationDataComposer
    import com.sulake.habbo.communication.messages.outgoing.room.bots.class_904

    [SecureSWF(rename="true")]
    public class HabboMessages implements IMessageConfiguration {

        private static const _events: Map = new class_885();

        private static const _composers: Map = new class_885();

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
            _composers[1503] = class_914;
            _composers[1511] = class_490;
            _composers[1521] = ForwardToARandomPromotedRoomMessageComposer;
            _composers[1526] = class_413;
            _composers[1538] = class_976;
            _composers[1539] = class_275;
            _composers[1554] = class_1059;
            _composers[1560] = class_229;
            _composers[1561] = class_553;
            _composers[1565] = class_344;
            _composers[157] = class_330;
            _composers[1575] = SilverFeeMessageComposer;
            _composers[1598] = class_827;
            _composers[16] = class_821;
            _composers[1601] = class_715;
            _composers[161] = class_595;
            _composers[1614] = class_801;
            _composers[1616] = class_989;
            _composers[1617] = class_403;
            _composers[1622] = class_312;
            _composers[1626] = class_720;
            _composers[1630] = class_201;
            _composers[1633] = class_902;
            _composers[1637] = class_328;
            _composers[1645] = RequestFriendMessageEvent;
            _composers[1666] = SetRelationshipStatusMessageComposer;
            _composers[1670] = class_870;
            _composers[1679] = class_998;
            _composers[1684] = class_937;
            _composers[1686] = class_260;
            _composers[17] = class_1052;
            _composers[1704] = class_391;
            _composers[1709] = class_669;
            _composers[171] = class_663;
            _composers[172] = class_200;
            _composers[1732] = class_938;
            _composers[1733] = class_272;
            _composers[1739] = Game2ThrowSnowballAtPositionMessageComposer;
            _composers[1746] = class_845;
            _composers[1753] = class_183;
            _composers[1773] = class_1081;
            _composers[1779] = class_791;
            _composers[1781] = class_519;
            _composers[1783] = class_678;
            _composers[180] = class_1101;
            _composers[1807] = FriendRequestQuestCompleteMessageEvent;
            _composers[1814] = class_127;
            _composers[1819] = class_580;
            _composers[1833] = class_664;
            _composers[1843] = class_203;
            _composers[1847] = class_166;
            _composers[1852] = class_855;
            _composers[1865] = class_731;
            _composers[1880] = class_555;
            _composers[1881] = class_584;
            _composers[1883] = class_389;
            _composers[1890] = class_194;
            _composers[1897] = class_935;
            _composers[1898] = class_153;
            _composers[1909] = class_737;
            _composers[1912] = class_435;
            _composers[1914] = class_906;
            _composers[1918] = class_511;
            _composers[1923] = class_508;
            _composers[193] = class_881;
            _composers[1931] = class_982;
            _composers[1935] = class_865;
            _composers[1947] = class_1009;
            _composers[1948] = class_643;
            _composers[195] = class_1037;
            _composers[1951] = class_814;
            _composers[1952] = class_188;
            _composers[1956] = GetCraftableProductsComposer;
            _composers[1959] = Game2GetFriendsLeaderboardComposer;
            _composers[1967] = class_964;
            _composers[1976] = class_1036;
            _composers[1990] = GetSilverMessageComposer;
            _composers[20] = class_383;
            _composers[2007] = class_734;
            _composers[201] = class_1025;
            _composers[2011] = class_749;
            _composers[2020] = class_215;
            _composers[2046] = class_1041;
            _composers[2049] = Game2GetWeeklyLeaderboardComposer;
            _composers[2057] = class_698;
            _composers[2064] = class_645;
            _composers[2065] = class_847;
            _composers[2068] = class_214;
            _composers[2077] = class_859;
            _composers[2080] = class_130;
            _composers[2085] = class_216;
            _composers[2087] = class_437;
            _composers[2089] = class_359;
            _composers[2109] = class_242;
            _composers[2114] = class_287;
            _composers[2123] = class_505;
            _composers[2131] = class_806;
            _composers[2137] = class_441;
            _composers[2141] = class_876;
            _composers[2159] = UpdateSelectorMessageComposer;
            _composers[2162] = class_585;
            _composers[2168] = class_753;
            _composers[2171] = class_804;
            _composers[2182] = class_667;
            _composers[2185] = class_724;
            _composers[2188] = class_991;
            _composers[2197] = class_825;
            _composers[2200] = Game2RequestFullStatusUpdateMessageComposer;
            _composers[2205] = class_626;
            _composers[2209] = class_433;
            _composers[222] = class_932;
            _composers[2244] = class_820;
            _composers[2249] = class_352;
            _composers[2250] = class_1046;
            _composers[2253] = class_472;
            _composers[2265] = Game2GameChatMessageComposer;
            _composers[2269] = class_768;
            _composers[2270] = class_740;
            _composers[2290] = class_367;
            _composers[2293] = class_513;
            _composers[2297] = EventLogMessageComposer;
            _composers[2302] = class_146;
            _composers[2304] = class_253;
            _composers[2305] = class_802;
            _composers[2307] = class_428;
            _composers[2317] = class_575;
            _composers[2321] = class_213;
            _composers[2325] = class_479;
            _composers[2327] = class_230;
            _composers[2331] = PongMessageComposer;
            _composers[2338] = class_424;
            _composers[2339] = class_755;
            _composers[2346] = class_157;
            _composers[2348] = class_1070;
            _composers[2351] = class_617;
            _composers[2362] = class_598;
            _composers[2363] = class_218;
            _composers[2370] = class_577;
            _composers[2374] = class_570;
            _composers[2404] = class_739;
            _composers[2418] = class_887;
            _composers[2428] = class_833;
            _composers[2443] = class_728;
            _composers[2446] = FollowFriendMessageComposer;
            _composers[245] = class_840;
            _composers[2460] = class_607;
            _composers[2470] = Game2SetUserMoveTargetMessageComposer;
            _composers[2473] = class_395;
            _composers[2476] = class_563;
            _composers[2477] = class_763;
            _composers[2481] = class_1011;
            _composers[2496] = class_346;
            _composers[250] = class_405;
            _composers[2508] = class_599;
            _composers[2513] = class_925;
            _composers[2534] = class_956;
            _composers[2549] = class_368;
            _composers[255] = class_1035;
            _composers[2558] = class_1095;
            _composers[2578] = VisitUserMessageComposer;
            _composers[2582] = class_561;
            _composers[2593] = class_775;
            _composers[2595] = class_904;
            _composers[2602] = class_489;
            _composers[2603] = class_913;
            _composers[2611] = class_917;
            _composers[2616] = class_385;
            _composers[2619] = class_658;
            _composers[2624] = class_569;
            _composers[2631] = class_850;
            _composers[2636] = class_308;
            _composers[2639] = class_1023;
            _composers[264] = class_525;
            _composers[2641] = class_1086;
            _composers[2663] = class_142;
            _composers[2666] = class_1003;
            _composers[2673] = class_458;
            _composers[2678] = class_993;
            _composers[268] = class_282;
            _composers[2681] = CraftComposer;
            _composers[2703] = class_365;
            _composers[2708] = class_471;
            _composers[271] = class_977;
            _composers[2714] = class_156;
            _composers[2718] = class_461;
            _composers[2722] = class_325;
            _composers[2729] = class_974;
            _composers[2749] = class_406;
            _composers[2760] = class_268;
            _composers[2765] = class_706;
            _composers[2775] = class_503;
            _composers[2781] = GetUserGameAchievementsMessageComposer;
            _composers[2798] = class_171;
            _composers[2800] = SendMsgMessageComposer;
            _composers[2806] = class_305;
            _composers[2809] = class_967;
            _composers[283] = class_244;
            _composers[2837] = class_614;
            _composers[2839] = class_376;
            _composers[2841] = class_780;
            _composers[2844] = class_873;
            _composers[2845] = class_322;
            _composers[2847] = class_443;
            _composers[2862] = class_757;
            _composers[2863] = class_759;
            _composers[2877] = class_1047;
            _composers[2889] = ConvertGlobalRoomIdMessageComposer;
            _composers[2897] = class_550;
            _composers[2899] = class_452;
            _composers[2901] = class_227;
            _composers[2905] = class_1050;
            _composers[2959] = class_412;
            _composers[296] = class_234;
            _composers[2972] = class_417;
            _composers[2982] = class_984;
            _composers[2998] = class_639;
            _composers[300] = class_656;
            _composers[3007] = class_966;
            _composers[3013] = class_999;
            _composers[3032] = class_990;
            _composers[3040] = class_409;
            _composers[3041] = Game2PlayAgainMessageComposer;
            _composers[3046] = class_445;
            _composers[306] = class_249;
            _composers[3066] = class_805;
            _composers[3074] = class_154;
            _composers[3082] = class_204;
            _composers[311] = class_582;
            _composers[3118] = class_131;
            _composers[3130] = class_700;
            _composers[315] = class_831;
            _composers[3154] = class_520;
            _composers[3162] = class_225;
            _composers[3165] = class_631;
            _composers[3171] = class_823;
            _composers[3172] = class_834;
            _composers[3173] = class_155;
            _composers[3175] = class_390;
            _composers[3177] = class_397;
            _composers[3181] = RequestFurniInventoryComposer;
            _composers[3186] = class_565;
            _composers[3188] = class_1045;
            _composers[320] = GetNftCreditsMessageComposer;
            _composers[3207] = class_457;
            _composers[3210] = class_752;
            _composers[3216] = class_711;
            _composers[3236] = class_648;
            _composers[324] = class_546;
            _composers[3240] = class_371;
            _composers[3241] = class_939;
            _composers[3266] = class_1040;
            _composers[3271] = class_647;
            _composers[3274] = class_650;
            _composers[3280] = class_375;
            _composers[3282] = class_1033;
            _composers[3288] = class_488;
            _composers[3308] = DeclineFriendMessageComposer;
            _composers[3312] = Game2GetWeeklyGroupLeaderboardComposer;
            _composers[3335] = class_1089;
            _composers[3340] = class_911;
            _composers[3343] = class_554;
            _composers[3351] = class_463;
            _composers[3357] = class_915;
            _composers[3363] = class_475;
            _composers[3373] = class_420;
            _composers[3392] = class_560;
            _composers[3401] = class_594;
            _composers[3404] = class_436;
            _composers[3452] = class_777;
            _composers[346] = class_165;
            _composers[3468] = RequestFurniInventoryWhenNotInRoomComposer;
            _composers[3472] = class_822;
            _composers[3473] = FindNewFriendsMessageComposer; //FindNewFriendsMessageComposer
            _composers[3477] = class_736;
            _composers[3478] = class_224;
            _composers[3484] = class_934;
            _composers[3487] = class_425; //GetCollectibleMintableItemTypesMessageComposer
            _composers[3492] = class_1017;
            _composers[3507] = class_1013;
            _composers[3510] = class_294;
            _composers[3519] = class_816;
            _composers[3523] = class_1002;
            _composers[3526] = class_517;
            _composers[3530] = class_764;
            _composers[3534] = class_985;
            _composers[3540] = class_646;
            _composers[355] = class_815;
            _composers[3560] = class_969;
            _composers[3566] = class_197;
            _composers[3575] = class_1028;
            _composers[3578] = class_202;
            _composers[3580] = class_852;
            _composers[3596] = class_1056;
            _composers[3600] = class_286;
            _composers[3623] = class_909;
            _composers[3625] = class_300;
            _composers[3632] = class_429;
            _composers[3638] = class_448;
            _composers[3651] = class_496;
            _composers[3654] = Game2GetTotalLeaderboardComposer;
            _composers[3657] = class_291;
            _composers[366] = SendRoomInviteMessageComposer;
            _composers[3681] = class_1007;
            _composers[3692] = class_251;
            _composers[3695] = GetUserNftWardrobeMessageComposer;
            _composers[3698] = class_703;
            _composers[3706] = class_363;
            _composers[372] = class_995;
            _composers[3727] = AddAdminRightsToMemberMessageComposer;
            _composers[3734] = Game2GetWeeklyFriendsLeaderboardComposer;
            _composers[3736] = class_1091;
            _composers[3746] = class_856;
            _composers[3747] = class_672;
            _composers[3750] = class_773;
            _composers[3755] = Game2ExitGameMessageComposer;
            _composers[3758] = class_290;
            _composers[3760] = class_862;
            _composers[3768] = class_928;
            _composers[3783] = class_864;
            _composers[3785] = class_360;
            _composers[3789] = GetFriendsWeeklyCompetitiveLeaderboardComposer;
            _composers[3794] = class_1053;
            _composers[380] = class_817;
            _composers[3806] = class_666;
            _composers[3809] = class_370;
            _composers[381] = class_1015;
            _composers[3814] = class_562;
            _composers[3833] = class_531;
            _composers[3835] = LatencyPingReportMessageComposer;
            _composers[3852] = class_912;
            _composers[386] = class_793;
            _composers[3878] = class_838;
            _composers[3881] = class_342;
            _composers[3894] = GetWeeklyCompetitiveLeaderboardComposer;
            _composers[3899] = class_493;
            _composers[3900] = class_136;
            _composers[3914] = class_482;
            _composers[3915] = class_600;
            _composers[3919] = class_1063;
            _composers[3920] = class_521;
            _composers[3933] = class_1010;
            _composers[3942] = class_951;
            _composers[3948] = GuideSessionReportMessageComposer;
            _composers[3949] = GetSnowWarGameTokensOfferComposer;
            _composers[3959] = UpdateGuildBadgeMessageComposer;
            _composers[3962] = LetUserInMessageComposer;
            _composers[3965] = CommunityGoalVoteMessageComposer;
            _composers[3967] = Game2GetAccountGameStatusMessageComposer;
            _composers[3975] = WiredSetPreferencesMessageComposer;
            _composers[4000] = ClientHelloMessageComposer;
            _composers[403] = class_179;
            _composers[406] = GetFriendRequestsMessageComposer;
            _composers[411] = class_1099;
            _composers[417] = RemoveFriendMessageComposer;
            _composers[421] = class_502;
            _composers[422] = class_807;
            _composers[43] = class_788;
            _composers[433] = class_717;
            _composers[459] = class_972;
            _composers[463] = class_180;
            _composers[472] = MessengerInitMessageComposer;
            _composers[478] = class_270;
            _composers[483] = class_675;
            _composers[485] = class_606;
            _composers[494] = class_687;
            _composers[505] = class_400;
            _composers[506] = class_539;
            _composers[509] = class_168;
            _composers[51] = class_320;
            _composers[511] = class_303;
            _composers[520] = class_1062;
            _composers[521] = class_273;
            _composers[524] = class_387;
            _composers[526] = class_890;
            _composers[53] = class_941;
            _composers[541] = class_1022;
            _composers[573] = class_978;
            _composers[583] = Game2MakeSnowballMessageComposer;
            _composers[584] = class_1094;
            _composers[586] = class_622;
            _composers[599] = class_742;
            _composers[604] = class_354;
            _composers[613] = SaveUserNftWardrobeMessageComposer;
            _composers[616] = class_331;
            _composers[625] = class_589;
            _composers[626] = class_704;
            _composers[630] = class_930;
            _composers[644] = class_933;
            _composers[657] = class_901;
            _composers[661] = class_571;
            _composers[663] = class_942;
            _composers[672] = class_478;
            _composers[68] = class_896;
            _composers[683] = class_530;
            _composers[692] = class_139;
            _composers[700] = Game2CheckGameDirectoryStatusMessageComposer;
            _composers[701] = class_813;
            _composers[710] = GetWeeklyGameRewardWinnersComposer;
            _composers[712] = class_891;
            _composers[726] = class_279;
            _composers[737] = class_304;
            _composers[740] = Game2ThrowSnowballAtHumanMessageComposer;
            _composers[747] = class_207;
            _composers[754] = class_748;
            _composers[757] = ClickFurniMessageComposer;
            _composers[758] = class_186;
            _composers[76] = AcceptFriendMessageEvent;
            _composers[766] = class_152;
            _composers[768] = class_421;
            _composers[772] = class_798;
            _composers[79] = class_1061;
            _composers[790] = class_868;
            _composers[795] = class_1004;
            _composers[799] = GetMessengerHistoryComposer;
            _composers[805] = class_512;
            _composers[813] = class_779;
            _composers[818] = GetWeeklyGameRewardComposer;
            _composers[833] = class_163;
            _composers[842] = class_665;
            _composers[843] = class_842;
            _composers[850] = class_727; //GetCollectibleMintingEnabledMessageComposer
            _composers[852] = class_781;
            _composers[856] = class_191;
            _composers[864] = class_824;
            _composers[872] = class_632;
            _composers[874] = class_542;
            _composers[885] = class_661;
            _composers[90] = class_206;
            _composers[905] = class_1018;
            _composers[91] = class_874;
            _composers[915] = class_771;
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
            _events[2676] = class_129;
            _events[2677] = Game2GameEndingMessageEvent;
            _events[2680] = UserChangeMessageEvent;
            _events[2689] = DiceValueMessageEvent;
            _events[2691] = ChatReviewSessionDetachedMessageEvent;
            _events[2709] = ModeratorMessageEvent;
            _events[2741] = ModeratorActionResultMessageEvent;
            _events[2771] = PetReceivedMessageEvent;
            _events[279] = class_756; //MiniMailNewMessageEvent
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
            _events[3856] = class_307; //MiniMailUnreadCountEvent
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
            _events[895] = class_491;
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

        public function HabboMessages() {
            super();
        }

        public function get events(): Map {
            return _events;
        }

        public function get composers(): Map {
            return _composers;
        }
    }
}
