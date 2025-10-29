package com.sulake.habbo.room {
   import assets.class_14

   import com.sulake.core.assets.BitmapDataAsset
   import com.sulake.core.assets.IAssetLibrary
   import com.sulake.core.communication.connection.IConnection
   import com.sulake.core.communication.messages.IMessageComposer
   import com.sulake.core.runtime.Component
   import com.sulake.core.runtime.ComponentDependency
   import com.sulake.core.runtime.IContext
   import com.sulake.core.runtime.ICoreConfiguration
   import com.sulake.core.runtime.IUpdateReceiver
   import com.sulake.core.utils.Map
   import com.sulake.core.utils.class_3484
   import com.sulake.core.utils.images.class_3362
   import com.sulake.habbo.advertisement.class_1811
   import com.sulake.habbo.advertisement.events.AdEvent
   import com.sulake.habbo.avatar.pets.PetFigureData
   import com.sulake.habbo.catalog.IHabboCatalog
   import com.sulake.habbo.communication.IHabboCommunicationManager
   import com.sulake.habbo.communication.messages.outgoing.camera.RenderRoomThumbnailMessageComposer
   import com.sulake.habbo.communication.messages.outgoing.camera.RenderRoomMessageComposer
   import com.sulake.habbo.game.class_1805
   import com.sulake.habbo.room.events.RoomEngineAreaHideStateWidgetEvent
   import com.sulake.habbo.room.events.RoomEngineDragWithMouseEvent
   import com.sulake.habbo.room.events.RoomEngineEvent
   import com.sulake.habbo.room.events.RoomEngineHSLColorEnableEvent
   import com.sulake.habbo.room.events.RoomEngineObjectEvent
   import com.sulake.habbo.room.events.RoomEngineRoomColorEvent
   import com.sulake.habbo.room.events.RoomEngineUseProductEvent
   import com.sulake.habbo.room.events.RoomToObjectOwnAvatarMoveEvent
   import com.sulake.habbo.room.messages.RoomObjectAvatarCarryObjectUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectAvatarChatUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectAvatarDanceUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectAvatarDirectionUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectAvatarEffectUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectAvatarExperienceUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectAvatarExpressionUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectAvatarFigureUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectAvatarFlatControlUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectAvatarGestureUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectAvatarGuideStatusUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectAvatarMutedUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectAvatarOwnMessage
   import com.sulake.habbo.room.messages.RoomObjectAvatarPetGestureUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectAvatarPlayerValueUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectAvatarPlayingGameMessage
   import com.sulake.habbo.room.messages.RoomObjectAvatarPostureUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectAvatarSignUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectAvatarSleepUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectAvatarTypingUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectAvatarUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectAvatarUseObjectUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectGroupBadgeUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectHeightUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectItemDataUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectModelDataUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectMoveUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectRoomAdUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectRoomColorUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectRoomFloorHoleUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectRoomMaskUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectRoomPlanePropertyUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectRoomPlaneVisibilityUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectRoomUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectTileCursorUpdateMessage
   import com.sulake.habbo.room.messages.RoomObjectUpdateStateMessage
   import com.sulake.habbo.room.object.RoomObjectUserTypes
   import com.sulake.habbo.room.object.RoomPlaneParser
   import com.sulake.habbo.room.object.data.class_1697
   import com.sulake.habbo.room.object.data.LegacyStuffData
   import com.sulake.habbo.room.utils.RoomAreaSelectionManager
   import com.sulake.habbo.room.utils.class_1769
   import com.sulake.habbo.room.utils.class_3344
   import com.sulake.habbo.room.utils.class_3355
   import com.sulake.habbo.room.utils.class_3373
   import com.sulake.habbo.room.utils.class_3413
   import com.sulake.habbo.room.utils.class_3419
   import com.sulake.habbo.room.utils.class_3467
   import com.sulake.habbo.room.utils.class_3498
   import com.sulake.habbo.room.utils.class_3500
   import com.sulake.habbo.room.utils.class_3513
   import com.sulake.habbo.session.IRoomSession
   import com.sulake.habbo.session.IRoomSessionManager
   import com.sulake.habbo.session.ISessionDataManager
   import com.sulake.habbo.session.events.BadgeImageReadyEvent
   import com.sulake.habbo.session.events.RoomSessionEvent
   import com.sulake.habbo.toolbar.IHabboToolbar
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent
   import com.sulake.habbo.utils.class_3521
   import com.sulake.habbo.window.IHabboWindowManager
   import com.sulake.iid.*
   import com.sulake.room.IRoomInstance
   import com.sulake.room.IRoomManager
   import com.sulake.room.IRoomManagerListener
   import com.sulake.room.IRoomObjectFactory
   import com.sulake.room.RoomInstance
   import com.sulake.room.events.RoomObjectEvent
   import com.sulake.room.events.RoomObjectMouseEvent
   import com.sulake.room.messages.RoomObjectUpdateMessage
   import com.sulake.room.object.*
   import com.sulake.room.object.logic.IRoomObjectEventHandler
   import com.sulake.room.object.visualization.IRoomObjectSpriteVisualization
   import com.sulake.room.object.visualization.IRoomObjectVisualization
   import com.sulake.room.renderer.IRoomRenderer
   import com.sulake.room.renderer.IRoomRendererFactory
   import com.sulake.room.renderer.IRoomRenderingCanvas
   import com.sulake.room.utils.IRoomGeometry
   import com.sulake.room.utils.IVector3d
   import com.sulake.room.utils.NumberBank
   import com.sulake.room.utils.RoomEnterEffect
   import com.sulake.room.utils.RoomGeometry
   import com.sulake.room.utils.Vector3d
   import com.sulake.room.utils.class_1781

   import flash.display.Bitmap
   import flash.display.BitmapData
   import flash.display.DisplayObject
   import flash.display.DisplayObjectContainer
   import flash.display.LoaderInfo
   import flash.display.Sprite
   import flash.events.Event
   import flash.geom.Matrix
   import flash.geom.Point
   import flash.geom.Rectangle
   import flash.net.FileReference
   import flash.ui.Mouse
   import flash.utils.ByteArray
   import flash.utils.getTimer

   [SecureSWF(rename="true")]
    public class RoomEngine extends Component implements IRoomEngine, IRoomManagerListener, IRoomCreator, IRoomEngineServices, IUpdateReceiver, IRoomContentListener {

        public static const SETUP_WITHOUT_TOOLBAR: uint = 1;

        public static const const_492: uint = 2;

        public static const SETUP_WITHOUT_GAME_MANAGER: uint = 4;

        public static const const_443: uint = 5;

        private static const ROOM_TEMP_ID: String = "temporary_room";

        public static const OBJECT_ID_ROOM: int = -1;

        private static const OBJECT_TYPE_ROOM: String = "room";

        private static const OBJECT_ID_ROOM_HIGHLIGHTER: int = -2;

        private static const OBJECT_TYPE_ROOM_HIGHLIGHTER: String = "tile_cursor";

        private static const const_1029: int = -3;

        private static const const_675: String = "selection_arrow";

        private static const const_958: String = "overlay";

        private static const const_836: String = "object_icon_sprite";

        private static const ROOM_DRAG_THRESHOLD: int = 15;

        private static const const_1074: int = 40;

        public function RoomEngine(param1: IContext, param2: uint = 0) {
            super(param1, param2);
        }
        protected var var_1669: int = 0;
        private var _communication: IHabboCommunicationManager = null;
        private var _roomRendererFactory: IRoomRendererFactory = null;
        private var _roomObjectFactory: IRoomObjectFactory = null;
        private var _visualizationFactory: IRoomObjectVisualizationFactory = null;
        private var _adManager: class_1811 = null;
        private var var_1707: RoomObjectEventHandler = null;
        private var var_2213: RoomMessageHandler = null;
        private var var_1634: RoomContentLoader = null;
        private var var_4878: Boolean = false;
        private var var_2574: NumberBank;
        private var var_3300: Map;
        private var var_2496: NumberBank;
        private var var_2960: Map;
        private var var_2250: Boolean = false;
        private var var_2450: int = -1;
        private var var_3760: int = 0;
        private var var_3684: int = 0;
        private var var_2322: Boolean = false;
        private var var_2059: Boolean = false;
        private var var_4853: int = 0;
        private var var_4567: int = 0;
        private var _roomDraggingAlwaysCenters: Boolean = false;
        private var var_2129: Map = null;
        private var var_1990: Map = null;
        private var _skipFurnitureCreationForNextFrame: Boolean = false;
        private var _mouseCursorUpdate: Boolean;
        private var var_2155: Map = null;
        private var _gameManager: class_1805;
        private var var_3050: Boolean;
        private var var_3913: int = -1;
        private var var_3862: int = 0;
        private var var_2503: int = 0;
        private var var_4981: int = 0;
        private var var_3441: int = 0;
        private var var_4953: Boolean = true;
        private var var_4633: Boolean = false;
        private var var_2309: RoomAreaSelectionManager;

        override protected function get dependencies(): Vector.<ComponentDependency> {
            return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDRoomObjectFactory(), function (param1: IRoomObjectFactory): void {
                _roomObjectFactory = param1;
            }), new ComponentDependency(new IIDRoomObjectVisualizationFactory(), function (param1: IRoomObjectVisualizationFactory): void {
                _visualizationFactory = param1;
            }), new ComponentDependency(new IIDRoomManager(), function (param1: IRoomManager): void {
                _roomManager = param1;
            }), new ComponentDependency(new IIDRoomRendererFactory(), function (param1: IRoomRendererFactory): void {
                _roomRendererFactory = param1;
            }), new ComponentDependency(new IIDHabboCommunicationManager(), function (param1: IHabboCommunicationManager): void {
                _communication = param1;
            }, (flags & 5) == 0), new ComponentDependency(new IIDHabboConfigurationManager(), null, true, [{
                "type":"complete",
                "callback":onConfigurationComplete
            }]), new ComponentDependency(new IIDHabboAdManager(), function (param1: class_1811): void {
                _adManager = param1;
            }, false, [{
                "type":"AE_ROOM_AD_SHOW",
                "callback":showRoomAd
            }, {
                "type":"AE_ROOM_AD_IMAGE_LOADED",
                "callback":onRoomAdImageLoaded
            }, {
                "type":"AE_ROOM_AD_IMAGE_LOADING_FAILED",
                "callback":onRoomAdImageLoaded
            }]), new ComponentDependency(new IIDSessionDataManager(), function (param1: ISessionDataManager): void {
                _sessionDataManager = param1;
            }), new ComponentDependency(new IIDHabboRoomSessionManager(), function (param1: IRoomSessionManager): void {
                _roomSessionManager = param1;
            }, false, [{
                "type":"RSE_STARTED",
                "callback":onRoomSessionEvent
            }, {
                "type":"RSE_ENDED",
                "callback":onRoomSessionEvent
            }]), new ComponentDependency(new IIDHabboToolbar(), function (param1: IHabboToolbar): void {
                _toolbar = param1;
            }, false, [{
                "type":"HTE_TOOLBAR_CLICK",
                "callback":onToolbarClicked
            }]), new ComponentDependency(new IIDHabboCatalog(), function (param1: IHabboCatalog): void {
                _catalog = param1;
            }, false), new ComponentDependency(new IIDHabboGameManager(), function (param1: class_1805): void {
                _gameManager = param1;
            }, (flags & 4) == 0), new ComponentDependency(new IIDHabboWindowManager(), function (param1: IHabboWindowManager): void {
                _windowManager = param1;
            })]);
        }

        private var _roomManager: IRoomManager = null;

        public function get roomManager(): IRoomManager {
            return _roomManager;
        }

        private var _sessionDataManager: ISessionDataManager = null;

        public function get sessionDataManager(): ISessionDataManager {
            return _sessionDataManager;
        }

        private var _roomSessionManager: IRoomSessionManager = null;

        public function get roomSessionManager(): IRoomSessionManager {
            return _roomSessionManager;
        }

        private var _toolbar: IHabboToolbar = null;

        public function get toolbar(): IHabboToolbar {
            return _toolbar;
        }

        private var _catalog: IHabboCatalog = null;

        public function get catalog(): IHabboCatalog {
            return _catalog;
        }

        private var _windowManager: IHabboWindowManager;

        public function get windowManager(): IHabboWindowManager {
            return _windowManager;
        }

        public function get mouseEventsDisabledAboveY(): int {
            return var_3862;
        }

        public function set mouseEventsDisabledAboveY(param1: int): void {
            var_3862 = param1;
        }

        public function get mouseEventsDisabledLeftToX(): int {
            return var_2503;
        }

        public function set mouseEventsDisabledLeftToX(param1: int): void {
            var_2503 = param1;
        }

        public function get isInitialized(): Boolean {
            return var_2250;
        }

        public function get connection(): IConnection {
            return _communication != null ? _communication.connection : null;
        }

        public function get activeRoomId(): int {
            return var_1669;
        }

        public function get configuration(): ICoreConfiguration {
            return this;
        }

        public function get gameEngine(): class_1805 {
            return _gameManager;
        }

        public function set disableUpdate(param1: Boolean): void {
            if (param1) {
                removeUpdateReceiver(this);
            } else {
                removeUpdateReceiver(this);
                registerUpdateReceiver(this, 1);
            }
        }

        public function get activeRoomHasHanditemControlBlocked(): Boolean {
            return getHasHanditemControlBlocked(var_1669);
        }

        public function get isDecorateMode(): Boolean {
            if (!_roomSessionManager) {
                return false;
            }
            var _loc1_: IRoomSession = _roomSessionManager.getSession(var_1669);
            return _loc1_ && _loc1_.isUserDecorating;
        }

        public function get isGameMode(): Boolean {
            return var_3050;
        }

        public function set isGameMode(param1: Boolean): void {
            var_3050 = param1;
        }

        public function get playerUnderCursor(): int {
            return var_3913;
        }

        public function get roomContentLoader(): RoomContentLoader {
            return var_1634;
        }

        public function get areaSelectionManager(): IRoomAreaSelectionManager {
            return var_2309;
        }

        protected function get eventHandler(): RoomObjectEventHandler {
            return var_1707;
        }

        private function get useOffsetScrolling(): Boolean {
            return true;
        }

        private function get cameraFollowDuration(): int {
            return getBoolean("room.camera.follow_user") ? 1000 : 0;
        }

        override protected function initComponent(): void {
            var_1990 = new Map();
            var_2574 = new NumberBank(1000);
            var_2496 = new NumberBank(1000);
            var_3300 = new Map();
            var_2960 = new Map();
            var_2129 = new Map();
            var_1707 = createRoomObjectEventHandlerInstance();
            var_2213 = new RoomMessageHandler(this);
            registerUpdateReceiver(this, 1);
            _roomObjectFactory.addObjectEventListener(roomObjectEventHandler);
            var_2309 = new RoomAreaSelectionManager(this);
        }

        override public function dispose(): void {
            var _loc2_: int = 0;
            var _loc1_: class_3344 = null;
            if (disposed) {
                return;
            }
            removeUpdateReceiver(this);
            if (var_2309 != null) {
                var_2309.dispose();
                var_2309 = null;
            }
            if (var_2574 != null) {
                var_2574.dispose();
                var_2574 = null;
            }
            if (var_2496 != null) {
                var_2496.dispose();
                var_2496 = null;
            }
            if (var_3300 != null) {
                var_3300.dispose();
            }
            if (var_2960 != null) {
                var_2960.dispose();
            }
            if (var_1707 != null) {
                var_1707.dispose();
                var_1707 = null;
            }
            if (var_2213 != null) {
                var_2213.dispose();
                var_2213 = null;
            }
            if (var_1634 != null) {
                var_1634.dispose();
                var_1634 = null;
            }
            if (var_2129 != null) {
                var_2129.dispose();
                var_2129 = null;
            }
            if (var_1990 != null) {
                _loc2_ = 0;
                while (_loc2_ < var_1990.length) {
                    _loc1_ = var_1990.getWithIndex(_loc2_) as class_3344;
                    if (_loc1_ != null) {
                        _loc1_.dispose();
                    }
                    _loc2_++;
                }
                var_1990.dispose();
                var_1990 = null;
            }
            if (var_2155 != null) {
                var_2155.dispose();
                var_2155 = null;
            }
            super.dispose();
        }

        override public function purge(): void {
            super.purge();
            if (var_1634) {
                var_1634.purge();
            }
        }

        public function runUpdate(): void {
            update(1);
        }

        public function setFurniStackingHeightMap(param1: int, param2: class_3419): void {
            var _loc3_: class_3344 = getRoomInstanceData(param1);
            if (_loc3_ != null) {
                _loc3_.furniStackingHeightMap = param2;
            }
        }

        public function getFurniStackingHeightMap(param1: int): class_3419 {
            var _loc2_: class_3344 = getRoomInstanceData(param1);
            if (_loc2_ != null) {
                return _loc2_.furniStackingHeightMap;
            }
            return null;
        }

        public function setWorldType(param1: int, param2: String): void {
            var _loc3_: class_3344 = getRoomInstanceData(param1);
            if (_loc3_ != null) {
                _loc3_.worldType = param2;
            }
        }

        public function getWorldType(param1: int): String {
            var _loc2_: class_3344 = getRoomInstanceData(param1);
            if (_loc2_ != null) {
                return _loc2_.worldType;
            }
            return null;
        }

        public function getLegacyGeometry(param1: int): class_3373 {
            var _loc2_: class_3344 = getRoomInstanceData(param1);
            if (_loc2_ != null) {
                return _loc2_.legacyGeometry;
            }
            return null;
        }

        public function getTileObjectMap(param1: int): class_3513 {
            var _loc2_: class_3344 = getRoomInstanceData(param1);
            if (_loc2_ != null) {
                return _loc2_.tileObjectMap;
            }
            return null;
        }

        public function setSelectedObjectData(param1: int, param2: class_3413): void {
            var _loc3_: class_3344 = getRoomInstanceData(param1);
            if (_loc3_ != null) {
                _loc3_.selectedObject = param2;
                if (param2 != null) {
                    _loc3_.placedObject = null;
                }
            }
        }

        public function getSelectedObjectData(param1: int): ISelectedRoomObjectData {
            var _loc2_: class_3344 = getRoomInstanceData(param1);
            if (_loc2_ != null) {
                return _loc2_.selectedObject;
            }
            return null;
        }

        public function setPlacedObjectData(param1: int, param2: class_3413): void {
            var _loc3_: class_3344 = getRoomInstanceData(param1);
            if (_loc3_ != null) {
                _loc3_.placedObject = param2;
            }
        }

        public function getPlacedObjectData(param1: int): ISelectedRoomObjectData {
            var _loc2_: class_3344 = getRoomInstanceData(param1);
            if (_loc2_ != null) {
                return _loc2_.placedObject;
            }
            return null;
        }

        public function addObjectUpdateCategory(param1: int): void {
            _roomManager.addObjectUpdateCategory(param1);
        }

        public function removeObjectUpdateCategory(param1: int): void {
            _roomManager.removeObjectUpdateCategory(param1);
        }

        public function update(param1: uint): void {
            var _loc2_: int = 0;
            var _loc3_: IRoomInstance = null;
            RoomEnterEffect.turnVisualizationOn();
            if (_roomManager != null) {
                createRoomFurniture();
                _roomManager.update(param1);
                _loc2_ = 0;
                while (_loc2_ < _roomManager.getRoomCount()) {
                    _loc3_ = _roomManager.getRoomWithIndex(_loc2_);
                    if (_loc3_ != null && _loc3_.getRenderer() != null) {
                        _loc3_.getRenderer().update(param1);
                    }
                    _loc2_++;
                }
                updateRoomCameras(param1);
                if (_mouseCursorUpdate) {
                    updateMouseCursor();
                }
            }
            RoomEnterEffect.turnVisualizationOff();
        }

        public function requestMouseCursor(param1: String, param2: int, param3: String): void {
            var _loc4_: int = getRoomObjectCategory(param3);
            var _loc5_: * = param1;
            if ("ROFCAE_MOUSE_BUTTON" !== _loc5_) {
                if (isGameMode && _loc4_ == 100) {
                    var_3913 = -1;
                }
                removeButtonMouseCursorOwner(var_1669, _loc4_, param2);
            } else {
                if (isGameMode && _loc4_ == 100) {
                    var_3913 = param2;
                }
                addButtonMouseCursorOwner(var_1669, _loc4_, param2);
            }
        }

        public function addFloorHole(param1: int, param2: int): void {
            var _loc8_: IRoomObjectController = null;
            var _loc9_: IRoomObjectController = null;
            var _loc5_: String = null;
            var _loc3_: int = 0;
            var _loc4_: int = 0;
            var _loc7_: int = 0;
            var _loc6_: int = 0;
            if (param2 >= 0) {
                _loc8_ = getObjectRoom(param1);
                if ((_loc9_ = getObjectFurniture(param1, param2)) != null && _loc9_.getModel() != null && _loc8_ != null && _loc8_.getEventHandler() != null) {
                    _loc5_ = "RORPFHUM_ADD";
                    _loc3_ = int(_loc9_.getLocation().x);
                    _loc4_ = int(_loc9_.getLocation().y);
                    _loc7_ = int(_loc9_.getModel().getNumber("furniture_size_x"));
                    _loc6_ = int(_loc9_.getModel().getNumber("furniture_size_y"));
                    _loc8_.getEventHandler().processUpdateMessage(new RoomObjectRoomFloorHoleUpdateMessage(_loc5_, param2, _loc3_, _loc4_, _loc7_, _loc6_));
                }
            }
        }

        public function removeFloorHole(param1: int, param2: int): void {
            var _loc4_: IRoomObjectController = null;
            var _loc3_: String = null;
            if (param2 >= 0) {
                if ((_loc4_ = getObjectRoom(param1)) != null && _loc4_.getEventHandler() != null) {
                    _loc3_ = "RORPFHUM_REMOVE";
                    _loc4_.getEventHandler().processUpdateMessage(new RoomObjectRoomFloorHoleUpdateMessage(_loc3_, param2));
                }
            }
        }

        public function getRoomGeometry(param1: int): RoomGeometry {
            var _loc2_: IRoomRenderingCanvas = getRoomCanvas(param1, 1);
            if (_loc2_ == null) {
                return null;
            }
            return _loc2_.geometry as RoomGeometry;
        }

        public function roomManagerInitialized(param1: Boolean): void {
            var _loc3_: int = 0;
            var _loc2_: class_1769 = null;
            if (param1) {
                var_2250 = true;
                events.dispatchEvent(new RoomEngineEvent("REE_ENGINE_INITIALIZED", 0));
                _loc3_ = 0;
                while (_loc3_ < var_2129.length) {
                    _loc2_ = var_2129.getWithIndex(_loc3_) as class_1769;
                    if (_loc2_ != null) {
                        initializeRoom(_loc2_.roomId, _loc2_.data);
                    }
                    _loc3_++;
                }
            } else {
                class_14.log("[RoomEngine] Failed to initialize manager");
            }
        }

        public function setActiveRoom(param1: int): void {
            var_1669 = param1;
        }

        public function getRoomIdentifier(param1: int): String {
            return String(param1);
        }

        public function getRoomNumberValue(param1: int, param2: String): Number {
            var _loc3_: IRoomInstance = getRoom(param1);
            if (_loc3_ != null) {
                return _loc3_.getNumber(param2);
            }
            return NaN;
        }

        public function getRoomStringValue(param1: int, param2: String): String {
            var _loc3_: IRoomInstance = getRoom(param1);
            if (_loc3_ != null) {
                return _loc3_.getString(param2);
            }
            return null;
        }

        public function setIsPlayingGame(param1: int, param2: Boolean): void {
            var _loc3_: int = 0;
            var _loc4_: IRoomInstance;
            if ((_loc4_ = getRoom(param1)) != null) {
                _loc3_ = param2 ? 1 : 0;
                _loc4_.setNumber("is_playing_game", _loc3_);
                if (_loc3_ == 0) {
                    events.dispatchEvent(new RoomEngineEvent("REE_NORMAL_MODE", param1));
                } else {
                    events.dispatchEvent(new RoomEngineEvent("REE_GAME_MODE", param1));
                }
            }
        }

        public function leaveSpectate(): void {
            events.dispatchEvent(new RoomEngineEvent("REE_ENTRANCE_AFTER_SPECTATE", var_1669));
        }

        public function setHanditemControlBlocked(param1: int, param2: Boolean): void {
            var _loc3_: int = 0;
            var _loc4_: IRoomInstance;
            if ((_loc4_ = getRoom(param1)) != null) {
                _loc3_ = param2 ? 1 : 0;
                _loc4_.setNumber("handitem_control_blocked", _loc3_);
            }
        }

        public function getIsPlayingGame(param1: int): Boolean {
            var _loc2_: Number = NaN;
            var _loc3_: IRoomInstance = getRoom(param1);
            if (_loc3_ != null) {
                _loc2_ = _loc3_.getNumber("is_playing_game");
                if (_loc2_ > 0) {
                    return true;
                }
            }
            return false;
        }

        public function getHasHanditemControlBlocked(param1: int): Boolean {
            var _loc2_: Number = NaN;
            var _loc3_: IRoomInstance = getRoom(param1);
            if (_loc3_ != null) {
                _loc2_ = _loc3_.getNumber("handitem_control_blocked");
                if (_loc2_ > 0) {
                    return true;
                }
            }
            return false;
        }

        public function getActiveRoomIsPlayingGame(): Boolean {
            return getIsPlayingGame(var_1669);
        }

        public function getRoom(param1: int): IRoomInstance {
            if (!var_2250) {
                return null;
            }
            var _loc2_: String = getRoomIdentifier(param1);
            return _roomManager.getRoom(_loc2_);
        }

        public function initializeRoom(param1: int, param2: XML): void {
            var _loc3_: String = getRoomIdentifier(param1);
            var _loc5_: class_1769 = null;
            var _loc6_: String = "111";
            var _loc7_: String = "201";
            var _loc4_: String = "1";
            if (!var_2250) {
                if ((_loc5_ = var_2129.remove(_loc3_)) != null) {
                    _loc6_ = _loc5_.floorType;
                    _loc7_ = _loc5_.wallType;
                    _loc4_ = _loc5_.landscapeType;
                }
                (_loc5_ = new class_1769(param1, param2)).floorType = _loc6_;
                _loc5_.wallType = _loc7_;
                _loc5_.landscapeType = _loc4_;
                var_2129.add(_loc3_, _loc5_);
                class_14.log("Room Engine not initilized yet, can not create room. Room data stored for later initialization.");
                return;
            }
            if (param2 == null) {
                class_14.log("Room property messages received before floor height map, will initialize when floor height map received.");
                return;
            }
            if ((_loc5_ = var_2129.remove(_loc3_)) != null) {
                if (_loc5_.floorType != null && _loc5_.floorType.length > 0) {
                    _loc6_ = _loc5_.floorType;
                }
                if (_loc5_.wallType != null && _loc5_.wallType.length > 0) {
                    _loc7_ = _loc5_.wallType;
                }
                if (_loc5_.landscapeType != null && _loc5_.landscapeType.length > 0) {
                    _loc4_ = _loc5_.landscapeType;
                }
            }
            var _loc8_: IRoomInstance;
            if ((_loc8_ = createRoom(_loc3_, param2, _loc6_, _loc7_, _loc4_, getWorldType(param1))) == null) {
                return;
            }
            events.dispatchEvent(new RoomEngineEvent("REE_INITIALIZED", param1));
        }

        public function getObjectRoom(param1: int): IRoomObjectController {
            return getObject(getRoomIdentifier(param1), -1, 0);
        }

        public function updateObjectRoom(param1: int, param2: String = null, param3: String = null, param4: String = null, param5: Boolean = false): Boolean {
            var _loc6_: String = null;
            var _loc8_: class_1769 = null;
            var _loc10_: IRoomObjectController = getObjectRoom(param1);
            var _loc7_: IRoomInstance = getRoom(param1);
            if (_loc10_ == null) {
                _loc6_ = getRoomIdentifier(param1);
                if ((_loc8_ = var_2129.getValue(_loc6_)) == null) {
                    _loc8_ = new class_1769(param1, null);
                    var_2129.add(_loc6_, _loc8_);
                }
                if (param2 != null) {
                    _loc8_.floorType = param2;
                }
                if (param3 != null) {
                    _loc8_.wallType = param3;
                }
                if (param4 != null) {
                    _loc8_.landscapeType = param4;
                }
                return true;
            }
            if (_loc10_.getEventHandler() == null) {
                return false;
            }
            var _loc9_: RoomObjectRoomUpdateMessage = null;
            if (param2 != null) {
                if (_loc7_ != null && !param5) {
                    _loc7_.setString("room_floor_type", param2);
                }
                _loc9_ = new RoomObjectRoomUpdateMessage("RORUM_ROOM_FLOOR_UPDATE", param2);
                _loc10_.getEventHandler().processUpdateMessage(_loc9_);
            }
            if (param3 != null) {
                if (_loc7_ != null && !param5) {
                    _loc7_.setString("room_wall_type", param3);
                }
                _loc9_ = new RoomObjectRoomUpdateMessage("RORUM_ROOM_WALL_UPDATE", param3);
                _loc10_.getEventHandler().processUpdateMessage(_loc9_);
            }
            if (param4 != null) {
                if (_loc7_ != null && !param5) {
                    _loc7_.setString("room_landscape_type", param4);
                }
                _loc9_ = new RoomObjectRoomUpdateMessage("RORUM_ROOM_LANDSCAPE_UPDATE", param4);
                _loc10_.getEventHandler().processUpdateMessage(_loc9_);
            }
            return true;
        }

        public function updateObjectRoomColor(param1: int, param2: uint, param3: int, param4: Boolean): Boolean {
            var _loc6_: IRoomObjectController;
            if ((_loc6_ = getObjectRoom(param1)) == null || _loc6_.getEventHandler() == null) {
                return false;
            }
            var _loc5_: RoomObjectRoomColorUpdateMessage = null;
            _loc5_ = new RoomObjectRoomColorUpdateMessage("RORCUM_BACKGROUND_COLOR", param2, param3, param4);
            _loc6_.getEventHandler().processUpdateMessage(_loc5_);
            events.dispatchEvent(new RoomEngineRoomColorEvent(param1, param2, param3, param4));
            return true;
        }

        public function updateObjectRoomBackgroundColor(param1: int, param2: Boolean, param3: int, param4: int, param5: int): Boolean {
            var _loc6_: IRoomObjectController;
            if ((_loc6_ = getObjectRoom(param1)) == null || _loc6_.getEventHandler() == null) {
                return false;
            }
            events.dispatchEvent(new RoomEngineHSLColorEnableEvent("ROHSLCEE_ROOM_BACKGROUND_COLOR", param1, param2, param3, param4, param5));
            return true;
        }

        public function updateObjectRoomVisibilities(param1: int, param2: Boolean, param3: Boolean = true): Boolean {
            var _loc4_: IRoomObjectController;
            if ((_loc4_ = getObjectRoom(param1)) == null || _loc4_.getEventHandler() == null) {
                return false;
            }
            var _loc5_: RoomObjectRoomPlaneVisibilityUpdateMessage = null;
            _loc5_ = new RoomObjectRoomPlaneVisibilityUpdateMessage("RORPVUM_WALL_VISIBILITY", param2);
            _loc4_.getEventHandler().processUpdateMessage(_loc5_);
            _loc5_ = new RoomObjectRoomPlaneVisibilityUpdateMessage("RORPVUM_FLOOR_VISIBILITY", param3);
            _loc4_.getEventHandler().processUpdateMessage(_loc5_);
            return true;
        }

        public function updateObjectRoomPlaneThicknesses(param1: int, param2: Number, param3: Number): Boolean {
            var _loc4_: IRoomObjectController;
            if ((_loc4_ = getObjectRoom(param1)) == null || _loc4_.getEventHandler() == null) {
                return false;
            }
            var _loc5_: RoomObjectRoomPlanePropertyUpdateMessage = null;
            _loc5_ = new RoomObjectRoomPlanePropertyUpdateMessage("RORPPUM_WALL_THICKNESS", param2);
            _loc4_.getEventHandler().processUpdateMessage(_loc5_);
            _loc5_ = new RoomObjectRoomPlanePropertyUpdateMessage("RORPVUM_FLOOR_THICKNESS", param3);
            _loc4_.getEventHandler().processUpdateMessage(_loc5_);
            return true;
        }

        public function updateAreaHide(param1: int, param2: int, param3: Boolean, param4: int, param5: int, param6: int, param7: int, param8: Boolean): Boolean {
            var _loc10_: RoomObjectRoomFloorHoleUpdateMessage = null;
            var _loc9_: RoomEngineAreaHideStateWidgetEvent = new RoomEngineAreaHideStateWidgetEvent(param1, param2, 10, param3);
            events.dispatchEvent(_loc9_);
            var _loc11_: IRoomObjectController;
            if ((_loc11_ = getObjectRoom(param1)) == null || _loc11_.getEventHandler() == null) {
                return false;
            }
            if (param3) {
                _loc10_ = new RoomObjectRoomFloorHoleUpdateMessage("RORPFHUM_ADD", param2, param4, param5, param6, param7, param8);
            } else {
                _loc10_ = new RoomObjectRoomFloorHoleUpdateMessage("RORPFHUM_REMOVE", param2);
            }
            _loc11_.getEventHandler().processUpdateMessage(_loc10_);
            return true;
        }

        public function disposeRoom(param1: int): void {
            var _loc2_: String = getRoomIdentifier(param1);
            _roomManager.disposeRoom(_loc2_);
            var _loc3_: class_3344 = var_1990.remove(_loc2_);
            if (_loc3_ != null) {
                _loc3_.dispose();
            }
            events.dispatchEvent(new RoomEngineEvent("REE_DISPOSED", param1));
        }

        public function setOwnUserId(param1: int, param2: int): void {
            var _loc3_: IRoomSession = _roomSessionManager.getSession(param1);
            if (_loc3_) {
                _loc3_.ownUserRoomId = param2;
            }
            var _loc4_: class_3355;
            if ((_loc4_ = getRoomCamera(param1)) != null) {
                _loc4_.targetId = param2;
                _loc4_.targetCategory = 100;
                _loc4_.activateFollowing(cameraFollowDuration);
            }
        }

        public function createRoomCanvas(param1: int, param2: int, param3: int, param4: int, param5: int): DisplayObject {
            var _loc17_: Number = NaN;
            var _loc16_: Number = NaN;
            var _loc14_: Number = NaN;
            var _loc12_: Number = NaN;
            var _loc13_: Vector3d = null;
            var _loc15_: Vector3d = null;
            var _loc8_: Sprite = null;
            var _loc11_: String = getRoomIdentifier(param1);
            var _loc9_: IRoomInstance;
            if ((_loc9_ = _roomManager.getRoom(_loc11_)) == null) {
                return null;
            }
            var _loc6_: IRoomRenderer;
            if ((_loc6_ = _loc9_.getRenderer() as IRoomRenderer) == null) {
                _loc6_ = _roomRendererFactory.createRenderer();
            }
            if (_loc6_ == null) {
                return null;
            }
            _loc6_.roomObjectVariableAccurateZ = "object_accurate_z_value";
            _loc9_.setRenderer(_loc6_);
            var _loc7_: IRoomRenderingCanvas;
            if ((_loc7_ = _loc6_.createCanvas(param2, param3, param4, param5)) == null) {
                return null;
            }
            _loc7_.mouseListener = var_1707;
            if (_loc7_.geometry != null) {
                _loc7_.geometry.z_scale = _loc9_.getNumber("room_z_scale");
            }
            if (_loc7_.geometry != null) {
                _loc17_ = _loc9_.getNumber("room_door_x");
                _loc16_ = _loc9_.getNumber("room_door_y");
                _loc14_ = _loc9_.getNumber("room_door_z");
                _loc12_ = _loc9_.getNumber("room_door_dir");
                _loc13_ = new Vector3d(_loc17_, _loc16_, _loc14_);
                _loc15_ = null;
                if (_loc12_ == 90) {
                    _loc15_ = new Vector3d(-2000, 0, 0);
                }
                if (_loc12_ == 180) {
                    _loc15_ = new Vector3d(0, -2000, 0);
                }
                _loc7_.geometry.setDisplacement(_loc13_, _loc15_);
            }
            var _loc10_: Sprite;
            if ((_loc10_ = _loc7_.displayObject as Sprite) != null) {
                (_loc8_ = new Sprite()).name = "overlay";
                _loc8_.mouseEnabled = false;
                _loc10_.addChild(_loc8_);
            }
            return _loc10_;
        }

        public function setRoomCanvasScale(param1: int, param2: int, param3: Number, param4: Point = null, param5: Point = null, param6: Boolean = false, param7: Boolean = false, param8: Boolean = false): void {
            if (!getBoolean("zoom.enabled")) {
                return;
            }
            if (!param7) {
                param3 = param6 ? -1 : (param3 < 1 ? 0.5 : Math.floor(param3));
            }
            var _loc9_: IRoomRenderingCanvas;
            if ((_loc9_ = getRoomCanvas(param1, param2)) != null) {
                _loc9_.setScale(param3, param4, param5, param8);
                events.dispatchEvent(new RoomEngineEvent("REE_ROOM_ZOOMED", param1));
            }
        }

        public function getRoomCanvasScale(param1: int = -1000, param2: int = -1): Number {
            if (param1 == -1000) {
                param1 = var_1669;
            }
            if (param2 == -1) {
                param2 = var_2450;
            }
            var _loc3_: IRoomRenderingCanvas = getRoomCanvas(param1, param2);
            if (_loc3_ == null) {
                return 1;
            }
            return _loc3_.scale;
        }

        public function getRoomCanvas(param1: int, param2: int): IRoomRenderingCanvas {
            var _loc3_: String = getRoomIdentifier(param1);
            var _loc6_: IRoomInstance;
            if ((_loc6_ = _roomManager.getRoom(_loc3_)) == null) {
                return null;
            }
            var _loc4_: IRoomRenderer;
            if ((_loc4_ = _loc6_.getRenderer() as IRoomRenderer) == null) {
                return null;
            }
            return _loc4_.getCanvas(param2);
        }

        public function modifyRoomCanvas(param1: int, param2: int, param3: int, param4: int): Boolean {
            var _loc5_: IRoomRenderingCanvas;
            if ((_loc5_ = getRoomCanvas(param1, param2)) == null) {
                return false;
            }
            _loc5_.initialize(param3, param4);
            return true;
        }

        public function setRoomCanvasMask(param1: int, param2: int, param3: Boolean): void {
            var _loc4_: IRoomRenderingCanvas;
            if ((_loc4_ = getRoomCanvas(param1, param2)) == null) {
                return;
            }
            _loc4_.useMask = param3;
        }

        public function getRoomCanvasGeometry(param1: int, param2: int = -1): IRoomGeometry {
            if (param2 == -1) {
                param2 = var_2450;
            }
            var _loc3_: IRoomRenderingCanvas = getRoomCanvas(param1, param2);
            if (_loc3_ == null) {
                return null;
            }
            return _loc3_.geometry;
        }

        public function getRoomCanvasScreenOffset(param1: int, param2: int = -1): Point {
            if (param2 == -1) {
                param2 = var_2450;
            }
            var _loc3_: IRoomRenderingCanvas = getRoomCanvas(param1, param2);
            if (_loc3_ == null) {
                return null;
            }
            return new Point(_loc3_.screenOffsetX, _loc3_.screenOffsetY);
        }

        public function setRoomCanvasScreenOffset(param1: int, param2: int, param3: Point): Boolean {
            var _loc4_: IRoomRenderingCanvas;
            if ((_loc4_ = getRoomCanvas(param1, param2)) == null || param3 == null) {
                return false;
            }
            _loc4_.screenOffsetX = param3.x;
            _loc4_.screenOffsetY = param3.y;
            return true;
        }

        public function snapshotRoomCanvasToBitmap(param1: int, param2: int, param3: BitmapData, param4: Matrix, param5: Boolean): Boolean {
            var _loc7_: IRoomRenderingCanvas;
            if (!(_loc7_ = getRoomCanvas(param1, param2))) {
                return false;
            }
            var _loc6_: DisplayObject;
            if (!(_loc6_ = _loc7_.displayObject)) {
                return false;
            }
            param3.draw(_loc6_, param4, null, null, null, param5);
            return true;
        }

        public function handleRoomCanvasMouseEvent(param1: int, param2: int, param3: int, param4: String, param5: Boolean, param6: Boolean, param7: Boolean, param8: Boolean): void {
            var _loc12_: Number = NaN;
            var _loc10_: Sprite = null;
            var _loc11_: Sprite = null;
            var _loc15_: Rectangle = null;
            var _loc14_: String = null;
            var _loc13_: RoomObjectEvent = null;
            if (var_3862 > 0 && param3 < var_3862) {
                return;
            }
            if (var_2503 > 0 && param2 < var_2503) {
                return;
            }
            var _loc9_: IRoomRenderingCanvas;
            if ((_loc9_ = getRoomCanvas(var_1669, param1)) != null) {
                if (_sessionDataManager.isPerkAllowed("MOUSE_ZOOM") && param4 == "click" && param6 && param5) {
                    _loc12_ = Number(param7 ? _loc9_.scale >> 1 : (_loc9_.scale < 1 ? 1 : _loc9_.scale << 1));
                    setRoomCanvasScale(activeRoomId, var_2450, _loc12_, new Point(param2, param3));
                    return;
                }
                _loc10_ = getOverlaySprite(_loc9_);
                if ((_loc11_ = getOverlayIconSprite(_loc10_, "object_icon_sprite")) != null) {
                    _loc15_ = _loc11_.getRect(_loc11_);
                    _loc11_.x = param2 - _loc15_.width / 2;
                    _loc11_.y = param3 - _loc15_.height / 2;
                }
                if (param4 == "click" && var_2309.finishSelecting()) {
                    var_2309.finishSelecting();
                } else if (!handleRoomDragging(_loc9_, param2, param3, param4, param5, param6, param7)) {
                    if (!_loc9_.handleMouseEvent(param2, param3, param4, param5, param6, param7, param8)) {
                        _loc14_ = "";
                        if (param4 == "click") {
                            if (events != null) {
                                events.dispatchEvent(new RoomEngineObjectEvent("REOE_DESELECTED", var_1669, -1, -2));
                            }
                            _loc14_ = "ROE_MOUSE_CLICK";
                        } else if (param4 == "mouseMove") {
                            _loc14_ = "ROE_MOUSE_MOVE";
                        } else if (param4 == "mouseDown") {
                            _loc14_ = "ROE_MOUSE_DOWN";
                        }
                        if (var_1707 != null) {
                            _loc13_ = new RoomObjectMouseEvent(_loc14_, getRoomObject(var_1669, -1, 0), null, param5);
                            var_1707.handleRoomObjectEvent(_loc13_, var_1669);
                        }
                    }
                }
                var_2450 = param1;
                var_3760 = param2;
                var_3684 = param3;
            }
        }

        public function setObjectMoverIconSprite(param1: int, param2: int, param3: Boolean, param4: String = null, param5: IStuffData = null, param6: int = -1, param7: int = -1, param8: String = null): void {
            var _loc13_: String = null;
            var _loc12_: int = 0;
            var _loc14_: PetFigureData = null;
            var _loc10_: Sprite = null;
            var _loc11_: Sprite = null;
            var _loc15_: class_3499 = null;
            if (param3) {
                _loc15_ = getRoomObjectImage(var_1669, param1, param2, new Vector3d(), 1, null);
            } else if (var_1634 != null) {
                _loc13_ = null;
                _loc12_ = 0;
                if (param2 == 10) {
                    _loc13_ = var_1634.getActiveObjectType(param1);
                    _loc12_ = var_1634.getActiveObjectColorIndex(param1);
                } else if (param2 == 20) {
                    _loc13_ = var_1634.getWallItemType(param1, param4);
                    _loc12_ = var_1634.getWallItemColorIndex(param1);
                }
                if (param2 == 100) {
                    if ((_loc13_ = RoomObjectUserTypes.getName(param1)) == "pet") {
                        _loc13_ = getPetType(param4);
                        _loc14_ = new PetFigureData(param4);
                        _loc15_ = getPetImage(_loc14_.typeId, _loc14_.paletteId, _loc14_.color, new Vector3d(180), 64, null, true, 0, _loc14_.customParts, param8);
                    } else {
                        _loc15_ = getGenericRoomObjectImage(_loc13_, param4, new Vector3d(180), 1, null, 0, null, param5, param6, param7, param8);
                    }
                } else {
                    _loc15_ = getGenericRoomObjectImage(_loc13_, String(_loc12_), new Vector3d(), 1, null, 0, param4, param5, param6, param7, param8);
                }
            }
            if (_loc15_ == null || _loc15_.data == null) {
                return;
            }
            var _loc9_: IRoomRenderingCanvas;
            if ((_loc9_ = getActiveRoomActiveCanvas()) != null) {
                _loc10_ = getOverlaySprite(_loc9_);
                removeOverlayIconSprite(_loc10_, "object_icon_sprite");
                if ((_loc11_ = addOverlayIconSprite(_loc10_, "object_icon_sprite", _loc15_.data)) != null) {
                    _loc11_.x = var_3760 - _loc15_.data.width / 2;
                    _loc11_.y = var_3684 - _loc15_.data.height / 2;
                }
            }
        }

        public function setObjectMoverIconSpriteVisible(param1: Boolean): void {
            var _loc3_: Sprite = null;
            var _loc4_: Sprite = null;
            var _loc2_: IRoomRenderingCanvas = getActiveRoomActiveCanvas();
            if (_loc2_ != null) {
                _loc3_ = getOverlaySprite(_loc2_);
                if ((_loc4_ = getOverlayIconSprite(_loc3_, "object_icon_sprite")) != null) {
                    _loc4_.visible = param1;
                }
            }
        }

        public function removeObjectMoverIconSprite(): void {
            var _loc2_: Sprite = null;
            var _loc1_: IRoomRenderingCanvas = getActiveRoomActiveCanvas();
            if (_loc1_ != null) {
                _loc2_ = getOverlaySprite(_loc1_);
                removeOverlayIconSprite(_loc2_, "object_icon_sprite");
            }
        }

        public function getRoomObjectCount(param1: int, param2: int): int {
            if (!var_2250) {
                return 0;
            }
            var _loc3_: String = getRoomIdentifier(param1);
            var _loc4_: IRoomInstance;
            if ((_loc4_ = _roomManager.getRoom(_loc3_)) == null) {
                return 0;
            }
            return _loc4_.getObjectCount(param2);
        }

        public function getRoomObject(param1: int, param2: int, param3: int): IRoomObject {
            if (!var_2250) {
                return null;
            }
            var _loc4_: String = getRoomIdentifier(param1);
            if (param1 == 0) {
                _loc4_ = "temporary_room";
            }
            return getObject(_loc4_, param2, param3);
        }

        public function getObjectsByCategory(param1: int): Array {
            var _loc2_: IRoomInstance = null;
            if (_roomManager != null) {
                _loc2_ = _roomManager.getRoom(getRoomIdentifier(var_1669));
            }
            if (_loc2_ == null) {
                return [];
            }
            return _loc2_.getObjects(param1);
        }

        public function getRoomObjectWithIndex(param1: int, param2: int, param3: int): IRoomObject {
            if (!var_2250) {
                return null;
            }
            var _loc4_: String = getRoomIdentifier(param1);
            var _loc5_: IRoomInstance;
            if ((_loc5_ = _roomManager.getRoom(_loc4_)) == null) {
                return null;
            }
            return _loc5_.getObjectWithIndex(param2, param3);
        }

        public function getRoomObjects(param1: int, param2: int): Array {
            var _loc3_: String = null;
            var _loc4_: IRoomInstance = null;
            if (var_2250) {
                _loc3_ = getRoomIdentifier(param1);
                if ((_loc4_ = _roomManager.getRoom(_loc3_)) != null) {
                    return _loc4_.getObjects(param2);
                }
            }
            return [];
        }

        public function modifyRoomObject(param1: int, param2: int, param3: String): Boolean {
            if (var_1707 != null) {
                return var_1707.modifyRoomObject(var_1669, param1, param2, param3);
            }
            return false;
        }

        public function modifyRoomObjectDataWithMap(param1: int, param2: int, param3: String, param4: Map): Boolean {
            if (var_1707 != null) {
                if (param2 == 10) {
                    return var_1707.modifyRoomObjectData(var_1669, param1, param2, param3, param4);
                }
            }
            return false;
        }

        public function modifyRoomObjectData(param1: int, param2: int, param3: String, param4: String): Boolean {
            if (var_1707 != null) {
                if (param2 == 20) {
                    return var_1707.modifyWallItemData(var_1669, param1, param3, param4);
                }
            }
            return false;
        }

        public function deleteRoomObject(param1: int, param2: int): Boolean {
            if (var_1707 != null) {
                if (param2 == 20) {
                    return var_1707.deleteWallItem(var_1669, param1);
                }
            }
            return false;
        }

        public function initializeRoomObjectInsert(param1: String, param2: int, param3: int, param4: int, param5: String = null, param6: IStuffData = null, param7: int = -1, param8: int = -1, param9: String = null, param10: Boolean = false): Boolean {
            var _loc11_: IRoomInstance;
            if ((_loc11_ = getRoom(var_1669)) == null || _loc11_.getNumber("room_is_public") != 0) {
                return false;
            }
            if (var_1707 != null) {
                return var_1707.initializeRoomObjectInsert(param1, var_1669, param2, param3, param4, param5, param6, param7, param8, param9, param10);
            }
            return false;
        }

        public function cancelRoomObjectInsert(): void {
            if (var_1707 != null) {
                var_1707.cancelRoomObjectInsert(var_1669);
            }
        }

        public function useRoomObjectInActiveRoom(param1: int, param2: int): Boolean {
            var _loc3_: IRoomObjectEventHandler = null;
            var _loc4_: IRoomObject;
            if ((_loc4_ = getRoomObject(var_1669, param1, param2)) != null) {
                _loc3_ = _loc4_.getMouseHandler() as IRoomObjectEventHandler;
                if (_loc3_ != null) {
                    _loc3_.useObject();
                    return true;
                }
            }
            return false;
        }

        public function setRoomObjectAlias(param1: String, param2: String): void {
            if (var_1634 != null) {
                var_1634.setRoomObjectAlias(param1, param2);
            }
        }

        public function getRoomObjectCategory(param1: String): int {
            if (var_1634 != null) {
                return var_1634.getObjectCategory(param1);
            }
            return -2;
        }

        public function getFurnitureType(param1: int): String {
            if (var_1634 != null) {
                return var_1634.getActiveObjectType(param1);
            }
            return "";
        }

        public function getFurnitureTypeId(param1: String): int {
            if (var_1634 != null) {
                return var_1634.getActiveObjectTypeId(param1);
            }
            return 0;
        }

        public function getWallItemType(param1: int, param2: String = null): String {
            if (var_1634 != null) {
                return var_1634.getWallItemType(param1, param2);
            }
            return "";
        }

        public function getPetTypeId(param1: String): int {
            var _loc2_: Array = null;
            var _loc3_: int = -1;
            if (param1 != null) {
                _loc2_ = param1.split(" ");
                if (_loc2_.length > 1) {
                    _loc3_ = parseInt(_loc2_[0]);
                }
            }
            return _loc3_;
        }

        public function getPetColor(param1: int, param2: int): PetColorResult {
            if (var_1634 != null) {
                return var_1634.getPetColor(param1, param2);
            }
            return null;
        }

        public function getPetColorsByTag(param1: int, param2: String): Array {
            if (var_1634 != null) {
                return var_1634.getPetColorsByTag(param1, param2);
            }
            return null;
        }

        public function getPetLayerIdForTag(param1: int, param2: String): int {
            if (var_1634 != null) {
                return var_1634.getPetLayerIdForTag(param1, param2);
            }
            return -1;
        }

        public function getPetDefaultPalette(param1: int, param2: String): PetColorResult {
            if (var_1634 != null) {
                return var_1634.getPetDefaultPalette(param1, param2);
            }
            return null;
        }

        public function getSelectionArrow(param1: int): IRoomObjectController {
            return getObject(getRoomIdentifier(param1), -3, 200);
        }

        public function getTileCursor(param1: int): IRoomObjectController {
            return getObject(getRoomIdentifier(param1), -2, 200);
        }

        public function setTileCursorState(param1: int, param2: int): void {
            var _loc4_: RoomObjectDataUpdateMessage = null;
            var _loc3_: IRoomObjectController = getTileCursor(param1);
            if (_loc3_ != null && _loc3_.getEventHandler() != null) {
                _loc4_ = new RoomObjectDataUpdateMessage(param2, null);
                _loc3_.getEventHandler().processUpdateMessage(_loc4_);
            }
        }

        public function toggleTileCursorVisibility(param1: int, param2: Boolean): void {
            var _loc4_: RoomObjectTileCursorUpdateMessage = null;
            var _loc3_: IRoomObjectController = getTileCursor(param1);
            if (_loc3_ != null && _loc3_.getEventHandler() != null) {
                _loc4_ = new RoomObjectTileCursorUpdateMessage(null, 0, param2, "", true);
                _loc3_.getEventHandler().processUpdateMessage(_loc4_);
            }
        }

        public function addObjectFurniture(param1: int, param2: int, param3: int, param4: IVector3d, param5: IVector3d, param6: int, param7: IStuffData, param8: Number = NaN, param9: int = -1, param10: int = 0, param11: int = 0, param12: String = "", param13: Boolean = true, param14: Boolean = true, param15: Number = -1): Boolean {
            var _loc17_: class_3498 = null;
            var _loc16_: class_3344;
            if ((_loc16_ = getRoomInstanceData(param1)) != null) {
                _loc17_ = new class_3498(param2, param3, null, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14, param15);
                _loc16_.addFurnitureData(_loc17_);
            }
            return true;
        }

        public function addObjectFurnitureByName(param1: int, param2: int, param3: String, param4: IVector3d, param5: IVector3d, param6: int, param7: IStuffData, param8: Number = NaN): Boolean {
            var _loc10_: class_3498 = null;
            var _loc9_: class_3344;
            if ((_loc9_ = getRoomInstanceData(param1)) != null) {
                _loc10_ = new class_3498(param2, 0, param3, param4, param5, param6, param7, param8, 0);
                _loc9_.addFurnitureData(_loc10_);
            }
            return true;
        }

        public function changeObjectState(param1: int, param2: int, param3: int): void {
            var _loc6_: Number = NaN;
            var _loc5_: int = 0;
            var _loc4_: IStuffData = null;
            var _loc7_: RoomObjectDataUpdateMessage = null;
            var _loc8_: IRoomObjectController;
            if ((_loc8_ = getObject(getRoomIdentifier(param1), param2, param3)) != null && _loc8_.getModelController() != null) {
                _loc6_ = Number(_loc8_.getModelController().getNumber("furniture_automatic_state_index"));
                if (isNaN(_loc6_)) {
                    _loc6_ = 1;
                } else {
                    _loc6_ += 1;
                }
                _loc8_.getModelController().setNumber("furniture_automatic_state_index", _loc6_);
                _loc5_ = int(_loc8_.getModel().getNumber("furniture_data_format"));
                (_loc4_ = class_1697.getStuffDataWrapperForType(_loc5_)).initializeFromRoomObjectModel(_loc8_.getModel());
                _loc7_ = new RoomObjectDataUpdateMessage(_loc6_, _loc4_);
                if (_loc8_.getEventHandler() != null) {
                    _loc8_.getEventHandler().processUpdateMessage(_loc7_);
                }
            }
        }

        public function changeObjectModelData(param1: int, param2: int, param3: int, param4: String, param5: int): Boolean {
            var _loc6_: RoomObjectModelDataUpdateMessage = null;
            var _loc7_: IRoomObjectController;
            if ((_loc7_ = getObject(getRoomIdentifier(param1), param2, param3)) == null) {
                return false;
            }
            if (_loc7_ != null && _loc7_.getEventHandler() != null) {
                _loc6_ = new RoomObjectModelDataUpdateMessage(param4, param5);
                _loc7_.getEventHandler().processUpdateMessage(_loc6_);
            }
            return true;
        }

        public function updateObjectFurniture(param1: int, param2: int, param3: IVector3d, param4: IVector3d, param5: int, param6: IStuffData, param7: Number = NaN): Boolean {
            var _loc10_: IRoomObjectController;
            if ((_loc10_ = getObjectFurniture(param1, param2)) == null) {
                return false;
            }
            var _loc8_: RoomObjectUpdateMessage = new RoomObjectUpdateMessage(param3, param4);
            var _loc9_: RoomObjectDataUpdateMessage = new RoomObjectDataUpdateMessage(param5, param6, param7);
            if (_loc10_ != null && _loc10_.getEventHandler() != null) {
                _loc10_.getEventHandler().processUpdateMessage(_loc8_);
                _loc10_.getEventHandler().processUpdateMessage(_loc9_);
            }
            return true;
        }

        public function updateObjectFurnitureHeight(param1: int, param2: int, param3: Number): Boolean {
            var _loc4_: RoomObjectHeightUpdateMessage = null;
            var _loc5_: IRoomObjectController;
            if ((_loc5_ = getObjectFurniture(param1, param2)) == null) {
                return false;
            }
            if (_loc5_ != null && _loc5_.getEventHandler() != null) {
                _loc4_ = new RoomObjectHeightUpdateMessage(null, null, param3);
                _loc5_.getEventHandler().processUpdateMessage(_loc4_);
            }
            return true;
        }

        public function updateObjectFurnitureLocation(param1: int, param2: int, param3: IVector3d, param4: IVector3d, param5: IVector3d, param6: Number = NaN): Boolean {
            var _loc7_: RoomObjectMoveUpdateMessage = null;
            var _loc8_: IRoomObjectController;
            if ((_loc8_ = getObjectFurniture(param1, param2)) == null) {
                return false;
            }
            if (_loc8_ != null && _loc8_.getEventHandler() != null) {
                _loc7_ = new RoomObjectMoveUpdateMessage(param3, param5, param4, param6, param5 != null);
                _loc8_.getEventHandler().processUpdateMessage(_loc7_);
            }
            return true;
        }

        public function updateObjectFurnitureExpiryTime(param1: int, param2: int, param3: int): Boolean {
            var _loc4_: IRoomObjectController;
            if ((_loc4_ = getObjectFurniture(param1, param2)) == null) {
                return false;
            }
            _loc4_.getModelController().setNumber("furniture_expiry_time", param3);
            _loc4_.getModelController().setNumber("furniture_expirty_timestamp", getTimer());
            return true;
        }

        public function disposeObjectFurniture(param1: int, param2: int, param3: int = -1, param4: Boolean = false): void {
            var _loc14_: IRoomObject = null;
            var _loc12_: Point = null;
            var _loc9_: IRoomObjectModel = null;
            var _loc10_: * = false;
            var _loc11_: int = 0;
            var _loc7_: String = null;
            var _loc13_: int = 0;
            var _loc8_: IStuffData = null;
            var _loc5_: BitmapData = null;
            var _loc6_: class_3344;
            if ((_loc6_ = getRoomInstanceData(param1)) != null) {
                _loc6_.getFurnitureDataWithId(param2);
            }
            if (_sessionDataManager && param3 == _sessionDataManager.userId && !class_3521.isBuilderClubId(param2)) {
                if (_loc14_ = getRoomObject(param1, param2, 10)) {
                    if (_loc12_ = getRoomObjectScreenLocation(param1, param2, 10, var_2450)) {
                        if (!(_loc10_ = (_loc9_ = _loc14_.getModel()).getNumber("furniture_disable_picking_animation") == 1)) {
                            _loc11_ = int(_loc9_.getNumber("furniture_type_id"));
                            _loc7_ = String(_loc9_.getString("furniture_extras"));
                            _loc13_ = int(_loc9_.getNumber("furniture_data_format"));
                            _loc8_ = class_1697.getStuffDataWrapperForType(_loc13_);
                            if (_loc5_ = getFurnitureIcon(_loc11_, null, _loc7_, _loc8_).data) {
                                _toolbar.createTransitionToIcon("HTIE_ICON_INVENTORY", _loc5_, _loc12_.x, _loc12_.y);
                            }
                        }
                    }
                }
            }
            disposeObject(param1, param2, 10);
            removeButtonMouseCursorOwner(param1, 10, param2);
            if (param4) {
                refreshTileObjectMap(param1, "RoomEngine.disposeObjectFurniture()");
            }
        }

        public function addObjectWallItem(param1: int, param2: int, param3: int, param4: IVector3d, param5: IVector3d, param6: int, param7: String, param8: int = 0, param9: int = 0, param10: String = "", param11: int = -1, param12: Boolean = true): Boolean {
            var _loc15_: LegacyStuffData = null;
            var _loc14_: class_3498 = null;
            var _loc13_: class_3344;
            if ((_loc13_ = getRoomInstanceData(param1)) != null) {
                (_loc15_ = new LegacyStuffData()).setString(param7);
                _loc14_ = new class_3498(param2, param3, null, param4, param5, param6, _loc15_, NaN, param11, param8, param9, param10, true, param12);
                _loc13_.addWallItemData(_loc14_);
            }
            return true;
        }

        public function updateObjectWallItem(param1: int, param2: int, param3: IVector3d, param4: IVector3d, param5: int, param6: String): Boolean {
            var _loc10_: IRoomObjectController;
            if ((_loc10_ = getObjectWallItem(param1, param2)) == null) {
                return false;
            }
            var _loc8_: RoomObjectUpdateMessage = new RoomObjectUpdateMessage(param3, param4);
            var _loc7_: LegacyStuffData;
            (_loc7_ = new LegacyStuffData()).setString(param6);
            var _loc9_: RoomObjectDataUpdateMessage = new RoomObjectDataUpdateMessage(param5, _loc7_);
            if (_loc10_ != null && _loc10_.getEventHandler() != null) {
                _loc10_.getEventHandler().processUpdateMessage(_loc8_);
                _loc10_.getEventHandler().processUpdateMessage(_loc9_);
            }
            updateObjectRoomWindow(param1, param2);
            return true;
        }

        public function updateObjectWallItemState(param1: int, param2: int, param3: int, param4: String): Boolean {
            var _loc7_: IRoomObjectController;
            if ((_loc7_ = getObjectWallItem(param1, param2)) == null) {
                return false;
            }
            var _loc5_: LegacyStuffData;
            (_loc5_ = new LegacyStuffData()).setString(param4);
            var _loc6_: RoomObjectDataUpdateMessage = new RoomObjectDataUpdateMessage(param3, _loc5_);
            if (_loc7_ != null && _loc7_.getEventHandler() != null) {
                _loc7_.getEventHandler().processUpdateMessage(_loc6_);
            }
            return true;
        }

        public function updateObjectRoomWindow(param1: int, param2: int, param3: Boolean = true): void {
            var _loc5_: String = null;
            var _loc4_: IVector3d = null;
            var _loc7_: String = "20_" + param2;
            var _loc6_: RoomObjectRoomMaskUpdateMessage = null;
            var _loc9_: IRoomObjectController;
            if ((_loc9_ = getObjectWallItem(param1, param2)) != null) {
                if (_loc9_.getModel() != null) {
                    if (_loc9_.getModel().getNumber("furniture_uses_plane_mask") > 0) {
                        _loc5_ = String(_loc9_.getModel().getString("furniture_plane_mask_type"));
                        _loc4_ = _loc9_.getLocation();
                        if (param3) {
                            _loc6_ = new RoomObjectRoomMaskUpdateMessage("RORMUM_ADD_MASK", _loc7_, _loc5_, _loc4_);
                        } else {
                            _loc6_ = new RoomObjectRoomMaskUpdateMessage("RORMUM_ADD_MASK", _loc7_);
                        }
                    }
                }
            } else {
                _loc6_ = new RoomObjectRoomMaskUpdateMessage("RORMUM_ADD_MASK", _loc7_);
            }
            var _loc8_: IRoomObjectController;
            if ((_loc8_ = getObjectRoom(param1)) != null && _loc8_.getEventHandler() != null && _loc6_ != null) {
                _loc8_.getEventHandler().processUpdateMessage(_loc6_);
            }
        }

        public function updateObjectWallItemData(param1: int, param2: int, param3: String): Boolean {
            var _loc5_: IRoomObjectController;
            if ((_loc5_ = getObjectWallItem(param1, param2)) == null) {
                return false;
            }
            var _loc4_: RoomObjectItemDataUpdateMessage = new RoomObjectItemDataUpdateMessage(param3);
            if (_loc5_ != null && _loc5_.getEventHandler() != null) {
                _loc5_.getEventHandler().processUpdateMessage(_loc4_);
            }
            return true;
        }

        public function updateObjectWallItemLocation(param1: int, param2: int, param3: IVector3d, param4: IVector3d = null, param5: Number = NaN): Boolean {
            var _loc6_: RoomObjectMoveUpdateMessage = null;
            var _loc7_: IRoomObjectController;
            if ((_loc7_ = getObjectWallItem(param1, param2)) == null) {
                return false;
            }
            if (_loc7_.getEventHandler() != null) {
                _loc6_ = new RoomObjectMoveUpdateMessage(param3, param4, null, param5, param4 != null);
                _loc7_.getEventHandler().processUpdateMessage(_loc6_);
            }
            updateObjectRoomWindow(param1, param2);
            return true;
        }

        public function updateObjectWallItemExpiryTime(param1: int, param2: int, param3: int): Boolean {
            var _loc4_: IRoomObjectController;
            if ((_loc4_ = getObjectWallItem(param1, param2)) == null) {
                return false;
            }
            _loc4_.getModelController().setNumber("furniture_expiry_time", param3);
            _loc4_.getModelController().setNumber("furniture_expirty_timestamp", getTimer());
            return true;
        }

        public function disposeObjectWallItem(param1: int, param2: int, param3: int = -1): void {
            var _loc10_: IRoomObject = null;
            var _loc6_: Point = null;
            var _loc8_: IRoomObjectModel = null;
            var _loc9_: int = 0;
            var _loc7_: String = null;
            var _loc4_: BitmapData = null;
            var _loc5_: class_3344;
            if ((_loc5_ = getRoomInstanceData(param1)) != null) {
                _loc5_.getWallItemDataWithId(param2);
            }
            if (_sessionDataManager && param3 == _sessionDataManager.userId && !class_3521.isBuilderClubId(param2)) {
                if ((_loc10_ = getRoomObject(param1, param2, 20)) && _loc10_.getType().indexOf("post_it") == -1 && _loc10_.getType().indexOf("external_image_wallitem") == -1) {
                    _loc6_ = getRoomObjectScreenLocation(param1, param2, 20, var_2450);
                    _loc9_ = int((_loc8_ = _loc10_.getModel()).getNumber("furniture_type_id"));
                    _loc7_ = String(_loc8_.getString("furniture_data"));
                    _loc4_ = getWallItemIcon(_loc9_, null, _loc7_).data;
                    if (_toolbar && _loc6_) {
                        _toolbar.createTransitionToIcon("HTIE_ICON_INVENTORY", _loc4_, _loc6_.x, _loc6_.y);
                    }
                }
            }
            disposeObject(param1, param2, 20);
            updateObjectRoomWindow(param1, param2, false);
            removeButtonMouseCursorOwner(param1, 20, param2);
        }

        public function addObjectUser(param1: int, param2: int, param3: IVector3d, param4: IVector3d, param5: Number, param6: int, param7: String = null): Boolean {
            var _loc9_: RoomObjectUpdateMessage = null;
            var _loc8_: RoomObjectAvatarFigureUpdateMessage = null;
            if (getObjectUser(param1, param2) != null) {
                return false;
            }
            var _loc10_: String;
            if ((_loc10_ = RoomObjectUserTypes.getName(param6)) == "pet") {
                _loc10_ = getPetType(param7);
            }
            var _loc11_: IRoomObjectController;
            if ((_loc11_ = createObjectUser(param1, param2, _loc10_)) == null) {
                return false;
            }
            if (_loc11_ != null && _loc11_.getEventHandler() != null) {
                _loc9_ = new RoomObjectAvatarUpdateMessage(fixedUserLocation(param1, param3), null, param4, param5, false, 0);
                _loc11_.getEventHandler().processUpdateMessage(_loc9_);
                if (param7 != null) {
                    _loc8_ = new RoomObjectAvatarFigureUpdateMessage(param7);
                    _loc11_.getEventHandler().processUpdateMessage(_loc8_);
                }
            }
            if (events != null) {
                events.dispatchEvent(new RoomEngineObjectEvent("REOE_ADDED", param1, param2, 100));
            }
            return true;
        }

        public function addObjectSnowWar(param1: int, param2: int, param3: IVector3d, param4: int): Boolean {
            var _loc5_: String = null;
            var _loc6_: RoomObjectUpdateMessage = null;
            if (param4 == 201) {
                _loc5_ = "game_snowball";
            } else if (param4 == 202) {
                _loc5_ = "game_snowsplash";
            }
            var _loc7_: IRoomObjectController;
            if (!(_loc7_ = createObjectSnowWar(param1, param2, _loc5_, param4))) {
                return false;
            }
            if (_loc7_.getEventHandler()) {
                _loc6_ = new RoomObjectUpdateMessage(param3, null);
                _loc7_.getEventHandler().processUpdateMessage(_loc6_);
            }
            return true;
        }

        public function addObjectSnowSplash(param1: int, param2: int, param3: IVector3d): Boolean {
            var _loc4_: RoomObjectUpdateMessage = null;
            _roomManager.addObjectUpdateCategory(202);
            var _loc5_: IRoomObjectController;
            if (!(_loc5_ = createObjectSnowWar(param1, param2, "game_snowsplash", 202))) {
                return false;
            }
            if (_loc5_.getEventHandler()) {
                _loc4_ = new RoomObjectUpdateMessage(param3, null);
                _loc5_.getEventHandler().processUpdateMessage(_loc4_);
            }
            return true;
        }

        public function updateObjectUser(param1: int, param2: int, param3: IVector3d, param4: IVector3d, param5: Boolean = false, param6: Number = 0, param7: IVector3d = null, param8: Number = NaN, param9: Number = NaN, param10: Boolean = false): Boolean {
            var _loc12_: IRoomObjectController;
            if ((_loc12_ = getObjectUser(param1, param2)) == null || _loc12_.getEventHandler() == null || _loc12_.getModel() == null) {
                return false;
            }
            if (param3 == null) {
                param3 = _loc12_.getLocation();
            }
            if (param7 == null) {
                param7 = _loc12_.getDirection();
            }
            if (isNaN(param8)) {
                param8 = Number(_loc12_.getModel().getNumber("head_direction"));
            }
            var _loc11_: RoomObjectUpdateMessage = new RoomObjectAvatarUpdateMessage(fixedUserLocation(param1, param3), fixedUserLocation(param1, param4), param7, param8, param5, param6, param9, param10);
            _loc12_.getEventHandler().processUpdateMessage(_loc11_);
            if (roomSessionManager && roomSessionManager.getSession(param1) && param2 == roomSessionManager.getSession(param1).ownUserRoomId) {
                _roomObjectFactory.events.dispatchEvent(new RoomToObjectOwnAvatarMoveEvent("ROAME_MOVE_TO", param4));
            }
            return true;
        }

        public function updateObjectUserDir(param1: int, param2: int, param3: IVector3d, param4: Number): Boolean {
            var _loc6_: IRoomObjectController;
            if ((_loc6_ = getObjectUser(param1, param2)) == null || _loc6_.getEventHandler() == null || _loc6_.getModel() == null) {
                return false;
            }
            var _loc5_: RoomObjectUpdateMessage = new RoomObjectAvatarDirectionUpdateMessage(null, param3, param4);
            _loc6_.getEventHandler().processUpdateMessage(_loc5_);
            return true;
        }

        public function updateObjectSnowWar(param1: int, param2: int, param3: IVector3d, param4: int): Boolean {
            var _loc5_: IRoomObjectController = getObject(getRoomIdentifier(param1), param2, param4);
            var _loc6_: RoomObjectUpdateMessage = new RoomObjectUpdateMessage(param3, null);
            _loc5_.getEventHandler().processUpdateMessage(_loc6_);
            return true;
        }

        public function disposeObjectSnowWar(param1: int, param2: int, param3: int): void {
            disposeObject(param1, param2, param3);
        }

        public function updateObjectUserFlatControl(param1: int, param2: int, param3: String): Boolean {
            var _loc5_: IRoomObjectController;
            if ((_loc5_ = getObjectUser(param1, param2)) == null || _loc5_.getEventHandler() == null) {
                return false;
            }
            var _loc4_: RoomObjectUpdateStateMessage = new RoomObjectAvatarFlatControlUpdateMessage(param3);
            _loc5_.getEventHandler().processUpdateMessage(_loc4_);
            return true;
        }

        public function updateObjectUserOwnUserAvatar(param1: int, param2: int): Boolean {
            var _loc3_: IRoomObjectController = getObjectUser(param1, param2);
            if (_loc3_ == null || _loc3_.getEventHandler() == null) {
                return false;
            }
            var _loc4_: RoomObjectUpdateMessage = new RoomObjectAvatarOwnMessage();
            _loc3_.getEventHandler().processUpdateMessage(_loc4_);
            return true;
        }

        public function updateObjectUserFigure(param1: int, param2: int, param3: String, param4: String = null, param5: String = null, param6: Boolean = false): Boolean {
            var _loc8_: IRoomObjectController;
            if ((_loc8_ = getObjectUser(param1, param2)) == null || _loc8_.getEventHandler() == null) {
                return false;
            }
            var _loc7_: RoomObjectUpdateStateMessage = new RoomObjectAvatarFigureUpdateMessage(param3, param4, param5, param6);
            _loc8_.getEventHandler().processUpdateMessage(_loc7_);
            return true;
        }

        public function updateObjectUserAction(param1: int, param2: int, param3: String, param4: int, param5: String = null): Boolean {
            var _loc7_: IRoomObjectController;
            if ((_loc7_ = getObjectUser(param1, param2)) == null || _loc7_.getEventHandler() == null) {
                return false;
            }
            var _loc6_: RoomObjectUpdateStateMessage = null;
            switch (param3) {
                case "figure_talk":
                    _loc6_ = new RoomObjectAvatarChatUpdateMessage(param4);
                    break;
                case "figure_sleep":
                    _loc6_ = new RoomObjectAvatarSleepUpdateMessage(param4 != 0);
                    break;
                case "figure_is_typing":
                    _loc6_ = new RoomObjectAvatarTypingUpdateMessage(param4 != 0);
                    break;
                case "figure_is_muted":
                    _loc6_ = new RoomObjectAvatarMutedUpdateMessage(param4 != 0);
                    break;
                case "figure_carry_object":
                    _loc6_ = new RoomObjectAvatarCarryObjectUpdateMessage(param4, param5);
                    break;
                case "figure_use_object":
                    _loc6_ = new RoomObjectAvatarUseObjectUpdateMessage(param4);
                    break;
                case "figure_dance":
                    _loc6_ = new RoomObjectAvatarDanceUpdateMessage(param4);
                    break;
                case "figure_gained_experience":
                    _loc6_ = new RoomObjectAvatarExperienceUpdateMessage(param4);
                    break;
                case "figure_number_value":
                    _loc6_ = new RoomObjectAvatarPlayerValueUpdateMessage(param4);
                    break;
                case "figure_sign":
                    _loc6_ = new RoomObjectAvatarSignUpdateMessage(param4);
                    break;
                case "figure_expression":
                    _loc6_ = new RoomObjectAvatarExpressionUpdateMessage(param4);
                    break;
                case "figure_is_playing_game":
                    _loc6_ = new RoomObjectAvatarPlayingGameMessage(param4 != 0);
                    break;
                case "figure_guide_status":
                    _loc6_ = new RoomObjectAvatarGuideStatusUpdateMessage(param4);
            }
            _loc7_.getEventHandler().processUpdateMessage(_loc6_);
            return true;
        }

        public function updateObjectUserPosture(param1: int, param2: int, param3: String, param4: String = ""): Boolean {
            var _loc6_: IRoomObjectController;
            if ((_loc6_ = getObjectUser(param1, param2)) == null || _loc6_.getEventHandler() == null) {
                return false;
            }
            var _loc5_: RoomObjectUpdateStateMessage = new RoomObjectAvatarPostureUpdateMessage(param3, param4);
            _loc6_.getEventHandler().processUpdateMessage(_loc5_);
            return true;
        }

        public function updateObjectUserGesture(param1: int, param2: int, param3: int): Boolean {
            var _loc5_: IRoomObjectController;
            if ((_loc5_ = getObjectUser(param1, param2)) == null || _loc5_.getEventHandler() == null) {
                return false;
            }
            var _loc4_: RoomObjectUpdateStateMessage = new RoomObjectAvatarGestureUpdateMessage(param3);
            _loc5_.getEventHandler().processUpdateMessage(_loc4_);
            return true;
        }

        public function updateObjectPetGesture(param1: int, param2: int, param3: String): Boolean {
            var _loc5_: IRoomObjectController;
            if ((_loc5_ = getObjectUser(param1, param2)) == null || _loc5_.getEventHandler() == null) {
                return false;
            }
            var _loc4_: RoomObjectUpdateStateMessage = new RoomObjectAvatarPetGestureUpdateMessage(param3);
            _loc5_.getEventHandler().processUpdateMessage(_loc4_);
            return true;
        }

        public function updateObjectUserEffect(param1: int, param2: int, param3: int, param4: int = 0): Boolean {
            var _loc5_: IRoomObjectController;
            if ((_loc5_ = getObjectUser(param1, param2)) == null || _loc5_.getEventHandler() == null) {
                return false;
            }
            _loc5_.getEventHandler().processUpdateMessage(new RoomObjectAvatarEffectUpdateMessage(param3, param4));
            return true;
        }

        public function disposeObjectUser(param1: int, param2: int): void {
            disposeObject(param1, param2, 100);
        }

        public function createScreenShot(param1: int, param2: int, param3: String): void {
            var _loc10_: ByteArray = null;
            var _loc7_: FileReference = null;
            var _loc5_: Date = null;
            var _loc6_: String = null;
            var _loc4_: RegExp = /[:\/\\\*\?"<>\|%]/g;
            param3 = param3.replace(_loc4_, "");
            var _loc9_: IRoomRenderingCanvas;
            if (!(_loc9_ = getRoomCanvas(param1, param2))) {
                return;
            }
            var _loc8_: BitmapData = _loc9_.takeScreenShot();
            if (class_3484.isVersionAtLeast(11, 3)) {
            }
            if (_loc10_ == null) {
                _loc10_ = class_3362.encode(_loc8_);
            }
            try {
                (_loc7_ = new FileReference()).save(_loc10_, param3);
            } catch (error: Error) {
                _loc6_ = [(_loc5_ = new Date()).getFullYear(), _loc5_.getMonth(), _loc5_.getDate()].join("-") + " " + [_loc5_.getHours(), _loc5_.getMinutes(), _loc5_.getSeconds()].join(".");
                param3 = "Habbo " + _loc6_;
                (_loc7_ = new FileReference()).save(_loc10_, param3);
            }
        }

        public function purgeRoomContent(): void {
            if (var_1634) {
                var_1634.purge();
            }
        }

        public function getFurnitureIconUrl(param1: int): String {
            var _loc3_: String = null;
            var _loc2_: String = "";
            if (var_1634 != null) {
                _loc3_ = var_1634.getActiveObjectType(param1);
                _loc2_ = String(var_1634.getActiveObjectColorIndex(param1));
            }
            return var_1634.getObjectUrl(_loc3_, _loc2_);
        }

        public function getFurnitureIcon(param1: int, param2: IGetImageListener, param3: String = null, param4: IStuffData = null, param5: Boolean = false): class_3499 {
            return getFurnitureImage(param1, new Vector3d(), 1, param2, 0, param3, -1, -1, param4, param5);
        }

        public function getWallItemIconUrl(param1: int, param2: String = null): String {
            var _loc4_: String = null;
            var _loc3_: String = "";
            if (var_1634 != null) {
                _loc4_ = var_1634.getWallItemType(param1, param2);
                _loc3_ = String(var_1634.getWallItemColorIndex(param1));
            }
            return var_1634.getObjectUrl(_loc4_, _loc3_);
        }

        public function getWallItemIcon(param1: int, param2: IGetImageListener, param3: String = null): class_3499 {
            return getWallItemImage(param1, new Vector3d(), 1, param2, 0, param3);
        }

        public function getFurnitureImage(param1: int, param2: IVector3d, param3: int, param4: IGetImageListener, param5: uint = 0, param6: String = null, param7: int = -1, param8: int = -1, param9: IStuffData = null, param10: Boolean = false): class_3499 {
            var _loc12_: String = null;
            var _loc11_: String = "";
            if (var_1634 != null) {
                _loc12_ = var_1634.getActiveObjectType(param1);
                _loc11_ = String(var_1634.getActiveObjectColorIndex(param1));
            }
            if (param3 == 1 && param4 != null && !param10) {
                return getGenericRoomObjectThumbnail(_loc12_, _loc11_, param4, param6, param9);
            }
            return getGenericRoomObjectImage(_loc12_, _loc11_, param2, param3, param4, param5, param6, param9, param7, param8);
        }

        public function getPetImage(param1: int, param2: int, param3: int, param4: IVector3d, param5: int, param6: IGetImageListener, param7: Boolean = true, param8: uint = 0, param9: Array = null, param10: String = null): class_3499 {
            var _loc11_: String = null;
            var _loc13_: String = param1 + " " + param2 + " " + param3.toString(16);
            if (!param7) {
                _loc13_ += " head";
            }
            if (param9 != null) {
                _loc13_ += " " + param9.length;
                for each(var _loc12_ in param9) {
                    _loc13_ += " " + _loc12_.layerId + " " + _loc12_.partId + " " + _loc12_.paletteId;
                }
            }
            if (var_1634 != null) {
                _loc11_ = var_1634.getPetType(param1);
            }
            return getGenericRoomObjectImage(_loc11_, _loc13_, param4, param5, param6, param8, null, null, -1, -1, param10);
        }

        public function getWallItemImage(param1: int, param2: IVector3d, param3: int, param4: IGetImageListener, param5: uint = 0, param6: String = null, param7: int = -1, param8: int = -1): class_3499 {
            var _loc10_: String = null;
            var _loc9_: String = "";
            if (var_1634 != null) {
                _loc10_ = var_1634.getWallItemType(param1, param6);
                _loc9_ = String(var_1634.getWallItemColorIndex(param1));
            }
            if (param3 == 1 && param4 != null) {
                return getGenericRoomObjectThumbnail(_loc10_, _loc9_, param4, param6, null);
            }
            return getGenericRoomObjectImage(_loc10_, _loc9_, param2, param3, param4, param5, param6, null, param7, param8);
        }

        public function getRoomImage(param1: String, param2: String, param3: String, param4: int, param5: IGetImageListener, param6: String = null): class_3499 {
            if (param1 == null) {
                param1 = "";
            }
            if (param2 == null) {
                param2 = "";
            }
            if (param3 == null) {
                param3 = "";
            }
            var _loc8_: String = "room";
            var _loc7_: String = param1 + "\n" + param2 + "\n" + param3 + "\n";
            if (param6 != null) {
                _loc7_ += param6;
            }
            return getGenericRoomObjectImage(_loc8_, _loc7_, new Vector3d(), param4, param5);
        }

        public function getRoomObjectImage(param1: int, param2: int, param3: int, param4: IVector3d, param5: int, param6: IGetImageListener, param7: uint = 0): class_3499 {
            var _loc9_: String = null;
            var _loc16_: IRoomObject = null;
            var _loc8_: int = 0;
            var _loc10_: String = null;
            var _loc13_: String = "";
            var _loc14_: IStuffData = null;
            var _loc15_: int = -1;
            var _loc12_: String = getRoomIdentifier(param1);
            var _loc11_: IRoomInstance;
            if ((_loc11_ = _roomManager.getRoom(_loc12_)) != null) {
                if ((_loc16_ = _loc11_.getObject(param2, param3)) != null && _loc16_.getModel() != null) {
                    _loc10_ = _loc16_.getType();
                    _loc15_ = _loc16_.getId();
                    switch (param3) {
                        case 10:
                        case 20:
                            _loc13_ = String(_loc16_.getModel().getNumber("furniture_color"));
                            _loc9_ = String(_loc16_.getModel().getString("furniture_extras"));
                            if ((_loc8_ = int(_loc16_.getModel().getNumber("furniture_data_format"))) != 0) {
                                (_loc14_ = class_1697.getStuffDataWrapperForType(_loc8_)).initializeFromRoomObjectModel(_loc16_.getModel());
                            }
                            break;
                        case 100:
                            _loc13_ = String(_loc16_.getModel().getString("figure"));
                    }
                }
            }
            return getGenericRoomObjectImage(_loc10_, _loc13_, param4, param5, param6, param7, _loc9_, _loc14_, -1, -1, null, _loc15_);
        }

        public function getGenericRoomObjectThumbnail(param1: String, param2: String, param3: IGetImageListener, param4: String = null, param5: IStuffData = null): class_3499 {
            var _loc6_: AssetCallbackInfo = null;
            var _loc13_: BitmapDataAsset = null;
            var _loc9_: BitmapData = null;
            var _loc8_: class_3499;
            (_loc8_ = new class_3499()).id = -1;
            if (!var_2250 || param1 == null) {
                return _loc8_;
            }
            var _loc7_: IRoomInstance;
            if ((_loc7_ = _roomManager.getRoom("temporary_room")) == null) {
                if ((_loc7_ = _roomManager.createRoom("temporary_room", null)) == null) {
                    return _loc8_;
                }
            }
            var _loc11_: int = var_2496.reserveNumber();
            var _loc12_: int = getRoomObjectCategory(param1);
            if (_loc11_ < 0) {
                return _loc8_;
            }
            _loc11_ += 1;
            _loc8_.id = _loc11_;
            _loc8_.data = null;
            var _loc10_: String = [param1, param2].join("_");
            if (!this.hasAsset(_loc10_) && param3 != null) {
                if ((_loc6_ = var_2960.getValue(_loc10_)) == null) {
                    _loc6_ = new AssetCallbackInfo(_loc11_);
                    var_2960.add(_loc10_, _loc6_);
                    var_1634.loadThumbnailContent(_loc11_, param1, param2, null);
                } else {
                    var_2496.freeNumber(_loc11_ - 1);
                    _loc8_.id = _loc6_.id;
                }
                _loc6_.listeners.push(param3);
            } else {
                if ((_loc13_ = this.findAssetByName(_loc10_) as BitmapDataAsset) && !_loc13_.disposed) {
                    _loc9_ = _loc13_.content as BitmapData;
                    try {
                        if (_loc9_ != null && _loc9_ is BitmapData && _loc9_.width > 0 && _loc9_.height > 0) {
                            _loc8_.data = _loc9_.clone();
                        } else {
                            class_14.log("Could not process thumbnail for icon (disposed?): " + _loc10_);
                        }
                    } catch (error: Error) {
                        class_14.log("Could not process thumbnail for icon: " + _loc10_);
                    }
                }
                var_2496.freeNumber(_loc11_ - 1);
                _loc8_.id = 0;
            }
            return _loc8_;
        }

        public function getGenericRoomObjectImage(param1: String, param2: String, param3: IVector3d, param4: int, param5: IGetImageListener, param6: uint = 0, param7: String = null, param8: IStuffData = null, param9: int = -1, param10: int = -1, param11: String = null, param12: int = -1): class_3499 {
            var _loc18_: PetFigureData = null;
            var _loc23_: RoomObjectDataUpdateMessage = null;
            var _loc15_: int = 0;
            var _loc17_: class_3499;
            (_loc17_ = new class_3499()).id = -1;
            if (!var_2250 || param1 == null) {
                return _loc17_;
            }
            var _loc16_: IRoomInstance;
            if ((_loc16_ = _roomManager.getRoom("temporary_room")) == null) {
                if ((_loc16_ = _roomManager.createRoom("temporary_room", null)) == null) {
                    return _loc17_;
                }
            }
            var _loc21_: int = var_2574.reserveNumber();
            var _loc22_: int = getRoomObjectCategory(param1);
            if (_loc21_ < 0) {
                return _loc17_;
            }
            _loc21_ += 1;
            var _loc24_: IRoomObjectController;
            if ((_loc24_ = _loc16_.createRoomObject(_loc21_, param1, _loc22_) as IRoomObjectController) == null || _loc24_.getModelController() == null || _loc24_.getEventHandler() == null) {
                return _loc17_;
            }
            var _loc13_: IRoomObjectModelController = _loc24_.getModelController();
            switch (_loc22_) {
                case 10:
                case 20:
                    _loc13_.setNumber("furniture_color", int(param2));
                    _loc13_.setString("furniture_extras", param7);
                    break;
                case 100:
                    if (param1 == "user" || param1 == "bot" || param1 == "rentable_bot" || param1 == "pet") {
                        _loc13_.setString("figure", param2);
                    } else {
                        _loc18_ = new PetFigureData(param2);
                        _loc13_.setNumber("pet_palette_index", _loc18_.paletteId);
                        _loc13_.setNumber("pet_color", _loc18_.color);
                        if (_loc18_.headOnly) {
                            _loc13_.setNumber("pet_head_only", 1);
                        }
                        if (_loc18_.hasCustomParts) {
                            _loc13_.setNumberArray("pet_custom_layer_ids", _loc18_.customLayerIds);
                            _loc13_.setNumberArray("pet_custom_part_ids", _loc18_.customPartIds);
                            _loc13_.setNumberArray("pet_custom_palette_ids", _loc18_.customPaletteIds);
                        }
                        if (param11 != null) {
                            _loc13_.setString("figure_posture", param11);
                        }
                    }
                    break;
                case 0:
                    initializeRoomForGettingImage(_loc24_, param2);
            }
            _loc24_.setDirection(param3);
            var _loc14_: IRoomObjectSpriteVisualization = null;
            if ((_loc14_ = _loc24_.getVisualization() as IRoomObjectSpriteVisualization) == null) {
                _loc16_.disposeObject(_loc21_, _loc22_);
                return _loc17_;
            }
            if (param9 > -1 || param8) {
                if (param8 != null && param8.getLegacyString() != "") {
                    _loc23_ = new RoomObjectDataUpdateMessage(int(param8.getLegacyString()), param8);
                } else {
                    _loc23_ = new RoomObjectDataUpdateMessage(param9, param8);
                }
                if (_loc24_.getEventHandler() != null) {
                    _loc24_.getEventHandler().processUpdateMessage(_loc23_);
                }
            }
            var _loc20_: RoomGeometry = new RoomGeometry(param4, new Vector3d(-135, 30, 0), new Vector3d(11, 11, 5));
            _loc14_.update(_loc20_, 0, true, false);
            if (param10 > 0) {
                _loc15_ = 0;
                while (_loc15_ < param10) {
                    _loc14_.update(_loc20_, 0, true, false);
                    _loc15_++;
                }
            }
            var _loc19_: BitmapData = _loc14_.getImage(param6, param12);
            _loc17_.data = _loc19_;
            _loc17_.id = _loc21_;
            if (!isRoomObjectContentAvailable(param1) && param5 != null) {
                var_3300.add(String(_loc21_), param5);
                _loc13_.setNumber("image_query_scale", param4, true);
            } else {
                _loc16_.disposeObject(_loc21_, _loc22_);
                var_2574.freeNumber(_loc21_ - 1);
                _loc17_.id = 0;
            }
            _loc20_.dispose();
            return _loc17_;
        }

        public function getRoomObjectBoundingRectangle(param1: int, param2: int, param3: int, param4: int): Rectangle {
            var _loc11_: IRoomObject = null;
            var _loc6_: IRoomObjectVisualization = null;
            var _loc5_: Rectangle = null;
            var _loc7_: IRoomRenderingCanvas = null;
            var _loc9_: Number = NaN;
            var _loc8_: Point = null;
            var _loc10_: IRoomGeometry;
            if ((_loc10_ = getRoomCanvasGeometry(param1, param4)) != null) {
                if ((_loc11_ = getRoomObject(param1, param2, param3)) != null) {
                    if ((_loc6_ = _loc11_.getVisualization()) != null) {
                        _loc5_ = _loc6_.boundingRectangle;
                        _loc9_ = !!(_loc7_ = getRoomCanvas(param1, param4)) ? _loc7_.scale : 1;
                        if ((_loc8_ = _loc10_.getScreenPoint(_loc11_.getLocation())) != null) {
                            _loc5_.left *= _loc9_;
                            _loc5_.top *= _loc9_;
                            _loc5_.width *= _loc9_;
                            _loc5_.height *= _loc9_;
                            _loc8_.x *= _loc9_;
                            _loc8_.y *= _loc9_;
                            _loc5_.offset(_loc8_.x, _loc8_.y);
                            if (_loc7_ != null) {
                                _loc5_.offset(_loc7_.width / 2 + _loc7_.screenOffsetX, _loc7_.height / 2 + _loc7_.screenOffsetY);
                                return _loc5_;
                            }
                        }
                    }
                }
            }
            return null;
        }

        public function getRoomObjectScreenLocation(param1: int, param2: int, param3: int, param4: int = -1): Point {
            var _loc8_: IRoomObject = null;
            var _loc6_: Point = null;
            var _loc5_: IRoomRenderingCanvas = null;
            if (param4 == -1) {
                param4 = var_2450;
            }
            var _loc7_: IRoomGeometry;
            if ((_loc7_ = getRoomCanvasGeometry(param1, param4)) != null) {
                if ((_loc8_ = getRoomObject(param1, param2, param3)) != null) {
                    if ((_loc6_ = _loc7_.getScreenPoint(_loc8_.getLocation())) != null) {
                        if ((_loc5_ = getRoomCanvas(param1, param4)) != null) {
                            _loc6_.x *= _loc5_.scale;
                            _loc6_.y *= _loc5_.scale;
                            _loc6_.offset(_loc5_.width / 2 + _loc5_.screenOffsetX, _loc5_.height / 2 + _loc5_.screenOffsetY);
                        }
                        return _loc6_;
                    }
                }
            }
            return null;
        }

        public function getActiveRoomBoundingRectangle(param1: int): Rectangle {
            return getRoomObjectBoundingRectangle(var_1669, -1, 0, param1);
        }

        public function getActiveRoomActiveCanvas(): IRoomRenderingCanvas {
            return getRoomCanvas(var_1669, var_2450);
        }

        public function isRoomObjectContentAvailable(param1: String): Boolean {
            return _roomManager.isContentAvailable(param1);
        }

        public function iconLoaded(param1: int, param2: String, param3: Boolean): void {
            var _loc7_: BitmapDataAsset = null;
            var _loc4_: BitmapData = null;
            if (var_1634 == null) {
                return;
            }
            if (param1 == -1) {
                return;
            }
            var_2496.freeNumber(param1 - 1);
            var _loc5_: AssetCallbackInfo;
            if ((_loc5_ = var_2960.getValue(param2)) != null) {
                if (_loc5_.id != param1) {
                    return;
                }
                var_2960.remove(param2);
                _loc4_ = (_loc7_ = this.findAssetByName(param2) as BitmapDataAsset).content as BitmapData;
                if (_loc7_ && !_loc7_.disposed) {
                    for each(var _loc6_ in _loc5_.listeners) {
                        if (_loc6_ != null) {
                            try {
                                if (_loc4_ != null && _loc4_ is BitmapData && _loc4_.width > 0 && _loc4_.height > 0) {
                                    _loc6_.imageReady(param1, _loc4_.clone());
                                } else {
                                    class_14.log("Could not load thumbnail for icon (disposed?): " + param2);
                                }
                            } catch (error: Error) {
                                class_14.log("Could not load thumbnail for icon: " + param2);

                            }
                        }
                    }
                }
            }
        }

        public function contentLoaded(param1: String, param2: Boolean): void {
            var _loc6_: int = 0;
            var _loc14_: IRoomObject = null;
            var _loc11_: int = 0;
            var _loc9_: BitmapData = null;
            var _loc4_: IRoomObjectSpriteVisualization = null;
            var _loc7_: Number = NaN;
            var _loc5_: IGetImageListener = null;
            if (!param2) {
                class_14.log("[RoomEngine] Failed to load content:  " + param1);
            }
            var _loc8_: IRoomInstance;
            if ((_loc8_ = _roomManager.getRoom("temporary_room")) == null) {
                class_14.log("No room instance for " + param1 + " room: " + "temporary_room");
                return;
            }
            if (var_1634 == null) {
                return;
            }
            var _loc10_: RoomGeometry = null;
            var _loc13_: * = 0;
            var _loc12_: int = var_1634.getObjectCategory(param1);
            var _loc3_: int = _loc8_.getObjectCount(_loc12_);
            _loc6_ = _loc3_ - 1;
            while (_loc6_ >= 0) {
                if ((_loc14_ = _loc8_.getObjectWithIndex(_loc6_, _loc12_)) != null && _loc14_.getModel() != null && _loc14_.getType() == param1) {
                    _loc11_ = _loc14_.getId();
                    _loc9_ = null;
                    _loc4_ = null;
                    if ((_loc4_ = _loc14_.getVisualization() as IRoomObjectSpriteVisualization) != null) {
                        _loc7_ = Number(_loc14_.getModel().getNumber("image_query_scale"));
                        if (_loc10_ != null && _loc13_ != _loc7_) {
                            _loc10_.dispose();
                            _loc10_ = null;
                        }
                        if (_loc10_ == null) {
                            _loc13_ = _loc7_;
                            _loc10_ = new RoomGeometry(_loc7_, new Vector3d(-135, 30, 0), new Vector3d(11, 11, 5));
                        }
                        _loc4_.update(_loc10_, 0, true, false);
                        _loc9_ = _loc4_.image;
                    }
                    _loc8_.disposeObject(_loc11_, _loc12_);
                    var_2574.freeNumber(_loc11_ - 1);
                    if ((_loc5_ = var_3300.remove(String(_loc11_)) as IGetImageListener) != null) {
                        if (_loc9_ != null) {
                            _loc5_.imageReady(_loc11_, _loc9_);
                        } else {
                            _loc5_.imageFailed(_loc11_);
                        }
                    } else if (_loc9_ != null) {
                        _loc9_.dispose();
                    }
                }
                _loc6_--;
            }
            if (_loc10_ != null) {
                _loc10_.dispose();
            }
        }

        public function objectInitialized(param1: String, param2: int, param3: int): void {
            var _loc5_: int = 0;
            var _loc4_: IStuffData = null;
            var _loc6_: int = 0;
            var _loc7_: RoomObjectDataUpdateMessage = null;
            var _loc8_: int = getRoomId(param1);
            if (param3 == 20) {
                updateObjectRoomWindow(_loc8_, param2);
            }
            var _loc9_: IRoomObjectController;
            if ((_loc9_ = getRoomObject(_loc8_, param2, param3) as IRoomObjectController) != null && _loc9_.getModel() != null && _loc9_.getEventHandler() != null) {
                if (!isNaN(_loc9_.getModel().getNumber("furniture_data_format"))) {
                    _loc5_ = int(_loc9_.getModel().getNumber("furniture_data_format"));
                    (_loc4_ = class_1697.getStuffDataWrapperForType(_loc5_)).initializeFromRoomObjectModel(_loc9_.getModel());
                    _loc6_ = int(_loc9_.getState(0));
                    _loc7_ = new RoomObjectDataUpdateMessage(_loc6_, _loc4_);
                    _loc9_.getEventHandler().processUpdateMessage(_loc7_);
                }
                if (events != null) {
                    events.dispatchEvent(new RoomEngineObjectEvent("REOE_CONTENT_UPDATED", _loc8_, param2, param3));
                }
            }
            if (param1 != "temporary_room") {
                addObjectToTileMap(_loc8_, _loc9_);
            }
        }

        public function objectsInitialized(param1: String): void {
            var _loc2_: int = 0;
            if (events != null) {
                _loc2_ = getRoomId(param1);
                events.dispatchEvent(new RoomEngineEvent("REE_OBJECTS_INITIALIZED", _loc2_));
            }
        }

        public function selectAvatar(param1: int, param2: int): void {
            if (var_1707 != null) {
                var_1707.setSelectedAvatar(param1, param2, true);
            }
        }

        public function getSelectedAvatarId(): int {
            if (var_1707 != null) {
                return var_1707.getSelectedAvatarId();
            }
            return -1;
        }

        public function selectRoomObject(param1: int, param2: int, param3: int): void {
            if (var_1707 == null) {
                return;
            }
            var_1707.setSelectedObject(param1, param2, param3);
        }

        public function refreshTileObjectMap(param1: int, param2: String): void {
            var _loc3_: class_3513 = getRoomInstanceData(param1).tileObjectMap;
            if (_loc3_) {
                _loc3_.populate(getRoomObjects(param1, 10));
            }
            var_1707.recalibrateMovements(param1);
        }

        public function requestRoomAdImage(param1: int, param2: int, param3: int, param4: String, param5: String): void {
            if (_adManager != null) {
                _adManager.loadRoomAdImage(param1, param2, param3, param4, param5);
            }
        }

        public function insertContentLibrary(param1: int, param2: int, param3: IAssetLibrary): Boolean {
            return var_1634.insertObjectContent(param1, param2, param3);
        }

        public function setActiveObjectType(param1: int, param2: String): void {
            var_1634.setActiveObjectType(param1, param2);
        }

        public function requestBadgeImageAsset(param1: int, param2: int, param3: int, param4: String, param5: Boolean = true): void {
            var _loc10_: IRoomInstance = null;
            var _loc6_: Array = null;
            var _loc11_: IRoomObjectController = null;
            if (param1 == 0) {
                if ((_loc10_ = _roomManager.getRoom("temporary_room")) != null) {
                    _loc11_ = _loc10_.getObject(param2, param3) as IRoomObjectController;
                }
            } else {
                _loc11_ = getObjectFurniture(param1, param2);
            }
            if (_loc11_ == null || _loc11_.getEventHandler() == null) {
                return;
            }
            var _loc7_: String;
            var _loc8_: Function;
            if (!(_loc7_ = (_loc8_ = param5 ? _sessionDataManager.getGroupBadgeAssetName : _sessionDataManager.getBadgeImageAssetName).call(null, param4))) {
                _loc7_ = "loading_icon";
                if (!var_2155) {
                    var_2155 = new Map();
                }
                if (var_2155.length == 0) {
                    _sessionDataManager.events.addEventListener("BIRE_BADGE_IMAGE_READY", onBadgeLoaded);
                }
                if ((_loc6_ = var_2155.getValue(param4)) == null) {
                    _loc6_ = [];
                }
                _loc6_.push(new class_3467(_loc11_, param5));
                var_2155[param4] = _loc6_;
            } else {
                addBadgeGraphicAssets(_loc11_, param4, param5);
            }
            var _loc9_: RoomObjectGroupBadgeUpdateMessage;
            if ((_loc9_ = new RoomObjectGroupBadgeUpdateMessage(param4, _loc7_)) != null) {
                _loc11_.getEventHandler().processUpdateMessage(_loc9_);
            }
        }

        public function showUseProductSelection(param1: int, param2: int, param3: int = -1): void {
            var _loc5_: int = 0;
            var _loc4_: String = null;
            if (var_1634 != null) {
                _loc4_ = var_1634.getActiveObjectType(param2);
                _loc5_ = getRoomObjectCategory(_loc4_);
                events.dispatchEvent(new RoomEngineUseProductEvent("ROSM_USE_PRODUCT_FROM_INVENTORY", var_1669, param3, _loc5_, param1, param2));
            }
        }

        public function setAvatarEffect(param1: int): void {
            if (_sessionDataManager == null || _roomSessionManager == null) {
                return;
            }
            var _loc2_: IRoomSession = _roomSessionManager.getSession(var_1669);
            if (_loc2_ == null) {
                return;
            }
            updateObjectUserEffect(activeRoomId, _loc2_.ownUserRoomId, param1);
        }

        public function getRenderRoomMessage(param1: Rectangle, param2: uint, param3: Boolean = false, param4: Boolean = true, param5: Boolean = false, param6: int = -1): IMessageComposer {
            var _loc8_: IRoomRenderingCanvas = null;
            if (param6 > -1) {
                _loc8_ = getRoomCanvas(var_1669, param6);
            } else {
                _loc8_ = getActiveRoomActiveCanvas();
            }
            if (!_loc8_) {
                return null;
            }
            if (param5) {
                _loc8_.skipSpriteVisibilityChecking();
            }
            var _loc12_: int = -1;
            if (!param4 && _roomSessionManager.getSession(var_1669) != null) {
                _loc12_ = _roomSessionManager.getSession(var_1669).ownUserRoomId;
            }
            var _loc11_: class_3500;
            var _loc10_: String = (_loc11_ = new class_3500()).getFurniData(param1, _loc8_, this, _loc12_);
            var _loc9_: String = _loc11_.getRoomRenderingModifiers(this);
            var _loc7_: Array = _loc11_.getRoomPlanes(param1, _loc8_, this, param2);
            if (param5) {
                _loc8_.resumeSpriteVisibilityChecking();
            }
            if (param3) {
                return new RenderRoomThumbnailMessageComposer(_loc7_, _loc10_, _loc9_, var_1669, _sessionDataManager.topSecurityLevel);
            }
            return new RenderRoomMessageComposer(_loc7_, _loc10_, _loc9_, var_1669, _sessionDataManager.topSecurityLevel);
        }

        public function isWhereYouClickWhereYouGo(): Boolean {
            return var_4953 && !isAreaSelectionMode();
        }

        public function isAreaSelectionMode(): Boolean {
            return var_2309.areaSelectionState != RoomAreaSelectionManager.NOT_ACTIVE;
        }

        public function setMoveBlocked(param1: Boolean): void {
            var_4633 = param1;
        }

        public function isMoveBlocked(): Boolean {
            return var_4633;
        }

        protected function createRoomObjectEventHandlerInstance(): RoomObjectEventHandler {
            return new RoomObjectEventHandler(this);
        }

        protected function addObjectToTileMap(param1: int, param2: IRoomObject): void {
            var _loc3_: class_3513 = getRoomInstanceData(param1).tileObjectMap;
            if (_loc3_) {
                _loc3_.addRoomObject(param2);
            }
        }

        private function getRoomInstanceData(param1: int): class_3344 {
            var _loc2_: String = getRoomIdentifier(param1);
            var _loc3_: class_3344 = null;
            if (var_1990 != null) {
                _loc3_ = var_1990.getValue(_loc2_) as class_3344;
                if (_loc3_ == null) {
                    _loc3_ = new class_3344(param1);
                    var_1990.add(_loc2_, _loc3_);
                }
            }
            return _loc3_;
        }

        private function getActiveRoomCamera(): class_3355 {
            return getRoomCamera(var_1669);
        }

        private function getRoomCamera(param1: int): class_3355 {
            var _loc2_: class_3344 = getRoomInstanceData(param1);
            if (_loc2_ != null) {
                return _loc2_.roomCamera;
            }
            return null;
        }

        private function updateMouseCursor(): void {
            _mouseCursorUpdate = false;
            var _loc1_: class_3344 = getRoomInstanceData(var_1669);
            if (_loc1_ && _loc1_.hasButtonMouseCursorOwners()) {
                Mouse.cursor = "button";
            } else {
                Mouse.cursor = "auto";
            }
        }

        private function addButtonMouseCursorOwner(param1: int, param2: int, param3: int): void {
            var _loc5_: String = null;
            var _loc4_: class_3344 = null;
            var _loc6_: IRoomSession = _roomSessionManager.getSession(param1);
            if (param2 != 10 && param2 != 20 || _loc6_ != null && _loc6_.roomControllerLevel >= 1) {
                _loc5_ = param2 + "_" + param3;
                if ((_loc4_ = getRoomInstanceData(param1)) != null) {
                    if (_loc4_.addButtonMouseCursorOwner(_loc5_)) {
                        _mouseCursorUpdate = true;
                    }
                }
            }
        }

        private function removeButtonMouseCursorOwner(param1: int, param2: int, param3: int): void {
            var _loc5_: String = null;
            var _loc4_: class_3344;
            if ((_loc4_ = getRoomInstanceData(param1)) != null) {
                _loc5_ = param2 + "_" + param3;
                if (_loc4_.removeButtonMouseCursorOwner(_loc5_)) {
                    _mouseCursorUpdate = true;
                }
            }
        }

        private function createRoomFurniture(): void {
            var _loc6_: int = 0;
            _loc6_ = 5;
            var _loc1_: int = 0;
            var _loc4_: int = 0;
            var _loc3_: class_3498 = null;
            var _loc9_: Boolean = false;
            var _loc7_: String = null;
            var _loc8_: RoomInstance = null;
            if (_skipFurnitureCreationForNextFrame) {
                _skipFurnitureCreationForNextFrame = false;
                return;
            }
            var _loc5_: int = getTimer();
            var _loc11_: int = 0;
            var _loc10_: Map = var_1990;
            do {
                for each(var _loc2_ in _loc10_) {
                    _loc4_ = 0;
                    _loc3_ = null;
                    _loc9_ = false;
                    while ((_loc3_ = _loc2_.getFurnitureData()) != null) {
                        _loc9_ = addObjectFurnitureFromData(_loc2_.roomId, _loc3_.id, _loc3_);
                        _loc4_++;
                        if (_loc4_ % 5 == 0) {
                            _loc1_ = getTimer();
                            if (_loc1_ - _loc5_ >= 40 && !var_3050) {
                                _skipFurnitureCreationForNextFrame = true;
                                break;
                            }
                        }
                    }
                    while (!_skipFurnitureCreationForNextFrame && (_loc3_ = _loc2_.getWallItemData()) != null) {
                        _loc9_ = addObjectWallItemFromData(_loc2_.roomId, _loc3_.id, _loc3_);
                        _loc4_++;
                        if (_loc4_ % 5 == 0) {
                            _loc1_ = getTimer();
                            if (_loc1_ - _loc5_ >= 40 && !var_3050) {
                                _skipFurnitureCreationForNextFrame = true;
                                break;
                            }
                        }
                    }
                    if (_loc9_ && var_3050) {
                        _loc7_ = getRoomIdentifier(_loc2_.roomId);
                        if (!(_loc8_ = _roomManager.getRoom(_loc7_) as RoomInstance).hasUninitializedObjects()) {
                            objectsInitialized(_loc7_);
                        }
                    }
                }
                return;
            }
            while (!_skipFurnitureCreationForNextFrame);

        }

        private function updateRoomCameras(param1: uint): void {
            var _loc7_: int = 0;
            var _loc3_: class_3344 = null;
            var _loc6_: class_3355 = null;
            var _loc8_: int = 0;
            var _loc5_: int = 0;
            var _loc4_: int = 0;
            var _loc9_: IRoomObject = null;
            var _loc2_: int = 1;
            _loc7_ = 0;
            while (_loc7_ < var_1990.length) {
                _loc3_ = var_1990.getWithIndex(_loc7_) as class_3344;
                _loc6_ = null;
                _loc8_ = 0;
                if (_loc3_ != null) {
                    _loc6_ = _loc3_.roomCamera;
                    _loc8_ = _loc3_.roomId;
                }
                if (_loc6_ != null) {
                    _loc5_ = _loc6_.targetId;
                    _loc4_ = _loc6_.targetCategory;
                    if ((_loc9_ = getRoomObject(_loc8_, _loc5_, _loc4_)) != null) {
                        if (_loc8_ != var_1669 || !var_2322) {
                            updateRoomCamera(_loc8_, _loc2_, _loc9_.getLocation(), param1);
                        }
                    }
                }
                _loc7_++;
            }
        }

        private function updateRoomCamera(param1: int, param2: int, param3: IVector3d, param4: uint): void {
            var _loc46_: Number = NaN;
            var _loc18_: Rectangle = null;
            var _loc26_: int = 0;
            var _loc25_: int = 0;
            var _loc41_: Rectangle = null;
            var _loc6_: Vector3d = null;
            var _loc31_: Number = NaN;
            var _loc32_: Number = NaN;
            var _loc9_: Number = NaN;
            var _loc27_: Number = NaN;
            var _loc22_: Number = NaN;
            var _loc21_: Number = NaN;
            var _loc19_: Number = NaN;
            var _loc34_: Point = null;
            var _loc17_: Number = NaN;
            var _loc20_: Number = NaN;
            var _loc12_: Matrix = null;
            var _loc36_: Number = NaN;
            var _loc38_: Number = NaN;
            var _loc42_: Number = NaN;
            var _loc40_: Number = NaN;
            var _loc10_: Number = NaN;
            var _loc8_: Number = NaN;
            var _loc5_: Point = null;
            var _loc44_: Boolean = false;
            var _loc43_: Boolean = false;
            var _loc24_: Boolean = false;
            var _loc23_: Boolean = false;
            var _loc14_: Number = NaN;
            var _loc13_: Number = NaN;
            var _loc33_: Number = NaN;
            var _loc37_: Number = NaN;
            var _loc28_: Number = NaN;
            var _loc15_: int = 0;
            var _loc16_: int = 0;
            var _loc39_: Point = null;
            var _loc29_: Vector3d = null;
            var _loc30_: IRoomRenderingCanvas = getRoomCanvas(param1, param2);
            var _loc7_: class_3344 = getRoomInstanceData(param1);
            if (_loc30_ == null || _loc7_ == null || _loc30_.scale != 1) {
                return;
            }
            var _loc45_: RoomGeometry = _loc30_.geometry as RoomGeometry;
            var _loc11_: class_3355 = _loc7_.roomCamera;
            var _loc35_: IRoomInstance = getRoom(param1);
            if (_loc45_ != null && _loc11_ != null && _loc35_ != null) {
                _loc46_ = Math.floor(param3.z) + 1;
                if ((_loc18_ = getRoomCanvasRectangle(param1, param2)) != null) {
                    _loc26_ = Math.round(_loc18_.width);
                    _loc25_ = Math.round(_loc18_.height);
                    if ((_loc41_ = getActiveRoomBoundingRectangle(param2)) != null && (_loc41_.right < 0 || _loc41_.bottom < 0 || _loc41_.left >= _loc26_ || _loc41_.top >= _loc25_)) {
                        _loc11_.reset();
                    }
                    if (_loc11_.screenWd != _loc26_ || _loc11_.screenHt != _loc25_ || _loc11_.scale != _loc45_.scale || _loc11_.geometryUpdateId != _loc45_.updateId || !Vector3d.isEqual(param3, _loc11_.targetObjectLoc) || _loc11_.isMoving) {
                        _loc11_.targetObjectLoc = param3;
                        (_loc6_ = new Vector3d()).assign(param3);
                        _loc6_.x = Math.round(_loc6_.x);
                        _loc6_.y = Math.round(_loc6_.y);
                        _loc31_ = _loc35_.getNumber("room_min_x") - 0.5;
                        _loc32_ = _loc35_.getNumber("room_min_y") - 0.5;
                        _loc9_ = _loc35_.getNumber("room_max_x") + 0.5;
                        _loc27_ = _loc35_.getNumber("room_max_y") + 0.5;
                        _loc22_ = Math.round((_loc31_ + _loc9_) / 2);
                        _loc21_ = Math.round((_loc32_ + _loc27_) / 2);
                        _loc19_ = 2;
                        _loc34_ = new Point(_loc6_.x - _loc22_, _loc6_.y - _loc21_);
                        _loc20_ = (_loc17_ = _loc45_.scale / Math.sqrt(2)) / 2;
                        (_loc12_ = new Matrix()).rotate(-(_loc45_.direction.x + 90) / 180 * 3.141592653589793);
                        _loc34_ = _loc12_.transformPoint(_loc34_);
                        _loc34_.y = _loc34_.y * (_loc20_ / _loc17_);
                        _loc36_ = _loc18_.width / 2 / _loc17_ - 1;
                        _loc38_ = _loc18_.height / 2 / _loc20_ - 1;
                        _loc42_ = 0;
                        _loc40_ = 0;
                        _loc10_ = 0;
                        _loc8_ = 0;
                        if (!(_loc5_ = _loc45_.getScreenPoint(new Vector3d(_loc22_, _loc21_, _loc19_)))) {
                            return;
                        }
                        _loc5_.x += Math.round(_loc18_.width / 2);
                        _loc5_.y += Math.round(_loc18_.height / 2);
                        if (_loc41_ == null) {
                            _loc45_.adjustLocation(new Vector3d(0, 0), 25);
                            return;
                        }
                        _loc41_.offset(-_loc30_.screenOffsetX, -_loc30_.screenOffsetY);
                        if (!(_loc41_.width > 1 && _loc41_.height > 1)) {
                            _loc45_.adjustLocation(new Vector3d(-30, -30), 25);
                            return;
                        }
                        _loc42_ = (_loc41_.left - _loc5_.x - _loc45_.scale * 0.25) / _loc17_;
                        _loc10_ = (_loc41_.right - _loc5_.x + _loc45_.scale * 0.25) / _loc17_;
                        _loc40_ = (_loc41_.top - _loc5_.y - _loc45_.scale * 0.5) / _loc20_;
                        _loc8_ = (_loc41_.bottom - _loc5_.y + _loc45_.scale * 0.5) / _loc20_;
                        _loc44_ = false;
                        _loc43_ = false;
                        _loc24_ = false;
                        _loc23_ = false;
                        if ((_loc14_ = Math.round((_loc10_ - _loc42_) * _loc17_)) < _loc18_.width) {
                            _loc46_ = 2;
                            _loc34_.x = (_loc10_ + _loc42_) / 2;
                            _loc24_ = true;
                        } else {
                            if (_loc34_.x > _loc10_ - _loc36_) {
                                _loc34_.x = _loc10_ - _loc36_;
                                _loc44_ = true;
                            }
                            if (_loc34_.x < _loc42_ + _loc36_) {
                                _loc34_.x = _loc42_ + _loc36_;
                                _loc44_ = true;
                            }
                        }
                        if ((_loc13_ = Math.round((_loc8_ - _loc40_) * _loc20_)) < _loc18_.height) {
                            _loc46_ = 2;
                            _loc34_.y = (_loc8_ + _loc40_) / 2;
                            _loc23_ = true;
                        } else {
                            if (_loc34_.y > _loc8_ - _loc38_) {
                                _loc34_.y = _loc8_ - _loc38_;
                                _loc43_ = true;
                            }
                            if (_loc34_.y < _loc40_ + _loc38_) {
                                _loc34_.y = _loc40_ + _loc38_;
                                _loc43_ = true;
                            }
                            if (_loc43_) {
                                _loc34_.y /= _loc20_ / _loc17_;
                            }
                        }
                        _loc12_.invert();
                        _loc34_ = _loc12_.transformPoint(_loc34_);
                        _loc34_.x = _loc34_.x + _loc22_;
                        _loc34_.y += _loc21_;
                        _loc33_ = 0.35;
                        _loc37_ = 0.2;
                        _loc28_ = 0.2;
                        _loc15_ = 10;
                        _loc16_ = 10;
                        if (_loc28_ * _loc26_ > 100) {
                            _loc28_ = 100 / _loc26_;
                        }
                        if (_loc33_ * _loc25_ > 150) {
                            _loc33_ = 150 / _loc25_;
                        }
                        if (_loc37_ * _loc25_ > 150) {
                            _loc37_ = 150 / _loc25_;
                        }
                        if (_loc11_.limitedLocationX && _loc11_.screenWd == _loc26_ && _loc11_.screenHt == _loc25_) {
                            _loc28_ = 0;
                        }
                        if (_loc11_.limitedLocationY && _loc11_.screenWd == _loc26_ && _loc11_.screenHt == _loc25_) {
                            _loc33_ = 0;
                            _loc37_ = 0;
                        }
                        _loc18_.right *= 1 - _loc28_ * 2;
                        _loc18_.bottom *= 1 - (_loc33_ + _loc37_);
                        if (_loc18_.right < _loc15_) {
                            _loc18_.right = _loc15_;
                        }
                        if (_loc18_.bottom < _loc16_) {
                            _loc18_.bottom = _loc16_;
                        }
                        if (_loc33_ + _loc37_ > 0) {
                            _loc18_.offset(-_loc18_.width / 2, -_loc18_.height * (_loc37_ / (_loc33_ + _loc37_)));
                        } else {
                            _loc18_.offset(-_loc18_.width / 2, -_loc18_.height / 2);
                        }
                        if (!(_loc5_ = _loc45_.getScreenPoint(_loc6_))) {
                            return;
                        }
                        if (_loc5_ != null) {
                            _loc5_.x += _loc30_.screenOffsetX;
                            _loc5_.y += _loc30_.screenOffsetY;
                            _loc6_.z = _loc46_;
                            _loc6_.x = Math.round(_loc34_.x * 2) / 2;
                            _loc6_.y = Math.round(_loc34_.y * 2) / 2;
                            if (_loc11_.location == null) {
                                _loc45_.location = _loc6_;
                                if (useOffsetScrolling) {
                                    _loc11_.initializeLocation(new Vector3d(0, 0, 0));
                                } else {
                                    _loc11_.initializeLocation(_loc6_);
                                }
                            }
                            _loc39_ = _loc45_.getScreenPoint(_loc6_);
                            _loc29_ = new Vector3d(0, 0, 0);
                            if (_loc39_ != null) {
                                _loc29_.x = _loc39_.x;
                                _loc29_.y = _loc39_.y;
                            }
                            if ((_loc5_.x < _loc18_.left || _loc5_.x > _loc18_.right) && !_loc11_.centeredLocX || (_loc5_.y < _loc18_.top || _loc5_.y > _loc18_.bottom) && !_loc11_.centeredLocY || _loc24_ && !_loc11_.centeredLocX && _loc11_.screenWd != _loc26_ || _loc23_ && !_loc11_.centeredLocY && _loc11_.screenHt != _loc25_ || (_loc11_.roomWd != _loc41_.width || _loc11_.roomHt != _loc41_.height) || (_loc11_.screenWd != _loc26_ || _loc11_.screenHt != _loc25_)) {
                                _loc11_.limitedLocationX = _loc44_;
                                _loc11_.limitedLocationY = _loc43_;
                                if (useOffsetScrolling) {
                                    _loc11_.target = _loc29_;
                                } else {
                                    _loc11_.target = _loc6_;
                                }
                            } else {
                                if (!_loc44_) {
                                    _loc11_.limitedLocationX = false;
                                }
                                if (!_loc43_) {
                                    _loc11_.limitedLocationY = false;
                                }
                            }
                        }
                        _loc11_.centeredLocX = _loc24_;
                        _loc11_.centeredLocY = _loc23_;
                        _loc11_.screenWd = _loc26_;
                        _loc11_.screenHt = _loc25_;
                        _loc11_.scale = _loc45_.scale;
                        _loc11_.geometryUpdateId = _loc45_.updateId;
                        _loc11_.roomWd = _loc41_.width;
                        _loc11_.roomHt = _loc41_.height;
                        if (!_sessionDataManager.isRoomCameraFollowDisabled) {
                            if (useOffsetScrolling) {
                                _loc11_.update(param4, 8);
                            } else {
                                _loc11_.update(param4, 0.5);
                            }
                        }
                        if (useOffsetScrolling) {
                            _loc30_.screenOffsetX = -_loc11_.location.x;
                            _loc30_.screenOffsetY = -_loc11_.location.y;
                        } else {
                            _loc45_.adjustLocation(_loc11_.location, 25);
                        }
                    } else {
                        _loc11_.limitedLocationX = false;
                        _loc11_.limitedLocationY = false;
                        _loc11_.centeredLocX = false;
                        _loc11_.centeredLocY = false;
                    }
                }
            }
        }

        private function getRoomId(param1: String): int {
            var _loc2_: Array = null;
            if (param1 != null) {
                _loc2_ = param1.split("_");
                if (_loc2_.length > 0) {
                    return _loc2_[0];
                }
            }
            return -1;
        }

        private function createRoom(param1: String, param2: XML, param3: String, param4: String, param5: String, param6: String): IRoomInstance {
            var _loc24_: int = 0;
            var _loc11_: XML = null;
            var _loc26_: Number = NaN;
            var _loc9_: Number = NaN;
            var _loc25_: Number = NaN;
            var _loc8_: Number = NaN;
            var _loc22_: RoomObjectRoomUpdateMessage = null;
            var _loc17_: XMLList = null;
            var _loc27_: Array = null;
            var _loc10_: RoomObjectRoomMaskUpdateMessage = null;
            var _loc20_: int = 0;
            var _loc7_: XML = null;
            var _loc16_: Number = NaN;
            var _loc14_: Number = NaN;
            var _loc13_: Number = NaN;
            var _loc12_: Number = NaN;
            var _loc18_: String = null;
            var _loc21_: String = null;
            var _loc19_: Vector3d = null;
            if (!var_2250) {
                return null;
            }
            var _loc23_: IRoomInstance;
            if ((_loc23_ = _roomManager.createRoom(param1, param2)) == null) {
                return null;
            }
            var _loc28_: int = 0;
            var _loc29_: IRoomObjectController = null;
            var _loc15_: Number = 1;
            _loc29_ = _loc23_.createRoomObject(-1, "room", _loc28_) as IRoomObjectController;
            _loc23_.setNumber("room_is_public", 0, true);
            _loc23_.setNumber("room_z_scale", _loc15_, true);
            if (param2 != null) {
                _loc24_ = 0;
                if (param2.dimensions.length() == 1) {
                    _loc26_ = Number((_loc11_ = param2.dimensions[0]).@minX);
                    _loc9_ = Number(_loc11_.@maxX);
                    _loc25_ = Number(_loc11_.@minY);
                    _loc8_ = Number(_loc11_.@maxY);
                    _loc23_.setNumber("room_min_x", _loc26_);
                    _loc23_.setNumber("room_max_x", _loc9_);
                    _loc23_.setNumber("room_min_y", _loc25_);
                    _loc23_.setNumber("room_max_y", _loc8_);
                    _loc24_ += _loc26_ * 423 + _loc9_ * 671 + _loc25_ * 913 + _loc8_ * 7509;
                    if (_loc29_ != null && _loc29_.getModelController() != null) {
                        _loc29_.getModelController().setNumber("room_random_seed", _loc24_, true);
                    }
                }
            }
            if (_loc29_ != null && _loc29_.getEventHandler() != null) {
                _loc29_.getEventHandler().initialize(param2);
                _loc22_ = null;
                if (param3 != null) {
                    _loc22_ = new RoomObjectRoomUpdateMessage("RORUM_ROOM_FLOOR_UPDATE", param3);
                    _loc29_.getEventHandler().processUpdateMessage(_loc22_);
                    _loc23_.setString("room_floor_type", param3);
                }
                if (param4 != null) {
                    _loc22_ = new RoomObjectRoomUpdateMessage("RORUM_ROOM_WALL_UPDATE", param4);
                    _loc29_.getEventHandler().processUpdateMessage(_loc22_);
                    _loc23_.setString("room_wall_type", param4);
                }
                if (param5 != null) {
                    _loc22_ = new RoomObjectRoomUpdateMessage("RORUM_ROOM_LANDSCAPE_UPDATE", param5);
                    _loc29_.getEventHandler().processUpdateMessage(_loc22_);
                    _loc23_.setString("room_landscape_type", param5);
                }
                if (param2 != null) {
                    if (param2.doors.door.length() > 0) {
                        _loc17_ = param2.doors.door;
                        _loc27_ = ["x", "y", "z", "dir"];
                        _loc10_ = null;
                        _loc20_ = 0;
                        while (_loc20_ < _loc17_.length()) {
                            _loc7_ = _loc17_[_loc20_];
                            if (class_1781.checkRequiredAttributes(_loc7_, _loc27_)) {
                                _loc16_ = Number(_loc7_.@x);
                                _loc14_ = Number(_loc7_.@y);
                                _loc13_ = Number(_loc7_.@z);
                                _loc12_ = Number(_loc7_.@dir);
                                _loc18_ = "door";
                                _loc21_ = "door_" + _loc20_;
                                _loc19_ = new Vector3d(_loc16_, _loc14_, _loc13_);
                                _loc10_ = new RoomObjectRoomMaskUpdateMessage("RORMUM_ADD_MASK", _loc21_, _loc18_, _loc19_, "hole");
                                _loc29_.getEventHandler().processUpdateMessage(_loc10_);
                                if (_loc12_ == 90 || _loc12_ == 180) {
                                    if (_loc12_ == 90) {
                                        _loc23_.setNumber("room_door_x", _loc16_ - 0.5, true);
                                        _loc23_.setNumber("room_door_y", _loc14_, true);
                                    }
                                    if (_loc12_ == 180) {
                                        _loc23_.setNumber("room_door_x", _loc16_, true);
                                        _loc23_.setNumber("room_door_y", _loc14_ - 0.5, true);
                                    }
                                    _loc23_.setNumber("room_door_z", _loc13_, true);
                                    _loc23_.setNumber("room_door_dir", _loc12_, true);
                                }
                            }
                            _loc20_++;
                        }
                    }
                }
            }
            _loc23_.createRoomObject(-2, "tile_cursor", 200);
            if (!getBoolean("avatar.widget.enabled")) {
                _loc23_.createRoomObject(-3, "selection_arrow", 200);
            }
            return _loc23_;
        }

        private function getRoomCanvasRectangle(param1: int, param2: int): Rectangle {
            var _loc3_: IRoomRenderingCanvas = getRoomCanvas(param1, param2);
            if (_loc3_ == null) {
                return null;
            }
            return new Rectangle(0, 0, _loc3_.width, _loc3_.height);
        }

        private function handleRoomDragging(param1: IRoomRenderingCanvas, param2: int, param3: int, param4: String, param5: Boolean, param6: Boolean, param7: Boolean): Boolean {
            var _loc10_: class_3344 = null;
            var _loc11_: class_3355 = null;
            if (var_3050) {
                return false;
            }
            if (var_2309.areaSelectionState == RoomAreaSelectionManager.SELECTING) {
                var_2322 = false;
                var_2059 = false;
                return false;
            }
            var _loc9_: int = param2 - var_3760;
            var _loc8_: int = param3 - var_3684;
            if (param4 == "mouseDown") {
                if (!param5 && !param6 && !param7 && !isDecorateMode) {
                    var_2322 = true;
                    var_2059 = false;
                    var_4853 = var_3760;
                    var_4567 = var_3684;
                    var_3441 = var_2503;
                    var_2503 = 0;
                }
            } else if (param4 == "mouseUp") {
                if (var_2322) {
                    var_2322 = false;
                    if (var_2059) {
                        if ((_loc10_ = getRoomInstanceData(var_1669)) != null) {
                            if ((_loc11_ = _loc10_.roomCamera) != null) {
                                if (useOffsetScrolling) {
                                    if (!_loc11_.isMoving) {
                                        _loc11_.centeredLocX = false;
                                        _loc11_.centeredLocY = false;
                                    }
                                    _loc11_.resetLocation(new Vector3d(-param1.screenOffsetX, -param1.screenOffsetY));
                                }
                                if (_roomDraggingAlwaysCenters) {
                                    _loc11_.reset();
                                }
                            }
                        }
                        events.dispatchEvent(new RoomEngineDragWithMouseEvent("REDWME_DRAG_END", var_1669));
                    }
                }
                if (var_3441 != 0) {
                    var_2503 = var_3441;
                    var_3441 = 0;
                }
            } else if (param4 == "mouseMove") {
                if (var_2322) {
                    if (!var_2059) {
                        _loc9_ = param2 - var_4853;
                        _loc8_ = param3 - var_4567;
                        if (_loc9_ <= -15 || _loc9_ >= 15 || _loc8_ <= -15 || _loc8_ >= 15) {
                            var_2059 = true;
                            events.dispatchEvent(new RoomEngineDragWithMouseEvent("REDWME_DRAG_START", var_1669));
                        }
                        _loc9_ = 0;
                        _loc8_ = 0;
                    }
                    if (_loc9_ != 0 || _loc8_ != 0) {
                        param1.screenOffsetX += _loc9_;
                        param1.screenOffsetY += _loc8_;
                        if (!var_2059) {
                            events.dispatchEvent(new RoomEngineDragWithMouseEvent("REDWME_DRAG_START", var_1669));
                        }
                        var_2059 = true;
                    }
                }
            } else if (param4 == "click" || param4 == "doubleClick") {
                var_2322 = false;
                if (var_2059) {
                    var_2059 = false;
                    return true;
                }
            }
            return false;
        }

        private function getOverlaySprite(param1: IRoomRenderingCanvas): Sprite {
            if (param1 == null) {
                return null;
            }
            var _loc3_: Sprite = param1.displayObject as Sprite;
            if (_loc3_ == null) {
                return null;
            }
            return _loc3_.getChildByName("overlay") as Sprite;
        }

        private function addOverlayIconSprite(param1: Sprite, param2: String, param3: BitmapData): Sprite {
            if (param1 == null || param3 == null) {
                return null;
            }
            var _loc5_: Sprite;
            if ((_loc5_ = getOverlayIconSprite(param1, param2)) != null) {
                return null;
            }
            (_loc5_ = new Sprite()).name = param2;
            _loc5_.mouseEnabled = false;
            var _loc4_: Bitmap = new Bitmap(param3);
            _loc5_.addChild(_loc4_);
            param1.addChild(_loc5_);
            return _loc5_;
        }

        private function removeOverlayIconSprite(param1: Sprite, param2: String): Boolean {
            var _loc5_: int = 0;
            var _loc4_: Sprite = null;
            var _loc3_: Bitmap = null;
            if (param1 == null) {
                return false;
            }
            _loc5_ = param1.numChildren - 1;
            while (_loc5_ >= 0) {
                if ((_loc4_ = param1.getChildAt(_loc5_) as Sprite) != null) {
                    if (_loc4_.name == param2) {
                        param1.removeChildAt(_loc5_);
                        _loc3_ = _loc4_.getChildAt(0) as Bitmap;
                        if (_loc3_ != null && _loc3_.bitmapData != null) {
                            _loc3_.bitmapData.dispose();
                            _loc3_.bitmapData = null;
                        }
                        return true;
                    }
                }
                _loc5_--;
            }
            return false;
        }

        private function getOverlayIconSprite(param1: Sprite, param2: String): Sprite {
            var _loc4_: int = 0;
            var _loc3_: Sprite = null;
            if (param1 == null) {
                return null;
            }
            _loc4_ = param1.numChildren - 1;
            while (_loc4_ >= 0) {
                _loc3_ = param1.getChildAt(_loc4_) as Sprite;
                if (_loc3_ != null) {
                    if (_loc3_.name == param2) {
                        return _loc3_;
                    }
                }
                _loc4_--;
            }
            return null;
        }

        private function getRoomObjectAdURL(param1: String): String {
            if (var_1634 != null) {
                return var_1634.getRoomObjectAdURL(param1);
            }
            return "";
        }

        private function getPetType(param1: String): String {
            var _loc2_: Array = null;
            var _loc3_: int = 0;
            if (param1 != null) {
                _loc2_ = param1.split(" ");
                if (_loc2_.length > 1) {
                    _loc3_ = parseInt(_loc2_[0]);
                    if (var_1634 != null) {
                        return var_1634.getPetType(_loc3_);
                    }
                    return "pet";
                }
            }
            return null;
        }

        private function getFurnitureColorIndex(param1: int): int {
            if (var_1634 != null) {
                return var_1634.getActiveObjectColorIndex(param1);
            }
            return 0;
        }

        private function getWallItemColorIndex(param1: int): int {
            if (var_1634 != null) {
                return var_1634.getWallItemColorIndex(param1);
            }
            return 0;
        }

        private function addObjectFurnitureFromData(param1: int, param2: int, param3: class_3498): Boolean {
            var _loc4_: class_3344 = null;
            if (param3 == null) {
                if ((_loc4_ = getRoomInstanceData(param1)) != null) {
                    param3 = _loc4_.getFurnitureDataWithId(param2);
                }
            }
            if (param3 == null) {
                return false;
            }
            var _loc6_: Boolean = false;
            var _loc9_: String;
            if ((_loc9_ = param3.type) == null) {
                _loc9_ = getFurnitureType(param3.typeId);
                _loc6_ = true;
            }
            var _loc7_: int = getFurnitureColorIndex(param3.typeId);
            var _loc8_: String = getRoomObjectAdURL(_loc9_);
            if (_loc9_ == null) {
                _loc9_ = "";
            }
            var _loc10_: IRoomObjectController;
            if ((_loc10_ = createObjectFurniture(param1, param2, _loc9_)) == null) {
                return false;
            }
            if (_loc10_ != null && _loc10_.getModelController() != null && _loc6_) {
                _loc10_.getModelController().setNumber("furniture_color", _loc7_, true);
                _loc10_.getModelController().setNumber("furniture_type_id", param3.typeId, true);
                _loc10_.getModelController().setString("furniture_ad_url", _loc8_, true);
                _loc10_.getModelController().setNumber("furniture_real_room_object", param3.realRoomObject ? 1 : 0, false);
                _loc10_.getModelController().setNumber("furniture_expiry_time", param3.expiryTime);
                _loc10_.getModelController().setNumber("furniture_expirty_timestamp", getTimer());
                _loc10_.getModelController().setNumber("furniture_usage_policy", param3.usagePolicy);
                _loc10_.getModelController().setNumber("furniture_owner_id", param3.ownerId);
                _loc10_.getModelController().setString("furniture_owner_name", param3.ownerName);
            }
            if (!updateObjectFurniture(param1, param2, param3.loc, param3.dir, param3.state, param3.data, param3.extra)) {
                return false;
            }
            if (param3.sizeZ >= 0) {
                if (!updateObjectFurnitureHeight(param1, param2, param3.sizeZ)) {
                    return false;
                }
            }
            if (events != null) {
                events.dispatchEvent(new RoomEngineObjectEvent("REOE_ADDED", param1, param2, 10));
            }
            var _loc5_: ISelectedRoomObjectData;
            if ((_loc5_ = getPlacedObjectData(param1)) && Math.abs(_loc5_.id) == param2 && _loc5_.category == 10) {
                selectRoomObject(param1, param2, 10);
            }
            if (_loc10_.isInitialized() && param3.synchronized) {
                addObjectToTileMap(param1, _loc10_);
            }
            return true;
        }

        private function createObjectFurniture(param1: int, param2: int, param3: String): IRoomObjectController {
            var _loc4_: int = 10;
            return createObject(getRoomIdentifier(param1), param2, param3, _loc4_);
        }

        private function getObjectFurniture(param1: int, param2: int): IRoomObjectController {
            return getObject(getRoomIdentifier(param1), param2, 10);
        }

        private function addObjectWallItemFromData(param1: int, param2: int, param3: class_3498): Boolean {
            var _loc4_: class_3344 = null;
            if (param3 == null) {
                if ((_loc4_ = getRoomInstanceData(param1)) != null) {
                    param3 = _loc4_.getWallItemDataWithId(param2);
                }
            }
            if (param3 == null) {
                return false;
            }
            var _loc6_: String = "";
            if (param3.data != null) {
                _loc6_ = String(param3.data.getLegacyString());
            }
            var _loc9_: String = getWallItemType(param3.typeId, _loc6_);
            var _loc7_: int = getWallItemColorIndex(param3.typeId);
            var _loc8_: String = getRoomObjectAdURL(_loc9_);
            if (_loc9_ == null) {
                _loc9_ = "";
            }
            var _loc10_: IRoomObjectController;
            if ((_loc10_ = createObjectWallItem(param1, param2, _loc9_)) == null) {
                return false;
            }
            if (_loc10_ != null && _loc10_.getModelController() != null) {
                _loc10_.getModelController().setNumber("furniture_color", _loc7_, false);
                _loc10_.getModelController().setNumber("furniture_type_id", param3.typeId, true);
                _loc10_.getModelController().setString("furniture_ad_url", _loc8_, true);
                _loc10_.getModelController().setNumber("furniture_real_room_object", param3.realRoomObject ? 1 : 0, false);
                _loc10_.getModelController().setNumber("object_accurate_z_value", 1, true);
                _loc10_.getModelController().setNumber("furniture_usage_policy", param3.usagePolicy);
                _loc10_.getModelController().setNumber("furniture_expiry_time", param3.expiryTime);
                _loc10_.getModelController().setNumber("furniture_expirty_timestamp", getTimer());
                _loc10_.getModelController().setNumber("furniture_owner_id", param3.ownerId);
                _loc10_.getModelController().setString("furniture_owner_name", param3.ownerName);
            }
            _loc6_ = "";
            if (param3.data != null) {
                _loc6_ = String(param3.data.getLegacyString());
            }
            if (!updateObjectWallItem(param1, param2, param3.loc, param3.dir, param3.state, _loc6_)) {
                return false;
            }
            if (events != null) {
                events.dispatchEvent(new RoomEngineObjectEvent("REOE_ADDED", param1, param2, 20));
            }
            var _loc5_: ISelectedRoomObjectData;
            if ((_loc5_ = getPlacedObjectData(param1)) && _loc5_.id == param2 && _loc5_.category == 20) {
                selectRoomObject(param1, param2, 20);
            }
            return true;
        }

        private function createObjectWallItem(param1: int, param2: int, param3: String): IRoomObjectController {
            var _loc4_: int = 20;
            return createObject(getRoomIdentifier(param1), param2, param3, _loc4_);
        }

        private function getObjectWallItem(param1: int, param2: int): IRoomObjectController {
            return getObject(getRoomIdentifier(param1), param2, 20);
        }

        private function createObjectUser(param1: int, param2: int, param3: String): IRoomObjectController {
            var _loc4_: int = 100;
            return createObject(getRoomIdentifier(param1), param2, param3, _loc4_);
        }

        private function createObjectSnowWar(param1: int, param2: int, param3: String, param4: int): IRoomObjectController {
            return createObject(getRoomIdentifier(param1), param2, param3, param4);
        }

        private function getObjectUser(param1: int, param2: int): IRoomObjectController {
            return getObject(getRoomIdentifier(param1), param2, 100);
        }

        private function createObject(param1: String, param2: int, param3: String, param4: int): IRoomObjectController {
            var _loc5_: IRoomInstance;
            if ((_loc5_ = _roomManager.getRoom(param1)) == null) {
                return null;
            }
            var _loc6_: IRoomObjectController = null;
            return _loc5_.createRoomObject(param2, param3, param4) as IRoomObjectController;
        }

        private function getObject(param1: String, param2: int, param3: int): IRoomObjectController {
            var _loc4_: IRoomInstance = null;
            if (_roomManager != null) {
                _loc4_ = _roomManager.getRoom(param1);
            }
            if (_loc4_ == null) {
                return null;
            }
            var _loc5_: IRoomObjectController = null;
            if ((_loc5_ = _loc4_.getObject(param2, param3) as IRoomObjectController) == null) {
                if (param3 == 10) {
                    addObjectFurnitureFromData(getRoomId(param1), param2, null);
                    _loc5_ = _loc4_.getObject(param2, param3) as IRoomObjectController;
                } else if (param3 == 20) {
                    addObjectWallItemFromData(getRoomId(param1), param2, null);
                    _loc5_ = _loc4_.getObject(param2, param3) as IRoomObjectController;
                }
            }
            return _loc5_;
        }

        private function disposeObject(param1: int, param2: int, param3: int): void {
            var _loc4_: IRoomInstance = null;
            if (_roomManager != null) {
                if ((_loc4_ = getRoom(param1)) == null) {
                    return;
                }
                if (_loc4_.disposeObject(param2, param3)) {
                    if (events != null) {
                        events.dispatchEvent(new RoomEngineObjectEvent("REOE_REMOVED", param1, param2, param3));
                    }
                }
            }
        }

        private function getRoomObjectRoomIdentifier(param1: IRoomObject): String {
            if (param1 != null && param1.getModel() != null) {
                return param1.getModel().getString("object_room_id");
            }
            return null;
        }

        private function initializeRoomForGettingImage(param1: IRoomObjectController, param2: String): void {
            var _loc3_: Array = null;
            var _loc8_: String = null;
            var _loc9_: String = null;
            var _loc12_: String = null;
            var _loc4_: String = null;
            var _loc11_: int = 0;
            var _loc5_: RoomPlaneParser = null;
            var _loc14_: int = 0;
            var _loc13_: int = 0;
            var _loc6_: XML = null;
            var _loc7_: RoomObjectRoomMaskUpdateMessage = null;
            var _loc10_: String = null;
            if (param2 != null) {
                _loc3_ = param2.split("\n");
                if (_loc3_.length >= 3) {
                    _loc8_ = String(_loc3_[0]);
                    _loc9_ = String(_loc3_[1]);
                    _loc12_ = String(_loc3_[2]);
                    _loc4_ = String(_loc3_[3]);
                    _loc11_ = 6;
                    (_loc5_ = new RoomPlaneParser()).initializeTileMap(_loc11_ + 2, _loc11_ + 2);
                    _loc14_ = 1;
                    while (_loc14_ < 1 + _loc11_) {
                        _loc13_ = 1;
                        while (_loc13_ < 1 + _loc11_) {
                            _loc5_.setTileHeight(_loc13_, _loc14_, 0);
                            _loc13_++;
                        }
                        _loc14_++;
                    }
                    _loc5_.wallHeight = _loc11_;
                    _loc5_.initializeFromTileData();
                    _loc6_ = _loc5_.getXML();
                    param1.getEventHandler().initialize(_loc6_);
                    param1.getModelController().setString("room_floor_type", _loc8_);
                    param1.getModelController().setString("room_wall_type", _loc9_);
                    param1.getModelController().setString("room_landscape_type", _loc12_);
                    if (_loc4_ != null) {
                        _loc7_ = null;
                        _loc10_ = "20_1";
                        _loc7_ = new RoomObjectRoomMaskUpdateMessage("RORMUM_ADD_MASK", _loc10_, _loc4_, new Vector3d(2.5, 0.5, 2));
                        param1.getEventHandler().processUpdateMessage(_loc7_);
                    }
                    _loc5_.dispose();
                }
            }
        }

        private function addBadgeGraphicAssets(param1: IRoomObjectController, param2: String, param3: Boolean = false): void {
            var _loc9_: Function = param3 ? _sessionDataManager.getGroupBadgeAssetName : _sessionDataManager.getBadgeImageAssetName;
            var _loc10_: Function = param3 ? _sessionDataManager.getGroupBadgeSmallAssetName : _sessionDataManager.getBadgeImageSmallAssetName;
            var _loc11_: Function = param3 ? _sessionDataManager.getGroupBadgeImage : _sessionDataManager.getBadgeImage;
            var _loc8_: Function = param3 ? _sessionDataManager.getGroupBadgeSmallImage : _sessionDataManager.getBadgeSmallImage;
            var _loc7_: String = _loc9_.call(null, param2);
            var _loc4_: BitmapData = BitmapData(_loc11_.call(null, param2));
            var_1634.addGraphicAsset(param1.getType(), _loc7_, _loc4_, false);
            var _loc5_: String = _loc10_.call(null, param2);
            var _loc6_: BitmapData;
            if (_loc6_ = _loc8_.call(null, param2)) {
                var_1634.addGraphicAsset(param1.getType(), _loc5_, _loc6_, false);
            }
        }

        private function fixedUserLocation(param1: int, param2: IVector3d): IVector3d {
            if (param2 == null) {
                return null;
            }
            var _loc5_: class_3419 = getFurniStackingHeightMap(param1);
            var _loc7_: class_3373 = getLegacyGeometry(param1);
            if (_loc5_ == null || _loc7_ == null) {
                return param2;
            }
            var _loc6_: Number = Number(param2.z);
            var _loc3_: Number = _loc5_.getTileHeight(param2.x, param2.y);
            var _loc4_: Number = _loc7_.getTileHeight(param2.x, param2.y);
            if (Math.abs(_loc6_ - _loc3_) < 0.02 && Math.abs(_loc3_ - _loc4_) < 0.02) {
                _loc6_ = _loc7_.getFloorAltitude(param2.x, param2.y);
            }
            return new Vector3d(param2.x, param2.y, _loc6_);
        }

        private function onConfigurationComplete(param1: Event): void {
            if (var_1634) {
                var_1634.dispose();
                events.removeEventListener("RCL_LOADER_READY", onContentLoaderReady);
            }
            var _loc2_: DisplayObjectContainer = context.displayObjectContainer;
            var _loc3_: LoaderInfo = _loc2_.loaderInfo;
            var_1634 = new RoomContentLoader(_loc3_.loaderURL);
            var_1634.initialize(events, this);
            var_1634.iconAssets = assets;
            var_1634.iconListener = this;
            var_1634.visualizationFactory = _visualizationFactory;
            _roomManager.addObjectUpdateCategory(10);
            _roomManager.addObjectUpdateCategory(20);
            _roomManager.addObjectUpdateCategory(100);
            _roomManager.addObjectUpdateCategory(200);
            _roomManager.addObjectUpdateCategory(0);
            _roomManager.setContentLoader(var_1634);
            if (var_2213 && _communication) {
                var_2213.connection = _communication.connection;
            }
            _roomDraggingAlwaysCenters = getBoolean("room.dragging.always_center");
            var_1634.sessionDataManager = _sessionDataManager;
            events.addEventListener("RCL_LOADER_READY", onContentLoaderReady);
        }

        private function onContentLoaderReady(param1: Event): void {
            var_4878 = true;
            _roomManager.initialize(<nothing/>, this);
        }

        private function onRoomSessionEvent(param1: RoomSessionEvent): void {
            switch (param1.type) {
                case "RSE_STARTED":
                    if (var_2213) {
                        var_2213.setCurrentRoom(param1.session.roomId);
                    }
                    break;
                case "RSE_ENDED":
                    if (var_2213) {
                        var_2213.resetCurrentRoom();
                        disposeRoom(param1.session.roomId);
                    }
            }
        }

        private function onToolbarClicked(param1: HabboToolbarEvent): void {
            var _loc2_: class_3355 = null;
            if (param1.iconId == "HTIE_ICON_MEMENU") {
                _loc2_ = getActiveRoomCamera();
                if (_loc2_) {
                    _loc2_.activateFollowing(cameraFollowDuration);
                    _loc2_.reset();
                }
            }
        }

        private function roomObjectEventHandler(param1: RoomObjectEvent): void {
            var _loc2_: String = null;
            var _loc3_: int = 0;
            if (var_1707 != null) {
                _loc2_ = getRoomObjectRoomIdentifier(param1.object);
                if (_loc2_ != null) {
                    _loc3_ = getRoomId(_loc2_);
                    var_1707.handleRoomObjectEvent(param1, _loc3_);
                }
            }
        }

        private function showRoomAd(param1: AdEvent): void {
            var _loc3_: IRoomObjectController = null;
            var _loc2_: RoomObjectRoomAdUpdateMessage = null;
            if (var_1634 != null) {
                _loc3_ = getObjectRoom(param1.roomId);
                if (_loc3_ == null) {
                    return;
                }
                _loc2_ = null;
                _loc2_ = new RoomObjectRoomAdUpdateMessage("RORUM_ROOM_AD_ACTIVATE", "room_ad_image_asset", param1.clickUrl);
                _loc3_.getEventHandler().processUpdateMessage(_loc2_);
            }
        }

        private function onRoomAdImageLoaded(param1: AdEvent): void {
            var _loc2_: RoomObjectRoomAdUpdateMessage = null;
            var _loc3_: IRoomObjectController = getObjectRoom(param1.roomId);
            if (_loc3_ == null) {
                return;
            }
            var _loc4_: IRoomObjectController;
            if ((_loc4_ = getObjectFurniture(param1.roomId, param1.objectId)) == null || _loc4_.getEventHandler() == null) {
                return;
            }
            if (param1.image != null) {
                var_1634.addGraphicAsset(_loc4_.getType(), param1.imageUrl, param1.image, true);
            }
            switch (param1.type) {
                case "AE_ROOM_AD_IMAGE_LOADED":
                    _loc2_ = new RoomObjectRoomAdUpdateMessage("RORUM_ROOM_BILLBOARD_IMAGE_LOADED", param1.imageUrl, param1.clickUrl, param1.objectId, param1.image);
                    break;
                case "AE_ROOM_AD_IMAGE_LOADING_FAILED":
                    _loc2_ = new RoomObjectRoomAdUpdateMessage("RORUM_ROOM_BILLBOARD_IMAGE_LOADING_FAILED", param1.imageUrl, param1.clickUrl, param1.objectId, param1.image);
            }
            if (_loc2_ != null) {
                _loc4_.getEventHandler().processUpdateMessage(_loc2_);
            }
        }

        private function onBadgeLoaded(param1: BadgeImageReadyEvent): void {
            var _loc4_: int = 0;
            var _loc3_: class_3467 = null;
            var _loc5_: Function = null;
            var _loc6_: RoomObjectGroupBadgeUpdateMessage = null;
            var _loc2_: Array = var_2155.getValue(param1.badgeId) as Array;
            if (_loc2_ == null) {
                class_14.log("Could not find matching objects for group badge asset request " + param1.badgeId);
                return;
            }
            _loc4_ = 0;
            while (_loc4_ < _loc2_.length) {
                _loc3_ = _loc2_[_loc4_];
                addBadgeGraphicAssets(_loc3_.object, param1.badgeId, _loc3_.groupBadge);
                _loc5_ = _loc3_.groupBadge ? _sessionDataManager.getGroupBadgeAssetName : _sessionDataManager.getBadgeImageAssetName;
                if ((_loc6_ = new RoomObjectGroupBadgeUpdateMessage(param1.badgeId, _loc5_.call(null, param1.badgeId))) != null && _loc3_.object.getEventHandler() != null) {
                    _loc3_.object.getEventHandler().processUpdateMessage(_loc6_);
                }
                _loc4_++;
            }
            var_2155.remove(param1.badgeId);
            if (var_2155.length == 0) {
                _sessionDataManager.events.removeEventListener("BIRE_BADGE_IMAGE_READY", onBadgeLoaded);
            }
        }
    }
}
