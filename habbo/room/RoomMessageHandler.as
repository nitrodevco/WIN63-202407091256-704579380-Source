package com.sulake.habbo.room {
   import com.sulake.core.communication.connection.IConnection
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.communication.messages.IMessageEvent
   import com.sulake.core.window.events.WindowEvent
   import com.sulake.core.window.utils.class_3441
   import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent
   import com.sulake.habbo.communication.messages.incoming.help.GuideSessionErrorMessageEvent
   import com.sulake.habbo.communication.messages.incoming.help.GuideSessionStartedMessageEvent
   import com.sulake.habbo.communication.messages.incoming.help.GuideSessionEndedMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.action.SleepMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.action.DanceMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.action.CarryObjectMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.action.ExpressionMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.action.AvatarEffectMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.action.UseObjectMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.chat.UserTypingMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.chat.ChatMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.chat.WhisperMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.chat.ShoutMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.engine.UserUpdateMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.engine.WiredMovementsMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomPropertyMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.engine.ItemUpdateMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_1668
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_1693
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_1710
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_1721
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_1753
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_1765
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_1766
   import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectRemoveMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.engine.HeightMapMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectDataUpdateMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectAddMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.engine.SpecialRoomEffectMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.engine.UserChangeMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.engine.BuildersClubPlacementWarningMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectRemoveConfirmMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.engine.FurnitureAliasesMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectsDataUpdateMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.engine.UserRemoveMessageEvent
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
   import com.sulake.habbo.communication.messages.incoming.room.furniture.DiceValueMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.furniture.AreaHideMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.furniture.OneWayDoorStatusMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.layout.RoomEntryTileMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.pets.PetExperienceEvent
   import com.sulake.habbo.communication.messages.incoming.room.pets.PetFigureUpdateEvent
   import com.sulake.habbo.communication.messages.incoming.room.session.HanditemConfigurationMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.session.GamePlayerValueMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.session.YouAreNotSpectatorMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.session.YouArePlayingGameMessageEvent
   import com.sulake.habbo.communication.messages.incoming.room.session.RoomReadyMessageEvent
   import com.sulake.habbo.communication.messages.incoming.users.IgnoreResultMessageEvent
   import com.sulake.habbo.communication.messages.outgoing.catalog.class_270
   import com.sulake.habbo.communication.messages.outgoing.catalog.class_852
   import com.sulake.habbo.communication.messages.outgoing.room.engine.class_216
   import com.sulake.habbo.communication.messages.outgoing.room.engine.class_645
   import com.sulake.habbo.communication.messages.outgoing.room.engine.class_865
   import com.sulake.habbo.communication.messages.parser.handshake.class_1267
   import com.sulake.habbo.communication.messages.parser.help.class_1464
   import com.sulake.habbo.communication.messages.parser.room.action.class_1140
   import com.sulake.habbo.communication.messages.parser.room.action.class_1175
   import com.sulake.habbo.communication.messages.parser.room.action.class_1292
   import com.sulake.habbo.communication.messages.parser.room.action.class_1386
   import com.sulake.habbo.communication.messages.parser.room.action.class_1620
   import com.sulake.habbo.communication.messages.parser.room.action.class_1625
   import com.sulake.habbo.communication.messages.parser.room.chat.class_1344
   import com.sulake.habbo.communication.messages.parser.room.chat.class_1489
   import com.sulake.habbo.communication.messages.parser.room.engine.AreaHideMessageData
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1176
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1214
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1221
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1226
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1227
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1280
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1304
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1319
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1326
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1329
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1333
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1341
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1365
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1376
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1391
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1412
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1424
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1432
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1437
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1465
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1471
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1526
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1529
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1548
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1570
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1612
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1624
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1629
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1655
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1676
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1690
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1761
   import com.sulake.habbo.communication.messages.parser.room.furniture.class_1168
   import com.sulake.habbo.communication.messages.parser.room.furniture.class_1397
   import com.sulake.habbo.communication.messages.parser.room.furniture.class_1508
   import com.sulake.habbo.communication.messages.parser.room.layout.class_1609
   import com.sulake.habbo.communication.messages.parser.room.pets.class_1310
   import com.sulake.habbo.communication.messages.parser.room.pets.class_1369
   import com.sulake.habbo.communication.messages.parser.room.session.class_1207
   import com.sulake.habbo.communication.messages.parser.room.session.class_1298
   import com.sulake.habbo.communication.messages.parser.room.session.class_1441
   import com.sulake.habbo.communication.messages.parser.room.session.class_1510
   import com.sulake.habbo.communication.messages.parser.room.session.class_1524
   import com.sulake.habbo.room.events.RoomEngineZoomEvent
   import com.sulake.habbo.room.object.RoomObjectUserTypes
   import com.sulake.habbo.room.object.RoomPlaneParser
   import com.sulake.habbo.room.object.data.LegacyStuffData
   import com.sulake.habbo.room.utils.class_3373
   import com.sulake.habbo.room.utils.class_3419
   import com.sulake.habbo.session.IRoomSession
   import com.sulake.habbo.session.class_3490
   import com.sulake.room.IRoomInstance
   import com.sulake.room.object.IRoomObject
   import com.sulake.room.object.IRoomObjectModel
   import com.sulake.room.utils.IVector3d
   import com.sulake.room.utils.RoomGeometry
   import com.sulake.room.utils.RoomRotatingEffect
   import com.sulake.room.utils.RoomShakingEffect
   import com.sulake.room.utils.Vector3d

   import flash.events.TimerEvent
   import flash.utils.Timer
   import flash.utils.setTimeout

   [SecureSWF(rename="true")]
    public class RoomMessageHandler {

        public static const const_617: int = 0;

        public static const EFFECT_ROOM_SHAKE: int = 1;

        public static const const_1121: int = 2;

        public static const EFFECT_ROOM_DISCO: int = 3;

        public function RoomMessageHandler(param1: IRoomCreator) {
            var_3554 = {};
            super();
            var_1630 = param1;
            var_1689 = new RoomPlaneParser();
            _initialConnection = true;
        }
        private var var_26: IConnection = null;
        private var var_1630: IRoomCreator = null;
        private var var_1689: RoomPlaneParser = null;
        private var var_2517: RoomEntryTileMessageEvent = null;
        private var var_4252: int = -1;
        private var _initialConnection: Boolean = true;
        private var var_4975: int = -1000000000;
        private var var_1632: int = 0;
        private var var_3554: Object;
        private var var_3120: int = -1;
        private var var_3284: int = -1;

        public function set connection(param1: IConnection): void {
            if (var_26 != null) {
                return;
            }
            if (param1 != null) {
                var_26 = param1;
                param1.addMessageEvent(new UserObjectEvent(onOwnUserEvent));
                param1.addMessageEvent(new RoomReadyMessageEvent(onRoomReady));
                param1.addMessageEvent(new RoomPropertyMessageEvent(onRoomProperty));
                param1.addMessageEvent(new RoomEntryTileMessageEvent(onEntryTileData));
                param1.addMessageEvent(new FloorHeightMapMessageEvent(onFloorHeightMap));
                param1.addMessageEvent(new HeightMapMessageEvent(onHeightMap));
                param1.addMessageEvent(new HeightMapUpdateMessageEvent(onHeightMapUpdate));
                param1.addMessageEvent(new RoomVisualizationSettingsEvent(onRoomVisualizationSettings));
                param1.addMessageEvent(new FurnitureAliasesMessageEvent(onFurnitureAliases));
                param1.addMessageEvent(new AreaHideMessageEvent(onAreaHide));
                param1.addMessageEvent(new ObjectsMessageEvent(onObjects));
                param1.addMessageEvent(new ObjectAddMessageEvent(onObjectAdd));
                param1.addMessageEvent(new ObjectUpdateMessageEvent(onObjectUpdate));
                param1.addMessageEvent(new ObjectDataUpdateMessageEvent(onObjectDataUpdate));
                param1.addMessageEvent(new ObjectsDataUpdateMessageEvent(onObjectsDataUpdate));
                param1.addMessageEvent(new ObjectRemoveMessageEvent(onObjectRemove));
                param1.addMessageEvent(new ObjectRemoveMultipleMessageEvent(onObjectRemoveMultiple));
                param1.addMessageEvent(new ItemsMessageEvent(onItems));
                param1.addMessageEvent(new ItemAddMessageEvent(onItemAdd));
                param1.addMessageEvent(new ItemRemoveMessageEvent(onItemRemove));
                param1.addMessageEvent(new ItemUpdateMessageEvent(onItemUpdate));
                param1.addMessageEvent(new ItemStateUpdateMessageEvent(onItemStateUpdate));
                param1.addMessageEvent(new ItemsStateUpdateMessageEvent(onItemsStateUpdate));
                param1.addMessageEvent(new ItemDataUpdateMessageEvent(onItemDataUpdate));
                param1.addMessageEvent(new UsersMessageEvent(onUsers));
                param1.addMessageEvent(new UserUpdateMessageEvent(onUserUpdate));
                param1.addMessageEvent(new UserRemoveMessageEvent(onUserRemove));
                param1.addMessageEvent(new UserChangeMessageEvent(onUserChange));
                param1.addMessageEvent(new ExpressionMessageEvent(onExpression));
                param1.addMessageEvent(new DanceMessageEvent(onDance));
                param1.addMessageEvent(new AvatarEffectMessageEvent(onAvatarEffect));
                param1.addMessageEvent(new SleepMessageEvent(onAvatarSleep));
                param1.addMessageEvent(new CarryObjectMessageEvent(onCarryObject));
                param1.addMessageEvent(new UseObjectMessageEvent(onUseObject));
                param1.addMessageEvent(new SlideObjectBundleMessageEvent(onSlideUpdate));
                param1.addMessageEvent(new WiredMovementsMessageEvent(onWiredMovements));
                param1.addMessageEvent(new ChatMessageEvent(onChat));
                param1.addMessageEvent(new WhisperMessageEvent(onChat));
                param1.addMessageEvent(new ShoutMessageEvent(onChat));
                param1.addMessageEvent(new UserTypingMessageEvent(onTypingStatus));
                param1.addMessageEvent(new DiceValueMessageEvent(onDiceValue));
                param1.addMessageEvent(new OneWayDoorStatusMessageEvent(onOneWayDoorStatus));
                param1.addMessageEvent(new PetExperienceEvent(onPetExperience));
                param1.addMessageEvent(new YouArePlayingGameMessageEvent(onPlayingGame));
                param1.addMessageEvent(new YouAreNotSpectatorMessageEvent(onYouAreNotSpectator));
                param1.addMessageEvent(new GamePlayerValueMessageEvent(onGamePlayerNumberValue));
                param1.addMessageEvent(new HanditemConfigurationMessageEvent(onHanditemConfiguration));
                param1.addMessageEvent(new PetFigureUpdateEvent(onPetFigureUpdate));
                param1.addMessageEvent(new IgnoreResultMessageEvent(onIgnoreResult));
                param1.addMessageEvent(new GuideSessionStartedMessageEvent(onGuideSessionStarted));
                param1.addMessageEvent(new GuideSessionEndedMessageEvent(onGuideSessionEnded));
                param1.addMessageEvent(new GuideSessionErrorMessageEvent(onGuideSessionError));
                param1.addMessageEvent(new SpecialRoomEffectMessageEvent(onSpecialRoomEvent));
                param1.addMessageEvent(new BuildersClubPlacementWarningMessageEvent(onBCPlacementWarning));
                param1.addMessageEvent(new ObjectRemoveConfirmMessageEvent(onObjectRemoveConfirm));
            }
        }

        public function dispose(): void {
            var_26 = null;
            var_1630 = null;
            if (var_1689 != null) {
                var_1689.dispose();
                var_1689 = null;
            }
            var_2517 = null;
        }

        public function setCurrentRoom(param1: int): void {
            if (var_1632 != 0) {
                if (var_1630 != null) {
                    var_1630.disposeRoom(var_1632);
                }
            }
            var_1632 = param1;
            var_2517 = null;
        }

        public function resetCurrentRoom(): void {
            var_1632 = 0;
            var_2517 = null;
        }

        public function onWiredMovements(param1: IMessageEvent): void {
            var _loc4_: class_1424 = null;
            if (var_1630 == null) {
                return;
            }
            if (param1 is WiredMovementsMessageEvent) {
                _loc4_ = (param1 as WiredMovementsMessageEvent).getParser();
                for each(var _loc5_ in _loc4_.userMoves) {
                    onWiredUserMove(_loc5_);
                }
                for each(var _loc6_ in _loc4_.furniMoves) {
                    onWiredFurniMove(_loc6_);
                }
                for each(var _loc2_ in _loc4_.wallItemMoves) {
                    onWiredWallItemMove(_loc2_);
                }
                for each(var _loc3_ in _loc4_.userDirectionUpdates) {
                    onUserDirectionUpdate(_loc3_);
                }
            }
        }

        public function onSpecialRoomEvent(param1: IMessageEvent): void {
            var arrayIndex: int;
            var discoColours: Array;
            var discoTimer: Timer;
            var event: IMessageEvent = param1;
            var eventParser: class_1329 = event.parser as class_1329;
            switch (eventParser.effectId) {
                case 0:
                    RoomRotatingEffect.init(250, 5000);
                    RoomRotatingEffect.turnVisualizationOn();
                    break;
                case 1:
                    RoomShakingEffect.init(250, 5000);
                    RoomShakingEffect.turnVisualizationOn();
                    break;
                case 2:
                    var_1630.roomSessionManager.events.dispatchEvent(new RoomEngineZoomEvent(var_1632, -1, true));
                    break;
                case 3:
                    arrayIndex = 0;
                    discoColours = [29371, 16731195, 16764980, 10092288, 29371, 16731195, 16764980, 10092288, 0];
                    discoTimer = new Timer(1000, discoColours.length + 1);
                    discoTimer.addEventListener("timer", function (param1: TimerEvent): void {
                        if (arrayIndex == discoColours.length) {
                            var_1630.updateObjectRoomColor(var_1632, discoColours[arrayIndex++], 176, true);
                        } else {
                            var_1630.updateObjectRoomColor(var_1632, discoColours[arrayIndex++], 176, false);
                        }
                    });
                    discoTimer.start();
            }
        }

        private function getRoomId(param1: int): int {
            return var_1632;
        }

        private function onObjectRemoveConfirm(param1: IMessageEvent): void {
            var parser: class_1624;
            var composer: IMessageComposer;
            var event: IMessageEvent = param1;
            var confirmationEvent: ObjectRemoveConfirmMessageEvent = event as ObjectRemoveConfirmMessageEvent;
            if (confirmationEvent == null) {
                return;
            }
            parser = confirmationEvent.getParser();
            if (parser == null) {
                return;
            }
            composer = new class_216(parser.id, parser.category, true);
            var_1630.windowManager.confirm("${" + parser.confirmTitle + "}", "${" + parser.confirmBody + "}", 0, function (param1: class_3441, param2: WindowEvent): void {
                param1.dispose();
                if (param2.type == "WE_OK") {
                    event.connection.send(composer);
                }
            });
        }

        private function onBCPlacementWarning(param1: IMessageEvent): void {
            var parser: class_1391;
            var composer: IMessageComposer;
            var event: IMessageEvent = param1;
            var warningEvent: BuildersClubPlacementWarningMessageEvent = event as BuildersClubPlacementWarningMessageEvent;
            if (warningEvent == null) {
                return;
            }
            parser = warningEvent.getParser();
            if (parser == null) {
                return;
            }
            if (parser.typeCode == class_1391.var_1593) {
                composer = new class_270(parser.pageId, parser.offerId, parser.extraParam, parser.x, parser.y, parser.direction, true);
            } else {
                composer = new class_852(parser.pageId, parser.offerId, parser.extraParam, parser.wallLocation, true);
            }
            var_1630.windowManager.confirm("${generic.alert.title}", "${room.confirm.hide_room}", 0, function (param1: class_3441, param2: WindowEvent): void {
                param1.dispose();
                if (param2.type == "WE_OK") {
                    event.connection.send(composer);
                }
            });
        }

        private function onOwnUserEvent(param1: IMessageEvent): void {
            var _loc2_: UserObjectEvent = param1 as UserObjectEvent;
            if (_loc2_ == null) {
                return;
            }
            var _loc3_: class_1267 = _loc2_.getParser();
            if (_loc3_ != null) {
                var_4252 = _loc3_.id;
            }
        }

        private function onRoomReady(param1: IMessageEvent): void {
            var _loc4_: RoomReadyMessageEvent;
            if ((_loc4_ = param1 as RoomReadyMessageEvent) == null || _loc4_.getParser() == null || param1.connection == null) {
                return;
            }
            var _loc2_: class_1207 = _loc4_.getParser();
            if (var_1632 != _loc2_.roomId) {
                setCurrentRoom(_loc2_.roomId);
            }
            var _loc3_: String = _loc2_.roomType;
            if (var_1630 != null) {
                var_1630.setWorldType(_loc2_.roomId, _loc3_);
            }
            if (_initialConnection) {
                param1.connection.send(new class_645());
                _initialConnection = false;
            } else {
                param1.connection.send(new class_865());
            }
        }

        private function onFurnitureAliases(param1: IMessageEvent): void {
            var _loc5_: FurnitureAliasesMessageEvent = null;
            var _loc2_: class_1548 = null;
            var _loc3_: int = 0;
            var _loc6_: int = 0;
            var _loc4_: String = null;
            var _loc7_: String = null;
            if (var_1630 != null) {
                if ((_loc5_ = param1 as FurnitureAliasesMessageEvent) == null || _loc5_.getParser() == null) {
                    return;
                }
                _loc2_ = _loc5_.getParser();
                if (_loc2_ != null) {
                    _loc3_ = _loc2_.aliasCount;
                    _loc6_ = 0;
                    while (_loc6_ < _loc3_) {
                        _loc4_ = _loc2_.getName(_loc6_);
                        _loc7_ = _loc2_.getAlias(_loc6_);
                        var_1630.setRoomObjectAlias(_loc4_, _loc7_);
                        _loc6_++;
                    }
                }
            }
            param1.connection.send(new class_865());
        }

        private function onHeightMap(param1: IMessageEvent): void {
            var _loc9_: int = 0;
            var _loc8_: int = 0;
            var _loc12_: Number = NaN;
            var _loc5_: Boolean = false;
            var _loc2_: Boolean = false;
            var _loc7_: HeightMapMessageEvent;
            if ((_loc7_ = param1 as HeightMapMessageEvent) == null || _loc7_.getParser() == null) {
                return;
            }
            if (var_1630 == null) {
                return;
            }
            var _loc4_: class_1412;
            var _loc11_: int = (_loc4_ = _loc7_.getParser()).width;
            var _loc10_: int = _loc4_.height;
            var _loc6_: class_3419 = new class_3419(_loc11_, _loc10_);
            var _loc3_: int = int(var_1630.configuration.getInteger("room.stacking_blocked_mask_bit", 14));
            _loc4_.stackingBlockedMaskBit = _loc3_;
            _loc9_ = 0;
            while (_loc9_ < _loc10_) {
                _loc8_ = 0;
                while (_loc8_ < _loc11_) {
                    _loc12_ = _loc4_.getTileHeight(_loc8_, _loc9_);
                    _loc5_ = _loc4_.getStackingBlocked(_loc8_, _loc9_);
                    _loc2_ = _loc4_.isRoomTile(_loc8_, _loc9_);
                    _loc6_.setTileHeight(_loc8_, _loc9_, _loc12_);
                    _loc6_.setStackingBlocked(_loc8_, _loc9_, _loc5_);
                    _loc6_.setIsRoomTile(_loc8_, _loc9_, _loc2_);
                    _loc8_++;
                }
                _loc9_++;
            }
            var_1630.setFurniStackingHeightMap(var_1632, _loc6_);
        }

        private function onHeightMapUpdate(param1: IMessageEvent): void {
            var _loc6_: int = 0;
            var _loc7_: int = 0;
            var _loc5_: HeightMapUpdateMessageEvent;
            if ((_loc5_ = param1 as HeightMapUpdateMessageEvent) == null || _loc5_.getParser() == null) {
                return;
            }
            if (var_1630 == null) {
                return;
            }
            var _loc3_: class_1341 = _loc5_.getParser();
            var _loc4_: class_3419;
            if ((_loc4_ = var_1630.getFurniStackingHeightMap(var_1632)) == null) {
                return;
            }
            var _loc2_: int = int(var_1630.configuration.getInteger("room.stacking_blocked_mask_bit", 14));
            _loc3_.stackingBlockedMaskBit = _loc2_;
            while (_loc3_.next()) {
                _loc6_ = _loc3_.x;
                _loc7_ = _loc3_.y;
                _loc4_.setTileHeight(_loc6_, _loc7_, _loc3_.tileHeight);
                _loc4_.setStackingBlocked(_loc6_, _loc7_, _loc3_.isStackingBlocked);
                _loc4_.setIsRoomTile(_loc6_, _loc7_, _loc3_.isRoomTile);
            }
            var_1630.refreshTileObjectMap(var_1632, "RoomMessageHandler.onHeightMapUpdate()");
        }

        private function onRoomVisualizationSettings(param1: IMessageEvent): void {
            var _loc2_: RoomVisualizationSettingsEvent = param1 as RoomVisualizationSettingsEvent;
            if (_loc2_ == null || _loc2_.getParser() == null) {
                return;
            }
            var _loc3_: class_1304 = _loc2_.getParser();
            var _loc7_: * = !_loc3_.wallsHidden;
            var _loc5_: Boolean = true;
            var _loc4_: Number = _loc3_.wallThicknessMultiplier;
            var _loc6_: Number = _loc3_.floorThicknessMultiplier;
            if (var_1630 != null) {
                var_1630.updateObjectRoomVisibilities(var_1632, _loc7_, _loc5_);
                var_1630.updateObjectRoomPlaneThicknesses(var_1632, _loc4_, _loc6_);
            }
        }

        private function onAreaHide(param1: IMessageEvent): void {
            var _loc4_: AreaHideMessageEvent;
            if ((_loc4_ = param1 as AreaHideMessageEvent) == null || _loc4_.getParser() == null) {
                return;
            }
            var _loc2_: class_1168 = _loc4_.getParser();
            var _loc3_: AreaHideMessageData = _loc2_.areaHideMessageData;
            if (var_1630 != null) {
                var_1630.updateAreaHide(var_1632, _loc3_.furniId, _loc3_.on, _loc3_.rootX, _loc3_.rootY, _loc3_.width, _loc3_.length, _loc3_.invert);
            }
        }

        private function onRoomProperty(param1: IMessageEvent): void {
            var _loc6_: RoomPropertyMessageEvent;
            if ((_loc6_ = param1 as RoomPropertyMessageEvent) == null || _loc6_.getParser() == null) {
                return;
            }
            var _loc2_: class_1437 = _loc6_.getParser();
            var _loc4_: String = _loc2_.floorType;
            var _loc5_: String = _loc2_.wallType;
            var _loc3_: String = _loc2_.landscapeType;
            if (var_1630 != null) {
                var_1630.updateObjectRoom(var_1632, _loc4_, _loc5_, _loc3_);
            }
        }

        private function onEntryTileData(param1: RoomEntryTileMessageEvent): void {
            var_2517 = param1;
        }

        private function onFloorHeightMap(param1: IMessageEvent): void {
            var _loc17_: int = 0;
            var _loc16_: int = 0;
            var _loc20_: int = 0;
            var _loc9_: int = 0;
            var _loc8_: int = 0;
            var _loc14_: FloorHeightMapMessageEvent;
            if ((_loc14_ = param1 as FloorHeightMapMessageEvent) == null || _loc14_.getParser() == null) {
                return;
            }
            var _loc11_: class_1471 = _loc14_.getParser();
            if (var_1630 == null) {
                return;
            }
            var _loc18_: class_3373;
            if ((_loc18_ = var_1630.getLegacyGeometry(var_1632)) == null) {
                return;
            }
            var_1689.reset();
            var _loc15_: int = _loc11_.width;
            var _loc19_: int = _loc11_.height;
            var_1689.initializeTileMap(_loc15_, _loc19_);
            var _loc5_: Number = -1;
            var _loc6_: Number = -1;
            var _loc2_: Number = 0;
            var _loc10_: Number = 0;
            var _loc3_: class_1609 = null;
            if (var_2517 != null) {
                _loc3_ = var_2517.getParser();
            }
            var _loc13_: class_3419;
            if ((_loc13_ = var_1630.getFurniStackingHeightMap(var_1632)) == null) {
                return;
            }
            _loc17_ = 0;
            while (_loc17_ < _loc19_) {
                _loc16_ = 0;
                while (_loc16_ < _loc15_) {
                    _loc20_ = _loc11_.getTileHeight(_loc16_, _loc17_);
                    if ((_loc17_ > 0 && _loc17_ < _loc19_ - 1 || _loc16_ > 0 && _loc16_ < _loc15_ - 1) && _loc20_ != -110 && (_loc3_ == null || _loc16_ == _loc3_.x && _loc17_ == _loc3_.y)) {
                        if (_loc11_.getTileHeight(_loc16_, _loc17_ - 1) == -110 && _loc11_.getTileHeight(_loc16_ - 1, _loc17_) == -110 && _loc11_.getTileHeight(_loc16_, _loc17_ + 1) == -110) {
                            _loc5_ = _loc16_ + 0.5;
                            _loc6_ = _loc17_;
                            _loc2_ = _loc20_;
                            _loc10_ = 90;
                        }
                        if (_loc11_.getTileHeight(_loc16_, _loc17_ - 1) == -110 && _loc11_.getTileHeight(_loc16_ - 1, _loc17_) == -110 && _loc11_.getTileHeight(_loc16_ + 1, _loc17_) == -110) {
                            _loc5_ = _loc16_;
                            _loc6_ = _loc17_ + 0.5;
                            _loc2_ = _loc20_;
                            _loc10_ = 180;
                        }
                    }
                    var_1689.setTileHeight(_loc16_, _loc17_, _loc20_);
                    _loc16_++;
                }
                _loc17_++;
            }
            var_1689.setTileHeight(Math.floor(_loc5_), Math.floor(_loc6_), _loc2_);
            var_1689.initializeFromTileData(_loc14_.getParser().fixedWallsHeight);
            var_1689.setTileHeight(Math.floor(_loc5_), Math.floor(_loc6_), _loc2_ + var_1689.wallHeight);
            _loc18_.scale = _loc11_.scale;
            _loc18_.initialize(_loc15_, _loc19_, var_1689.floorHeight);
            _loc9_ = _loc11_.height - 1;
            while (_loc9_ >= 0) {
                _loc8_ = _loc11_.width - 1;
                while (_loc8_ >= 0) {
                    _loc18_.setTileHeight(_loc8_, _loc9_, var_1689.getTileHeight(_loc8_, _loc9_));
                    _loc8_--;
                }
                _loc9_--;
            }
            var _loc7_: XML = var_1689.getXML();
            var _loc4_: XML = <doors>
                <door x={_loc5_} y={_loc6_} z={_loc2_} dir={_loc10_}/>
            </doors>;
            _loc7_.appendChild(_loc4_);
            var_1630.initializeRoom(var_1632, _loc7_);
            if (var_3554.objectData) {
                addActiveObject(var_1632, var_3554.objectData);
                var_3554.objectData = null;
            } else {
                var_3554.floorReady = true;
            }
            for each(var _loc12_ in _loc11_.areaHideData) {
                var_1630.updateAreaHide(var_1632, _loc12_.furniId, _loc12_.on, _loc12_.rootX, _loc12_.rootY, _loc12_.width, _loc12_.length, _loc12_.invert);
            }
        }

        private function onObjects(param1: IMessageEvent): void {
            var _loc6_: int = 0;
            var _loc4_: class_1765 = null;
            var _loc3_: ObjectsMessageEvent = param1 as ObjectsMessageEvent;
            if (_loc3_ == null || _loc3_.getParser() == null) {
                return;
            }
            var _loc2_: class_1432 = _loc3_.getParser();
            var _loc5_: int = _loc2_.getObjectCount();
            _loc6_ = 0;
            while (_loc6_ < _loc5_) {
                _loc4_ = _loc2_.getObject(_loc6_);
                addActiveObject(var_1632, _loc4_);
                _loc6_++;
            }
        }

        private function onObjectAdd(param1: IMessageEvent): void {
            var _loc2_: ObjectAddMessageEvent = param1 as ObjectAddMessageEvent;
            if (_loc2_ == null || _loc2_.getParser() == null) {
                return;
            }
            var _loc3_: class_1176 = _loc2_.getParser();
            var _loc4_: class_1765 = _loc3_.data;
            addActiveObject(var_1632, _loc4_);
        }

        private function onObjectUpdate(param1: IMessageEvent): void {
            var _loc2_: IVector3d = null;
            var _loc6_: IVector3d = null;
            var _loc3_: ObjectUpdateMessageEvent = param1 as ObjectUpdateMessageEvent;
            if (_loc3_ == null || _loc3_.getParser() == null) {
                return;
            }
            if (var_1630 == null) {
                return;
            }
            var _loc5_: class_1765;
            var _loc4_: class_1376;
            if ((_loc5_ = (_loc4_ = _loc3_.getParser()).data) != null) {
                _loc2_ = new Vector3d(_loc5_.x, _loc5_.y, _loc5_.z);
                _loc6_ = new Vector3d(_loc5_.dir);
                var_1630.updateObjectFurniture(var_1632, _loc5_.id, _loc2_, _loc6_, _loc5_.state, _loc5_.data, _loc5_.extra);
                var_1630.updateObjectFurnitureHeight(var_1632, _loc5_.id, _loc5_.sizeZ);
                var_1630.updateObjectFurnitureExpiryTime(var_1632, _loc5_.id, _loc5_.expiryTime);
            }
        }

        private function onObjectDataUpdate(param1: IMessageEvent): void {
            var _loc4_: ObjectDataUpdateMessageEvent;
            if ((_loc4_ = param1 as ObjectDataUpdateMessageEvent) == null || _loc4_.getParser() == null) {
                return;
            }
            if (var_1630 == null) {
                return;
            }
            var _loc2_: class_1365 = _loc4_.getParser();
            var _loc5_: int = _loc2_.id;
            var _loc6_: int = _loc2_.state;
            var _loc3_: IStuffData = _loc2_.data;
            var_1630.updateObjectFurniture(var_1632, _loc5_, null, null, _loc6_, _loc3_);
        }

        private function onObjectsDataUpdate(param1: IMessageEvent): void {
            var _loc6_: int = 0;
            var _loc5_: class_1721 = null;
            var _loc7_: int = 0;
            var _loc8_: int = 0;
            var _loc3_: IStuffData = null;
            var _loc4_: ObjectsDataUpdateMessageEvent;
            if ((_loc4_ = param1 as ObjectsDataUpdateMessageEvent) == null || _loc4_.getParser() == null) {
                return;
            }
            if (var_1630 == null) {
                return;
            }
            var _loc2_: class_1221 = _loc4_.getParser();
            _loc6_ = 0;
            while (_loc6_ < _loc2_.objectCount) {
                if ((_loc5_ = _loc2_.getObjectData(_loc6_)) != null) {
                    _loc7_ = _loc5_.id;
                    _loc8_ = _loc5_.state;
                    _loc3_ = _loc5_.data;
                    var_1630.updateObjectFurniture(var_1632, _loc7_, null, null, _loc8_, _loc3_);
                }
                _loc6_++;
            }
        }

        private function onObjectRemove(param1: IMessageEvent): void {
            var parser: class_1280;
            var id: int;
            var delay: int;
            var event: IMessageEvent = param1;
            var objectRemoveEvent: ObjectRemoveMessageEvent = event as ObjectRemoveMessageEvent;
            if (objectRemoveEvent == null || objectRemoveEvent.getParser() == null) {
                return;
            }
            if (var_1630 == null) {
                return;
            }
            parser = objectRemoveEvent.getParser();
            id = parser.id;
            delay = parser.delay;
            if (delay > 0) {
                setTimeout(function (): void {
                    var_1630.disposeObjectFurniture(var_1632, id, parser.isExpired ? -1 : parser.pickerId, true);
                }, delay);
            } else {
                var_1630.disposeObjectFurniture(var_1632, id, parser.isExpired ? -1 : parser.pickerId, true);
            }
        }

        private function onObjectRemoveMultiple(param1: IMessageEvent): void {
            var _loc4_: ObjectRemoveMultipleMessageEvent;
            if ((_loc4_ = param1 as ObjectRemoveMultipleMessageEvent) == null || _loc4_.getParser() == null) {
                return;
            }
            if (var_1630 == null) {
                return;
            }
            var _loc2_: class_1612 = _loc4_.getParser();
            for each(var _loc3_ in _loc2_.ids) {
                var_1630.disposeObjectFurniture(var_1632, _loc3_, _loc2_.pickerId);
            }
            var_1630.refreshTileObjectMap(var_1632, "RoomEngine.onObjectRemoveMultiple()");
        }

        private function addActiveObject(param1: int, param2: class_1765): void {
            if (param2 == null || var_1630 == null) {
                return;
            }
            var _loc3_: IVector3d = new Vector3d(param2.x, param2.y, param2.z);
            var _loc4_: IVector3d = new Vector3d(param2.dir);
            if (param2.staticClass != null) {
                var_1630.addObjectFurnitureByName(param1, param2.id, param2.staticClass, _loc3_, _loc4_, param2.state, param2.data, param2.extra);
            } else {
                var_1630.addObjectFurniture(param1, param2.id, param2.type, _loc3_, _loc4_, param2.state, param2.data, param2.extra, param2.expiryTime, param2.usagePolicy, param2.ownerId, param2.ownerName, true, true, param2.sizeZ);
            }
        }

        private function onItems(param1: IMessageEvent): void {
            var _loc5_: int = 0;
            var _loc3_: class_1710 = null;
            var _loc6_: ItemsMessageEvent;
            if ((_loc6_ = param1 as ItemsMessageEvent) == null || _loc6_.getParser() == null) {
                return;
            }
            var _loc2_: class_1570 = _loc6_.getParser();
            var _loc4_: int = _loc2_.getItemCount();
            _loc5_ = 0;
            while (_loc5_ < _loc4_) {
                _loc3_ = _loc2_.getItem(_loc5_);
                addWallItem(var_1632, _loc3_);
                _loc5_++;
            }
        }

        private function onItemAdd(param1: IMessageEvent): void {
            var _loc2_: ItemAddMessageEvent = param1 as ItemAddMessageEvent;
            if (_loc2_ == null || _loc2_.getParser() == null) {
                return;
            }
            var _loc3_: class_1629 = _loc2_.getParser();
            var _loc4_: class_1710;
            if ((_loc4_ = _loc3_.data) != null) {
                addWallItem(var_1632, _loc4_);
            }
        }

        private function onItemRemove(param1: IMessageEvent): void {
            var _loc3_: ItemRemoveMessageEvent = param1 as ItemRemoveMessageEvent;
            if (_loc3_ == null || _loc3_.getParser() == null) {
                return;
            }
            if (var_1630 == null) {
                return;
            }
            var _loc2_: class_1214 = _loc3_.getParser();
            var_1630.disposeObjectWallItem(var_1632, _loc2_.itemId, _loc2_.pickerId);
        }

        private function onItemUpdate(param1: IMessageEvent): void {
            var _loc2_: IVector3d = null;
            var _loc5_: IVector3d = null;
            var _loc6_: ItemUpdateMessageEvent;
            if ((_loc6_ = param1 as ItemUpdateMessageEvent) == null || _loc6_.getParser() == null) {
                return;
            }
            var _loc3_: class_1319 = _loc6_.getParser();
            var _loc7_: class_3373 = var_1630.getLegacyGeometry(var_1632);
            if (var_1630 == null || _loc7_ == null) {
                return;
            }
            var _loc4_: class_1710;
            if ((_loc4_ = _loc3_.data) != null) {
                _loc2_ = _loc7_.getLocation(_loc4_.wallX, _loc4_.wallY, _loc4_.localX, _loc4_.localY, _loc4_.dir);
                _loc5_ = new Vector3d(_loc7_.getDirection(_loc4_.dir));
                var_1630.updateObjectWallItem(var_1632, _loc4_.id, _loc2_, _loc5_, _loc4_.state, _loc4_.data);
                var_1630.updateObjectWallItemExpiryTime(var_1632, _loc4_.id, _loc4_.secondsToExpiration);
            }
        }

        private function onItemStateUpdate(param1: IMessageEvent): void {
            var _loc3_: ItemStateUpdateMessageEvent = param1 as ItemStateUpdateMessageEvent;
            if (_loc3_ == null || _loc3_.getParser() == null) {
                return;
            }
            var _loc2_: class_1465 = _loc3_.getParser();
            var_1630.updateObjectWallItemState(var_1632, _loc2_.id, _loc2_.state, _loc2_.itemData);
        }

        private function onItemsStateUpdate(param1: IMessageEvent): void {
            var _loc4_: int = 0;
            var _loc2_: class_1766 = null;
            var _loc5_: ItemsStateUpdateMessageEvent;
            if ((_loc5_ = param1 as ItemsStateUpdateMessageEvent) == null || _loc5_.getParser() == null) {
                return;
            }
            var _loc3_: class_1227 = _loc5_.getParser();
            _loc4_ = 0;
            while (_loc4_ < _loc3_.itemCount) {
                _loc2_ = _loc3_.getItemData(_loc4_);
                var_1630.updateObjectWallItemState(var_1632, _loc2_.id, _loc2_.state, _loc2_.itemData);
                _loc4_++;
            }
        }

        private function onMultipleItemStateUpdates(param1: IMessageEvent): void {
            var _loc3_: ItemStateUpdateMessageEvent = param1 as ItemStateUpdateMessageEvent;
            if (_loc3_ == null || _loc3_.getParser() == null) {
                return;
            }
            var _loc2_: class_1465 = _loc3_.getParser();
            var_1630.updateObjectWallItemState(var_1632, _loc2_.id, _loc2_.state, _loc2_.itemData);
        }

        private function onItemDataUpdate(param1: IMessageEvent): void {
            var _loc3_: ItemDataUpdateMessageEvent = param1 as ItemDataUpdateMessageEvent;
            if (_loc3_ == null || _loc3_.getParser() == null) {
                return;
            }
            var _loc2_: class_1529 = _loc3_.getParser();
            var_1630.updateObjectWallItemData(var_1632, _loc2_.id, _loc2_.itemData);
        }

        private function addWallItem(param1: int, param2: class_1710): void {
            if (param2 == null || var_1630 == null) {
                return;
            }
            var _loc5_: class_3373;
            if ((_loc5_ = var_1630.getLegacyGeometry(param1)) == null) {
                return;
            }
            var _loc3_: IVector3d = null;
            if (!param2.isOldFormat) {
                _loc3_ = _loc5_.getLocation(param2.wallX, param2.wallY, param2.localX, param2.localY, param2.dir);
            } else {
                _loc3_ = _loc5_.getLocationOldFormat(param2.y, param2.z, param2.dir);
            }
            var _loc4_: IVector3d = new Vector3d(_loc5_.getDirection(param2.dir));
            var_1630.addObjectWallItem(param1, param2.id, param2.type, _loc3_, _loc4_, param2.state, param2.data, param2.usagePolicy, param2.ownerId, param2.ownerName, param2.secondsToExpiration);
        }

        private function onUsers(param1: IMessageEvent): void {
            var _loc4_: int = 0;
            var _loc7_: class_1668 = null;
            var _loc2_: IVector3d = null;
            var _loc6_: IVector3d = null;
            var _loc5_: int = 0;
            var _loc8_: UsersMessageEvent;
            if ((_loc8_ = param1 as UsersMessageEvent) == null || _loc8_.getParser() == null) {
                return;
            }
            if (var_1630 == null) {
                return;
            }
            var _loc3_: class_1333 = _loc8_.getParser();
            _loc4_ = 0;
            while (_loc4_ < _loc3_.getUserCount()) {
                if ((_loc7_ = _loc3_.getUser(_loc4_)) != null) {
                    _loc2_ = new Vector3d(_loc7_.x, _loc7_.y, _loc7_.z);
                    _loc6_ = new Vector3d(_loc7_.dir);
                    _loc5_ = _loc7_.userType;
                    var_1630.addObjectUser(var_1632, _loc7_.roomIndex, _loc2_, _loc6_, _loc7_.dir, _loc5_, _loc7_.figure);
                    if (_loc7_.webID == var_4252) {
                        var_1630.setOwnUserId(var_1632, _loc7_.roomIndex);
                        var_1630.updateObjectUserOwnUserAvatar(var_1632, _loc7_.roomIndex);
                    }
                    var_1630.updateObjectUserFigure(var_1632, _loc7_.roomIndex, _loc7_.figure, _loc7_.sex, _loc7_.subType, _loc7_.isRiding);
                    if (RoomObjectUserTypes.getName(_loc5_) == "pet") {
                        if (var_1630.getPetTypeId(_loc7_.figure) == 16) {
                            var_1630.updateObjectUserPosture(var_1632, _loc7_.roomIndex, _loc7_.petPosture);
                        }
                    }
                    if (var_1630.configuration.getBoolean("avatar.ignored.bubble.enabled")) {
                        var_1630.updateObjectUserAction(var_1632, _loc7_.roomIndex, "figure_is_muted", Number(var_1630.sessionDataManager.isIgnored(_loc7_.webID)));
                    }
                }
                _loc4_++;
            }
            updateGuideMarker();
        }

        private function onUserUpdate(param1: IMessageEvent): void {
            var _loc10_: int = 0;
            var _loc6_: class_1753 = null;
            var _loc16_: Number = NaN;
            var _loc3_: IVector3d = null;
            var _loc11_: IVector3d = null;
            var _loc13_: IVector3d = null;
            var _loc18_: Boolean = false;
            var _loc8_: Boolean = false;
            var _loc9_: String = null;
            var _loc7_: String = null;
            var _loc5_: Boolean = false;
            var _loc15_: Boolean = false;
            var _loc2_: * = 0;
            var _loc4_: UserUpdateMessageEvent;
            if ((_loc4_ = param1 as UserUpdateMessageEvent) == null || _loc4_.getParser() == null) {
                return;
            }
            if (var_1630 == null) {
                return;
            }
            var _loc14_: class_1326 = _loc4_.getParser();
            var _loc12_: IRoomInstance;
            if ((_loc12_ = var_1630.getRoom(var_1632)) == null) {
                return;
            }
            var _loc19_: Number = _loc12_.getNumber("room_z_scale");
            _loc10_ = 0;
            while (_loc10_ < _loc14_.userUpdateCount) {
                if ((_loc6_ = _loc14_.getUserUpdateData(_loc10_)) != null) {
                    _loc16_ = _loc6_.localZ;
                    if (_loc19_ != 0) {
                        _loc16_ /= _loc19_;
                    }
                    _loc3_ = new Vector3d(_loc6_.x, _loc6_.y, _loc6_.z + _loc16_);
                    _loc11_ = new Vector3d(_loc6_.dir);
                    _loc13_ = null;
                    if (_loc6_.isMoving) {
                        _loc13_ = new Vector3d(_loc6_.targetX, _loc6_.targetY, _loc6_.targetZ);
                    }
                    var_1630.updateObjectUser(var_1632, _loc6_.id, _loc3_, _loc13_, _loc6_.canStandUp, _loc16_, _loc11_, _loc6_.dirHead, NaN, _loc6_.skipPositionUpdate);
                    _loc18_ = true;
                    _loc8_ = false;
                    _loc9_ = "std";
                    _loc7_ = "";
                    var_1630.updateObjectUserFlatControl(var_1632, _loc6_.id, null);
                    _loc5_ = false;
                    _loc15_ = false;
                    _loc2_ = _loc6_.actions.length;
                    for each(var _loc17_ in _loc6_.actions) {
                        switch (_loc17_.actionType) {
                            case "flatctrl":
                                var_1630.updateObjectUserFlatControl(var_1632, _loc6_.id, _loc17_.actionParameter);
                                break;
                            case "sign":
                                if (_loc2_ == 1) {
                                    _loc18_ = false;
                                }
                                var_1630.updateObjectUserAction(var_1632, _loc6_.id, "figure_sign", int(_loc17_.actionParameter));
                                break;
                            case "gst":
                                if (_loc2_ == 1) {
                                    _loc18_ = false;
                                }
                                var_1630.updateObjectPetGesture(var_1632, _loc6_.id, _loc17_.actionParameter);
                                break;
                            case "wav":
                            case "mv":
                                _loc15_ = true;
                                _loc8_ = true;
                                break;
                            case "swim":
                                _loc5_ = true;
                                _loc8_ = true;
                                _loc9_ = _loc17_.actionType;
                                _loc7_ = _loc17_.actionParameter;
                                break;
                            case "wf":
                                break;
                            case "trd":
                                break;
                            default:
                                _loc8_ = true;
                                _loc9_ = _loc17_.actionType;
                                _loc7_ = _loc17_.actionParameter;
                                break;
                        }
                        _loc9_ = _loc17_.actionType;
                        _loc7_ = _loc17_.actionParameter;
                    }
                    if (!_loc15_ && _loc5_) {
                        _loc8_ = true;
                        _loc9_ = "float";
                    }
                    if (_loc8_) {
                        var_1630.updateObjectUserPosture(var_1632, _loc6_.id, _loc9_, _loc7_);
                    } else if (_loc18_) {
                        var_1630.updateObjectUserPosture(var_1632, _loc6_.id, "std", "");
                    }
                }
                _loc10_++;
            }
            updateGuideMarker();
        }

        private function onUserRemove(param1: IMessageEvent): void {
            var _loc3_: UserRemoveMessageEvent = param1 as UserRemoveMessageEvent;
            if (_loc3_ == null || _loc3_.getParser() == null) {
                return;
            }
            if (var_1630 == null) {
                return;
            }
            var _loc2_: class_1226 = _loc3_.getParser();
            var_1630.disposeObjectUser(var_1632, _loc2_.id);
            updateGuideMarker();
        }

        private function onUserChange(param1: IMessageEvent): void {
            var _loc2_: UserChangeMessageEvent = param1 as UserChangeMessageEvent;
            if (_loc2_ == null) {
                return;
            }
            var_1630.updateObjectUserFigure(var_1632, _loc2_.id, _loc2_.figure, _loc2_.sex);
        }

        private function onPetFigureUpdate(param1: IMessageEvent): void {
            var _loc3_: PetFigureUpdateEvent = param1 as PetFigureUpdateEvent;
            if (_loc3_ == null) {
                return;
            }
            var _loc2_: class_1310 = _loc3_.getParser();
            var_1630.updateObjectUserFigure(var_1632, _loc2_.roomIndex, _loc2_.figureData.figureString, "", "", _loc2_.isRiding);
        }

        private function onExpression(param1: IMessageEvent): void {
            var _loc2_: ExpressionMessageEvent = param1 as ExpressionMessageEvent;
            if (_loc2_ == null) {
                return;
            }
            if (var_1630 == null) {
                return;
            }
            var _loc3_: class_1175 = _loc2_.getParser();
            if (_loc3_ == null) {
                return;
            }
            var_1630.updateObjectUserAction(var_1632, _loc3_.userId, "figure_expression", _loc3_.expressionType);
        }

        private function onDance(param1: IMessageEvent): void {
            var _loc2_: DanceMessageEvent = param1 as DanceMessageEvent;
            if (_loc2_ == null || _loc2_.getParser() == null) {
                return;
            }
            if (var_1630 == null) {
                return;
            }
            var _loc3_: class_1140 = _loc2_.getParser();
            var_1630.updateObjectUserAction(var_1632, _loc3_.userId, "figure_dance", _loc3_.danceStyle);
        }

        private function onAvatarEffect(param1: IMessageEvent): void {
            var _loc3_: AvatarEffectMessageEvent = param1 as AvatarEffectMessageEvent;
            if (_loc3_ == null || _loc3_.getParser() == null) {
                return;
            }
            if (var_1630 == null) {
                return;
            }
            var _loc2_: class_1620 = _loc3_.getParser();
            var_1630.updateObjectUserEffect(var_1632, _loc2_.userId, _loc2_.effectId, _loc2_.delayMilliSeconds);
        }

        private function onAvatarSleep(param1: IMessageEvent): void {
            var _loc4_: SleepMessageEvent;
            if ((_loc4_ = param1 as SleepMessageEvent) == null || _loc4_.getParser() == null) {
                return;
            }
            if (var_1630 == null) {
                return;
            }
            var _loc3_: class_1386 = _loc4_.getParser();
            var _loc2_: int = 1;
            if (!_loc3_.sleeping) {
                _loc2_ = 0;
            }
            var_1630.updateObjectUserAction(var_1632, _loc3_.userId, "figure_sleep", _loc2_);
        }

        private function onCarryObject(param1: IMessageEvent): void {
            var _loc2_: class_1292 = null;
            if (var_1630 == null) {
                return;
            }
            if (param1 is CarryObjectMessageEvent) {
                _loc2_ = (param1 as CarryObjectMessageEvent).getParser();
                var_1630.updateObjectUserAction(var_1632, _loc2_.userId, "figure_carry_object", _loc2_.itemType);
            }
        }

        private function onUseObject(param1: IMessageEvent): void {
            var _loc2_: class_1625 = null;
            if (var_1630 == null) {
                return;
            }
            if (param1 is UseObjectMessageEvent) {
                _loc2_ = (param1 as UseObjectMessageEvent).getParser();
                var_1630.updateObjectUserAction(var_1632, _loc2_.userId, "figure_use_object", _loc2_.itemType);
            }
        }

        private function onSlideUpdate(param1: IMessageEvent): void {
            var _loc3_: class_1526 = null;
            var _loc6_: Array = null;
            var _loc4_: int = 0;
            var _loc2_: class_1693 = null;
            var _loc5_: class_1693 = null;
            if (var_1630 == null) {
                return;
            }
            if (param1 is SlideObjectBundleMessageEvent) {
                _loc3_ = (param1 as SlideObjectBundleMessageEvent).getParser();
                var_1630.updateObjectFurniture(var_1632, _loc3_.id, null, null, 1, null);
                var_1630.updateObjectFurniture(var_1632, _loc3_.id, null, null, 2, null);
                _loc6_ = _loc3_.objectList;
                _loc4_ = 0;
                while (_loc4_ < _loc6_.length) {
                    _loc2_ = _loc6_[_loc4_];
                    if (_loc2_ != null) {
                        var_1630.updateObjectFurnitureLocation(var_1632, _loc2_.id, _loc2_.loc, null, _loc2_.target);
                    }
                    _loc4_++;
                }
                if (_loc3_.avatar != null) {
                    _loc5_ = _loc3_.avatar;
                    var_1630.updateObjectUser(var_1632, _loc5_.id, _loc5_.loc, _loc5_.target);
                    setUserMovePosture(_loc5_.id, _loc5_.moveType);
                }
            }
        }

        private function onWiredFurniMove(param1: class_1690): void {
            var _loc2_: IVector3d = new Vector3d(param1.rotation % 8 * 45);
            var_1630.updateObjectFurnitureLocation(var_1632, param1.furniId, roundLocation(param1.source), _loc2_, roundLocation(param1.target), param1.animationTime);
        }

        private function roundLocation(param1: IVector3d): IVector3d {
            var _loc7_: RoomGeometry;
            if ((_loc7_ = var_1630.getRoomGeometry(var_1632)) == null) {
                return param1;
            }
            var _loc6_: IVector3d;
            if ((_loc6_ = _loc7_.getScreenPosition(param1)) == null) {
                return param1;
            }
            var _loc9_: IVector3d = new Vector3d(param1.x, param1.y, param1.z + 0.01);
            var _loc3_: IVector3d = _loc7_.getScreenPosition(_loc9_);
            if (_loc3_ == null) {
                return param1;
            }
            var _loc10_: Number;
            var _loc4_: Number = ((_loc10_ = Number(_loc6_.y)) - _loc3_.y) * 100;
            var _loc5_: Number = _loc10_ - Math.round(_loc10_);
            var _loc2_: Number = param1.z + _loc5_ / _loc4_;
            return new Vector3d(param1.x, param1.y, _loc2_);
        }

        private function onWiredWallItemMove(param1: class_1676): void {
            var _loc4_: class_3373 = var_1630.getLegacyGeometry(var_1632);
            var _loc3_: String = param1.isDirectionRight ? "r" : "l";
            var _loc2_: IVector3d = _loc4_.getLocation(param1.oldWallX, param1.oldWallY, param1.oldOffsetX, param1.oldOffsetY, _loc3_);
            var _loc5_: IVector3d = _loc4_.getLocation(param1.newWallX, param1.newWallY, param1.newOffsetX, param1.newOffsetY, _loc3_);
            var_1630.updateObjectWallItemLocation(var_1632, param1.itemId, roundLocation(_loc2_), roundLocation(_loc5_), param1.animationTime);
        }

        private function onWiredUserMove(param1: class_1761): void {
            var _loc3_: IRoomObject = null;
            var _loc2_: IRoomInstance = null;
            var _loc5_: IRoomObjectModel = null;
            var _loc4_: * = false;
            if (param1.moveType == "sld") {
                _loc2_ = var_1630.getRoom(var_1632);
                if (_loc2_) {
                    _loc3_ = _loc2_.getObject(param1.userIndex, 100);
                    if (_loc3_ != null) {
                        _loc4_ = (_loc5_ = _loc3_.getModel()).getNumber("figure_can_stand_up") > 0;
                    }
                }
            }
            var _loc7_: IVector3d = new Vector3d(param1.bodyDirection % 8 * 45);
            var _loc6_: Number = param1.headDirection % 8 * 45;
            var_1630.updateObjectUser(var_1632, param1.userIndex, roundLocation(param1.source), roundLocation(param1.target), _loc4_, 0, _loc7_, _loc6_, param1.animationTime);
            setUserMovePosture(param1.userIndex, param1.moveType);
        }

        private function onUserDirectionUpdate(param1: class_1655): void {
            var _loc3_: IVector3d = new Vector3d(param1.bodyDirection % 8 * 45);
            var _loc2_: Number = param1.bodyDirection % 8 * 45;
            var_1630.updateObjectUserDir(var_1632, param1.userIndex, _loc3_, _loc2_);
        }

        private function setUserMovePosture(param1: int, param2: String): void {
            var _loc5_: IRoomObject = null;
            var _loc6_: String = null;
            var _loc7_: IRoomObjectModel = null;
            var _loc4_: String = null;
            var _loc3_: IRoomInstance = var_1630.getRoom(var_1632);
            if (_loc3_) {
                _loc5_ = _loc3_.getObject(param1, 100);
            }
            if (_loc5_ != null && _loc5_.getType() != "monsterplant") {
                _loc7_ = _loc5_.getModel();
                switch (param2) {
                    case "mv":
                        _loc6_ = "mv";
                        break;
                    case "sld":
                        _loc6_ = (_loc4_ = String(_loc7_.getString("figure_posture"))) == "mv" ? "std" : _loc4_;
                }
                var_1630.updateObjectUserPosture(var_1632, param1, _loc6_);
            }
        }

        private function onChat(param1: IMessageEvent): void {
            var _loc2_: class_1344 = null;
            if (var_1630 == null) {
                return;
            }
            var _loc3_: IRoomSession = var_1630.roomSessionManager.getSession(var_1632);
            if (param1 is ChatMessageEvent) {
                _loc2_ = (param1 as ChatMessageEvent).getParser();
            } else if (param1 is WhisperMessageEvent) {
                _loc2_ = (param1 as WhisperMessageEvent).getParser();
                if (_loc2_ && _loc3_ && _loc2_.userId == _loc3_.ownUserRoomId) {
                    return;
                }
            } else if (param1 is ShoutMessageEvent) {
                _loc2_ = (param1 as ShoutMessageEvent).getParser();
            }
            if (_loc2_ == null) {
                return;
            }
            var_1630.updateObjectUserGesture(var_1632, _loc2_.userId, _loc2_.gesture);
            var_1630.updateObjectUserAction(var_1632, _loc2_.userId, "figure_talk", Math.ceil(_loc2_.text.length / 10));
        }

        private function onTypingStatus(param1: IMessageEvent): void {
            var _loc2_: UserTypingMessageEvent = param1 as UserTypingMessageEvent;
            if (_loc2_ == null) {
                return;
            }
            var _loc3_: class_1489 = _loc2_.getParser();
            var _loc4_: int = 1;
            if (!_loc3_.isTyping) {
                _loc4_ = 0;
            }
            var_1630.updateObjectUserAction(var_1632, _loc3_.userId, "figure_is_typing", _loc4_);
        }

        private function onPetExperience(param1: PetExperienceEvent): void {
            if (param1 == null) {
                return;
            }
            var _loc2_: class_1369 = param1.getParser();
            var_1630.updateObjectUserAction(var_1632, _loc2_.petRoomIndex, "figure_gained_experience", _loc2_.gainedExperience);
        }

        private function onDiceValue(param1: IMessageEvent): void {
            var _loc5_: DiceValueMessageEvent;
            if ((_loc5_ = param1 as DiceValueMessageEvent) == null || _loc5_.getParser() == null) {
                return;
            }
            if (var_1630 == null) {
                return;
            }
            var _loc2_: class_1508 = _loc5_.getParser();
            var _loc4_: int = _loc2_.id;
            var _loc6_: int = _loc2_.value;
            var _loc3_: IStuffData = new LegacyStuffData();
            var_1630.updateObjectFurniture(var_1632, _loc4_, null, null, _loc6_, _loc3_);
        }

        private function onOneWayDoorStatus(param1: IMessageEvent): void {
            var _loc2_: OneWayDoorStatusMessageEvent = param1 as OneWayDoorStatusMessageEvent;
            if (_loc2_ == null || _loc2_.getParser() == null) {
                return;
            }
            if (var_1630 == null) {
                return;
            }
            var _loc3_: class_1397 = _loc2_.getParser();
            var _loc5_: int = _loc3_.id;
            var _loc6_: int = _loc3_.status;
            var _loc4_: IStuffData = new LegacyStuffData();
            var_1630.updateObjectFurniture(var_1632, _loc5_, null, null, _loc6_, _loc4_);
        }

        private function onPlayingGame(param1: YouArePlayingGameMessageEvent): void {
            if (param1 == null) {
                return;
            }
            var _loc3_: class_1298 = param1.getParser();
            var _loc2_: Boolean = _loc3_.isPlaying;
            var_1630.setIsPlayingGame(var_1632, _loc2_);
        }

        private function onYouAreNotSpectator(param1: YouAreNotSpectatorMessageEvent): void {
            if (param1 == null) {
                return;
            }
            var _loc2_: class_1524 = param1.getParser();
            if (_loc2_ == null || _loc2_.flatId != var_1632) {
                return;
            }
            var _loc3_: IRoomSession = var_1630.roomSessionManager.getSession(var_1632);
            if (_loc3_ == null) {
                return;
            }
            if (!_loc3_.isSpectatorMode) {
                return;
            }
            _loc3_.isSpectatorMode = false;
            var_1630.leaveSpectate();
        }

        private function onHanditemConfiguration(param1: HanditemConfigurationMessageEvent): void {
            if (param1 == null) {
                return;
            }
            var _loc2_: class_1441 = param1.getParser();
            var _loc3_: Boolean = _loc2_.isHanditemControlBlocked;
            var_1630.setHanditemControlBlocked(var_1632, _loc3_);
        }

        private function onGamePlayerNumberValue(param1: IMessageEvent): void {
            var _loc2_: class_1510 = null;
            var _loc3_: int = 0;
            if (var_1630 == null) {
                return;
            }
            if (param1 is GamePlayerValueMessageEvent) {
                _loc2_ = (param1 as GamePlayerValueMessageEvent).getParser();
                _loc3_ = getRoomId(0);
                var_1630.updateObjectUserAction(_loc3_, _loc2_.userId, "figure_number_value", _loc2_.value);
            }
        }

        private function onIgnoreResult(param1: IMessageEvent): void {
            if (!var_1630.configuration.getBoolean("avatar.ignored.bubble.enabled")) {
                return;
            }
            var _loc2_: IgnoreResultMessageEvent = param1 as IgnoreResultMessageEvent;
            var _loc3_: class_3490 = var_1630.roomSessionManager.getSession(var_1632).userDataManager.getUserData(_loc2_.userId);
            if (_loc3_ != null) {
                switch (_loc2_.result - 1) {
                    case 0:
                    case 1:
                        var_1630.updateObjectUserAction(var_1632, _loc3_.roomObjectId, "figure_is_muted", 1);
                        break;
                    case 2:
                        var_1630.updateObjectUserAction(var_1632, _loc3_.roomObjectId, "figure_is_muted", 0);
                }
            }
        }

        private function onGuideSessionStarted(param1: IMessageEvent): void {
            var _loc2_: class_1464 = param1.parser as class_1464;
            var_3120 = _loc2_.guideUserId;
            var_3284 = _loc2_.requesterUserId;
            updateGuideMarker();
        }

        private function onGuideSessionEnded(param1: IMessageEvent): void {
            removeGuideMarker();
        }

        private function onGuideSessionError(param1: IMessageEvent): void {
            removeGuideMarker();
        }

        private function updateGuideMarker(): void {
            var _loc1_: int = var_1630.sessionDataManager.userId;
            setUserGuideStatus(var_3120, var_3284 == _loc1_ ? 1 : 0);
            setUserGuideStatus(var_3284, var_3120 == _loc1_ ? 2 : 0);
        }

        private function removeGuideMarker(): void {
            setUserGuideStatus(var_3120, 0);
            setUserGuideStatus(var_3284, 0);
            var_3120 = -1;
            var_3284 = -1;
        }

        private function setUserGuideStatus(param1: int, param2: int): void {
            if (!var_1630 || !var_1630.roomSessionManager) {
                return;
            }
            var _loc4_: IRoomSession;
            if ((_loc4_ = var_1630.roomSessionManager.getSession(var_1632)) == null) {
                return;
            }
            var _loc3_: class_3490 = _loc4_.userDataManager.getUserDataByType(param1, 1);
            if (_loc3_ != null) {
                var_1630.updateObjectUserAction(var_1632, _loc3_.roomObjectId, "figure_guide_status", param2);
            }
        }
    }
}
