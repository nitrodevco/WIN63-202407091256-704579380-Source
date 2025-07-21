package com.sulake.habbo.navigator {
    import assets.class_14

    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.utils.ErrorReportStorage
    import com.sulake.core.window.IWindow
    import com.sulake.core.window.class_3400
    import com.sulake.core.window.events.WindowEvent
    import com.sulake.core.window.utils.class_3348
    import com.sulake.habbo.communication.IHabboCommunicationManager
    import com.sulake.habbo.communication.messages.incoming.competition.class_293
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListFragmentMessageEvent
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListUpdateEvent
    import com.sulake.habbo.communication.messages.incoming.game.directory.class_418
    import com.sulake.habbo.communication.messages.incoming.handshake.class_143
    import com.sulake.habbo.communication.messages.incoming.handshake.class_485
    import com.sulake.habbo.communication.messages.incoming.handshake.class_556
    import com.sulake.habbo.communication.messages.incoming.navigator.class_1038
    import com.sulake.habbo.communication.messages.incoming.navigator.class_1079
    import com.sulake.habbo.communication.messages.incoming.navigator.class_129
    import com.sulake.habbo.communication.messages.incoming.navigator.class_1675
    import com.sulake.habbo.communication.messages.incoming.navigator.class_1727
    import com.sulake.habbo.communication.messages.incoming.navigator.class_1742
    import com.sulake.habbo.communication.messages.incoming.navigator.class_296
    import com.sulake.habbo.communication.messages.incoming.navigator.class_454
    import com.sulake.habbo.communication.messages.incoming.navigator.class_467
    import com.sulake.habbo.communication.messages.incoming.navigator.class_487
    import com.sulake.habbo.communication.messages.incoming.navigator.class_491
    import com.sulake.habbo.communication.messages.incoming.navigator.class_526
    import com.sulake.habbo.communication.messages.incoming.navigator.class_534
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
    import com.sulake.habbo.communication.messages.incoming.room.chat.class_583
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_510
    import com.sulake.habbo.communication.messages.incoming.room.session.class_128
    import com.sulake.habbo.communication.messages.incoming.room.session.class_357
    import com.sulake.habbo.communication.messages.incoming.room.session.class_640
    import com.sulake.habbo.communication.messages.incoming.room.session.class_875
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
    import com.sulake.habbo.communication.messages.incoming.users.class_1057
    import com.sulake.habbo.communication.messages.outgoing.friendlist.FollowFriendMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_553
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_831
    import com.sulake.habbo.communication.messages.outgoing.navigator.class_998
    import com.sulake.habbo.communication.messages.outgoing.room.session.class_325
    import com.sulake.habbo.communication.messages.parser.handshake.class_1267
    import com.sulake.habbo.communication.messages.parser.navigator.class_1129
    import com.sulake.habbo.communication.messages.parser.navigator.RoomSettingsDataEvent
    import com.sulake.habbo.communication.messages.parser.navigator.class_1157
    import com.sulake.habbo.communication.messages.parser.navigator.class_1180
    import com.sulake.habbo.communication.messages.parser.navigator.class_1266
    import com.sulake.habbo.communication.messages.parser.navigator.class_1349
    import com.sulake.habbo.communication.messages.parser.navigator.class_1368
    import com.sulake.habbo.communication.messages.parser.navigator.class_1377
    import com.sulake.habbo.communication.messages.parser.navigator.class_1388
    import com.sulake.habbo.communication.messages.parser.navigator.class_1446
    import com.sulake.habbo.communication.messages.parser.navigator.class_1468
    import com.sulake.habbo.communication.messages.parser.navigator.class_1483
    import com.sulake.habbo.communication.messages.parser.navigator.class_1523
    import com.sulake.habbo.communication.messages.parser.navigator.class_1539
    import com.sulake.habbo.communication.messages.parser.navigator.class_1588
    import com.sulake.habbo.communication.messages.parser.navigator.class_1616
    import com.sulake.habbo.communication.messages.parser.room.chat.class_1253
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1339
    import com.sulake.habbo.communication.messages.parser.room.session.class_1208
    import com.sulake.habbo.communication.messages.parser.room.session.class_1428
    import com.sulake.habbo.communication.messages.parser.room.session.class_1515
    import com.sulake.habbo.communication.messages.parser.roomsettings.class_1120
    import com.sulake.habbo.communication.messages.parser.roomsettings.class_1185
    import com.sulake.habbo.communication.messages.parser.roomsettings.class_1204
    import com.sulake.habbo.communication.messages.parser.roomsettings.class_1293
    import com.sulake.habbo.communication.messages.parser.roomsettings.class_1296
    import com.sulake.habbo.communication.messages.parser.roomsettings.class_1374
    import com.sulake.habbo.communication.messages.parser.roomsettings.class_1399
    import com.sulake.habbo.communication.messages.parser.roomsettings.class_1417
    import com.sulake.habbo.communication.messages.parser.roomsettings.class_1429
    import com.sulake.habbo.communication.messages.parser.roomsettings.class_1514
    import com.sulake.habbo.communication.messages.parser.roomsettings.class_1587
    import com.sulake.habbo.communication.messages.parser.users.class_1359
    import com.sulake.habbo.configuration.enum.HabboComponentFlags
    import com.sulake.habbo.navigator.domain.NavigatorData
    import com.sulake.habbo.navigator.domain.RoomSessionTags
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.RoomsTabPageDecorator
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent
    import com.sulake.habbo.utils.HabboWebTools

    [SecureSWF(rename="true")]
    public class IncomingMessages {

        private var _navigator: HabboNavigator;

        public function IncomingMessages(param1: HabboNavigator) {
            super();
            _navigator = param1;
            var communication: IHabboCommunicationManager = _navigator.communication;
            communication.addHabboConnectionMessageEvent(new class_750(onRoomEventCancel));
            communication.addHabboConnectionMessageEvent(new class_923(onBannedUsersFromRoom));
            communication.addHabboConnectionMessageEvent(new class_1064(onUserUnbannedFromRoom));
            communication.addHabboConnectionMessageEvent(new class_510(onRoomEnter));
            communication.addHabboConnectionMessageEvent(new class_605(onUserFlatCats));
            communication.addHabboConnectionMessageEvent(new class_936(onPopularRoomTagsResult));
            communication.addHabboConnectionMessageEvent(new class_718(onFlatControllers));
            communication.addHabboConnectionMessageEvent(new class_746(onRoomRating));
            communication.addHabboConnectionMessageEvent(new class_296(onOfficialRooms));
            communication.addHabboConnectionMessageEvent(new class_128(onRoomForward));
            communication.addHabboConnectionMessageEvent(new class_583(onRoomFilterSettings));
            communication.addHabboConnectionMessageEvent(new FriendListUpdateEvent(onFriendListUpdate));
            communication.addHabboConnectionMessageEvent(new FriendListFragmentMessageEvent(onFriendsListFragment));
            communication.addHabboConnectionMessageEvent(new class_770(onRoomSettingsData));
            communication.addHabboConnectionMessageEvent(new class_467(onCategoriesWithUserCount));
            communication.addHabboConnectionMessageEvent(new class_526(onUserEventCats));
            communication.addHabboConnectionMessageEvent(new class_319(onRoomSettingsError));
            communication.addHabboConnectionMessageEvent(new class_898(onRoomInfo));
            communication.addHabboConnectionMessageEvent(new class_640(onRoomExit));
            communication.addHabboConnectionMessageEvent(new class_839(onFlatControllerRemoved));
            communication.addHabboConnectionMessageEvent(new class_418(onGameStarted));
            communication.addHabboConnectionMessageEvent(new class_1038(onFlatAccessDenied));
            communication.addHabboConnectionMessageEvent(new class_540(onRoomSettingsSaved));
            communication.addHabboConnectionMessageEvent(new class_987(onRoomSettingsSaveError));
            communication.addHabboConnectionMessageEvent(new class_1082(onNoSuchFlat));
            communication.addHabboConnectionMessageEvent(new class_491(onNavigatorSettings));
            communication.addHabboConnectionMessageEvent(new class_454(onGuestRoomSearchResult));
            communication.addHabboConnectionMessageEvent(new class_837(onDoorbell));
            communication.addHabboConnectionMessageEvent(new class_1044(onFlatControllerAdded));
            communication.addHabboConnectionMessageEvent(new class_979(onCanCreateRoom));
            communication.addHabboConnectionMessageEvent(new class_556(onUserObject));
            communication.addHabboConnectionMessageEvent(new class_1079(onConvertedRoomId));
            communication.addHabboConnectionMessageEvent(new class_875(onCantConnect));
            communication.addHabboConnectionMessageEvent(new class_722(onCanCreateRoomEventEvent));
            communication.addHabboConnectionMessageEvent(new class_485(onError));
            communication.addHabboConnectionMessageEvent(new class_129(onFavourites));
            communication.addHabboConnectionMessageEvent(new class_627(onRoomEventEvent));
            communication.addHabboConnectionMessageEvent(new class_534(onCompetitionData));
            communication.addHabboConnectionMessageEvent(new class_143(onUserRights));
            communication.addHabboConnectionMessageEvent(new class_1032(onEnforceRoomCategorySelection));
            communication.addHabboConnectionMessageEvent(new class_357(onDoorOpened));
            communication.addHabboConnectionMessageEvent(new class_795(onFlatCreated));
            communication.addHabboConnectionMessageEvent(new class_1057(onSubscriptionInfo));
            communication.addHabboConnectionMessageEvent(new class_487(onRoomInfoUpdated));
            communication.addHabboConnectionMessageEvent(new class_963(onMuteAllEvent));
            communication.addHabboConnectionMessageEvent(new class_761(onFavouriteChanged));
            communication.addHabboConnectionMessageEvent(new class_293(onNoOwnedRoomsAlert));
        }

        public function get data(): NavigatorData {
            return _navigator.data;
        }

        private function onMuteAllEvent(param1: IMessageEvent): void {
            var _loc4_: class_963;
            var _loc3_: class_1374 = (_loc4_ = param1 as class_963).getParser();
            var _loc2_: class_1675 = _navigator.data.enteredGuestRoom;
            if (_loc2_ != null) {
                _loc2_.allInRoomMuted = _loc3_.allMuted;
                if (_navigator.roomInfoViewCtrl != null) {
                    _navigator.roomInfoViewCtrl.refreshButtons(_navigator.data.enteredGuestRoom);
                }
            }
        }

        private function onNoSuchFlat(param1: IMessageEvent): void {
        }

        private function onUserObject(param1: IMessageEvent): void {
            var _loc2_: class_1267 = class_556(param1).getParser();
            data.avatarId = _loc2_.id;
            _navigator.send(new class_831());
            _navigator.send(new class_998());
        }

        private function onUserRights(param1: IMessageEvent): void {
            var _loc2_: class_143 = class_143(param1);
            if (_loc2_.securityLevel >= 5) {
                _navigator.data.eventMod = true;
            }
            if (_loc2_.securityLevel >= 7) {
                _navigator.data.roomPicker = true;
            }
        }

        private function onCategoriesWithUserCount(param1: IMessageEvent): void {
            var _loc2_: class_1388 = class_467(param1).getParser();
            data.categoriesWithVisitorData = _loc2_.data;
            class_14.log("Received Categories with user count: " + data.categoriesWithVisitorData.categoryToCurrentUserCountMap.length);
        }

        private function onOfficialRooms(param1: IMessageEvent): void {
            var _loc2_: class_1368 = class_296(param1).getParser();
            data.officialRooms = _loc2_.data;
            data.adRoom = _loc2_.adRoom;
            data.promotedRooms = _loc2_.promotedRooms;
            class_14.log("Received Official rooms: " + data.officialRooms.entries.length);
        }

        private function onGuestRoomSearchResult(param1: IMessageEvent): void {
            var _loc2_: class_1742 = class_454(param1).getParser().data;
            data.guestRoomSearchResults = _loc2_;
            class_14.log("Received GuestRoomSearch: " + data.guestRoomSearchResults.rooms.length);
        }

        private function onPopularRoomTagsResult(param1: IMessageEvent): void {
            var _loc2_: class_1727 = class_936(param1).getParser().data;
            data.popularTags = _loc2_;
            class_14.log("Received popular room tags: " + data.popularTags.tags.length);
        }

        private function onRoomEventEvent(param1: IMessageEvent): void {
            var _loc2_: class_1157 = class_627(param1).getParser();
            class_14.log("Got room event: " + _loc2_.data.ownerAvatarId + ", " + _loc2_.data.eventName);
            data.roomEventData = _loc2_.data.ownerAvatarId > 0 ? _loc2_.data : null;
            _navigator.roomEventInfoCtrl.refresh();
        }

        private function onRoomEventCancel(param1: IMessageEvent): void {
            data.roomEventData = null;
            _navigator.roomEventInfoCtrl.refresh();
        }

        private function onCanCreateRoomEventEvent(param1: IMessageEvent): void {
            var _loc3_: SimpleAlertView = null;
            var _loc2_: class_1349 = class_722(param1).getParser();
            class_14.log("CAN CREATE EVENT: " + _loc2_.canCreateEvent);
            if (_loc2_.canCreateEvent) {
                _navigator.roomEventViewCtrl.show();
            } else {
                _loc3_ = new SimpleAlertView(_navigator, "${navigator.cannotcreateevent.title}", "${navigator.cannotcreateevent.error." + _loc2_.errorCode + "}");
                _loc3_.show();
                class_14.log("Cannot create an event just now...");
            }
        }

        private function onRoomEnter(param1: IMessageEvent): void {
            var _loc2_: class_1339 = class_510(param1).getParser();
            class_14.log("Navigator: entering room");
            data.onRoomEnter(_loc2_);
            closeOpenCantConnectAlerts();
            _navigator.roomInfoViewCtrl.close();
            _navigator.send(new class_553(_loc2_.guestRoomId, true, false));
            class_14.log("Sent get guest room...");
            _navigator.roomEventInfoCtrl.refresh();
            _navigator.roomEventViewCtrl.close();
            _navigator.roomSettingsCtrl.close();
            _navigator.roomFilterCtrl.close();
            HabboWebTools.closeNews();
        }

        private function onRoomInfo(param1: IMessageEvent): void {
            var _loc3_: * = false;
            var _loc4_: RoomSessionTags = null;
            var _loc2_: RoomSettingsDataEvent = class_898(param1).getParser();
            class_14.log("Got room info: " + _loc2_.enterRoom + ", " + _loc2_.roomForward);
            if (_loc2_.enterRoom) {
                data.enteredRoom = _loc2_.data;
                data.currentRoomIsStaffPick = _loc2_.staffPick;
                _loc3_ = data.createdFlatId == _loc2_.data.flatId;
                if (!_loc3_ && _loc2_.data.displayRoomEntryAd) {
                    requestRoomEnterAd();
                }
                data.createdFlatId = 0;
                if (data.enteredGuestRoom != null && data.enteredGuestRoom.habboGroupId > 0) {
                    _navigator.roomEventInfoCtrl.expanded = false;
                    _navigator.roomEventInfoCtrl.refresh();
                }
                if ((_loc4_ = _navigator.data.getAndResetSessionTags()) != null) {
                    _navigator.send(_loc4_.getMsg());
                }
            } else if (_loc2_.roomForward) {
                if (_loc2_.data.doorMode == 1 && (_navigator.sessionData.userName != _loc2_.data.ownerName && _loc2_.isGroupMember == false)) {
                    _navigator.doorbell.show(_loc2_.data);
                } else if (_loc2_.data.doorMode == 2 && (_navigator.sessionData.userName != _loc2_.data.ownerName && _loc2_.isGroupMember == false)) {
                    _navigator.passwordInput.show(_loc2_.data);
                } else {
                    if (_loc2_.data.doorMode == 4 && !_navigator.sessionData.isAmbassador && !_navigator.sessionData.isRealNoob && !_navigator.sessionData.isAnyRoomController) {
                        return;
                    }
                    _navigator.goToRoom(_loc2_.data.flatId, false);
                }
            } else {
                data.enteredRoom = _loc2_.data;
                data.currentRoomIsStaffPick = _loc2_.staffPick;
                _navigator.roomInfoViewCtrl.reload();
            }
        }

        private function requestRoomEnterAd(): void {
            if (_navigator.getProperty("roomenterad.habblet.enabled") == "true") {
                HabboWebTools.openRoomEnterAd();
            }
        }

        private function onFlatCreated(param1: IMessageEvent): void {
            var _loc2_: class_1616 = class_795(param1).getParser();
            ErrorReportStorage.addDebugData("IncomingEvent", "Flat created: " + _loc2_.flatId + ", " + _loc2_.flatName);
            data.createdFlatId = _loc2_.flatId;
            _navigator.goToRoom(_loc2_.flatId, true);
            _navigator.mainViewCtrl.reloadRoomList(5);
            _navigator.goToMainView();
            _navigator.closeNavigator();
        }

        private function onGameStarted(param1: IMessageEvent): void {
            _navigator.mainViewCtrl.close();
        }

        private function onSubscriptionInfo(param1: IMessageEvent): void {
            var _loc2_: class_1359 = class_1057(param1).getParser();
            class_14.log("Got subscription info: " + _loc2_.productName + ", " + _loc2_.daysToPeriodEnd + ", " + _loc2_.memberPeriods + ", " + _loc2_.periodsSubscribedAhead + ", " + _loc2_.responseType);
            data.hcMember = _loc2_.daysToPeriodEnd > 0;
        }

        private function onRoomForward(param1: IMessageEvent): void {
            var _loc2_: class_1208 = class_128(param1).getParser();
            class_14.log("Got room forward: " + _loc2_.roomId);
            forwardToRoom(_loc2_.roomId);
        }

        private function onConvertedRoomId(param1: IMessageEvent): void {
            var _loc2_: class_1180 = class_1079(param1).getParser();
            if (_navigator.webRoomReport) {
                _navigator.habboHelp.reportRoom(_loc2_.convertedId, _navigator.webRoomReportedName, "");
            } else {
                class_14.log("Got converted room ID for " + _loc2_.globalId + ", forward to room " + _loc2_.convertedId);
                forwardToRoom(_loc2_.convertedId);
            }
        }

        private function onNavigatorSettings(param1: IMessageEvent): void {
            var _loc6_: Boolean = false;
            var _loc4_: * = false;
            var _loc7_: int = 0;
            var _loc5_: Boolean = false;
            var _loc2_: class_1266 = class_491(param1).getParser();
            class_14.log("Got navigator settings: " + _loc2_.homeRoomId);
            var _loc3_: * = !_navigator.data.settingsReceived;
            _navigator.data.homeRoomId = _loc2_.homeRoomId;
            _navigator.data.settingsReceived = true;
            _navigator.mainViewCtrl.refresh();
            var _loc8_: int = -1;
            var _loc9_: int = -1;
            if (_loc3_ && !HabboComponentFlags.isRoomViewerMode(_navigator.flags)) {
                _loc6_ = false;
                _loc4_ = false;
                if (_navigator.propertyExists("friend.id")) {
                    _loc8_ = 0;
                    _navigator.send(new FollowFriendMessageComposer(int(_navigator.getProperty("friend.id"))));
                }
                if (_navigator.propertyExists("forward.type") && _navigator.propertyExists("forward.id")) {
                    _loc8_ = int(_navigator.getProperty("forward.type"));
                    _loc9_ = int(_navigator.getProperty("forward.id"));
                }
                _loc4_ = _loc2_.roomIdToEnter <= 0;
                if (_loc8_ == 2) {
                    class_14.log("Guest room forward on enter: " + _loc9_);
                    forwardToRoom(_loc9_);
                } else if (_loc8_ == -1) {
                    if (!_loc4_) {
                        if ((_loc7_ = _loc2_.roomIdToEnter) != _navigator.data.homeRoomId) {
                            this._navigator.goToRoom(_loc7_, true);
                        } else if (!(_loc5_ = this._navigator.goToHomeRoom())) {
                            _loc6_ = true;
                        }
                    }
                }
                if (_loc6_ && !_navigator.mainViewCtrl.isOpen()) {
                    _navigator.mainViewCtrl.onNavigatorToolBarIconClick();
                }
            } else {
                _navigator.roomInfoViewCtrl.reload();
            }
        }

        private function onRoomExit(param1: IMessageEvent): void {
            class_14.log("Navigator: exiting room");
            data.onRoomExit();
            _navigator.roomInfoViewCtrl.close();
            _navigator.roomEventInfoCtrl.close();
            _navigator.roomEventViewCtrl.close();
            _navigator.roomSettingsCtrl.close();
            _navigator.roomFilterCtrl.close();
            var _loc2_: Boolean = _navigator.getBoolean("news.auto_popup.enabled");
            if (_loc2_) {
                HabboWebTools.openNews();
            }
        }

        private function onUserFlatCats(param1: IMessageEvent): void {
            var _loc3_: class_1377 = (param1 as class_605).getParser();
            _navigator.data.categories = _loc3_.nodes;
            var _loc2_: RoomsTabPageDecorator = RoomsTabPageDecorator(_navigator.tabs.getTab(2).tabPageDecorator);
            _loc2_.prepareRoomCategories();
        }

        private function onUserEventCats(param1: IMessageEvent): void {
            var _loc2_: class_1129 = (param1 as class_526).getParser();
            _navigator.data.eventCategories = _loc2_.eventCategories;
        }

        private function onRoomSettingsData(param1: IMessageEvent): void {
            var _loc2_: class_1120 = null;
            try {
                _loc2_ = (param1 as class_770).getParser();
                _navigator.roomSettingsCtrl.onRoomSettings(_loc2_.data);
                class_14.log("GOT ROOM SETTINGS DATA: " + _loc2_.data.name + ", " + _loc2_.data.maximumVisitors + ", " + _loc2_.data.maximumVisitorsLimit);
            } catch (e: Error) {
                class_14.log("CRASHED WHILE PROCESSING ROOM SETTINGS DATA!");
            }
        }

        private function onRoomFilterSettings(param1: IMessageEvent): void {
            var _loc2_: class_1253 = (param1 as class_583).getParser();
            _navigator.roomFilterCtrl.onRoomFilterSettings(_loc2_.badWords);
            class_14.log("GOT ROOM FILTER SETTINGS: " + _loc2_.badWords);
        }

        private function onRoomSettingsError(param1: IMessageEvent): void {
            var _loc2_: class_1296 = (param1 as class_319).getParser();
        }

        private function onRoomSettingsSaved(param1: IMessageEvent): void {
            var _loc2_: class_1514 = (param1 as class_540).getParser();
            ErrorReportStorage.addDebugData("IncomingEvent", "Room settings saved: " + _loc2_.roomId);
            _navigator.mainViewCtrl.reloadRoomList(5);
        }

        private function onRoomSettingsSaveError(param1: IMessageEvent): void {
            var _loc2_: class_1204 = (param1 as class_987).getParser();
            _navigator.roomSettingsCtrl.onRoomSettingsSaveError(_loc2_.roomId, _loc2_.errorCode, _loc2_.info);
        }

        private function onRoomInfoUpdated(param1: IMessageEvent): void {
            var _loc2_: class_1468 = (param1 as class_487).getParser();
            class_14.log("ROOM UPDATED: " + _loc2_.flatId);
            _navigator.send(new class_553(_loc2_.flatId, false, false));
        }

        private function onFavourites(param1: IMessageEvent): void {
            var _loc2_: class_1588 = (param1 as class_129).getParser();
            _navigator.data.onFavourites(_loc2_);
        }

        private function onFavouriteChanged(param1: IMessageEvent): void {
            var _loc2_: class_1446 = (param1 as class_761).getParser();
            class_14.log("Received favourite changed: " + _loc2_.flatId + ", " + _loc2_.added);
            _navigator.data.favouriteChanged(_loc2_.flatId, _loc2_.added);
            _navigator.roomInfoViewCtrl.reload();
            _navigator.mainViewCtrl.refresh();
        }

        private function onCanCreateRoom(param1: IMessageEvent): void {
            var _loc2_: AlertView = null;
            var _loc3_: class_1483 = (param1 as class_979).getParser();
            class_14.log("Can create room: " + _loc3_.resultCode + ", " + _loc3_.roomLimit);
            if (_loc3_.resultCode == 0) {
                _navigator.roomCreateViewCtrl.show();
            } else {
                _navigator.registerParameter("navigator.createroom.limitreached", "limit", "" + _loc3_.roomLimit);
                if (_navigator.sessionData.hasVip) {
                    _loc2_ = new SimpleAlertView(_navigator, "${navigator.createroom.error}", "${navigator.createroom.limitreached}");
                } else {
                    _loc2_ = new ClubPromoAlertView(_navigator, "${navigator.createroom.error}", "${navigator.createroom.limitreached}", "${navigator.createroom.vippromo}");
                }
                _loc2_.show();
            }
        }

        private function onFlatControllers(param1: IMessageEvent): void {
            var _loc2_: class_1185 = (param1 as class_718).getParser();
            class_14.log("Got flat controllers: " + _loc2_.roomId + ", " + _loc2_.controllers.length);
            _navigator.roomSettingsCtrl.onFlatControllers(_loc2_.roomId, _loc2_.controllers);
        }

        private function onFlatControllerAdded(param1: IMessageEvent): void {
            var _loc2_: class_1399 = (param1 as class_1044).getParser();
            class_14.log("Flat controller added: " + _loc2_.flatId + ", " + _loc2_.data.userId + ", " + _loc2_.data.userName);
            _navigator.roomSettingsCtrl.onFlatControllerAdded(_loc2_.flatId, _loc2_.data);
        }

        private function onFlatControllerRemoved(param1: IMessageEvent): void {
            var _loc2_: class_1293 = (param1 as class_839).getParser();
            class_14.log("Flat controller removed: " + _loc2_.flatId + ", " + _loc2_.userId);
            _navigator.roomSettingsCtrl.onFlatControllerRemoved(_loc2_.flatId, _loc2_.userId);
        }

        private function onBannedUsersFromRoom(param1: IMessageEvent): void {
            var _loc2_: class_1429 = (param1 as class_923).getParser();
            class_14.log("Got Banned users for room: " + _loc2_.roomId + ", " + _loc2_.bannedUsers.length);
            _navigator.roomSettingsCtrl.onBannedUsersFromRoom(_loc2_.roomId, _loc2_.bannedUsers);
        }

        private function onUserUnbannedFromRoom(param1: IMessageEvent): void {
            var _loc2_: class_1417 = (param1 as class_1064).getParser();
            class_14.log("User was unbanned from room. User Id: " + _loc2_.userId + " Room Id: " + _loc2_.roomId);
            _navigator.roomSettingsCtrl.onUserUnbannedFromRoom(_loc2_.roomId, _loc2_.userId);
        }

        private function onError(param1: IMessageEvent): void {
            var event: IMessageEvent = param1;
            var error: class_485 = event as class_485;
            if (error == null) {
                return;
            }
            switch (error.getParser().errorCode) {
                case -100002:
                    _navigator.passwordInput.showRetry();
                    break;
                case 4009:
                    _navigator.windowManager.alert("${generic.alert.title}", "${navigator.alert.need.to.be.vip}", 0, function (param1: class_3348, param2: WindowEvent): void {
                        param1.dispose();
                    });
                    break;
                case 4010:
                    _navigator.windowManager.alert("${generic.alert.title}", "${navigator.alert.invalid_room_name}", 0, function (param1: class_3348, param2: WindowEvent): void {
                        param1.dispose();
                    });
                    break;
                case 4011:
                    _navigator.windowManager.alert("${generic.alert.title}", "${navigator.alert.cannot_perm_ban}", 0, function (param1: class_3348, param2: WindowEvent): void {
                        param1.dispose();
                    });
                    break;
                case 4013:
                    _navigator.windowManager.alert("${generic.alert.title}", "${navigator.alert.room_in_maintenance}", 0, function (param1: class_3348, param2: WindowEvent): void {
                        param1.dispose();
                    });
                    break;
                case -100005:
                    _navigator.windowManager.alert("${generic.alert.title}", "${notification.nft_token_required}", 0, function (param1: class_3348, param2: WindowEvent): void {
                        param1.dispose();
                    });
            }
        }

        private function onDoorbell(param1: IMessageEvent): void {
            var _loc2_: class_837 = param1 as class_837;
            if (_loc2_ == null) {
                return;
            }
            if (_loc2_.userName != "") {
                return;
            }
            _navigator.doorbell.showWaiting();
        }

        private function onDoorOpened(param1: IMessageEvent): void {
            var _loc3_: class_357 = param1 as class_357;
            if (_loc3_ == null) {
                return;
            }
            var _loc2_: class_1515 = _loc3_.getParser();
            if (_loc2_ != null && (_loc2_.userName == null || _loc2_.userName.length == 0)) {
                _navigator.doorbell.hide();
            }
        }

        private function onRoomRating(param1: IMessageEvent): void {
            var _loc2_: class_1523 = (param1 as class_746).getParser();
            _navigator.data.currentRoomRating = _loc2_.rating;
            _navigator.data.canRate = _loc2_.canRate;
            this._navigator.roomInfoViewCtrl.reload();
        }

        private function onFlatAccessDenied(param1: IMessageEvent): void {
            var _loc2_: class_1539 = (param1 as class_1038).getParser();
            if (_loc2_.userName == null || _loc2_.userName == "") {
                _navigator.doorbell.showNoAnswer();
            }
        }

        private function onFriendsListFragment(param1: IMessageEvent): void {
            _navigator.data.friendList.onFriendsListFragment(param1);
        }

        private function onFriendListUpdate(param1: IMessageEvent): void {
            _navigator.data.friendList.onFriendListUpdate(param1);
            _navigator.roomSettingsCtrl.onFriendListUpdate();
        }

        private function onCompetitionData(param1: class_534): void {
            _navigator.data.competitionRoomsData = param1.getParser().data;
        }

        private function forwardToRoom(param1: int): void {
            _navigator.send(new class_553(param1, false, true));
            _navigator.trackNavigationDataPoint("Room Forward", "go.roomforward", "", param1);
        }

        private function onNoOwnedRoomsAlert(param1: class_293): void {
            _navigator.startRoomCreation();
        }

        private function closeOpenCantConnectAlerts(): void {
            var _loc1_: Array = null;
            var _loc7_: class_3400 = null;
            var _loc4_: int = 0;
            var _loc5_: int = 0;
            var _loc6_: IWindow = null;
            var _loc3_: AlertView = null;
            if (_navigator != null) {
                _loc1_ = [];
                _loc4_ = int((_loc7_ = _navigator.windowManager.getWindowContext(2)).getDesktopWindow().numChildren);
                _loc5_ = 0;
                while (_loc5_ < _loc4_) {
                    if ((_loc6_ = _loc7_.getDesktopWindow().getChildAt(_loc5_)).tags.indexOf("SimpleAlertView") > -1) {
                        _loc1_.push(_loc6_);
                    }
                    _loc5_++;
                }
                if (_loc1_.length > 0) {
                    for each(var _loc2_ in _loc1_) {
                        _loc3_ = AlertView.findAlertView(_loc2_);
                        if (_loc3_ != null) {
                            _loc3_.dispose();
                        }
                    }
                }
            }
        }

        private function onCantConnect(param1: IMessageEvent): void {
            var _loc2_: SimpleAlertView = null;
            var _loc3_: class_1428 = (param1 as class_875).getParser();
            class_14.log("FAILED TO CONNECT: REASON: " + _loc3_.reason);
            switch (_loc3_.reason - 1) {
                case 0:
                    _loc2_ = new SimpleAlertView(_navigator, "${navigator.guestroomfull.title}", "${navigator.guestroomfull.text}");
                    _loc2_.show();
                    break;
                case 2:
                    _loc2_ = new SimpleAlertView(_navigator, "${room.queue.error.title}", "${room.queue.error." + _loc3_.parameter + "}");
                    _loc2_.show();
                    break;
                case 3:
                    _loc2_ = new SimpleAlertView(_navigator, "${navigator.banned.title}", "${navigator.banned.text}");
                    _loc2_.show();
                    break;
                default:
                    _loc2_ = new SimpleAlertView(_navigator, "${room.queue.error.title}", "${room.queue.error.title}");
                    _loc2_.show();
            }
            _navigator.send(new class_325());
            var _loc4_: HabboToolbarEvent;
            (_loc4_ = new HabboToolbarEvent("HTE_TOOLBAR_CLICK")).iconId = "HTIE_ICON_RECEPTION";
            _navigator.toolbar.events.dispatchEvent(_loc4_);
        }

        private function onEnforceRoomCategorySelection(param1: IMessageEvent): void {
            var _loc2_: class_1587 = (param1 as class_1032).getParser();
            _navigator.enforceCategoryCtrl.show(_loc2_.selectionType);
        }
    }
}
