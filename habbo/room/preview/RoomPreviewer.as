package com.sulake.habbo.room.preview {
   import com.sulake.core.runtime.Component
   import com.sulake.habbo.room.IGetImageListener
   import com.sulake.habbo.room.IRoomEngine
   import com.sulake.habbo.room.IStuffData
   import com.sulake.habbo.room.class_3499
   import com.sulake.habbo.room.events.RoomEngineEvent
   import com.sulake.habbo.room.events.RoomEngineObjectEvent
   import com.sulake.habbo.room.object.RoomPlaneParser
   import com.sulake.habbo.room.object.data.LegacyStuffData
   import com.sulake.room.object.IRoomObject
   import com.sulake.room.object.IRoomObjectModelController
   import com.sulake.room.object.visualization.IRoomObjectVisualization
   import com.sulake.room.utils.IRoomGeometry
   import com.sulake.room.utils.IVector3d
   import com.sulake.room.utils.RoomId
   import com.sulake.room.utils.Vector3d

   import flash.display.BitmapData
   import flash.display.DisplayObject
   import flash.geom.Point
   import flash.geom.Rectangle
   import flash.utils.getTimer

   public class RoomPreviewer {

        private static const PREVIEW_CANVAS_ID: int = 1;

        private static const PREVIEW_OBJECT_ID: int = 1;

        private static const PREVIEW_OBJECT_LOCATION_X: int = 2;

        private static const PREVIEW_OBJECT_LOCATION_Y: int = 2;

        private static const ALLOWED_IMAGE_CUT: Number = 0.25;

        public static const SCALE_NORMAL: int = 64;

        public static const SCALE_SMALL: int = 32;

        private static const AUTOMATIC_STATE_CHANGE_INTERVAL: int = 2500;

        public function RoomPreviewer(param1: IRoomEngine, param2: int = 1) {
            _addViewOffset = new Point(0, 0);
            super();
            _roomEngine = param1;
            var_1667 = RoomId.makeRoomPreviewerId(param2);
            if (_roomEngine) {
                _roomEngine.events.addEventListener("REOE_ADDED", onRoomObjectAdded);
                _roomEngine.events.addEventListener("REOE_CONTENT_UPDATED", onRoomObjectAdded);
                _roomEngine.events.addEventListener("REE_INITIALIZED", onRoomInitialized);
            }
        }
        private var _roomEngine: IRoomEngine;
        private var var_1667: int = 1;
        private var var_2824: int = 0;
        private var var_1904: int = 0;
        private var var_3136: String = "";
        private var _currentPreviewRectangle: Rectangle = null;
        private var _currentPreviewCanvasWidth: int = 0;
        private var var_2737: int = 0;
        private var var_1965: int = 64;
        private var var_2979: Boolean;
        private var var_2673: Boolean;
        private var _previousAutomaticStateChangeTime: int;

        private var _addViewOffset: Point;

        public function get addViewOffset(): Point {
            return _addViewOffset;
        }

        public function set addViewOffset(param1: Point): void {
            _addViewOffset = param1;
        }

        private var _disableUpdate: Boolean = false;

        public function set disableUpdate(param1: Boolean): void {
            _disableUpdate = param1;
        }

        public function set disableRoomEngineUpdate(param1: Boolean): void {
            if (isRoomEngineReady) {
                _roomEngine.disableUpdate = param1;
            }
        }

        public function get previewRoomId(): int {
            return var_1667;
        }

        public function get isRoomEngineReady(): Boolean {
            return _roomEngine != null && _roomEngine.isInitialized;
        }

        public function dispose(): void {
            reset(true);
            if (_roomEngine && _roomEngine.events != null) {
                _roomEngine.events.removeEventListener("REOE_ADDED", onRoomObjectAdded);
                _roomEngine.events.removeEventListener("REOE_CONTENT_UPDATED", onRoomObjectAdded);
                _roomEngine.events.removeEventListener("REE_INITIALIZED", onRoomInitialized);
            }
        }

        public function createRoomForPreviews(): void {
            var _loc1_: int = 0;
            var _loc2_: RoomPlaneParser = null;
            var _loc4_: int = 0;
            var _loc3_: int = 0;
            if (_roomEngine) {
                _loc1_ = 7;
                _loc2_ = new RoomPlaneParser();
                _loc2_.initializeTileMap(_loc1_ + 2, _loc1_ + 2);
                _loc4_ = 1;
                while (_loc4_ < 1 + _loc1_) {
                    _loc3_ = 1;
                    while (_loc3_ < 1 + _loc1_) {
                        _loc2_.setTileHeight(_loc3_, _loc4_, 0);
                        _loc3_++;
                    }
                    _loc4_++;
                }
                _loc2_.initializeFromTileData();
                _roomEngine.initializeRoom(var_1667, _loc2_.getXML());
                _loc2_.dispose();
            }
        }

        public function reset(param1: Boolean): void {
            if (_roomEngine) {
                _roomEngine.disposeObjectFurniture(var_1667, 1);
                _roomEngine.disposeObjectWallItem(var_1667, 1);
                _roomEngine.disposeObjectUser(var_1667, 1);
                if (!param1) {
                    updatePreviewRoomView();
                }
            }
            var_1904 = -2;
        }

        public function addFurnitureIntoRoom(param1: int, param2: IVector3d, param3: IStuffData = null, param4: String = null): int {
            var _loc6_: IRoomObject = null;
            var _loc5_: int = -1;
            if (param3 == null) {
                param3 = new LegacyStuffData();
            }
            if (isRoomEngineReady) {
                if (var_1904 == 10 && var_2824 == param1) {
                    return 1;
                }
                reset(false);
                var_2824 = param1;
                var_1904 = 10;
                var_3136 = "";
                if (_roomEngine.addObjectFurniture(var_1667, 1, param1, new Vector3d(2, 2, 0), param2, 0, param3, NaN, -1, 0, 0, "", true, false)) {
                    _previousAutomaticStateChangeTime = getTimer();
                    var_2673 = true;
                    _loc5_ = 1;
                    if (_loc6_ = _roomEngine.getRoomObject(var_1667, 1, var_1904)) {
                        if (param4 != null) {
                            (_loc6_.getModel() as IRoomObjectModelController).setString("furniture_extras", param4);
                        }
                    }
                    updatePreviewRoomView();
                }
            }
            return _loc5_;
        }

        public function addWallItemIntoRoom(param1: int, param2: IVector3d, param3: String): int {
            var _loc4_: int = -1;
            if (isRoomEngineReady) {
                if (var_1904 == 20 && var_2824 == param1 && var_3136 == param3) {
                    return 1;
                }
                reset(false);
                var_2824 = param1;
                var_1904 = 20;
                var_3136 = param3;
                if (_roomEngine.addObjectWallItem(var_1667, 1, param1, new Vector3d(0.5, 2.3, 1.8), param2, 0, param3, 0, 0, "", -1, false)) {
                    _previousAutomaticStateChangeTime = getTimer();
                    var_2673 = true;
                    return 1;
                }
            }
            return _loc4_;
        }

        public function addAvatarIntoRoom(param1: String, param2: int): int {
            if (isRoomEngineReady) {
                reset(false);
                var_2824 = 1;
                var_1904 = 100;
                var_3136 = param1;
                if (_roomEngine.addObjectUser(var_1667, 1, new Vector3d(2, 2, 0), new Vector3d(90, 0, 0), 135, 1, param1)) {
                    _previousAutomaticStateChangeTime = getTimer();
                    var_2673 = true;
                    updateUserGesture(1);
                    updateUserEffect(param2);
                    updateUserPosture("std");
                }
                updatePreviewRoomView();
                return 1;
            }
            return -1;
        }

        public function updateUserPosture(param1: String, param2: String = ""): void {
            if (isRoomEngineReady) {
                _roomEngine.updateObjectUserPosture(var_1667, 1, param1, param2);
            }
        }

        public function updateUserGesture(param1: int): void {
            if (isRoomEngineReady) {
                _roomEngine.updateObjectUserGesture(var_1667, 1, param1);
            }
        }

        public function updateUserEffect(param1: int): void {
            if (isRoomEngineReady) {
                _roomEngine.updateObjectUserEffect(var_1667, 1, param1);
            }
        }

        public function updateObjectUserFigure(param1: String, param2: String = null, param3: String = null, param4: Boolean = false): Boolean {
            if (isRoomEngineReady) {
                return _roomEngine.updateObjectUserFigure(var_1667, 1, param1, param2, param3, param4);
            }
            return false;
        }

        public function updateObjectUserAction(param1: String, param2: int, param3: String = null): void {
            if (isRoomEngineReady) {
                _roomEngine.updateObjectUserAction(var_1667, 1, param1, param2, param3);
            }
        }

        public function changeRoomObjectState(): void {
            if (isRoomEngineReady) {
                var_2673 = false;
                if (var_1904 != 100) {
                    _roomEngine.changeObjectState(var_1667, 1, var_1904);
                }
            }
        }

        public function getRoomCanvas(param1: int, param2: int): DisplayObject {
            var _loc3_: DisplayObject = null;
            var _loc4_: IRoomGeometry = null;
            if (_roomEngine) {
                _loc3_ = _roomEngine.createRoomCanvas(var_1667, 1, param1, param2, var_1965);
                _roomEngine.setRoomCanvasMask(var_1667, 1, true);
                if ((_loc4_ = _roomEngine.getRoomCanvasGeometry(var_1667, 1)) != null) {
                    _loc4_.adjustLocation(new Vector3d(2, 2, 0), 30);
                }
                _currentPreviewCanvasWidth = param1;
                var_2737 = param2;
                return _loc3_;
            }
            return null;
        }

        public function modifyRoomCanvas(param1: int, param2: int): void {
            if (_roomEngine) {
                _currentPreviewCanvasWidth = param1;
                var_2737 = param2;
                _roomEngine.modifyRoomCanvas(var_1667, 1, param1, param2);
            }
        }

        public function zoomIn(): void {
            var _loc1_: IRoomGeometry = null;
            if (isRoomEngineReady) {
                if ((_roomEngine as Component).getBoolean("zoom.enabled")) {
                    _roomEngine.setRoomCanvasScale(var_1667, 1, 1);
                }
                _loc1_ = _roomEngine.getRoomCanvasGeometry(var_1667, 1);
                if (!_loc1_) {
                    return;
                }
                _loc1_.performZoomIn();
            }
            var_1965 = 64;
        }

        public function zoomOut(): void {
            var _loc1_: IRoomGeometry = null;
            if (isRoomEngineReady) {
                if ((_roomEngine as Component).getBoolean("zoom.enabled")) {
                    _roomEngine.setRoomCanvasScale(var_1667, 1, 0.5);
                } else {
                    _loc1_ = _roomEngine.getRoomCanvasGeometry(var_1667, 1);
                    if (!_loc1_) {
                        return;
                    }
                    _loc1_.performZoomOut();
                }
            }
            var_1965 = 32;
        }

        public function updateAvatarDirection(param1: int, param2: int): void {
            if (isRoomEngineReady) {
                _roomEngine.updateObjectUser(var_1667, 1, new Vector3d(2, 2, 0), new Vector3d(2, 2, 0), false, 0, new Vector3d(param1 * 45, 0, 0), param2 * 45);
            }
        }

        public function updateObjectRoom(param1: String = null, param2: String = null, param3: String = null, param4: Boolean = false): Boolean {
            if (isRoomEngineReady) {
                return _roomEngine.updateObjectRoom(var_1667, param1, param2, param3, false);
            }
            return false;
        }

        public function updateRoomWallsAndFloorVisibility(param1: Boolean, param2: Boolean = true): void {
            if (isRoomEngineReady) {
                _roomEngine.updateObjectRoomVisibilities(var_1667, param1, param2);
            }
        }

        public function updatePreviewRoomView(param1: Boolean = false): void {
            var _loc3_: Point = null;
            var _loc4_: int = 0;
            var _loc2_: Point = null;
            if (_disableUpdate && !param1) {
                return;
            }
            checkAutomaticRoomObjectStateChange();
            if (isRoomEngineReady) {
                _loc3_ = _roomEngine.getRoomCanvasScreenOffset(var_1667, 1);
                if (_loc3_ != null) {
                    updatePreviewObjectBoundingRectangle(_loc3_);
                    if (_currentPreviewRectangle != null) {
                        _loc4_ = var_1965;
                        _loc3_ = validatePreviewSize(_loc3_);
                        _loc2_ = getCanvasOffset(_loc3_);
                        if (_loc2_ != null) {
                            _roomEngine.setRoomCanvasScreenOffset(var_1667, 1, _loc2_);
                        }
                        if (var_1965 != _loc4_) {
                            _currentPreviewRectangle = null;
                        }
                    }
                }
            }
        }

        public function updateRoomEngine(): void {
            if (isRoomEngineReady) {
                _roomEngine.runUpdate();
            }
        }

        public function getGenericRoomObjectImage(param1: String, param2: String, param3: IVector3d, param4: int, param5: IGetImageListener, param6: uint = 0, param7: String = null, param8: IStuffData = null, param9: int = -1, param10: int = -1, param11: String = null): class_3499 {
            if (isRoomEngineReady) {
                return _roomEngine.getGenericRoomObjectImage(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
            }
            return null;
        }

        public function getRoomObjectImage(param1: int, param2: IVector3d, param3: int, param4: IGetImageListener, param5: uint = 0): class_3499 {
            if (isRoomEngineReady) {
                return _roomEngine.getRoomObjectImage(var_1667, 1, param1, param2, param3, param4, param5);
            }
            return null;
        }

        public function getRoomObjectCurrentImage(): BitmapData {
            var _loc2_: IRoomObject = null;
            var _loc1_: IRoomObjectVisualization = null;
            if (isRoomEngineReady) {
                _loc2_ = _roomEngine.getRoomObject(var_1667, 1, 100);
                if (_loc2_) {
                    _loc1_ = _loc2_.getVisualization();
                    if (_loc1_) {
                        return _loc1_.getImage(16777215, -1);
                    }
                }
            }
            return null;
        }

        private function checkAutomaticRoomObjectStateChange(): void {
            var _loc1_: int = 0;
            if (var_2673) {
                _loc1_ = getTimer();
                if (_loc1_ > _previousAutomaticStateChangeTime + 2500) {
                    _previousAutomaticStateChangeTime = _loc1_;
                    if (isRoomEngineReady) {
                        _roomEngine.changeObjectState(var_1667, 1, var_1904);
                    }
                }
            }
        }

        private function updatePreviewObjectBoundingRectangle(param1: Point): void {
            var _loc2_: Rectangle = null;
            var _loc3_: Rectangle = _roomEngine.getRoomObjectBoundingRectangle(var_1667, 1, var_1904, 1);
            if (_loc3_ != null && param1 != null) {
                _loc3_.offset(-(_currentPreviewCanvasWidth >> 1), -(var_2737 >> 1));
                _loc3_.offset(-param1.x, -param1.y);
                if (_currentPreviewRectangle == null) {
                    _currentPreviewRectangle = _loc3_;
                } else {
                    _loc2_ = _currentPreviewRectangle.union(_loc3_);
                    if (_loc2_.width - _currentPreviewRectangle.width > _currentPreviewCanvasWidth - _currentPreviewRectangle.width >> 1 || _loc2_.height - _currentPreviewRectangle.height > var_2737 - _currentPreviewRectangle.height >> 1 || _currentPreviewRectangle.width < 1 || _currentPreviewRectangle.height < 1) {
                        _currentPreviewRectangle = _loc2_;
                    }
                }
            }
        }

        private function validatePreviewSize(param1: Point): Point {
            var _loc2_: IRoomGeometry = null;
            if (_currentPreviewRectangle.width < 1 || _currentPreviewRectangle.height < 1) {
                return param1;
            }
            if (isRoomEngineReady) {
                _loc2_ = _roomEngine.getRoomCanvasGeometry(var_1667, 1);
                if (_currentPreviewRectangle.width > _currentPreviewCanvasWidth * (1 + 0.25) || _currentPreviewRectangle.height > var_2737 * (1 + 0.25)) {
                    if ((_roomEngine as Component).getBoolean("zoom.enabled")) {
                        if (_roomEngine.getRoomCanvasScale(var_1667, 1) != 0.5) {
                            _roomEngine.setRoomCanvasScale(var_1667, 1, 0.5, null, null, false, false, true);
                            var_1965 = 32;
                            var_2979 = true;
                            param1.x >>= 1;
                            param1.y >>= 1;
                            _currentPreviewRectangle.left >>= 2;
                            _currentPreviewRectangle.right >>= 2;
                            _currentPreviewRectangle.top >>= 2;
                            _currentPreviewRectangle.bottom >>= 2;
                        }
                    } else if (_loc2_.isZoomedIn()) {
                        _loc2_.performZoomOut();
                        var_1965 = 32;
                        var_2979 = true;
                        param1.x >>= 1;
                        param1.y >>= 1;
                        _currentPreviewRectangle.left >>= 2;
                        _currentPreviewRectangle.right >>= 2;
                        _currentPreviewRectangle.top >>= 2;
                        _currentPreviewRectangle.bottom >>= 2;
                    }
                } else if (_currentPreviewRectangle.width << 1 < _currentPreviewCanvasWidth * (1 + 0.25) - 5 && _currentPreviewRectangle.height << 1 < var_2737 * (1 + 0.25) - 5) {
                    if ((_roomEngine as Component).getBoolean("zoom.enabled")) {
                        if (_roomEngine.getRoomCanvasScale(var_1667, 1) != 1 && !var_2979) {
                            _roomEngine.setRoomCanvasScale(var_1667, 1, 1, null, null, false, false, true);
                            var_1965 = 64;
                            param1.x <<= 1;
                            param1.y <<= 1;
                        }
                    } else if (!_loc2_.isZoomedIn() && !var_2979) {
                        _loc2_.performZoomIn();
                        var_1965 = 64;
                        param1.x <<= 1;
                        param1.y <<= 1;
                    }
                }
            }
            return param1;
        }

        private function getCanvasOffset(param1: Point): Point {
            var _loc7_: Number = NaN;
            if (_currentPreviewRectangle.width < 1 || _currentPreviewRectangle.height < 1) {
                return param1;
            }
            var _loc4_: * = -(_currentPreviewRectangle.left + _currentPreviewRectangle.right) >> 1;
            var _loc2_: * = -(_currentPreviewRectangle.top + _currentPreviewRectangle.bottom) >> 1;
            var _loc3_: * = var_2737 - _currentPreviewRectangle.height >> 1;
            if (_loc3_ > 10) {
                _loc2_ += Math.min(15, _loc3_ - 10);
            } else if (var_1904 != 100) {
                _loc2_ += 5 - Math.max(0, _loc3_ / 2);
            } else {
                _loc2_ -= 5 - Math.min(0, _loc3_ / 2);
            }
            _loc2_ += _addViewOffset.y;
            var _loc5_: int = (_loc4_ += _addViewOffset.x) - param1.x;
            var _loc6_: int = _loc2_ - param1.y;
            if (_loc5_ != 0 || _loc6_ != 0) {
                if ((_loc7_ = Math.sqrt(_loc5_ * _loc5_ + _loc6_ * _loc6_)) > 10) {
                    _loc4_ = param1.x + _loc5_ * 10 / _loc7_;
                    _loc2_ = param1.y + _loc6_ * 10 / _loc7_;
                }
                return new Point(_loc4_, _loc2_);
            }
            return null;
        }

        private function onRoomInitialized(param1: RoomEngineEvent): void {
            if (param1 == null) {
                return;
            }
            var _loc2_: * = param1.type;
            if ("REE_INITIALIZED" === _loc2_) {
                if (param1.roomId == var_1667) {
                    if (_roomEngine) {
                        _roomEngine.updateObjectRoom(var_1667, "110", "99999");
                    }
                }
            }
        }

        private function onRoomObjectAdded(param1: RoomEngineObjectEvent): void {
            var _loc3_: IRoomObject = null;
            var _loc4_: Number = NaN;
            var _loc2_: Number = NaN;
            if (param1.roomId == var_1667 && param1.objectId == 1 && param1.category == var_1904) {
                _currentPreviewRectangle = null;
                var_2979 = false;
                _loc3_ = _roomEngine.getRoomObject(param1.roomId, param1.objectId, param1.category);
                if (_loc3_ != null && _loc3_.getModel() != null && param1.category == 20) {
                    _loc4_ = Number(_loc3_.getModel().getNumber("furniture_size_z"));
                    _loc2_ = Number(_loc3_.getModel().getNumber("furniture_center_z"));
                    if (!isNaN(_loc4_) && !isNaN(_loc2_)) {
                        _roomEngine.updateObjectWallItemLocation(param1.roomId, param1.objectId, new Vector3d(0.5, 2.3, (3.6 - _loc4_) / 2 + _loc2_));
                    }
                }
            }
        }
    }
}
