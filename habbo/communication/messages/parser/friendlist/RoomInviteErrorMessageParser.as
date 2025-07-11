package com.sulake.habbo.communication.messages.parser.friendlist {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class RoomInviteErrorMessageParser implements IMessageParser {

        public function RoomInviteErrorMessageParser() {
            super();
        }
        private var var_412: int;
        private var var_1330: Array;

        public function get errorCode(): int {
            return this.var_412;
        }

        public function get failedRecipients(): Array {
            return this.var_1330;
        }

        public function flush(): Boolean {
            this.var_1330 = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc2_: int = 0;
            var _loc3_: int = 0;
            this.var_412 = param1.readInteger();
            if (this.var_412 == 1) {
                _loc2_ = param1.readInteger();
                _loc3_ = 0;
                while (_loc3_ < _loc2_) {
                    this.var_1330.push(param1.readInteger());
                    _loc3_++;
                }
            }
            return true;
        }
    }
}
