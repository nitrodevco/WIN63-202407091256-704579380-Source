package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.catalog.class_1222

    [SecureSWF(rename="true")]
    public class BundleDiscountRulesetMessageEvent extends MessageEvent implements IMessageEvent {

        public function BundleDiscountRulesetMessageEvent(param1: Function) {
            super(param1, class_1222);
        }

        public function getParser(): class_1222 {
            return this._parser as class_1222;
        }
    }
}
