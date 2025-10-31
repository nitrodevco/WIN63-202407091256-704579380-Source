package com.sulake.habbo.communication.messages.parser.moderation {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.runtime.IDisposable

    [SecureSWF(rename="true")]
    public class class_1762 implements IDisposable {

        public function class_1762(param1: IMessageDataWrapper) {
            var _loc4_: int = 0;
            super();
            var _loc2_: IssueInfoMessageEventParser = new IssueInfoMessageEventParser();
            var_314 = [];
            var_278 = [];
            var_290 = [];
            var _loc3_: int = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                if (_loc2_.parse(param1)) {
                    var_314.push(_loc2_.issueData);
                }
                _loc4_++;
            }
            _loc3_ = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                var_278.push(param1.readString());
                _loc4_++;
            }
            _loc3_ = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                param1.readString();
                _loc4_++;
            }
            var_1473 = param1.readBoolean();
            var_1446 = param1.readBoolean();
            var_906 = param1.readBoolean();
            var_908 = param1.readBoolean();
            var_1113 = param1.readBoolean();
            var_1360 = param1.readBoolean();
            var_1382 = param1.readBoolean();
            _loc3_ = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc3_) {
                var_290.push(param1.readString());
                _loc4_++;
            }
        }
        private var var_278: Array;
        private var var_290: Array;
        private var var_314: Array;
        private var var_1473: Boolean;
        private var var_1446: Boolean;
        private var var_906: Boolean;
        private var var_908: Boolean;
        private var var_1113: Boolean;
        private var var_1360: Boolean;
        private var var_1382: Boolean;

        private var _disposed: Boolean;

        public function get disposed(): Boolean {
            return _disposed;
        }

        public function get messageTemplates(): Array {
            return var_278;
        }

        public function get roomMessageTemplates(): Array {
            return var_290;
        }

        public function get issues(): Array {
            return var_314;
        }

        public function get cfhPermission(): Boolean {
            return var_1473;
        }

        public function get chatlogsPermission(): Boolean {
            return var_1446;
        }

        public function get alertPermission(): Boolean {
            return var_906;
        }

        public function get kickPermission(): Boolean {
            return var_908;
        }

        public function get banPermission(): Boolean {
            return var_1113;
        }

        public function get roomAlertPermission(): Boolean {
            return var_1360;
        }

        public function get roomKickPermission(): Boolean {
            return var_1382;
        }

        public function dispose(): void {
            if (_disposed) {
                return;
            }
            _disposed = true;
            var_278 = null;
            var_290 = null;
            var_314 = null;
        }
    }
}
