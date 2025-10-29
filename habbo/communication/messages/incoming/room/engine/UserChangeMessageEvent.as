package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1277

    [SecureSWF(rename="true")]
    public class UserChangeMessageEvent extends MessageEvent implements IMessageEvent {

        public function UserChangeMessageEvent(param1: Function) {
            super(param1, class_1277);
        }

        public function get id(): int {
            return (_parser as class_1277).id;
        }

        public function get figure(): String {
            return (_parser as class_1277).figure;
        }

        public function get sex(): String {
            return (_parser as class_1277).sex;
        }

        public function get customInfo(): String {
            return (_parser as class_1277).customInfo;
        }

        public function get achievementScore(): int {
            return (_parser as class_1277).achievementScore;
        }
    }
}
