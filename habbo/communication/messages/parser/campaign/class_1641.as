package com.sulake.habbo.communication.messages.parser.campaign {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1641 {

        public function class_1641() {
            super();
        }
        private var var_327: String;
        private var var_283: String;
        private var var_285: int;
        private var var_295: int;
        private var var_191: Vector.<int>;
        private var var_231: Vector.<int>;

        public function get campaignName(): String {
            return var_327;
        }

        public function set campaignName(param1: String): void {
            var_327 = param1;
        }

        public function get campaignImage(): String {
            return var_283;
        }

        public function set campaignImage(param1: String): void {
            var_283 = param1;
        }

        public function get currentDay(): int {
            return var_285;
        }

        public function set currentDay(param1: int): void {
            var_285 = param1;
        }

        public function get campaignDays(): int {
            return var_295;
        }

        public function set campaignDays(param1: int): void {
            var_295 = param1;
        }

        public function get openedDays(): Vector.<int> {
            return var_191;
        }

        public function set openedDays(param1: Vector.<int>): void {
            var_191 = param1;
        }

        public function get missedDays(): Vector.<int> {
            return var_231;
        }

        public function set missedDays(param1: Vector.<int>): void {
            var_231 = param1;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc2_: int = 0;
            var_327 = param1.readString();
            var_283 = param1.readString();
            var_285 = param1.readInteger();
            var_295 = param1.readInteger();
            var_191 = new Vector.<int>(0);
            _loc2_ = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_191.push(param1.readInteger());
                _loc3_++;
            }
            var_231 = new Vector.<int>(0);
            _loc2_ = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_231.push(param1.readInteger());
                _loc3_++;
            }
            return true;
        }

        public function clone(): class_1641 {
            var _loc1_: class_1641 = new class_1641();
            _loc1_.campaignDays = var_295;
            _loc1_.campaignImage = var_283;
            _loc1_.campaignName = var_327;
            _loc1_.currentDay = var_285;
            _loc1_.missedDays = var_231;
            _loc1_.openedDays = var_191;
            return _loc1_;
        }
    }
}
