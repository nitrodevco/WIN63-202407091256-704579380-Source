package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.runtime.IDisposable

    [SecureSWF(rename="true")]
    public class class_1680 implements IDisposable {

        public function class_1680(param1: IMessageDataWrapper) {
            super();
            var_1035 = param1.readInteger();
            var_1104 = param1.readInteger();
            var_1288 = param1.readString();
            _flatId = param1.readInteger();
            var_1049 = param1.readInteger();
            var_880 = param1.readString();
            var_1432 = param1.readString();
            var _loc8_: int = param1.readInteger();
            var _loc5_: int = param1.readInteger();
            var _loc9_: Date;
            var _loc3_: Number = (_loc9_ = new Date()).getTime();
            var _loc2_: Number = _loc8_ * 60 * 1000;
            _loc3_ -= _loc2_;
            var _loc6_: Date;
            _creationTime = (_loc6_ = new Date(_loc3_)).date + "-" + _loc6_.month + "-" + _loc6_.fullYear + " " + _loc6_.hours + ":" + _loc6_.minutes;
            var _loc7_: Number = _loc9_.getTime();
            var _loc4_: Number = _loc5_ * 60 * 1000;
            _loc7_ += _loc4_;
            var_774 = new Date(_loc7_);
            var_634 = param1.readInteger();
        }
        private var var_1035: int;
        private var var_1104: int;
        private var var_1288: String;
        private var var_634: int;

        private var var_1049: int;

        private var var_880: String;

        private var var_1432: String;
        private var var_774: Date;

        private var _flatId: int;

        public function get flatId(): int {
            return _flatId;
        }

        private var _creationTime: String;

        public function get creationTime(): String {
            return _creationTime;
        }

        private var _disposed: Boolean;

        public function get disposed(): Boolean {
            return _disposed;
        }

        public function get adId(): int {
            return var_1035;
        }

        public function get ownerAvatarId(): int {
            return var_1104;
        }

        public function get ownerAvatarName(): String {
            return var_1288;
        }

        public function get categoryId(): int {
            return var_634;
        }

        public function get eventType(): int {
            return var_1049;
        }

        public function get eventName(): String {
            return var_880;
        }

        public function get eventDescription(): String {
            return var_1432;
        }

        public function get expirationDate(): Date {
            return var_774;
        }

        public function dispose(): void {
            if (_disposed) {
                return;
            }
            _disposed = true;
        }
    }
}
