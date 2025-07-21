package com.sulake.habbo.communication {
    import com.sulake.core.communication.messages.IMessageConfiguration
    import com.sulake.core.utils.Map
    import com.sulake.core.utils.class_885
    import com.sulake.habbo.communication.messages.incoming.availability.class_1083
    import com.sulake.habbo.communication.messages.incoming.availability.class_1090
    import com.sulake.habbo.communication.messages.incoming.availability.AvailabilityStatusMessageEvent
    import com.sulake.habbo.communication.messages.incoming.availability.class_636
    import com.sulake.habbo.communication.messages.incoming.availability.class_686
    import com.sulake.habbo.communication.messages.incoming.availability.class_960
    import com.sulake.habbo.communication.messages.incoming.avatar.class_199
    import com.sulake.habbo.communication.messages.incoming.avatar.class_332
    import com.sulake.habbo.communication.messages.incoming.avatar.class_341
    import com.sulake.habbo.communication.messages.incoming.avatar.class_725
    import com.sulake.habbo.communication.messages.incoming.callforhelp.class_177
    import com.sulake.habbo.communication.messages.incoming.callforhelp.class_642
    import com.sulake.habbo.communication.messages.incoming.callforhelp.class_696
    import com.sulake.habbo.communication.messages.incoming.camera.class_1102
    import com.sulake.habbo.communication.messages.incoming.camera.class_343
    import com.sulake.habbo.communication.messages.incoming.camera.class_473
    import com.sulake.habbo.communication.messages.incoming.camera.class_532
    import com.sulake.habbo.communication.messages.incoming.camera.class_618
    import com.sulake.habbo.communication.messages.incoming.camera.class_741
    import com.sulake.habbo.communication.messages.incoming.campaign.class_712
    import com.sulake.habbo.communication.messages.incoming.campaign.class_961
    import com.sulake.habbo.communication.messages.incoming.catalog.SnowWarGameTokensMessageEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.TargetedOfferEvent
    import com.sulake.habbo.communication.messages.incoming.catalog.class_1039
    import com.sulake.habbo.communication.messages.incoming.catalog.class_1093
    import com.sulake.habbo.communication.messages.incoming.catalog.class_149
    import com.sulake.habbo.communication.messages.incoming.catalog.class_169
    import com.sulake.habbo.communication.messages.incoming.catalog.class_195
    import com.sulake.habbo.communication.messages.incoming.catalog.class_209
    import com.sulake.habbo.communication.messages.incoming.catalog.class_241
    import com.sulake.habbo.communication.messages.incoming.catalog.class_254
    import com.sulake.habbo.communication.messages.incoming.catalog.class_264
    import com.sulake.habbo.communication.messages.incoming.catalog.class_283
    import com.sulake.habbo.communication.messages.incoming.catalog.class_297
    import com.sulake.habbo.communication.messages.incoming.catalog.class_545
    import com.sulake.habbo.communication.messages.incoming.catalog.class_604
    import com.sulake.habbo.communication.messages.incoming.catalog.class_616
    import com.sulake.habbo.communication.messages.incoming.catalog.class_652
    import com.sulake.habbo.communication.messages.incoming.catalog.class_676
    import com.sulake.habbo.communication.messages.incoming.catalog.class_690
    import com.sulake.habbo.communication.messages.incoming.catalog.class_714
    import com.sulake.habbo.communication.messages.incoming.catalog.class_721
    import com.sulake.habbo.communication.messages.incoming.catalog.class_733
    import com.sulake.habbo.communication.messages.incoming.catalog.class_738
    import com.sulake.habbo.communication.messages.incoming.catalog.class_769
    import com.sulake.habbo.communication.messages.incoming.catalog.class_786
    import com.sulake.habbo.communication.messages.incoming.catalog.class_790
    import com.sulake.habbo.communication.messages.incoming.catalog.class_796
    import com.sulake.habbo.communication.messages.incoming.catalog.class_812
    import com.sulake.habbo.communication.messages.incoming.catalog.class_869
    import com.sulake.habbo.communication.messages.incoming.catalog.class_897
    import com.sulake.habbo.communication.messages.incoming.catalog.class_944
    import com.sulake.habbo.communication.messages.incoming.catalog.class_975
    import com.sulake.habbo.communication.messages.incoming.collectibles.class_1074
    import com.sulake.habbo.communication.messages.incoming.collectibles.class_160
    import com.sulake.habbo.communication.messages.incoming.collectibles.class_175
    import com.sulake.habbo.communication.messages.incoming.collectibles.class_284
    import com.sulake.habbo.communication.messages.incoming.collectibles.class_321
    import com.sulake.habbo.communication.messages.incoming.collectibles.class_378
    import com.sulake.habbo.communication.messages.incoming.collectibles.class_444
    import com.sulake.habbo.communication.messages.incoming.collectibles.class_593
    import com.sulake.habbo.communication.messages.incoming.collectibles.class_699
    import com.sulake.habbo.communication.messages.incoming.collectibles.class_767
    import com.sulake.habbo.communication.messages.incoming.collectibles.class_829
    import com.sulake.habbo.communication.messages.incoming.collectibles.class_883
    import com.sulake.habbo.communication.messages.incoming.collectibles.class_929
    import com.sulake.habbo.communication.messages.incoming.collectibles.class_981
    import com.sulake.habbo.communication.messages.incoming.competition.class_293
    import com.sulake.habbo.communication.messages.incoming.competition.class_394
    import com.sulake.habbo.communication.messages.incoming.competition.class_533
    import com.sulake.habbo.communication.messages.incoming.competition.class_581
    import com.sulake.habbo.communication.messages.incoming.competition.class_659
    import com.sulake.habbo.communication.messages.incoming.competition.class_692
    import com.sulake.habbo.communication.messages.incoming.crafting.class_1021
    import com.sulake.habbo.communication.messages.incoming.crafting.class_689
    import com.sulake.habbo.communication.messages.incoming.crafting.class_745
    import com.sulake.habbo.communication.messages.incoming.crafting.class_774
    import com.sulake.habbo.communication.messages.incoming.error.class_231
    import com.sulake.habbo.communication.messages.incoming.friendfurni.class_1005
    import com.sulake.habbo.communication.messages.incoming.friendfurni.class_464
    import com.sulake.habbo.communication.messages.incoming.friendfurni.class_541
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
    import com.sulake.habbo.communication.messages.incoming.game.directory.class_418
    import com.sulake.habbo.communication.messages.incoming.game.directory.class_423
    import com.sulake.habbo.communication.messages.incoming.game.directory.class_707
    import com.sulake.habbo.communication.messages.incoming.game.directory.class_892
    import com.sulake.habbo.communication.messages.incoming.game.lobby.UserGameAchievementsMessageEvent
    import com.sulake.habbo.communication.messages.incoming.game.lobby.class_1012
    import com.sulake.habbo.communication.messages.incoming.game.lobby.class_494
    import com.sulake.habbo.communication.messages.incoming.game.lobby.class_894
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
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.class_1055
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.class_220
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.class_245
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.class_255
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.class_269
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.class_314
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.class_316
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.class_404
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.class_628
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.class_679
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.class_744
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.class_903
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.class_958
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.ingame.class_1067
    import com.sulake.habbo.communication.messages.incoming.game.snowwar.ingame.class_350
    import com.sulake.habbo.communication.messages.incoming.gifts.class_484
    import com.sulake.habbo.communication.messages.incoming.gifts.class_766
    import com.sulake.habbo.communication.messages.incoming.gifts.class_785
    import com.sulake.habbo.communication.messages.incoming.groupforums.class_281
    import com.sulake.habbo.communication.messages.incoming.groupforums.class_299
    import com.sulake.habbo.communication.messages.incoming.groupforums.class_334
    import com.sulake.habbo.communication.messages.incoming.groupforums.class_339
    import com.sulake.habbo.communication.messages.incoming.groupforums.class_495
    import com.sulake.habbo.communication.messages.incoming.groupforums.class_573
    import com.sulake.habbo.communication.messages.incoming.groupforums.class_624
    import com.sulake.habbo.communication.messages.incoming.groupforums.class_782
    import com.sulake.habbo.communication.messages.incoming.groupforums.class_988
    import com.sulake.habbo.communication.messages.incoming.handshake.NoobnessLevelMessageEvent
    import com.sulake.habbo.communication.messages.incoming.handshake.class_1060
    import com.sulake.habbo.communication.messages.incoming.handshake.class_1103
    import com.sulake.habbo.communication.messages.incoming.handshake.class_134
    import com.sulake.habbo.communication.messages.incoming.handshake.class_143
    import com.sulake.habbo.communication.messages.incoming.handshake.class_223
    import com.sulake.habbo.communication.messages.incoming.handshake.class_257
    import com.sulake.habbo.communication.messages.incoming.handshake.class_280
    import com.sulake.habbo.communication.messages.incoming.handshake.class_474
    import com.sulake.habbo.communication.messages.incoming.handshake.class_483
    import com.sulake.habbo.communication.messages.incoming.handshake.class_485
    import com.sulake.habbo.communication.messages.incoming.handshake.class_556
    import com.sulake.habbo.communication.messages.incoming.help.CallForHelpPendingCallsMessageEvent
    import com.sulake.habbo.communication.messages.incoming.help.class_1080
    import com.sulake.habbo.communication.messages.incoming.help.class_135
    import com.sulake.habbo.communication.messages.incoming.help.class_145
    import com.sulake.habbo.communication.messages.incoming.help.class_174
    import com.sulake.habbo.communication.messages.incoming.help.class_182
    import com.sulake.habbo.communication.messages.incoming.help.class_185
    import com.sulake.habbo.communication.messages.incoming.help.class_302
    import com.sulake.habbo.communication.messages.incoming.help.class_306
    import com.sulake.habbo.communication.messages.incoming.help.class_410
    import com.sulake.habbo.communication.messages.incoming.help.class_440
    import com.sulake.habbo.communication.messages.incoming.help.class_465
    import com.sulake.habbo.communication.messages.incoming.help.class_509
    import com.sulake.habbo.communication.messages.incoming.help.class_572
    import com.sulake.habbo.communication.messages.incoming.help.class_579
    import com.sulake.habbo.communication.messages.incoming.help.class_603
    import com.sulake.habbo.communication.messages.incoming.help.class_638
    import com.sulake.habbo.communication.messages.incoming.help.class_644
    import com.sulake.habbo.communication.messages.incoming.help.class_651
    import com.sulake.habbo.communication.messages.incoming.help.class_653
    import com.sulake.habbo.communication.messages.incoming.help.class_673
    import com.sulake.habbo.communication.messages.incoming.help.class_697
    import com.sulake.habbo.communication.messages.incoming.help.class_784
    import com.sulake.habbo.communication.messages.incoming.help.class_808
    import com.sulake.habbo.communication.messages.incoming.help.class_811
    import com.sulake.habbo.communication.messages.incoming.help.class_819
    import com.sulake.habbo.communication.messages.incoming.help.class_867
    import com.sulake.habbo.communication.messages.incoming.help.class_880
    import com.sulake.habbo.communication.messages.incoming.help.class_895
    import com.sulake.habbo.communication.messages.incoming.help.class_953
    import com.sulake.habbo.communication.messages.incoming.help.class_965
    import com.sulake.habbo.communication.messages.incoming.help.class_968
    import com.sulake.habbo.communication.messages.incoming.hotlooks.class_1104
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.class_1109
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.class_470
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.class_854
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.class_1072
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.class_1108
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.class_233
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.class_247
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.class_327
    import com.sulake.habbo.communication.messages.incoming.inventory.badges.class_1019
    import com.sulake.habbo.communication.messages.incoming.inventory.badges.class_522
    import com.sulake.habbo.communication.messages.incoming.inventory.badges.class_623
    import com.sulake.habbo.communication.messages.incoming.inventory.badges.class_683
    import com.sulake.habbo.communication.messages.incoming.inventory.bots.class_250
    import com.sulake.habbo.communication.messages.incoming.inventory.bots.class_258
    import com.sulake.habbo.communication.messages.incoming.inventory.bots.class_588
    import com.sulake.habbo.communication.messages.incoming.inventory.bots.class_592
    import com.sulake.habbo.communication.messages.incoming.inventory.clothing.class_1073
    import com.sulake.habbo.communication.messages.incoming.inventory.clothing.class_401
    import com.sulake.habbo.communication.messages.incoming.inventory.clothing.class_456
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListEvent
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.class_274
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.class_340
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.class_379
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.class_446
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.class_140
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.class_265
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.class_278
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.class_292
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.class_311
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.class_399
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.class_602
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.class_615
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.class_716
    import com.sulake.habbo.communication.messages.incoming.inventory.purse.class_459
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.class_1006
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.class_144
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.class_187
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.class_262
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.class_310
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.class_349
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.class_384
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.class_407
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.class_528
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.class_535
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.class_587
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.class_705
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.class_872
    import com.sulake.habbo.communication.messages.incoming.landingview.class_162
    import com.sulake.habbo.communication.messages.incoming.landingview.votes.class_860
    import com.sulake.habbo.communication.messages.incoming.marketplace.class_1077
    import com.sulake.habbo.communication.messages.incoming.marketplace.class_248
    import com.sulake.habbo.communication.messages.incoming.marketplace.class_431
    import com.sulake.habbo.communication.messages.incoming.marketplace.class_549
    import com.sulake.habbo.communication.messages.incoming.marketplace.class_633
    import com.sulake.habbo.communication.messages.incoming.marketplace.class_900
    import com.sulake.habbo.communication.messages.incoming.marketplace.class_926
    import com.sulake.habbo.communication.messages.incoming.marketplace.class_943
    import com.sulake.habbo.communication.messages.incoming.moderation.class_1024
    import com.sulake.habbo.communication.messages.incoming.moderation.class_1068
    import com.sulake.habbo.communication.messages.incoming.moderation.class_1084
    import com.sulake.habbo.communication.messages.incoming.moderation.class_211
    import com.sulake.habbo.communication.messages.incoming.moderation.class_237
    import com.sulake.habbo.communication.messages.incoming.moderation.class_324
    import com.sulake.habbo.communication.messages.incoming.moderation.class_398
    import com.sulake.habbo.communication.messages.incoming.moderation.class_415
    import com.sulake.habbo.communication.messages.incoming.moderation.class_476
    import com.sulake.habbo.communication.messages.incoming.moderation.class_504
    import com.sulake.habbo.communication.messages.incoming.moderation.class_514
    import com.sulake.habbo.communication.messages.incoming.moderation.class_574
    import com.sulake.habbo.communication.messages.incoming.moderation.class_680
    import com.sulake.habbo.communication.messages.incoming.moderation.class_688
    import com.sulake.habbo.communication.messages.incoming.moderation.class_851
    import com.sulake.habbo.communication.messages.incoming.mysterybox.class_601
    import com.sulake.habbo.communication.messages.incoming.mysterybox.class_621
    import com.sulake.habbo.communication.messages.incoming.mysterybox.class_695
    import com.sulake.habbo.communication.messages.incoming.mysterybox.class_843
    import com.sulake.habbo.communication.messages.incoming.navigator.class_1038
    import com.sulake.habbo.communication.messages.incoming.navigator.class_1079
    import com.sulake.habbo.communication.messages.incoming.navigator.class_129
    import com.sulake.habbo.communication.messages.incoming.navigator.class_296
    import com.sulake.habbo.communication.messages.incoming.navigator.class_454
    import com.sulake.habbo.communication.messages.incoming.navigator.class_467
    import com.sulake.habbo.communication.messages.incoming.navigator.class_487
    import com.sulake.habbo.communication.messages.incoming.navigator.class_491
    import com.sulake.habbo.communication.messages.incoming.navigator.class_526
    import com.sulake.habbo.communication.messages.incoming.navigator.class_534
    import com.sulake.habbo.communication.messages.incoming.navigator.class_590
    import com.sulake.habbo.communication.messages.incoming.navigator.class_605
    import com.sulake.habbo.communication.messages.incoming.navigator.class_627
    import com.sulake.habbo.communication.messages.incoming.navigator.class_722
    import com.sulake.habbo.communication.messages.incoming.navigator.class_746
    import com.sulake.habbo.communication.messages.incoming.navigator.class_750
    import com.sulake.habbo.communication.messages.incoming.navigator.class_761
    import com.sulake.habbo.communication.messages.incoming.navigator.class_795
    import com.sulake.habbo.communication.messages.incoming.navigator.class_837
    import com.sulake.habbo.communication.messages.incoming.navigator.class_898
    import com.sulake.habbo.communication.messages.incoming.navigator.class_936
    import com.sulake.habbo.communication.messages.incoming.navigator.class_979
    import com.sulake.habbo.communication.messages.incoming.newnavigator.class_151
    import com.sulake.habbo.communication.messages.incoming.newnavigator.class_348
    import com.sulake.habbo.communication.messages.incoming.newnavigator.class_364
    import com.sulake.habbo.communication.messages.incoming.newnavigator.class_713
    import com.sulake.habbo.communication.messages.incoming.newnavigator.class_760
    import com.sulake.habbo.communication.messages.incoming.newnavigator.class_954
    import com.sulake.habbo.communication.messages.incoming.nft.class_240
    import com.sulake.habbo.communication.messages.incoming.nft.class_567
    import com.sulake.habbo.communication.messages.incoming.nft.class_957
    import com.sulake.habbo.communication.messages.incoming.notifications.class_164
    import com.sulake.habbo.communication.messages.incoming.notifications.class_205
    import com.sulake.habbo.communication.messages.incoming.notifications.class_267
    import com.sulake.habbo.communication.messages.incoming.notifications.class_289
    import com.sulake.habbo.communication.messages.incoming.notifications.class_377
    import com.sulake.habbo.communication.messages.incoming.notifications.class_469
    import com.sulake.habbo.communication.messages.incoming.notifications.class_523
    import com.sulake.habbo.communication.messages.incoming.notifications.class_552
    import com.sulake.habbo.communication.messages.incoming.notifications.class_649
    import com.sulake.habbo.communication.messages.incoming.notifications.class_800
    import com.sulake.habbo.communication.messages.incoming.notifications.class_803
    import com.sulake.habbo.communication.messages.incoming.notifications.class_858
    import com.sulake.habbo.communication.messages.incoming.notifications.class_959
    import com.sulake.habbo.communication.messages.incoming.nux.class_295
    import com.sulake.habbo.communication.messages.incoming.nux.class_685
    import com.sulake.habbo.communication.messages.incoming.nux.class_694
    import com.sulake.habbo.communication.messages.incoming.perk.class_256
    import com.sulake.habbo.communication.messages.incoming.perk.class_828
    import com.sulake.habbo.communication.messages.incoming.poll.class_222
    import com.sulake.habbo.communication.messages.incoming.poll.class_277
    import com.sulake.habbo.communication.messages.incoming.poll.class_466
    import com.sulake.habbo.communication.messages.incoming.poll.class_507
    import com.sulake.habbo.communication.messages.incoming.poll.class_719
    import com.sulake.habbo.communication.messages.incoming.poll.class_922
    import com.sulake.habbo.communication.messages.incoming.preferences.class_219
    import com.sulake.habbo.communication.messages.incoming.quest.class_1001
    import com.sulake.habbo.communication.messages.incoming.quest.class_1016
    import com.sulake.habbo.communication.messages.incoming.quest.class_345
    import com.sulake.habbo.communication.messages.incoming.quest.class_538
    import com.sulake.habbo.communication.messages.incoming.quest.class_548
    import com.sulake.habbo.communication.messages.incoming.quest.class_836
    import com.sulake.habbo.communication.messages.incoming.quest.class_907
    import com.sulake.habbo.communication.messages.incoming.quest.class_931
    import com.sulake.habbo.communication.messages.incoming.quest.class_946
    import com.sulake.habbo.communication.messages.incoming.quest.class_973
    import com.sulake.habbo.communication.messages.incoming.quest.class_983
    import com.sulake.habbo.communication.messages.incoming.room.action.class_133
    import com.sulake.habbo.communication.messages.incoming.room.action.class_313
    import com.sulake.habbo.communication.messages.incoming.room.action.class_408
    import com.sulake.habbo.communication.messages.incoming.room.action.class_866
    import com.sulake.habbo.communication.messages.incoming.room.action.class_918
    import com.sulake.habbo.communication.messages.incoming.room.action.class_994
    import com.sulake.habbo.communication.messages.incoming.room.bots.class_1088
    import com.sulake.habbo.communication.messages.incoming.room.bots.class_181
    import com.sulake.habbo.communication.messages.incoming.room.bots.class_612
    import com.sulake.habbo.communication.messages.incoming.room.bots.class_792
    import com.sulake.habbo.communication.messages.incoming.room.camera.class_380
    import com.sulake.habbo.communication.messages.incoming.room.chat.class_1078
    import com.sulake.habbo.communication.messages.incoming.room.chat.class_1092
    import com.sulake.habbo.communication.messages.incoming.room.chat.class_184
    import com.sulake.habbo.communication.messages.incoming.room.chat.class_372
    import com.sulake.habbo.communication.messages.incoming.room.chat.class_468
    import com.sulake.habbo.communication.messages.incoming.room.chat.class_583
    import com.sulake.habbo.communication.messages.incoming.room.chat.class_758
    import com.sulake.habbo.communication.messages.incoming.room.chat.class_921
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_1000
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_1065
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_1106
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_148
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_198
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_252
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_323
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_333
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_335
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_337
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_386
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_393
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_432
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_447
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_486
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_492
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_510
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_558
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_641
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_654
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_660
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_671
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_691
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_762
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_776
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_778
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_853
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_927
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_945
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_947
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_962
    import com.sulake.habbo.communication.messages.incoming.room.furniture.class_1096
    import com.sulake.habbo.communication.messages.incoming.room.furniture.class_1110
    import com.sulake.habbo.communication.messages.incoming.room.furniture.class_161
    import com.sulake.habbo.communication.messages.incoming.room.furniture.class_276
    import com.sulake.habbo.communication.messages.incoming.room.furniture.class_434
    import com.sulake.habbo.communication.messages.incoming.room.furniture.class_460
    import com.sulake.habbo.communication.messages.incoming.room.furniture.class_462
    import com.sulake.habbo.communication.messages.incoming.room.furniture.class_597
    import com.sulake.habbo.communication.messages.incoming.room.furniture.class_620
    import com.sulake.habbo.communication.messages.incoming.room.furniture.class_629
    import com.sulake.habbo.communication.messages.incoming.room.furniture.class_637
    import com.sulake.habbo.communication.messages.incoming.room.furniture.class_708
    import com.sulake.habbo.communication.messages.incoming.room.furniture.class_710
    import com.sulake.habbo.communication.messages.incoming.room.furniture.class_730
    import com.sulake.habbo.communication.messages.incoming.room.furniture.class_810
    import com.sulake.habbo.communication.messages.incoming.room.furniture.class_818
    import com.sulake.habbo.communication.messages.incoming.room.furniture.class_844
    import com.sulake.habbo.communication.messages.incoming.room.furniture.class_878
    import com.sulake.habbo.communication.messages.incoming.room.furniture.class_919
    import com.sulake.habbo.communication.messages.incoming.room.layout.class_228
    import com.sulake.habbo.communication.messages.incoming.room.layout.class_971
    import com.sulake.habbo.communication.messages.incoming.room.permissions.class_500
    import com.sulake.habbo.communication.messages.incoming.room.permissions.class_702
    import com.sulake.habbo.communication.messages.incoming.room.permissions.class_809
    import com.sulake.habbo.communication.messages.incoming.room.pets.class_189
    import com.sulake.habbo.communication.messages.incoming.room.pets.class_263
    import com.sulake.habbo.communication.messages.incoming.room.pets.class_298
    import com.sulake.habbo.communication.messages.incoming.room.pets.class_537
    import com.sulake.habbo.communication.messages.incoming.room.pets.class_608
    import com.sulake.habbo.communication.messages.incoming.room.pets.class_613
    import com.sulake.habbo.communication.messages.incoming.room.pets.class_751
    import com.sulake.habbo.communication.messages.incoming.room.pets.class_863
    import com.sulake.habbo.communication.messages.incoming.room.pets.class_920
    import com.sulake.habbo.communication.messages.incoming.room.session.class_1027
    import com.sulake.habbo.communication.messages.incoming.room.session.class_1105
    import com.sulake.habbo.communication.messages.incoming.room.session.class_128
    import com.sulake.habbo.communication.messages.incoming.room.session.class_357
    import com.sulake.habbo.communication.messages.incoming.room.session.class_427
    import com.sulake.habbo.communication.messages.incoming.room.session.class_518
    import com.sulake.habbo.communication.messages.incoming.room.session.class_566
    import com.sulake.habbo.communication.messages.incoming.room.session.class_640
    import com.sulake.habbo.communication.messages.incoming.room.session.class_875
    import com.sulake.habbo.communication.messages.incoming.room.session.class_886
    import com.sulake.habbo.communication.messages.incoming.room.session.class_899
    import com.sulake.habbo.communication.messages.incoming.room.session.class_948
    import com.sulake.habbo.communication.messages.incoming.roomsettings.class_1032
    import com.sulake.habbo.communication.messages.incoming.roomsettings.class_1044
    import com.sulake.habbo.communication.messages.incoming.roomsettings.class_1064
    import com.sulake.habbo.communication.messages.incoming.roomsettings.class_1082
    import com.sulake.habbo.communication.messages.incoming.roomsettings.class_319
    import com.sulake.habbo.communication.messages.incoming.roomsettings.class_540
    import com.sulake.habbo.communication.messages.incoming.roomsettings.class_718
    import com.sulake.habbo.communication.messages.incoming.roomsettings.class_770
    import com.sulake.habbo.communication.messages.incoming.roomsettings.class_839
    import com.sulake.habbo.communication.messages.incoming.roomsettings.class_923
    import com.sulake.habbo.communication.messages.incoming.roomsettings.class_963
    import com.sulake.habbo.communication.messages.incoming.roomsettings.class_987
    import com.sulake.habbo.communication.messages.incoming.sound.class_1051
    import com.sulake.habbo.communication.messages.incoming.sound.class_1066
    import com.sulake.habbo.communication.messages.incoming.sound.class_1069
    import com.sulake.habbo.communication.messages.incoming.sound.class_382
    import com.sulake.habbo.communication.messages.incoming.sound.class_662
    import com.sulake.habbo.communication.messages.incoming.sound.class_747
    import com.sulake.habbo.communication.messages.incoming.sound.class_765
    import com.sulake.habbo.communication.messages.incoming.sound.class_794
    import com.sulake.habbo.communication.messages.incoming.talent.class_1107
    import com.sulake.habbo.communication.messages.incoming.talent.class_381
    import com.sulake.habbo.communication.messages.incoming.talent.class_559
    import com.sulake.habbo.communication.messages.incoming.tracking.LatencyPingResponseMessageEvent
    import com.sulake.habbo.communication.messages.incoming.userclassification.class_356
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1034
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1042
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_329
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_362
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_481
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_498
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_586
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_743
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_783
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_857
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.class_1100
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.class_158
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.class_326
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.class_353
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.class_442
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.class_657
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.class_877
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.class_905
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.class_910
    import com.sulake.habbo.communication.messages.incoming.users.GuildEditorDataMessageEvent
    import com.sulake.habbo.communication.messages.incoming.users.class_1057
    import com.sulake.habbo.communication.messages.incoming.users.class_132
    import com.sulake.habbo.communication.messages.incoming.users.class_147
    import com.sulake.habbo.communication.messages.incoming.users.class_150
    import com.sulake.habbo.communication.messages.incoming.users.class_172
    import com.sulake.habbo.communication.messages.incoming.users.class_196
    import com.sulake.habbo.communication.messages.incoming.users.class_210
    import com.sulake.habbo.communication.messages.incoming.users.class_217
    import com.sulake.habbo.communication.messages.incoming.users.class_226
    import com.sulake.habbo.communication.messages.incoming.users.class_232
    import com.sulake.habbo.communication.messages.incoming.users.class_238
    import com.sulake.habbo.communication.messages.incoming.users.class_246
    import com.sulake.habbo.communication.messages.incoming.users.class_266
    import com.sulake.habbo.communication.messages.incoming.users.class_315
    import com.sulake.habbo.communication.messages.incoming.users.class_358
    import com.sulake.habbo.communication.messages.incoming.users.class_402
    import com.sulake.habbo.communication.messages.incoming.users.class_438
    import com.sulake.habbo.communication.messages.incoming.users.class_543
    import com.sulake.habbo.communication.messages.incoming.users.class_547
    import com.sulake.habbo.communication.messages.incoming.users.class_557
    import com.sulake.habbo.communication.messages.incoming.users.class_596
    import com.sulake.habbo.communication.messages.incoming.users.class_611
    import com.sulake.habbo.communication.messages.incoming.users.class_630
    import com.sulake.habbo.communication.messages.incoming.users.class_668
    import com.sulake.habbo.communication.messages.incoming.users.class_670
    import com.sulake.habbo.communication.messages.incoming.users.class_693
    import com.sulake.habbo.communication.messages.incoming.users.class_787
    import com.sulake.habbo.communication.messages.incoming.users.class_799
    import com.sulake.habbo.communication.messages.incoming.users.class_830
    import com.sulake.habbo.communication.messages.incoming.users.class_835
    import com.sulake.habbo.communication.messages.incoming.users.class_846
    import com.sulake.habbo.communication.messages.incoming.users.class_908
    import com.sulake.habbo.communication.messages.incoming.users.class_949
    import com.sulake.habbo.communication.messages.incoming.users.class_996
    import com.sulake.habbo.communication.messages.incoming.vault.class_426
    import com.sulake.habbo.communication.messages.incoming.vault.class_564
    import com.sulake.habbo.communication.messages.incoming.vault.class_578
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
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_506
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
            _composers[1521] = class_506;
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
            _events[1] = class_1006;
            _events[1002] = class_659;
            _events[1005] = TargetedOfferEvent;
            _events[1008] = class_604;
            _events[1009] = class_1027;
            _events[1011] = class_310;
            _events[1013] = class_564;
            _events[1018] = class_796;
            _events[104] = class_574;
            _events[106] = class_1096;
            _events[1061] = class_473;
            _events[1069] = class_1032;
            _events[1076] = class_182;
            _events[1084] = class_442;
            _events[1093] = class_660;
            _events[1110] = class_265;
            _events[1118] = class_394;
            _events[1119] = class_1072;
            _events[1122] = FindFriendsProcessResultEvent;
            _events[1124] = class_232;
            _events[1128] = class_751;
            _events[1134] = class_713;
            _events[1135] = class_843;
            _events[114] = class_803;
            _events[1142] = FriendListFragmentMessageEvent;
            _events[1145] = class_410;
            _events[1154] = class_869;
            _events[1156] = class_758;
            _events[1164] = class_919;
            _events[118] = class_456;
            _events[1183] = class_746;
            _events[1196] = class_1109;
            _events[1205] = class_567;
            _events[1207] = NewFriendRequestEvent;
            _events[1209] = class_981;
            _events[1227] = class_616;
            _events[1245] = class_151;
            _events[1252] = class_784;
            _events[1254] = class_494;
            _events[1256] = class_679;
            _events[1266] = class_250;
            _events[1267] = class_1102;
            _events[1270] = class_776;
            _events[1271] = class_1051;
            _events[1278] = class_903;
            _events[1287] = class_205;
            _events[1296] = class_770;
            _events[1297] = class_721;
            _events[1299] = class_408;
            _events[1306] = class_652;
            _events[131] = class_637;
            _events[1310] = class_348;
            _events[1318] = class_189;
            _events[1330] = class_828;
            _events[134] = class_1012;
            _events[1343] = class_774;
            _events[1346] = class_278;
            _events[1349] = class_306;
            _events[137] = class_460;
            _events[1373] = class_1042;
            _events[1376] = class_535;
            _events[1395] = class_384;
            _events[1396] = class_954;
            _events[1397] = class_733;
            _events[1411] = class_790;
            _events[1412] = class_812;
            _events[1416] = class_143;
            _events[1417] = class_1103;
            _events[1419] = class_897;
            _events[1423] = class_1082;
            _events[1429] = class_799;
            _events[1432] = class_559;
            _events[1438] = class_644;
            _events[1440] = class_335;
            _events[1444] = class_786;
            _events[145] = class_533;
            _events[1454] = class_476;
            _events[146] = class_857;
            _events[1485] = class_174;
            _events[1487] = class_466;
            _events[1489] = class_795;
            _events[1492] = class_673;
            _events[1519] = class_854;
            _events[1527] = class_792;
            _events[1546] = class_837;
            _events[1552] = class_504;
            _events[1564] = class_187;
            _events[1569] = class_835;
            _events[1572] = class_654;
            _events[1575] = GuildEditorDataMessageEvent;
            _events[1578] = class_633;
            _events[1580] = class_971;
            _events[1593] = class_315;
            _events[1604] = class_459;
            _events[1623] = MessengerInitEvent;
            _events[1632] = class_184;
            _events[1646] = class_638;
            _events[1654] = class_552;
            _events[1661] = class_778;
            _events[1673] = class_1001;
            _events[1674] = class_329;
            _events[1682] = class_557;
            _events[1683] = class_794;
            _events[1699] = class_465;
            _events[1714] = Game2StopCounterMessageEvent;
            _events[1722] = class_722;
            _events[173] = class_469;
            _events[1730] = class_623;
            _events[1751] = class_327;
            _events[1753] = class_707;
            _events[1758] = class_481;
            _events[1764] = class_241;
            _events[1767] = class_918;
            _events[1772] = class_185;
            _events[1773] = class_487;
            _events[1774] = class_507;
            _events[1780] = class_1078;
            _events[1795] = class_744;
            _events[1796] = class_877;
            _events[1797] = class_867;
            _events[180] = class_284;
            _events[1819] = ConsoleMessageHistoryEvent;
            _events[1820] = class_830;
            _events[1823] = class_377;
            _events[183] = class_583;
            _events[1875] = class_162;
            _events[1879] = class_953;
            _events[1906] = class_1038;
            _events[1916] = NoobnessLevelMessageEvent;
            _events[1923] = class_910;
            _events[1928] = FriendNotificationEvent;
            _events[1940] = class_402;
            _events[1961] = class_651;
            _events[1993] = class_522;
            _events[200] = class_295;
            _events[2014] = class_326;
            _events[2016] = class_1074;
            _events[2021] = class_787;
            _events[2029] = class_226;
            _events[2034] = class_147;
            _events[2039] = class_683;
            _events[2044] = class_880;
            _events[2048] = class_898;
            _events[2049] = class_705;
            _events[2055] = class_957;
            _events[2067] = Game2UserBlockedMessageEvent;
            _events[207] = class_800;
            _events[2095] = class_1107;
            _events[2101] = class_148;
            _events[2111] = class_518;
            _events[2117] = class_222;
            _events[2130] = class_603;
            _events[2141] = class_1080;
            _events[2146] = class_175;
            _events[215] = class_296;
            _events[2152] = class_195;
            _events[2154] = class_302;
            _events[2161] = class_588;
            _events[2190] = class_128;
            _events[2193] = class_492;
            _events[2194] = class_247;
            _events[2196] = class_596;
            _events[2200] = class_676;
            _events[2210] = class_686;
            _events[2217] = class_172;
            _events[2239] = class_836;
            _events[2240] = class_597;
            _events[2258] = class_908;
            _events[226] = class_398;
            _events[2260] = class_246;
            _events[228] = Game2GameNotFoundMessageEvent;
            _events[2288] = class_745;
            _events[2308] = class_1039;
            _events[2318] = class_514;
            _events[2319] = class_237;
            _events[2323] = class_483;
            _events[2327] = class_602;
            _events[234] = class_447;
            _events[2342] = class_276;
            _events[2346] = class_615;
            _events[237] = class_894;
            _events[2376] = class_427;
            _events[2383] = class_545;
            _events[2386] = class_340;
            _events[2389] = class_423;
            _events[2405] = class_274;
            _events[2417] = class_926;
            _events[2422] = class_440;
            _events[2425] = class_549;
            _events[2429] = class_689;
            _events[2437] = class_949;
            _events[2439] = class_765;
            _events[2449] = class_149;
            _events[2455] = class_630;
            _events[2457] = class_923;
            _events[2464] = class_810;
            _events[2472] = class_537;
            _events[2474] = Game2TotalGroupLeaderboardEvent;
            _events[2495] = class_886;
            _events[2498] = class_407;
            _events[25] = class_350;
            _events[2508] = FollowFriendFailedEvent;
            _events[2514] = RoomInviteEvent;
            _events[2518] = class_1093;
            _events[2551] = class_334;
            _events[2557] = class_1021;
            _events[2559] = class_245;
            _events[2590] = class_418;
            _events[261] = class_431;
            _events[2619] = class_613;
            _events[2621] = class_1088;
            _events[2627] = class_900;
            _events[263] = class_618;
            _events[2641] = class_219;
            _events[2657] = class_920;
            _events[2661] = class_958;
            _events[2662] = class_975;
            _events[2670] = class_256;
            _events[2674] = class_1077;
            _events[2675] = class_994;
            _events[2676] = class_129;
            _events[2677] = class_220;
            _events[2680] = class_337;
            _events[2689] = class_1110;
            _events[2691] = class_965;
            _events[2709] = class_324;
            _events[2741] = class_415;
            _events[2771] = class_311;
            _events[279] = class_756; //MiniMailNewMessageEvent
            _events[2791] = class_510;
            _events[2798] = class_611;
            _events[2799] = class_566;
            _events[2802] = class_228;
            _events[2805] = class_382;
            _events[2807] = class_872;
            _events[2813] = Game2InArenaQueueMessageEvent;
            _events[2814] = class_697;
            _events[2834] = class_372;
            _events[2835] = Game2GameDirectoryStatusMessageEvent;
            _events[2843] = class_592;
            _events[2846] = class_558;
            _events[2850] = RoomAdErrorEvent;
            _events[2854] = class_1055;
            _events[2861] = class_426;
            _events[2869] = class_1064;
            _events[2875] = class_289;
            _events[2879] = class_210;
            _events[2893] = class_640;
            _events[2920] = class_767;
            _events[2923] = class_738;
            _events[2930] = class_696;
            _events[2935] = NewConsoleMessageEvent;
            _events[2936] = class_543;
            _events[2948] = class_641;
            _events[295] = WeeklyGameRewardEvent;
            _events[2957] = class_608;
            _events[2962] = class_316;
            _events[2965] = WeeklyCompetitiveFriendsLeaderboardEvent;
            _events[2969] = class_358;
            _events[297] = class_144;
            _events[2976] = class_769;
            _events[298] = class_211;
            _events[30] = class_1068;
            _events[3000] = class_1065;
            _events[3002] = class_298;
            _events[3006] = class_292;
            _events[3007] = class_323;
            _events[3011] = class_671;
            _events[3012] = class_181;
            _events[3024] = class_899;
            _events[3031] = class_718;
            _events[3037] = class_627;
            _events[3040] = class_692;
            _events[3043] = class_1100;
            _events[3048] = class_556;
            _events[3053] = class_725;
            _events[3054] = class_1067;
            _events[3059] = class_690;
            _events[3060] = class_297;
            _events[3063] = class_710;
            _events[3075] = class_691;
            _events[3077] = class_1084;
            _events[3079] = class_160;
            _events[308] = class_528;
            _events[3088] = class_948;
            _events[3097] = class_579;
            _events[3104] = class_1034;
            _events[3108] = class_712;
            _events[3113] = class_314;
            _events[3116] = class_809;
            _events[3117] = class_699;
            _events[3122] = class_333;
            _events[3125] = AcceptFriendResultEvent;
            _events[3126] = class_1090;
            _events[3129] = class_474;
            _events[3134] = class_343;
            _events[3139] = class_164;
            _events[3140] = class_386;
            _events[3158] = class_233;
            _events[316] = class_853;
            _events[3160] = class_851;
            _events[3169] = class_462;
            _events[3172] = class_590;
            _events[3187] = class_345;
            _events[3199] = class_573;
            _events[32] = class_762;
            _events[320] = class_509;
            _events[3208] = class_434;
            _events[3210] = class_936;
            _events[3214] = Game2WeeklyFriendsLeaderboardEvent;
            _events[3224] = WeeklyCompetitiveLeaderboardEvent;
            _events[3226] = class_929;
            _events[3229] = class_1104;
            _events[3230] = class_987;
            _events[3233] = class_198;
            _events[3259] = class_839;
            _events[3260] = Game2GameCancelledMessageEvent;
            _events[3262] = class_264;
            _events[327] = class_1105;
            _events[3270] = class_624;
            _events[3288] = class_258;
            _events[3299] = class_378;
            _events[33] = class_578;
            _events[3313] = FriendRequestsEvent;
            _events[3314] = class_393;
            _events[3326] = class_670;
            _events[334] = class_688;
            _events[3343] = class_829;
            _events[3348] = class_1005;
            _events[3382] = class_581;
            _events[3383] = class_1108;
            _events[3392] = Game2WeeklyLeaderboardEvent;
            _events[34] = class_454;
            _events[3405] = class_1092;
            _events[3407] = class_962;
            _events[3408] = class_747;
            _events[341] = class_150;
            _events[3410] = class_132;
            _events[3414] = class_593;
            _events[3415] = class_927;
            _events[3430] = InterstitialMessageEvent;
            _events[3437] = class_1044;
            _events[3442] = class_240;
            _events[3444] = class_158;
            _events[3447] = class_540;
            _events[3449] = AvailabilityStatusMessageEvent;
            _events[3453] = class_269;
            _events[3464] = Game2WeeklyGroupLeaderboardEvent;
            _events[3471] = HabboSearchResultEvent;
            _events[3478] = class_907;
            _events[3481] = class_404;
            _events[3490] = UserGameAchievementsMessageEvent;
            _events[3492] = class_252;
            _events[3498] = InstantMessageErrorEvent;
            _events[3502] = class_401;
            _events[3504] = class_1083;
            _events[3505] = class_818;
            _events[3506] = class_716;
            _events[351] = class_621;
            _events[3514] = class_947;
            _events[3517] = class_620;
            _events[3518] = class_782;
            _events[352] = class_538;
            _events[3523] = class_761;
            _events[3525] = class_959;
            _events[3536] = class_808;
            _events[3538] = class_438;
            _events[3550] = FurniListEvent;
            _events[3551] = class_444;
            _events[3554] = class_468;
            _events[3555] = class_883;
            _events[3573] = Game2FriendsLeaderboardEvent;
            _events[3579] = class_299;
            _events[358] = class_946;
            _events[3580] = class_819;
            _events[3581] = class_968;
            _events[3583] = class_694;
            _events[3585] = class_921;
            _events[3595] = class_379;
            _events[3598] = class_878;
            _events[3603] = class_653;
            _events[3610] = class_332;
            _events[3613] = class_319;
            _events[3619] = class_1024;
            _events[3627] = class_979;
            _events[3628] = class_811;
            _events[3633] = class_1106;
            _events[3635] = class_657;
            _events[365] = class_532;
            _events[3658] = class_364;
            _events[3661] = Game2AccountGameStatusMessageEvent;
            _events[3669] = class_988;
            _events[367] = class_743;
            _events[3675] = class_283;
            _events[3679] = class_741;
            _events[369] = class_353;
            _events[3691] = class_446;
            _events[3693] = class_685;
            _events[3696] = class_642;
            _events[3718] = class_760;
            _events[3720] = SnowWarGameTokensMessageEvent;
            _events[3722] = class_931;
            _events[3731] = class_266;
            _events[3732] = class_341;
            _events[3748] = class_612;
            _events[3758] = class_399;
            _events[3764] = class_381;
            _events[3766] = class_783;
            _events[3769] = Game2TotalLeaderboardEvent;
            _events[3774] = class_255;
            _events[3775] = class_973;
            _events[3777] = class_1060;
            _events[3778] = class_177;
            _events[3806] = class_785;
            _events[381] = class_248;
            _events[3812] = class_356;
            _events[3819] = class_695;
            _events[382] = class_432;
            _events[3825] = class_719;
            _events[3844] = class_730;
            _events[3855] = class_866;
            _events[3856] = class_307; //MiniMailUnreadCountEvent
            _events[3859] = class_662;
            _events[3874] = class_267;
            _events[3884] = WeeklyGameRewardWinnersEvent;
            _events[3892] = class_960;
            _events[3907] = class_169;
            _events[3911] = class_1000;
            _events[3915] = class_500;
            _events[3920] = class_161;
            _events[3929] = class_484;
            _events[3959] = class_548;
            _events[3960] = class_349;
            _events[3961] = class_922;
            _events[3966] = FriendListUpdateEvent;
            _events[3968] = class_983;
            _events[3974] = class_223;
            _events[3975] = class_846;
            _events[3983] = class_680;
            _events[3988] = class_254;
            _events[3994] = RoomInviteErrorEvent;
            _events[4000] = class_280;
            _events[403] = class_262;
            _events[404] = class_470;
            _events[431] = class_357;
            _events[440] = class_523;
            _events[442] = class_1019;
            _events[45] = class_541;
            _events[464] = class_1073;
            _events[472] = class_714;
            _events[473] = class_486;
            _events[481] = class_209;
            _events[497] = class_277;
            _events[502] = class_961;
            _events[517] = class_1069;
            _events[523] = class_605;
            _events[529] = class_572;
            _events[541] = class_863;
            _events[553] = class_135;
            _events[558] = class_313;
            _events[573] = class_321;
            _events[574] = class_1079;
            _events[585] = class_464;
            _events[586] = class_693;
            _events[588] = class_498;
            _events[598] = class_485;
            _events[619] = class_495;
            _events[623] = class_636;
            _events[63] = class_963;
            _events[631] = class_844;
            _events[633] = class_263;
            _events[647] = class_281;
            _events[652] = class_905;
            _events[654] = class_217;
            _events[657] = class_231;
            _events[658] = class_257;
            _events[668] = Game2JoiningGameFailedMessageEvent;
            _events[674] = class_892;
            _events[675] = class_858;
            _events[677] = class_1016;
            _events[679] = class_944;
            _events[684] = class_945;
            _events[687] = MessengerErrorEvent;
            _events[692] = class_601;
            _events[695] = class_943;
            _events[712] = class_547;
            _events[713] = class_145;
            _events[731] = class_629;
            _events[739] = class_534;
            _events[770] = class_293;
            _events[771] = class_134;
            _events[791] = class_628;
            _events[795] = Game2UserLeftGameMessageEvent;
            _events[804] = class_526;
            _events[805] = class_750;
            _events[807] = class_133;
            _events[816] = class_339;
            _events[817] = class_702;
            _events[836] = class_199;
            _events[840] = class_649;
            _events[845] = class_766;
            _events[847] = class_1066;
            _events[85] = class_895;
            _events[853] = class_668;
            _events[858] = class_875;
            _events[865] = Game2StartingGameFailedMessageEvent;
            _events[867] = class_860;
            _events[873] = Game2StartCounterMessageEvent;
            _events[878] = CallForHelpPendingCallsMessageEvent;
            _events[889] = class_196;
            _events[893] = class_362;
            _events[895] = class_491;
            _events[919] = class_996;
            _events[929] = class_140;
            _events[931] = LatencyPingResponseMessageEvent;
            _events[937] = class_1057;
            _events[939] = class_587;
            _events[965] = class_467;
            _events[968] = class_238;
            _events[972] = class_380;
            _events[975] = class_708;
            _events[996] = class_586;
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
