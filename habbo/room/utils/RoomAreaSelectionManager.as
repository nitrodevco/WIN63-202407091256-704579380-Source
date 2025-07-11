package com.sulake.habbo.room.utils {
    import com.sulake.habbo.room.IRoomAreaSelectionManager
    import com.sulake.habbo.room.IRoomEngine
    import com.sulake.habbo.room.events.RoomEngineObjectEvent
    import com.sulake.habbo.room.events.RoomObjectTileMouseEvent
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureVisualization
    import com.sulake.habbo.room.object.visualization.room.RoomVisualization
    import com.sulake.room.object.IRoomObject

    import flash.filters.ColorMatrixFilter

    public class RoomAreaSelectionManager implements IRoomAreaSelectionManager {

        private static const HIGHLIGHT_FILTERS: Object = createHighlightFilters();

        public static var NOT_ACTIVE: int = 0;

        public static var NOT_SELECTING_AREA: int = 1;

        public static var AWAITING_MOUSE_DOWN: int = 2;

        public static var SELECTING: int = 3;

        private static function createHighlightFilters(): Object {
            var _loc3_: Object = {};
            var _loc4_: Array = [1.5, 0, 0, 0, 0, 0, 1.5, 0, 0, 20, 0, 0, 1.5, 0, 20, 0, 0, 0, 1, 0];
            var _loc2_: Array = [1.05, 0, 0, 0, 0, 0, 1.3, 0, 0, 8, 0, 0, 1.8, 0, 20, 0, 0, 0, 1, 0];
            var _loc1_: Array = [0.55, 0, 0, 0, -10, 0, 0.55, 0, 0, -10, 0, 0, 0.55, 0, -10, 0, 0, 0, 1, 0];
            _loc3_["highlight_brighten"] = [new ColorMatrixFilter(_loc4_)];
            _loc3_["highlight_blue"] = [new ColorMatrixFilter(_loc2_)];
            _loc3_["highlight_darken"] = [new ColorMatrixFilter(_loc1_)];
            return _loc3_;
        }

        public function RoomAreaSelectionManager(param1: IRoomEngine) {
            var_1745 = NOT_ACTIVE;
            super();
            _roomEngine = param1;
            _roomEngine.events.addEventListener("REOE_ADDED", onRoomObjectAdded);
        }
        private var _roomEngine: IRoomEngine;
        private var var_1745: int;
        private var var_3175: int = 0;
        private var var_3214: int = 0;
        private var var_932: int = 0;
        private var var_1081: int = 0;
        private var _highlightRootX: int = 0;
        private var _highlightRootY: int = 0;
        private var _highlightWidth: int = 0;
        private var _highlightHeight: int = 0;
        private var _callback: Function;
        private var _highlightType: String = "highlight_brighten";

        public function get areaSelectionState(): int {
            return var_1745;
        }

        public function startSelecting(): void {
            if (var_1745 == NOT_SELECTING_AREA) {
                clearHighlightSilent();
                var_1745 = AWAITING_MOUSE_DOWN;
                _roomEngine.setMoveBlocked(true);
            }
        }

        public function finishSelecting(): Boolean {
            if (var_1745 == SELECTING) {
                var_1745 = NOT_SELECTING_AREA;
                _roomEngine.setMoveBlocked(false);
                if (_callback != null) {
                    _callback(_highlightRootX, _highlightRootY, _highlightWidth, _highlightHeight);
                }
                return true;
            }
            return false;
        }

        public function clearHighlight(): void {
            if (var_1745 == NOT_ACTIVE) {
                return;
            }
            clearHighlightSilent();
            var_1745 = NOT_SELECTING_AREA;
            _roomEngine.setMoveBlocked(false);
            if (_callback != null) {
                _callback(0, 0, 0, 0);
            }
        }

        public function setHighlight(param1: int, param2: int, param3: int, param4: int): void {
            var _loc5_: RoomVisualization = null;
            if (var_1745 == NOT_ACTIVE) {
                return;
            }
            _highlightRootX = param1;
            _highlightRootY = param2;
            _highlightWidth = param3;
            _highlightHeight = param4;
            var _loc6_: IRoomObject;
            if ((_loc6_ = _roomEngine.getRoomObject(_roomEngine.activeRoomId, -1, 0)) != null) {
                (_loc5_ = _loc6_.getVisualization() as RoomVisualization).initializeHighlightArea(param1, param2, param3, param4, HIGHLIGHT_FILTERS[_highlightType]);
            }
        }

        public function activate(param1: Function, param2: String): Boolean {
            var _loc3_: FurnitureVisualization = null;
            if (var_1745 != NOT_ACTIVE) {
                return false;
            }
            _callback = param1;
            _highlightType = param2;
            for each(var _loc4_ in getAllFurnis()) {
                _loc3_ = _loc4_.getVisualization() as FurnitureVisualization;
                if (_loc3_ != null) {
                    _loc3_.lookThrough = true;
                }
            }
            var_1745 = NOT_SELECTING_AREA;
            return true;
        }

        public function deactivate(): void {
            var _loc1_: FurnitureVisualization = null;
            if (var_1745 == NOT_ACTIVE) {
                return;
            }
            _callback = null;
            for each(var _loc2_ in getAllFurnis()) {
                _loc1_ = _loc2_.getVisualization() as FurnitureVisualization;
                if (_loc1_ != null) {
                    _loc1_.lookThrough = false;
                }
            }
            clearHighlight();
            var_1745 = NOT_ACTIVE;
        }

        public function dispose(): void {
            deactivate();
            _roomEngine.events.removeEventListener("REOE_ADDED", onRoomObjectAdded);
        }

        private function getAllFurnis(): Array {
            return _roomEngine.getObjectsByCategory(20).concat(_roomEngine.getObjectsByCategory(10));
        }

        private function clearHighlightSilent(): void {
            var _loc1_: RoomVisualization = null;
            var _loc2_: IRoomObject = _roomEngine.getRoomObject(_roomEngine.activeRoomId, -1, 0);
            if (_loc2_ != null) {
                _loc1_ = _loc2_.getVisualization() as RoomVisualization;
                _loc1_.clearHighlightArea();
            }
        }

        public function handleTileMouseEvent(param1: RoomObjectTileMouseEvent): void {
            var _loc4_: int = 0;
            var _loc5_: int = 0;
            var _loc2_: int = 0;
            var _loc6_: int = 0;
            var _loc3_: Boolean = var_1745 == AWAITING_MOUSE_DOWN && param1.type == "ROE_MOUSE_DOWN";
            if (param1.shiftKey && var_1745 == NOT_SELECTING_AREA && param1.type == "ROE_MOUSE_DOWN") {
                startSelecting();
                _loc3_ = true;
            }
            if (_loc3_) {
                var_1745 = SELECTING;
                var_3175 = param1.tileXAsInt;
                var_3214 = param1.tileYAsInt;
                var_932 = param1.tileXAsInt;
                var_1081 = param1.tileYAsInt;
                setHighlight(var_3175, var_3214, 1, 1);
            } else if (var_1745 == SELECTING && param1.type == "ROE_MOUSE_MOVE") {
                if (param1.tileXAsInt != var_932 || param1.tileYAsInt != var_1081) {
                    var_932 = param1.tileXAsInt;
                    var_1081 = param1.tileYAsInt;
                    if (var_932 > var_3175) {
                        _loc4_ = var_3175;
                        _loc2_ = var_932 - var_3175 + 1;
                    } else {
                        _loc4_ = var_932;
                        _loc2_ = var_3175 - var_932 + 1;
                    }
                    if (var_1081 > var_3214) {
                        _loc5_ = var_3214;
                        _loc6_ = var_1081 - var_3214 + 1;
                    } else {
                        _loc5_ = var_1081;
                        _loc6_ = var_3214 - var_1081 + 1;
                    }
                    setHighlight(_loc4_, _loc5_, _loc2_, _loc6_);
                }
            }
        }

        private function onRoomObjectAdded(param1: RoomEngineObjectEvent): void {
            var _loc2_: FurnitureVisualization = null;
            if (var_1745 == NOT_ACTIVE) {
                return;
            }
            if (param1.type != "REOE_ADDED") {
                return;
            }
            if (param1.roomId != _roomEngine.activeRoomId) {
                return;
            }
            if (param1.category != 10 && param1.category != 20) {
                return;
            }
            var _loc3_: IRoomObject = _roomEngine.getRoomObject(param1.roomId, param1.objectId, param1.category);
            if (_loc3_) {
                _loc2_ = _loc3_.getVisualization() as FurnitureVisualization;
                if (_loc2_ != null) {
                    _loc2_.lookThrough = true;
                }
            }
        }
    }
}
