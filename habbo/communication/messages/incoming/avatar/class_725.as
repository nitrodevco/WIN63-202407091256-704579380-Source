package com.sulake.habbo.communication.messages.incoming.avatar {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.avatar.class_1164

    [SecureSWF(rename="true")]
    public class class_725 extends MessageEvent implements IMessageEvent {

        public static var var_1586: int = 0;

        public static var var_1595: int = 1;

        public static var var_1592: int = 2;

        public static var var_1596: int = 3;

        public static var var_1604: int = 4;

        public static var var_1590: int = 5;

        public function class_725(param1: Function) {
            super(param1, class_1164);
        }

        public function getParser(): class_1164 {
            return _parser as class_1164;
        }
    }
}
