package com.sulake.habbo.communication.messages.incoming.callforhelp {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.callforhelp.class_1223

    [SecureSWF(rename="true")]
    public class CfhSanctionMessageEvent extends MessageEvent implements IMessageEvent {

        public function CfhSanctionMessageEvent(param1: Function) {
            super(param1, class_1223);
        }

        public function getParser(): class_1223 {
            return _parser as class_1223;
        }
    }
}
