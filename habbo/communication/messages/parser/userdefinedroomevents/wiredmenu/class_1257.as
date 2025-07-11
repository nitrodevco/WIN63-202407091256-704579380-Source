package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    public class class_1257 implements IMessageParser {

        public function class_1257() {
            super();
        }
        private var var_649: int;
        private var var_492: int;

        public function get modifyPermissionMask(): int {
            return var_649;
        }

        public function get readPermissionMask(): int {
            return var_492;
        }

        public function flush(): Boolean {
            var_649 = 0;
            var_492 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_649 = param1.readInteger();
            var_492 = param1.readInteger();
            return true;
        }
    }
}
