package com.sulake.habbo.communication.messages.parser.game.snowwar.data {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    public class GameLevelData {

        public function GameLevelData(param1: IMessageDataWrapper) {
            var_699 = [];
            super();
            parse(param1);
        }
        private var var_46: int;

        private var var_142: String;

        private var var_699: Array;

        private var _width: int;

        public function get width(): int {
            return _width;
        }

        public function get height(): int {
            return var_46;
        }

        public function get heightMap(): String {
            return var_142;
        }

        public function get fuseObjects(): Array {
            return var_699;
        }

        public function parse(param1: IMessageDataWrapper): void {
            var _loc3_: int = 0;
            var _loc4_: FuseObjectData = null;
            _width = param1.readInteger();
            var_46 = param1.readInteger();
            var_142 = param1.readString();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                (_loc4_ = new FuseObjectData()).parse(param1);
                var_699.push(_loc4_);
                _loc3_++;
            }
        }
    }
}
