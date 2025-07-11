package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.users.class_1460

    [SecureSWF(rename="true")]
    public class GuildEditorDataMessageEvent extends MessageEvent implements IMessageEvent {

        public function GuildEditorDataMessageEvent(param1: Function) {
            super(param1, class_1460);
        }

        public function get data(): class_1300 {
            return class_1460(_parser).data;
        }
    }
}
