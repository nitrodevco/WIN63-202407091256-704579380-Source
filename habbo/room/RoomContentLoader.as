package com.sulake.habbo.room {
   import assets.class_14

   import com.sulake.core.assets.AssetLibrary
   import com.sulake.core.assets.AssetLibraryCollection
   import com.sulake.core.assets.AssetLoaderStruct
   import com.sulake.core.assets.BitmapDataAsset
   import com.sulake.core.assets.IAsset
   import com.sulake.core.assets.IAssetLibrary
   import com.sulake.core.class_79
   import com.sulake.core.runtime.ICoreConfiguration
   import com.sulake.core.runtime.IDisposable
   import com.sulake.core.utils.Map
   import com.sulake.core.utils.LibraryLoader
   import com.sulake.core.utils.class_67
   import com.sulake.habbo.room.object.RoomObjectUserTypes
   import com.sulake.habbo.session.ISessionDataManager
   import com.sulake.habbo.session.furniture.class_1813
   import com.sulake.habbo.session.furniture.class_3365
   import com.sulake.habbo.utils.StringUtil
   import com.sulake.room.IRoomContentLoader
   import com.sulake.room.events.RoomContentLoadedEvent
   import com.sulake.room.object.IRoomObject
   import com.sulake.room.object.IRoomObjectController
   import com.sulake.room.object.IRoomObjectVisualizationFactory
   import com.sulake.room.object.visualization.utils.class_3367

   import flash.display.BitmapData
   import flash.events.Event
   import flash.events.IEventDispatcher
   import flash.net.URLRequest
   import flash.utils.Dictionary
   import flash.utils.getTimer

   [SecureSWF(rename="true")]
    public class RoomContentLoader implements IRoomContentLoader, class_1813, IDisposable {

        public static const CONTENT_LOADER_READY: String = "RCL_LOADER_READY";

        private static const ASSET_LIBRARY_NAME_PREFIX: String = "RoomContentLoader ";

        private static const STATE_CREATED: int = 0;

        private static const STATE_INITIALIZING: int = 1;

        private static const STATE_READY: int = 2;

        private static const PLACE_HOLDER_FURNITURE: String = "place_holder";

        private static const PLACE_HOLDER_WALL_ITEM: String = "wall_place_holder";

        private static const PLACE_HOLDER_PET: String = "pet_place_holder";

        private static const PLACE_HOLDER_DEFAULT: String = "place_holder";

        private static const ROOM_CONTENT: String = "room";

        private static const const_929: String = "tile_cursor";

        private static const const_1065: String = "selection_arrow";

        private static const PLACE_HOLDER_TYPES: Array = ["place_holder", "wall_place_holder", "pet_place_holder", "room", "tile_cursor", "selection_arrow"];

        private static const PLACE_HOLDER_TYPES_GPU: Array = ["place_holder", "wall_place_holder", "pet_place_holder", "room", "selection_arrow"];

        private static const CONTENT_DROP_DELAY: int = 20000;

        private static const COMPRESSION_INTERVAL: int = 30000;

        public function RoomContentLoader(param1: String) {
            var_2100 = new Dictionary();
            _wallItems = new Dictionary();
            var_2094 = new Dictionary();
            super();
            var_240 = param1;
            var_2051 = new Map();
            name_1 = new Map();
            var_2179 = new Map();
            var_2532 = new Map();
            var_2552 = new Map();
            var_2816 = new Map();
            var_2887 = new Map();
            var_2748 = new Map();
            var_2442 = new Map();
            var_2291 = new Map();
            var_2370 = new Map();
            var_1827 = new Map();
            var_2603 = new Map();
        }
        private var var_240: String;
        private var var_2051: Map = null;
        private var name_1: Map = null;
        private var var_2603: Map = null;
        private var var_1827: Map = null;
        private var var_149: int = 0;

        private var _stateEvents: IEventDispatcher = null;

        private var var_318: Boolean = false;

        private var var_4558: Boolean = false;

        private var var_2179: Map = null;

        private var var_2100: Dictionary;

        private var var_2532: Map = null;

        private var var_2552: Map = null;

        private var _wallItems: Dictionary;

        private var var_2816: Map = null;

        private var var_2887: Map = null;

        private var var_2094: Dictionary;

        private var _petColors: Map = null;

        private var _petLayers: Map = null;

        private var var_2442: Map = null;

        private var var_2291: Map = null;

        private var var_2370: Map = null;

        private var var_2748: Map = null;

        private var var_4646: String;

        private var var_4721: String;

        private var var_4542: String;

        private var var_4243: String;

        private var var_4790: String;

        private var var_3642: Boolean = false;

        private var _lastAssetCompressionTime: uint;
        private var var_4493: IAssetLibrary;
        private var var_2084: IRoomContentListener;
        private var var_209: ICoreConfiguration;
        private var var_3106: Array;

        private var _visualizationFactory: IRoomObjectVisualizationFactory = null;

        public function set visualizationFactory(param1: IRoomObjectVisualizationFactory): void {
            _visualizationFactory = param1;
        }

        private var _sessionDataManager: ISessionDataManager;

        public function set sessionDataManager(param1: ISessionDataManager): void {
            _sessionDataManager = param1;
            if (var_3642) {
                var_3642 = false;
                initFurnitureData();
            }
        }

        public function get disposed(): Boolean {
            return var_318;
        }

        public function set iconAssets(param1: IAssetLibrary): void {
            var_4493 = param1;
        }

        public function set iconListener(param1: IRoomContentListener): void {
            var_2084 = param1;
        }

        private function get fileProxy(): class_67 {
            return class_79.instance.fileProxy;
        }

        public function initialize(param1: IEventDispatcher, param2: ICoreConfiguration): void {
            _stateEvents = param1;
            var_4646 = param2.getProperty("flash.dynamic.download.url");
            var_4721 = param2.getProperty("flash.dynamic.download.name.template");
            var_4542 = param2.getProperty("flash.dynamic.icon.download.name.template");
            var_4243 = param2.getProperty("pet.dynamic.download.url");
            var_4790 = param2.getProperty("pet.dynamic.download.name.template");
            var_209 = param2;
            var_149 = 1;
            initFurnitureData();
            initPetData(param2);
        }

        public function dispose(): void {
            var _loc2_: int = 0;
            var _loc3_: int = 0;
            var _loc1_: AssetLibrary = null;
            var _loc4_: class_3367 = null;
            var _loc5_: String = null;
            if (var_2051 != null) {
                _loc2_ = int(var_2051.length);
                _loc3_ = 0;
                while (_loc3_ < _loc2_) {
                    _loc1_ = var_2051.getWithIndex(_loc3_) as AssetLibrary;
                    if (_loc1_ != null) {
                        _loc1_.dispose();
                    }
                    _loc3_++;
                }
                var_2051.dispose();
                var_2051 = null;
            }
            if (name_1 != null) {
                name_1.dispose();
                name_1 = null;
            }
            if (var_2179 != null) {
                var_2179.dispose();
                var_2179 = null;
            }
            if (var_2532) {
                var_2532.dispose();
                var_2532 = null;
            }
            if (var_2552 != null) {
                var_2552.dispose();
                var_2552 = null;
            }
            if (var_2816) {
                var_2816.dispose();
                var_2816 = null;
            }
            if (var_2887 != null) {
                var_2887.dispose();
                var_2887 = null;
            }
            if (_petColors != null) {
                _petColors.dispose();
                _petColors = null;
            }
            if (_petLayers != null) {
                _petLayers.dispose();
                _petLayers = null;
            }
            if (var_2442 != null) {
                var_2442.dispose();
                var_2442 = null;
            }
            if (var_2291 != null) {
                var_2291.dispose();
                var_2291 = null;
            }
            if (var_2370 != null) {
                var_2370.dispose();
                var_2370 = null;
            }
            if (var_2748 != null) {
                var_2748.dispose();
                var_2748 = null;
            }
            if (var_1827 != null) {
                _loc2_ = int(var_1827.length);
                _loc3_ = 0;
                while (_loc3_ < _loc2_) {
                    if ((_loc4_ = var_1827.getWithIndex(_loc3_) as class_3367) != null) {
                        _loc4_.dispose();
                    }
                    _loc3_++;
                }
                var_1827.dispose();
                var_1827 = null;
            }
            if (var_2603 != null) {
                var_2603.dispose();
                var_2603 = null;
            }
            if (var_2100 != null) {
                for (_loc5_ in var_2100) {
                    delete var_2100[_loc5_];
                }
                var_2100 = null;
            }
            if (_wallItems != null) {
                for (_loc5_ in _wallItems) {
                    delete _wallItems[_loc5_];
                }
                _wallItems = null;
            }
            if (var_2094 != null) {
                for (_loc5_ in var_2094) {
                    delete var_2094[_loc5_];
                }
                var_2094 = null;
            }
            _stateEvents = null;
            _sessionDataManager = null;
            var_209 = null;
            var_318 = true;
        }

        public function setRoomObjectAlias(param1: String, param2: String): void {
            if (var_2291 != null) {
                var_2291.remove(param1);
                var_2291.add(param1, param2);
            }
            if (var_2370 != null) {
                var_2370.remove(param2);
                var_2370.add(param2, param1);
            }
        }

        public function getObjectCategory(param1: String): int {
            if (param1 == null) {
                return -2;
            }
            if (var_2100[param1] != null) {
                return 10;
            }
            if (_wallItems[param1] != null) {
                return 20;
            }
            if (var_2094[param1] != null) {
                return 100;
            }
            if (param1.indexOf("poster") == 0) {
                return 20;
            }
            if (param1 == "room") {
                return 0;
            }
            if (param1 == "user") {
                return 100;
            }
            if (param1 == "pet") {
                return 100;
            }
            if (param1 == "bot") {
                return 100;
            }
            if (param1 == "rentable_bot") {
                return 100;
            }
            if (param1 == "tile_cursor" || param1 == "selection_arrow") {
                return 200;
            }
            return -2;
        }

        public function getPlaceHolderType(param1: String): String {
            if (var_2100[param1] != null) {
                return "place_holder";
            }
            if (_wallItems[param1] != null) {
                return "wall_place_holder";
            }
            if (var_2094[param1] != null) {
                return "pet_place_holder";
            }
            return "place_holder";
        }

        public function getPlaceHolderTypes(): Array {
            return PLACE_HOLDER_TYPES;
        }

        public function getActiveObjectType(param1: int): String {
            var _loc2_: String = var_2179.getValue(param1) as String;
            if (_loc2_ == null) {
                class_14.log("[RoomContentLoader] Could not find type for id: " + param1);
            }
            return getObjectType(_loc2_);
        }

        public function getActiveObjectTypeId(param1: String): int {
            return var_2532.getValue(param1);
        }

        public function getWallItemType(param1: int, param2: String = null): String {
            var _loc3_: String = var_2552.getValue(param1) as String;
            if (_loc3_ == "poster" && param2 != null) {
                _loc3_ += param2;
            }
            return getObjectType(_loc3_);
        }

        public function getWallItemTypeId(param1: String): int {
            return var_2816.getValue(param1);
        }

        public function getPetType(param1: int): String {
            return var_2887.getValue(param1) as String;
        }

        public function getPetTypeId(param1: String): int {
            return var_2094[param1];
        }

        public function getPetColor(param1: int, param2: int): PetColorResult {
            var _loc3_: Map = _petColors[param1];
            if (_loc3_ != null) {
                return _loc3_[param2] as PetColorResult;
            }
            return null;
        }

        public function getPetColorsByTag(param1: int, param2: String): Array {
            var _loc5_: Map = _petColors[param1];
            var _loc3_: Array = [];
            if (_loc5_ != null) {
                for each(var _loc4_ in _loc5_.getValues()) {
                    if (_loc4_.tag == param2) {
                        _loc3_.push(_loc4_);
                    }
                }
            }
            return _loc3_;
        }

        public function getPetLayerIdForTag(param1: int, param2: String, param3: int = 64): int {
            var _loc5_: Dictionary = null;
            var _loc4_: Map;
            if (_loc4_ = _petLayers[param1]) {
                if (_loc5_ = _loc4_[param3.toString()]) {
                    return _loc5_[param2] != null ? _loc5_[param2] : -1;
                }
            }
            return -1;
        }

        public function getPetDefaultPalette(param1: int, param2: String): PetColorResult {
            var _loc4_: Map;
            if ((_loc4_ = _petColors[param1]) != null) {
                for each(var _loc3_ in _loc4_.getValues()) {
                    if (_loc3_.layerTags.indexOf(param2) > -1 && _loc3_.isMaster) {
                        return _loc3_;
                    }
                }
            }
            return null;
        }

        public function getActiveObjectColorIndex(param1: int): int {
            var _loc2_: String = var_2179.getValue(param1) as String;
            return getObjectColorIndex(_loc2_);
        }

        public function getWallItemColorIndex(param1: int): int {
            var _loc2_: String = var_2552.getValue(param1) as String;
            return getObjectColorIndex(_loc2_);
        }

        public function getRoomObjectAdURL(param1: String): String {
            if (var_2748.getValue(param1) != null) {
                return var_2748.getValue(param1);
            }
            return "";
        }

        public function getContentType(param1: String): String {
            return param1;
        }

        public function hasInternalContent(param1: String): Boolean {
            param1 = RoomObjectUserTypes.getVisualizationType(param1);
            if (param1 == "user" || param1 == "game_snowball" || param1 == "game_snowsplash") {
                return true;
            }
            return false;
        }

        public function insertObjectContent(param1: int, param2: int, param3: IAssetLibrary): Boolean {
            var _loc6_: Event = null;
            var _loc7_: IEventDispatcher = null;
            var _loc5_: String = getAssetLibraryType(param3);
            switch (param2 - 10) {
                case 0:
                    var_2179[param1] = _loc5_;
                    var_2532.add(_loc5_, param1);
                    break;
                case 10:
                    var_2552[param1] = _loc5_;
                    break;
                default:
                    throw new Error("Registering content library for unsupported category " + param2 + "!");
            }
            var _loc4_: AssetLibraryCollection;
            if (_loc4_ = addAssetLibraryCollection(_loc5_, null) as AssetLibraryCollection) {
                _loc4_.addAssetLibrary(param3);
                if (initializeGraphicAssetCollection(_loc5_, param3)) {
                    switch (param2 - 10) {
                        case 0:
                            if (var_2100[_loc5_] == null) {
                                var_2100[_loc5_] = 1;
                            }
                            break;
                        case 10:
                            if (_wallItems[_loc5_] == null) {
                                _wallItems[_loc5_] = 1;
                            }
                            break;
                        default:
                            throw new Error("Registering content library for unsupported category " + param2 + "!");
                    }
                    _loc6_ = new RoomContentLoadedEvent("RCLE_SUCCESS", _loc5_);
                    if (_loc7_ = getAssetLibraryEventDispatcher(_loc5_, true)) {
                        _loc7_.dispatchEvent(_loc6_);
                    }
                    return true;
                }
            }
            return false;
        }

        public function getObjectUrl(param1: String, param2: String): String {
            var _loc3_: Array = null;
            var _loc4_: * = null;
            if (param1 && param1.indexOf(",") >= 0) {
                param1 = String((_loc4_ = param1).split(",")[0]);
            }
            if (_loc4_ != null) {
                _loc3_ = getObjectContentURLs(_loc4_, param2, true);
            } else {
                _loc3_ = getObjectContentURLs(param1, param2, true);
            }
            if (_loc3_.length > 0) {
                return _loc3_[0] as String;
            }
            return null;
        }

        public function loadThumbnailContent(param1: int, param2: String, param3: String, param4: IEventDispatcher): Boolean {
            var _loc7_: Array = null;
            var _loc9_: int = 0;
            var _loc6_: String = null;
            var _loc5_: * = null;
            var _loc8_: AssetLoaderStruct = null;
            var _loc10_: * = null;
            if (param2 && param2.indexOf(",") >= 0) {
                param2 = String((_loc10_ = param2).split(",")[0]);
            }
            if (_loc10_ != null) {
                _loc7_ = getObjectContentURLs(_loc10_, param3, true);
            } else {
                _loc7_ = getObjectContentURLs(param2, param3, true);
            }
            if (_loc7_ != null && _loc7_.length > 0) {
                _loc9_ = 0;
                while (_loc9_ < _loc7_.length) {
                    _loc5_ = _loc6_ = String(_loc7_[_loc9_]);
                    (_loc8_ = var_4493.loadAssetFromFile([param2, param3].join("_"), new URLRequest(_loc5_), "image/png", param1)).addEventListener("AssetLoaderEventComplete", onContentLoaded);
                    _loc9_++;
                }
                return true;
            }
            return false;
        }

        public function loadObjectContent(param1: String, param2: IEventDispatcher): Boolean {
            var _loc5_: Array = null;
            var _loc7_: int = 0;
            var _loc6_: LibraryLoader = null;
            var _loc4_: String = null;
            var _loc3_: * = null;
            if (param1 == null || param1 == "") {
                class_14.log("[RoomContentLoader] Can not load content, object type unknown!");
                return false;
            }
            var _loc9_: * = null;
            if (param1 && param1.indexOf(",") >= 0) {
                param1 = String((_loc9_ = param1).split(",")[0]);
            }
            if (getAssetLibrary(param1) != null || getAssetLibraryEventDispatcher(param1) != null) {
                return false;
            }
            var _loc8_: AssetLibraryCollection;
            if ((_loc8_ = addAssetLibraryCollection(param1, param2) as AssetLibraryCollection) == null) {
                return false;
            }
            if (isIgnoredFurniType(param1)) {
                class_14.log("Ignored object type found from configuration. Not downloading assets for: " + param1);
                return false;
            }
            if (_loc9_ != null) {
                _loc5_ = getObjectContentURLs(_loc9_);
            } else {
                _loc5_ = getObjectContentURLs(param1);
            }
            if (_loc5_ != null && _loc5_.length > 0) {
                _loc8_.addEventListener("AssetLibraryLoaded", onContentLoaded);
                _loc7_ = 0;
                while (_loc7_ < _loc5_.length) {
                    _loc6_ = new LibraryLoader();
                    _loc3_ = _loc4_ = String(_loc5_[_loc7_]);
                    _loc8_.loadFromFile(_loc6_, true);
                    _loc6_.addEventListener("LIBRARY_LOADER_EVENT_ERROR", onContentLoadError);
                    _loc6_.load(new URLRequest(_loc3_));
                    _loc7_++;
                }
                return true;
            }
            return false;
        }

        public function extractObjectContent(param1: String, param2: String): Boolean {
            var _loc3_: IAssetLibrary = getAssetLibrary(param1);
            var_2603.add(param2, param1);
            if (initializeGraphicAssetCollection(param2, _loc3_)) {
                return true;
            }
            var_2603.remove(param2);
            return false;
        }

        public function getVisualizationType(param1: String): String {
            if (param1 == null) {
                return null;
            }
            var _loc2_: IAssetLibrary = getAssetLibrary(param1);
            if (_loc2_ == null) {
                return null;
            }
            var _loc4_: IAsset;
            if ((_loc4_ = _loc2_.getAssetByName(param1 + "_index")) == null) {
                _loc4_ = _loc2_.getAssetByName("index");
            }
            if (_loc4_ == null) {
                return null;
            }
            var _loc3_: XML = _loc4_.content as XML;
            if (_loc3_ == null) {
                return null;
            }
            return _loc3_.@visualization;
        }

        public function getLogicType(param1: String): String {
            if (param1 == null) {
                return null;
            }
            var _loc2_: IAssetLibrary = getAssetLibrary(param1);
            if (_loc2_ == null) {
                return null;
            }
            var _loc4_: IAsset;
            if ((_loc4_ = _loc2_.getAssetByName(param1 + "_index")) == null) {
                _loc4_ = _loc2_.getAssetByName("index");
            }
            if (_loc4_ == null) {
                return null;
            }
            var _loc3_: XML = _loc4_.content as XML;
            if (_loc3_ == null) {
                return null;
            }
            return _loc3_.@logic;
        }

        public function hasVisualizationXML(param1: String): Boolean {
            return hasXML(param1, "_visualization");
        }

        public function getVisualizationXML(param1: String): XML {
            return getXML(param1, "_visualization");
        }

        public function hasAssetXML(param1: String): Boolean {
            return hasXML(param1, "binaryData");
        }

        public function getAssetXML(param1: String): XML {
            return getXML(param1, "binaryData");
        }

        public function hasLogicXML(param1: String): Boolean {
            return hasXML(param1, "_logic");
        }

        public function getLogicXML(param1: String): XML {
            return getXML(param1, "_logic");
        }

        public function addGraphicAsset(param1: String, param2: String, param3: BitmapData, param4: Boolean, param5: Boolean = true): Boolean {
            var _loc6_: class_3367;
            if ((_loc6_ = getGraphicAssetCollection(param1)) != null) {
                return _loc6_.addAsset(param2, param3, param4, 0, 0, false, false);
            }
            return false;
        }

        public function getGraphicAssetCollection(param1: String): class_3367 {
            var _loc2_: String = getContentType(param1);
            return var_1827.getValue(_loc2_) as class_3367;
        }

        public function roomObjectCreated(param1: IRoomObject, param2: String): void {
            var _loc3_: IRoomObjectController = param1 as IRoomObjectController;
            if (_loc3_ && _loc3_.getModelController()) {
                _loc3_.getModelController().setString("object_room_id", param2, true);
            }
        }

        public function furniDataReady(): void {
            initFurnitureData();
        }

        public function setActiveObjectType(param1: int, param2: String): void {
            var_2179.remove(param1);
            var_2179.add(param1, param2);
        }

        public function compressAssets(): void {
            var _loc5_: class_3367 = null;
            var _loc10_: String = null;
            var _loc7_: int = 0;
            var _loc2_: String = null;
            var _loc3_: IAssetLibrary = null;
            var _loc4_: int = 0;
            var _loc8_: int = 0;
            var _loc9_: BitmapDataAsset = null;
            var _loc1_: int = int(var_1827.length);
            var _loc6_: Array = getPlaceHolderTypes();
            _loc7_ = _loc1_ - 1;
            while (_loc7_ > -1) {
                _loc10_ = var_1827.getKey(_loc7_);
                if (_loc6_.indexOf(_loc10_) == -1) {
                    _loc5_ = var_1827.getValue(_loc10_);
                    _loc2_ = getAssetLibraryName(_loc10_);
                    _loc3_ = var_2051.getValue(_loc2_) as IAssetLibrary;
                    if (_loc3_) {
                        _loc4_ = int(_loc3_.numAssets);
                        _loc8_ = 0;
                        while (_loc8_ < _loc4_) {
                            if (!(_loc9_ = _loc3_.getAssetByIndex(_loc8_) as BitmapDataAsset)) {
                            }
                            _loc8_++;
                        }
                    }
                }
                _loc7_--;
            }
            _lastAssetCompressionTime = getTimer();
        }

        public function purge(): void {
            var _loc4_: class_3367 = null;
            var _loc7_: String = null;
            var _loc5_: int = 0;
            var _loc2_: String = null;
            var _loc3_: IAssetLibrary = null;
            var _loc1_: int = int(var_1827.length);
            var _loc6_: int = getTimer();
            _loc5_ = _loc1_ - 1;
            while (_loc5_ > -1) {
                _loc7_ = var_1827.getKey(_loc5_);
                if (PLACE_HOLDER_TYPES.indexOf(_loc7_) < 0) {
                    if ((_loc4_ = var_1827.getValue(_loc7_)).getReferenceCount() < 1 && _loc6_ - _loc4_.getLastReferenceTimeStamp() >= 20000) {
                        var_1827.remove(_loc7_);
                        _loc4_.dispose();
                        _loc2_ = getAssetLibraryName(_loc7_);
                        _loc3_ = var_2051.getValue(_loc2_) as IAssetLibrary;
                        if (_loc3_) {
                            var_2051.remove(_loc2_);
                            _loc3_.dispose();
                        }
                    }
                }
                _loc5_--;
            }
        }

        private function initPetData(param1: ICoreConfiguration): void {
            var _loc2_: Array = param1.getProperty("pet.configuration").split(",");
            var _loc3_: int = 0;
            for each(var _loc4_ in _loc2_) {
                var_2094[_loc4_] = _loc3_;
                var_2887.add(_loc3_, _loc4_);
                _loc3_++;
            }
            _petColors = new Map();
            _petLayers = new Map();
        }

        private function initFurnitureData(): void {
            if (_sessionDataManager == null) {
                var_3642 = true;
                return;
            }
            var _loc1_: Vector.<class_3365> = _sessionDataManager.getFurniData(this);
            if (_loc1_ == null) {
                return;
            }
            _sessionDataManager.removeFurniDataListener(this);
            populateFurniData(_loc1_);
            var_4558 = true;
            parseIgnoredFurniTypes();
            continueInitilization();
        }

        private function parseIgnoredFurniTypes(): void {
            var _loc3_: int = 0;
            var _loc1_: String = String(var_209.getProperty("gpu.ignored_furni"));
            if (!_loc1_) {
                return;
            }
            var_3106 = _loc1_.split(",");
            var _loc2_: int = int(var_3106.length);
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_3106[_loc3_] = StringUtil.trim(var_3106[_loc3_]);
                _loc3_++;
            }
        }

        private function isIgnoredFurniType(param1: String): Boolean {
            return !!var_3106 ? var_3106.indexOf(param1) != -1 : false;
        }

        private function populateFurniData(param1: Vector.<class_3365>): void {
            var _loc3_: * = null;
            var _loc4_: int = 0;
            var _loc6_: String = null;
            var _loc8_: int = 0;
            var _loc2_: String = null;
            var _loc7_: String = null;
            var _loc5_: int = 0;
            for each(_loc3_ in param1) {
                _loc4_ = _loc3_.id;
                _loc6_ = _loc3_.className;
                if (_loc3_.hasIndexedColor) {
                    _loc6_ = _loc6_ + "*" + _loc3_.colourIndex;
                }
                _loc8_ = _loc3_.revision;
                _loc2_ = _loc3_.adUrl;
                if (_loc2_ != null && _loc2_.length > 0) {
                    var_2748.add(_loc6_, _loc2_);
                }
                _loc7_ = _loc3_.className;
                if (_loc3_.type == "s") {
                    var_2179.add(_loc4_, _loc6_);
                    var_2532.add(_loc6_, _loc4_);
                    if (var_2100[_loc7_] == null) {
                        var_2100[_loc7_] = 1;
                    }
                } else if (_loc3_.type == "i") {
                    if (_loc6_ == "post.it") {
                        _loc6_ = "post_it";
                        _loc7_ = "post_it";
                    }
                    if (_loc6_ == "post.it.vd") {
                        _loc6_ = "post_it_vd";
                        _loc7_ = "post_it_vd";
                    }
                    var_2552.add(_loc4_, _loc6_);
                    var_2816.add(_loc6_, _loc4_);
                    if (_wallItems[_loc7_] == null) {
                        _wallItems[_loc7_] = 1;
                    }
                }
                _loc5_ = var_2442.getValue(_loc7_);
                if (_loc8_ > _loc5_) {
                    var_2442.remove(_loc7_);
                    var_2442.add(_loc7_, _loc8_);
                }
            }
        }

        private function continueInitilization(): void {
            if (var_4558) {
                var_149 = 2;
                if (_stateEvents != null) {
                    _stateEvents.dispatchEvent(new Event("RCL_LOADER_READY"));
                }
            }
        }

        private function getRoomObjectAlias(param1: String): String {
            var _loc2_: * = null;
            if (var_2291 != null) {
                _loc2_ = var_2291.getValue(param1) as String;
            }
            if (_loc2_ == null) {
                _loc2_ = param1;
            }
            return _loc2_;
        }

        private function getRoomObjectOriginalName(param1: String): String {
            var _loc2_: * = null;
            if (var_2370 != null) {
                _loc2_ = var_2370.getValue(param1) as String;
            }
            if (_loc2_ == null) {
                _loc2_ = param1;
            }
            return _loc2_;
        }

        private function getObjectType(param1: String): String {
            if (param1 == null) {
                return null;
            }
            var _loc2_: int = param1.indexOf("*");
            if (_loc2_ >= 0) {
                param1 = param1.substr(0, _loc2_);
            }
            return param1;
        }

        private function getObjectColorIndex(param1: String): int {
            if (param1 == null) {
                return -1;
            }
            var _loc3_: int = 0;
            var _loc2_: int = param1.indexOf("*");
            if (_loc2_ >= 0) {
                _loc3_ = int(param1.substr(_loc2_ + 1));
            }
            return _loc3_;
        }

        private function getObjectRevision(param1: String): int {
            var _loc3_: int = 0;
            var _loc2_: int = getObjectCategory(param1);
            if (_loc2_ == 10 || _loc2_ == 20) {
                if (param1.indexOf("poster") == 0) {
                    param1 = "poster";
                }
                return var_2442.getValue(param1);
            }
            return 0;
        }

        private function getObjectContentURLs(param1: String, param2: String = null, param3: Boolean = false): Array {
            var _loc6_: int = 0;
            var _loc4_: String = null;
            var _loc8_: String = null;
            var _loc10_: int = 0;
            var _loc5_: Boolean = false;
            var _loc9_: String = null;
            var _loc7_: String;
            switch (_loc7_ = getContentType(param1)) {
                case "place_holder":
                    return [resolveLocalOrAssetBaseUrl("PlaceHolderFurniture.swf")];
                case "wall_place_holder":
                    return [resolveLocalOrAssetBaseUrl("PlaceHolderWallItem.swf")];
                case "pet_place_holder":
                    return [resolveLocalOrAssetBaseUrl("PlaceHolderPet.swf")];
                case "room":
                    return [resolveLocalOrAssetBaseUrl("HabboRoomContent.swf")];
                case "tile_cursor":
                    return [resolveLocalOrAssetBaseUrl("TileCursor.swf")];
                case "selection_arrow":
                    return [resolveLocalOrAssetBaseUrl("SelectionArrow.swf")];
                default:
                    if ((_loc6_ = getObjectCategory(_loc7_)) == 10 || _loc6_ == 20) {
                        _loc4_ = getRoomObjectAlias(_loc7_);
                        _loc8_ = (_loc8_ = param3 ? var_4542 : var_4721).replace(/%typeid%/, _loc4_);
                        _loc10_ = getObjectRevision(_loc7_);
                        _loc8_ = _loc8_.replace(/%revision%/, _loc10_);
                        if (param3) {
                            _loc5_ = param2 != null && param2 != "" && var_2532.hasKey(param1 + "*" + param2);
                            _loc8_ = _loc8_.replace(/%param%/, _loc5_ ? "_" + param2 : "");
                        }
                        return [var_4646 + _loc8_];
                    }
                    if (_loc6_ == 100) {
                        return [_loc9_ = (_loc9_ = var_4243 + var_4790).replace(/%type%/, _loc7_)];
                    }
                    return [];
            }
        }

        private function resolveLocalOrAssetBaseUrl(param1: String): String {
            var _loc2_: * = null;
            if (fileProxy && fileProxy.localFileExists(param1)) {
                return String(fileProxy.localFilePath(param1));
            }
            return var_4243 + param1;
        }

        private function processLoadedLibrary(param1: IAssetLibrary): void {
            var _loc3_: RoomContentLoadedEvent = null;
            var _loc2_: Boolean = false;
            var _loc4_: String = getAssetLibraryType(param1);
            if ((_loc4_ = getRoomObjectOriginalName(_loc4_)) != null) {
                _loc2_ = initializeGraphicAssetCollection(_loc4_, param1);
            }
            if (_loc2_) {
                if (var_2094[_loc4_] != null) {
                    extractPetDataFromLoadedContent(_loc4_);
                }
                _loc3_ = new RoomContentLoadedEvent("RCLE_SUCCESS", _loc4_);
            } else {
                _loc3_ = new RoomContentLoadedEvent("RCLE_FAILURE", _loc4_);
            }
            var _loc5_: IEventDispatcher;
            if ((_loc5_ = getAssetLibraryEventDispatcher(_loc4_, true)) != null && _loc3_ != null) {
                _loc5_.dispatchEvent(_loc3_);
            }
        }

        private function extractPetDataFromLoadedContent(param1: String): void {
            var _loc7_: Map = null;
            var _loc5_: Array = null;
            var _loc9_: Array = null;
            var _loc13_: XML = null;
            var _loc8_: int = 0;
            var _loc16_: int = 0;
            var _loc2_: Array = null;
            var _loc14_: Boolean = false;
            var _loc11_: Map = null;
            var _loc17_: Dictionary = null;
            var _loc10_: String = null;
            var _loc15_: String = null;
            var _loc19_: int = int(var_2094[param1]);
            var _loc6_: class_3367;
            if ((_loc6_ = getGraphicAssetCollection(param1)) != null) {
                _loc7_ = new Map();
                _loc5_ = _loc6_.getPaletteNames();
                for each(var _loc12_ in _loc5_) {
                    if ((_loc9_ = _loc6_.getPaletteColors(_loc12_)) != null && _loc9_.length >= 2) {
                        _loc8_ = int((_loc13_ = _loc6_.getPaletteXML(_loc12_)).@breed);
                        _loc16_ = int(_loc13_.hasOwnProperty("@colortag") ? _loc13_.@colortag : -1);
                        _loc2_ = _loc13_.hasOwnProperty("@tags") ? String(_loc13_.@tags).split(",") : [];
                        _loc14_ = _loc13_.hasOwnProperty("@master") ? String(_loc13_.@master) == "true" : false;
                        _loc7_.add(_loc12_, new PetColorResult(_loc9_[0], _loc9_[1], _loc8_, _loc16_, _loc12_, _loc14_, _loc2_));
                    }
                }
                _petColors.add(_loc19_, _loc7_);
            }
            var _loc4_: XML;
            if ((_loc4_ = getVisualizationXML(param1)) != null) {
                _loc11_ = new Map();
                for each(var _loc3_ in _loc4_.visualization) {
                    _loc17_ = new Dictionary();
                    for each(var _loc18_ in _loc3_.layers.layer) {
                        if (_loc18_.hasOwnProperty("@tag")) {
                            _loc10_ = _loc18_.@tag;
                            _loc17_[_loc10_] = parseInt(String(_loc18_.@id));
                        }
                    }
                    _loc15_ = _loc3_.@size;
                    _loc11_.add(_loc15_, _loc17_);
                }
                _petLayers.add(_loc19_, _loc11_);
            }
        }

        private function initializeGraphicAssetCollection(param1: String, param2: IAssetLibrary): Boolean {
            var _loc4_: XML = null;
            if (param1 == null || param2 == null) {
                return false;
            }
            var _loc3_: Boolean = false;
            var _loc5_: class_3367;
            if ((_loc5_ = createGraphicAssetCollection(param1, param2)) != null) {
                _loc4_ = getAssetXML(param1);
                if (_loc5_.define(_loc4_)) {
                    _loc3_ = true;
                } else {
                    disposeGraphicAssetCollection(param1);
                }
            }
            return _loc3_;
        }

        private function getAssetLibraryName(param1: String): String {
            return "RoomContentLoader " + param1;
        }

        private function getAssetLibrary(param1: String): IAssetLibrary {
            var _loc3_: String = null;
            var _loc4_: String = getContentType(param1);
            _loc4_ = getRoomObjectOriginalName(_loc4_);
            var _loc2_: IAssetLibrary = var_2051.getValue(getAssetLibraryName(_loc4_)) as IAssetLibrary;
            if (_loc2_ == null) {
                _loc3_ = var_2603.getValue(_loc4_);
                if (_loc3_ != null) {
                    _loc4_ = getContentType(_loc3_);
                    _loc2_ = var_2051.getValue(getAssetLibraryName(_loc4_)) as IAssetLibrary;
                }
            }
            return _loc2_;
        }

        private function addAssetLibraryCollection(param1: String, param2: IEventDispatcher): IAssetLibrary {
            var _loc5_: String = getContentType(param1);
            var _loc3_: IAssetLibrary = getAssetLibrary(param1);
            if (_loc3_ != null) {
                return _loc3_;
            }
            var _loc4_: String = getAssetLibraryName(_loc5_);
            _loc3_ = new AssetLibraryCollection(_loc4_);
            var_2051.add(_loc4_, _loc3_);
            if (param2 != null && getAssetLibraryEventDispatcher(param1) == null) {
                name_1.add(_loc5_, param2);
            }
            return _loc3_;
        }

        private function getAssetLibraryEventDispatcher(param1: String, param2: Boolean = false): IEventDispatcher {
            var _loc3_: String = getContentType(param1);
            if (!param2) {
                return name_1.getValue(_loc3_);
            }
            return name_1.remove(_loc3_);
        }

        private function getIconAssetType(param1: AssetLoaderStruct): String {
            if (param1 == null) {
                return null;
            }
            var _loc4_: String;
            var _loc2_: Array = (_loc4_ = param1.assetName).split("_");
            var _loc5_: int = parseInt(_loc2_.pop());
            var _loc3_: String = _loc2_.join("_");
            return _loc5_ > 0 ? _loc3_ + "*" + _loc5_ : _loc3_;
        }

        private function getAssetLibraryType(param1: IAssetLibrary): String {
            if (param1 == null) {
                return null;
            }
            var _loc3_: IAsset = param1.getAssetByName("index");
            if (_loc3_ == null) {
                return null;
            }
            var _loc2_: XML = _loc3_.content as XML;
            if (_loc2_ == null) {
                return null;
            }
            return _loc2_.@type;
        }

        private function getXML(param1: String, param2: String): XML {
            var _loc3_: IAssetLibrary = getAssetLibrary(param1);
            if (_loc3_ == null) {
                return null;
            }
            var _loc7_: String = getContentType(param1);
            var _loc5_: String = getRoomObjectAlias(_loc7_);
            var _loc6_: IAsset;
            if ((_loc6_ = _loc3_.getAssetByName(_loc5_ + param2)) == null) {
                return null;
            }
            var _loc4_: XML;
            if ((_loc4_ = _loc6_.content as XML) == null) {
                return null;
            }
            return _loc4_;
        }

        private function hasXML(param1: String, param2: String): Boolean {
            var _loc3_: IAssetLibrary = getAssetLibrary(param1);
            if (_loc3_ == null) {
                return false;
            }
            var _loc5_: String = getContentType(param1);
            var _loc4_: String = getRoomObjectAlias(_loc5_);
            return _loc3_.hasAsset(_loc4_ + param2);
        }

        private function createGraphicAssetCollection(param1: String, param2: IAssetLibrary): class_3367 {
            var _loc3_: class_3367 = getGraphicAssetCollection(param1);
            if (_loc3_ != null) {
                return _loc3_;
            }
            if (param2 == null) {
                return null;
            }
            _loc3_ = _visualizationFactory.createGraphicAssetCollection();
            if (_loc3_ != null) {
                _loc3_.assetLibrary = param2;
                var_1827.add(param1, _loc3_);
            }
            return _loc3_;
        }

        private function disposeGraphicAssetCollection(param1: String): Boolean {
            var _loc3_: class_3367 = null;
            var _loc2_: String = getContentType(param1);
            if (var_1827[_loc2_] != null) {
                _loc3_ = var_1827.remove(_loc2_);
                if (_loc3_ != null) {
                    _loc3_.dispose();
                }
                return true;
            }
            return false;
        }

        private function onContentLoadError(param1: Event): void {
            var _loc3_: Array = null;
            var _loc4_: LibraryLoader = LibraryLoader(param1.target);
            var _loc5_: Array = getPlaceHolderTypes();
            for each(var _loc2_ in _loc5_) {
                _loc3_ = getObjectContentURLs(_loc2_);
                if (_loc3_.length > 0 && _loc4_.url != null && _loc4_.url.indexOf(_loc3_[0]) == 0) {
                    class_79.crash("Failed to load asset: " + _loc4_.url, 3);
                    return;
                }
            }
        }

        private function onContentLoaded(param1: Event): void {
            var _loc2_: AssetLoaderStruct = null;
            var _loc3_: IAssetLibrary = null;
            if (disposed) {
                return;
            }
            if (param1.target is AssetLoaderStruct) {
                _loc2_ = param1.target as AssetLoaderStruct;
                var_2084.iconLoaded(_loc2_.assetLoader.id, _loc2_.assetName, true);
            } else {
                _loc3_ = param1.target as IAssetLibrary;
                if (_loc3_ == null) {
                    return;
                }
                processLoadedLibrary(_loc3_);
            }
        }
    }
}
