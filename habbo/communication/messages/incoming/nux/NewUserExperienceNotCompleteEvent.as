package com.sulake.habbo.communication.messages.incoming.nux {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.nux.class_1494

    [SecureSWF(rename="true")]
    public class NewUserExperienceNotCompleteEvent extends MessageEvent implements IMessageEvent {

        public function NewUserExperienceNotCompleteEvent(param1: Function) {
            super(param1, class_1494);
        }

        public function getParser(): class_1494 {
            return _parser as class_1494;
        }
    }
}
