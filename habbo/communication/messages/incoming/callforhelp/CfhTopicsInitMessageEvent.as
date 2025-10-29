package com.sulake.habbo.communication.messages.incoming.callforhelp {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.callforhelp.class_1245

    [SecureSWF(rename="true")]
    public class CfhTopicsInitMessageEvent extends MessageEvent implements IMessageEvent {

        public function CfhTopicsInitMessageEvent(param1: Function) {
            super(param1, class_1245);
        }

        public function getParser(): class_1245 {
            return _parser as class_1245;
        }
    }
}
