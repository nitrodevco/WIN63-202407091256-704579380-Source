package com.sulake.habbo.communication.messages.parser.help.data {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1698 {

        public function class_1698(param1: IMessageDataWrapper) {
            super();
            var_329 = param1.readInteger();
            var_775 = param1.readInteger();
            var_1285 = param1.readBoolean();
            switch (var_329) {
                case 0:
                case 2:
                    var_205 = param1.readString();
                    var_222 = param1.readString();
                    return;
                case 1:
                    var_205 = param1.readString();
                    var_222 = param1.readString();
                    var_363 = param1.readString();
                    return;
                case 3:
                    if (!isGuide) {
                        var_205 = param1.readString();
                        var_222 = param1.readString();
                        _roomName = param1.readString();
                    }
                    return;
                default:
                    return;
            }
        }
        private var var_329: int;
        private var var_775: int;
        private var var_1285: Boolean;
        private var var_205: String;
        private var var_222: String;
        private var var_363: String;

        private var _roomName: String;

        public function get roomName(): String {
            return _roomName;
        }

        public function get type(): int {
            return var_329;
        }

        public function get secondsAgo(): int {
            return var_775;
        }

        public function get isGuide(): Boolean {
            return var_1285;
        }

        public function get otherPartyName(): String {
            return var_205;
        }

        public function get otherPartyFigure(): String {
            return var_222;
        }

        public function get description(): String {
            return var_363;
        }
    }
}
