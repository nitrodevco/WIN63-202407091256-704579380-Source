package com.sulake.habbo.room.utils {
    import com.sulake.core.utils.Map

    [SecureSWF(rename="true")]
    public class class_3344 {

        public function class_3344(param1: int) {
            var_2361 = new Map();
            var_2327 = new Map();
            _mouseButtonCursorOwners = [];
            super();
            var_369 = param1;
            _legacyGeometry = new class_3373();
            var_3247 = new class_3355();
        }
        private var var_369: int = 0;
        private var var_2234: class_3419 = null;
        private var var_2619: class_3513 = null;

        private var var_3247: class_3355 = null;
        private var var_4336: String = null;
        private var var_2361: Map;
        private var var_2327: Map;
        private var _mouseButtonCursorOwners: Array;

        private var _legacyGeometry: class_3373 = null;

        public function get legacyGeometry(): class_3373 {
            return _legacyGeometry;
        }

        private var _selectedObject: class_3413 = null;

        public function get selectedObject(): class_3413 {
            return _selectedObject;
        }

        public function set selectedObject(param1: class_3413): void {
            if (_selectedObject != null) {
                _selectedObject.dispose();
            }
            _selectedObject = param1;
        }

        private var _placedObject: class_3413 = null;

        public function get placedObject(): class_3413 {
            return _placedObject;
        }

        public function set placedObject(param1: class_3413): void {
            if (_placedObject != null) {
                _placedObject.dispose();
            }
            _placedObject = param1;
        }

        public function get roomId(): int {
            return var_369;
        }

        public function get furniStackingHeightMap(): class_3419 {
            return var_2234;
        }

        public function set furniStackingHeightMap(param1: class_3419): void {
            if (var_2234 != null) {
                var_2234.dispose();
            }
            var_2234 = param1;
            if (var_2619) {
                var_2619.dispose();
            }
            if (var_2234) {
                var_2619 = new class_3513(var_2234.width, var_2234.height);
            }
        }

        public function get tileObjectMap(): class_3513 {
            return var_2619;
        }

        public function get roomCamera(): class_3355 {
            return var_3247;
        }

        public function get worldType(): String {
            return var_4336;
        }

        public function set worldType(param1: String): void {
            var_4336 = param1;
        }

        public function dispose(): void {
            if (var_2234 != null) {
                var_2234.dispose();
                var_2234 = null;
            }
            if (_legacyGeometry != null) {
                _legacyGeometry.dispose();
                _legacyGeometry = null;
            }
            if (var_3247 != null) {
                var_3247.dispose();
                var_3247 = null;
            }
            if (_selectedObject != null) {
                _selectedObject.dispose();
                _selectedObject = null;
            }
            if (_placedObject != null) {
                _placedObject.dispose();
                _placedObject = null;
            }
            if (var_2361 != null) {
                var_2361.dispose();
                var_2361 = null;
            }
            if (var_2327 != null) {
                var_2327.dispose();
                var_2327 = null;
            }
            if (var_2619 != null) {
                var_2619.dispose();
                var_2619 = null;
            }
        }

        public function addFurnitureData(param1: class_3498): void {
            if (param1 != null) {
                var_2361.remove(param1.id);
                var_2361.add(param1.id, param1);
            }
        }

        public function getFurnitureData(): class_3498 {
            if (var_2361.length > 0) {
                return getFurnitureDataWithId(var_2361.getKey(0));
            }
            return null;
        }

        public function getFurnitureDataWithId(param1: int): class_3498 {
            return var_2361.remove(param1);
        }

        public function addWallItemData(param1: class_3498): void {
            if (param1 != null) {
                var_2327.remove(param1.id);
                var_2327.add(param1.id, param1);
            }
        }

        public function getWallItemData(): class_3498 {
            if (var_2327.length > 0) {
                return getWallItemDataWithId(var_2327.getKey(0));
            }
            return null;
        }

        public function getWallItemDataWithId(param1: int): class_3498 {
            return var_2327.remove(param1);
        }

        public function addButtonMouseCursorOwner(param1: String): Boolean {
            var _loc2_: int = _mouseButtonCursorOwners.indexOf(param1);
            if (_loc2_ == -1) {
                _mouseButtonCursorOwners.push(param1);
                return true;
            }
            return false;
        }

        public function removeButtonMouseCursorOwner(param1: String): Boolean {
            var _loc2_: int = _mouseButtonCursorOwners.indexOf(param1);
            if (_loc2_ > -1) {
                _mouseButtonCursorOwners.splice(_loc2_, 1);
                return true;
            }
            return false;
        }

        public function hasButtonMouseCursorOwners(): Boolean {
            return _mouseButtonCursorOwners.length > 0;
        }
    }
}
