package com.sulake.habbo.room {
   import com.sulake.core.runtime.ICoreConfiguration
   import com.sulake.habbo.room.utils.class_3373
   import com.sulake.habbo.room.utils.class_3419
   import com.sulake.habbo.room.utils.class_3513
   import com.sulake.habbo.session.IRoomSessionManager
   import com.sulake.habbo.session.ISessionDataManager
   import com.sulake.habbo.window.IHabboWindowManager
   import com.sulake.room.IRoomInstance
   import com.sulake.room.object.IRoomObjectController
   import com.sulake.room.utils.RoomGeometry

   [SecureSWF(rename="true")]
    public interface IRoomCreator extends IRoomObjectCreator {

        function get configuration(): ICoreConfiguration;

        function get roomSessionManager(): IRoomSessionManager;

        function get sessionDataManager(): ISessionDataManager;

        function get windowManager(): IHabboWindowManager;

        function initializeRoom(param1: int, param2: XML): void;

        function getRoom(param1: int): IRoomInstance;

        function disposeRoom(param1: int): void;

        function setOwnUserId(param1: int, param2: int): void;

        function setWorldType(param1: int, param2: String): void;

        function getObjectRoom(param1: int): IRoomObjectController;

        function setFurniStackingHeightMap(param1: int, param2: class_3419): void;

        function getFurniStackingHeightMap(param1: int): class_3419;

        function getLegacyGeometry(param1: int): class_3373;

        function getRoomGeometry(param1: int): RoomGeometry;

        function getTileObjectMap(param1: int): class_3513;

        function getRoomNumberValue(param1: int, param2: String): Number;

        function getRoomStringValue(param1: int, param2: String): String;

        function setIsPlayingGame(param1: int, param2: Boolean): void;

        function leaveSpectate(): void;

        function setHanditemControlBlocked(param1: int, param2: Boolean): void;

        function refreshTileObjectMap(param1: int, param2: String): void;
    }
}
