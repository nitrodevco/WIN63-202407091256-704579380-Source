package com.sulake.habbo.communication.messages.parser.room.engine {
    import assets.class_14

    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.room.engine.class_1693
    import com.sulake.room.utils.Vector3d

    [SecureSWF(rename="true")]
    public class class_1526 implements IMessageParser {

        public function class_1526() {
            super();
        }
        private var var_280: int;
        private var var_330: Array;
        private var var_254: class_1693 = null;

        public function get id(): int {
            return var_280;
        }

        public function get avatar(): class_1693 {
            return var_254;
        }

        public function get objectList(): Array {
            return var_330;
        }

        public function flush(): Boolean {
            var_280 = -1;
            var_254 = null;
            var_330 = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc14_: int = 0;
            var _loc7_: class_1693 = null;
            var _loc2_: Vector3d = null;
            var _loc9_: Vector3d = null;
            var _loc12_: Number = NaN;
            var _loc3_: Number = NaN;
            var _loc6_: int = 0;
            if (param1 == null) {
                return false;
            }
            var _loc10_: Number = param1.readInteger();
            var _loc11_: Number = param1.readInteger();
            var _loc5_: Number = param1.readInteger();
            var _loc4_: Number = param1.readInteger();
            var _loc8_: int = param1.readInteger();
            var_330 = [];
            _loc6_ = 0;
            while (_loc6_ < _loc8_) {
                _loc14_ = param1.readInteger();
                _loc12_ = Number(param1.readString());
                _loc3_ = Number(param1.readString());
                _loc2_ = new Vector3d(_loc10_, _loc11_, _loc12_);
                _loc9_ = new Vector3d(_loc5_, _loc4_, _loc3_);
                _loc7_ = new class_1693(_loc14_, _loc2_, _loc9_);
                var_330.push(_loc7_);
                _loc6_++;
            }
            var_280 = param1.readInteger();
            if (!param1.bytesAvailable) {
                return true;
            }
            var _loc13_: int;
            switch (_loc13_ = param1.readInteger()) {
                case 0:
                    break;
                case 1:
                    _loc14_ = param1.readInteger();
                    _loc12_ = Number(param1.readString());
                    _loc3_ = Number(param1.readString());
                    _loc2_ = new Vector3d(_loc10_, _loc11_, _loc12_);
                    _loc9_ = new Vector3d(_loc5_, _loc4_, _loc3_);
                    var_254 = new class_1693(_loc14_, _loc2_, _loc9_, "mv");
                    break;
                case 2:
                    _loc14_ = param1.readInteger();
                    _loc12_ = Number(param1.readString());
                    _loc3_ = Number(param1.readString());
                    _loc2_ = new Vector3d(_loc10_, _loc11_, _loc12_);
                    _loc9_ = new Vector3d(_loc5_, _loc4_, _loc3_);
                    var_254 = new class_1693(_loc14_, _loc2_, _loc9_, "sld");
                    break;
                default:
                    class_14.log("** Incompatible character movetype!");
            }
            return true;
        }
    }
}
