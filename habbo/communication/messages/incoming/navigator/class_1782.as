package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.runtime.IDisposable

    [SecureSWF(rename="true")]
    public class class_1782 implements IDisposable {

        public function class_1782(param1: IMessageDataWrapper) {
            var _loc4_: int = 0;
            var _loc3_: class_1788 = null;
            var_136 = [];
            super();
            if (param1 == null) {
                return;
            }
            var_103 = param1.readInteger();
            var_112 = param1.readInteger();
            var _loc2_: int = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc2_) {
                _loc3_ = new class_1788();
                _loc3_.pos = param1.readInteger();
                _loc3_.imgId = param1.readInteger();
                var_136.push(_loc3_);
                _loc4_++;
            }
            if (var_103 == 0) {
                setDefaults();
            }
        }
        private var var_103: int;
        private var var_112: int;
        private var var_136: Array;

        private var _disposed: Boolean;

        public function get disposed(): Boolean {
            return _disposed;
        }

        public function get bgImgId(): int {
            return var_103;
        }

        public function set bgImgId(param1: int): void {
            var_103 = param1;
        }

        public function get frontImgId(): int {
            return var_112;
        }

        public function set frontImgId(param1: int): void {
            var_112 = param1;
        }

        public function get objects(): Array {
            return var_136;
        }

        public function setDefaults(): void {
            var_103 = 1;
            var_112 = 0;
            var _loc1_: class_1788 = new class_1788();
            _loc1_.pos = 4;
            _loc1_.imgId = 1;
            var_136.push(_loc1_);
        }

        public function getCopy(): class_1782 {
            var _loc1_: class_1782 = new class_1782(null);
            _loc1_.var_103 = this.var_103;
            _loc1_.var_112 = this.var_112;
            for each(var _loc2_ in var_136) {
                _loc1_.var_136.push(_loc2_.getCopy());
            }
            return _loc1_;
        }

        public function dispose(): void {
            if (_disposed) {
                return;
            }
            _disposed = true;
            this.var_136 = null;
        }

        public function getAsString(): String {
            var _loc1_: String = var_112 + ";";
            _loc1_ += var_103 + ";";
            for each(var _loc2_ in var_136) {
                _loc1_ += _loc2_.imgId + "," + _loc2_.pos + ";";
            }
            return _loc1_;
        }
    }
}
