package com.sulake.habbo.communication.messages.parser.room.engine {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1471 implements IMessageParser {

        public function class_1471() {
            var_142 = [];
            super();
        }
        private var var_142: Array;
        private var var_46: int = 0;
        private var var_911: Number = 0;
        private var var_286: Vector.<AreaHideMessageData>;

        private var _text: String = "";

        public function get text(): String {
            return _text;
        }

        private var _width: int = 0;

        public function get width(): int {
            return _width;
        }

        private var _fixedWallsHeight: int = -1;

        public function get fixedWallsHeight(): int {
            return _fixedWallsHeight;
        }

        public function get height(): int {
            return var_46;
        }

        public function get scale(): Number {
            return var_911;
        }

        public function get areaHideData(): Vector.<AreaHideMessageData> {
            return var_286;
        }

        public function getTileHeight(param1: int, param2: int): int {
            if (param1 < 0 || param1 >= width || param2 < 0 || param2 >= height) {
                return -110;
            }
            var _loc3_: Array = var_142[param2] as Array;
            return _loc3_[param1];
        }

        public function flush(): Boolean {
            var_142 = [];
            _width = 0;
            var_46 = 0;
            _text = "";
            _fixedWallsHeight = -1;
            var_286 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc8_: String = null;
            var _loc5_: int = 0;
            if (param1 == null) {
                return false;
            }
            var _loc9_: Boolean = param1.readBoolean();
            _fixedWallsHeight = param1.readInteger();
            _text = param1.readString();
            var _loc6_: Array = _text.split("\r");
            var _loc3_: int = 0;
            var _loc4_: int = 0;
            var _loc11_: int = 0;
            var _loc2_: Array = null;
            var _loc12_: int;
            if ((_loc12_ = int(_loc6_.length)) > 0 && _loc6_[_loc12_ - 1] == "") {
                _loc12_ -= 1;
            }
            var _loc7_: int = 0;
            var _loc10_: String = null;
            _loc4_ = 0;
            while (_loc4_ < _loc12_) {
                if ((_loc10_ = _loc6_[_loc4_] as String).length > _loc7_) {
                    _loc7_ = _loc10_.length;
                }
                _loc4_++;
            }
            var_142 = [];
            _loc4_ = 0;
            while (_loc4_ < _loc12_) {
                _loc2_ = [];
                _loc3_ = 0;
                while (_loc3_ < _loc7_) {
                    _loc2_.push(-110);
                    _loc3_++;
                }
                var_142.push(_loc2_);
                _loc4_++;
            }
            _width = _loc7_;
            var_46 = _loc12_;
            _loc4_ = 0;
            while (_loc4_ < _loc12_) {
                _loc2_ = var_142[_loc4_] as Array;
                if ((_loc10_ = _loc6_[_loc4_] as String).length > 0) {
                    _loc3_ = 0;
                    while (_loc3_ < _loc10_.length) {
                        if ((_loc8_ = _loc10_.charAt(_loc3_)) != "x" && _loc8_ != "X") {
                            _loc11_ = parseInt(_loc8_, 36);
                        } else {
                            _loc11_ = -110;
                        }
                        _loc2_[_loc3_] = _loc11_;
                        _loc3_++;
                    }
                }
                _loc4_++;
            }
            var_911 = _loc9_ ? 32 : 64;
            var_286 = new Vector.<AreaHideMessageData>();
            var _loc13_: int = param1.readInteger();
            _loc5_ = 0;
            while (_loc5_ < _loc13_) {
                var_286.push(new AreaHideMessageData(param1));
                _loc5_++;
            }
            return true;
        }
    }
}
