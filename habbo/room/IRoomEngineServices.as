package com.sulake.habbo.room {
   import com.sulake.core.communication.connection.IConnection
   import com.sulake.core.runtime.ICoreConfiguration
   import com.sulake.habbo.catalog.IHabboCatalog
   import com.sulake.habbo.game.class_1805
   import com.sulake.habbo.room.utils.class_3373
   import com.sulake.habbo.room.utils.class_3413
   import com.sulake.habbo.room.utils.class_3419
   import com.sulake.habbo.room.utils.class_3513
   import com.sulake.habbo.session.IRoomSessionManager
   import com.sulake.habbo.session.ISessionDataManager
   import com.sulake.habbo.toolbar.IHabboToolbar
   import com.sulake.habbo.window.IHabboWindowManager
   import com.sulake.room.IRoomInstance
   import com.sulake.room.object.IRoomObject
   import com.sulake.room.object.IRoomObjectController
   import com.sulake.room.renderer.IRoomRenderingCanvas

   import flash.events.IEventDispatcher

   [SecureSWF(rename="true")]
    public interface IRoomEngineServices extends IRoomObjectCreator {

        function get connection(): IConnection;

        function get events(): IEventDispatcher;

        function get gameEngine(): class_1805;

        function get activeRoomHasHanditemControlBlocked(): Boolean;

        function get isDecorateMode(): Boolean;

        function get isGameMode(): Boolean;

        function get playerUnderCursor(): int;

        function get configuration(): ICoreConfiguration;

        function get roomSessionManager(): IRoomSessionManager;

        function get sessionDataManager(): ISessionDataManager;

        function get toolbar(): IHabboToolbar;

        function get catalog(): IHabboCatalog;

        function get windowManager(): IHabboWindowManager;

        function get areaSelectionManager(): IRoomAreaSelectionManager;

        function getRoom(param1: int): IRoomInstance;

        function getRoomObjectCategory(param1: String): int;

        function getRoomObject(param1: int, param2: int, param3: int): IRoomObject;

        function getRoomObjectWithIndex(param1: int, param2: int, param3: int): IRoomObject;

        function getRoomObjectCount(param1: int, param2: int): int;

        function updateObjectRoomWindow(param1: int, param2: int, param3: Boolean = true): void;

        function setObjectMoverIconSprite(param1: int, param2: int, param3: Boolean, param4: String = null, param5: IStuffData = null, param6: int = -1, param7: int = -1, param8: String = null): void;

        function setObjectMoverIconSpriteVisible(param1: Boolean): void;

        function removeObjectMoverIconSprite(): void;

        function getSelectedObjectData(param1: int): ISelectedRoomObjectData;

        function setSelectedObjectData(param1: int, param2: class_3413): void;

        function setPlacedObjectData(param1: int, param2: class_3413): void;

        function getPlacedObjectData(param1: int): ISelectedRoomObjectData;

        function getLegacyGeometry(param1: int): class_3373;

        function getFurniStackingHeightMap(param1: int): class_3419;

        function getTileObjectMap(param1: int): class_3513;

        function getSelectionArrow(param1: int): IRoomObjectController;

        function getTileCursor(param1: int): IRoomObjectController;

        function getIsPlayingGame(param1: int): Boolean;

        function getActiveRoomIsPlayingGame(): Boolean;

        function requestRoomAdImage(param1: int, param2: int, param3: int, param4: String, param5: String): void;

        function requestMouseCursor(param1: String, param2: int, param3: String): void;

        function addFloorHole(param1: int, param2: int): void;

        function removeFloorHole(param1: int, param2: int): void;

        function getActiveRoomActiveCanvas(): IRoomRenderingCanvas;

        function requestBadgeImageAsset(param1: int, param2: int, param3: int, param4: String, param5: Boolean = true): void;

        function isAreaSelectionMode(): Boolean;

        function isMoveBlocked(): Boolean;

        function isWhereYouClickWhereYouGo(): Boolean;
    }
}
