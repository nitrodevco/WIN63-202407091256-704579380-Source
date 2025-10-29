package com.sulake.habbo.communication.messages.incoming.landingview {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.landingview.class_1457

    [SecureSWF(rename="true")]
    public class PromoArticlesMessageEvent extends MessageEvent implements IMessageEvent {

        public function PromoArticlesMessageEvent(param1: Function) {
            super(param1, class_1457);
        }

        public function getParser(): class_1457 {
            return _parser as class_1457;
        }
    }
}
