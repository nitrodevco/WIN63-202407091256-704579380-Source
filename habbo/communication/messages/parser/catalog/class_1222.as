package com.sulake.habbo.communication.messages.parser.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.catalog.class_1639

    [SecureSWF(rename="true")]
    public class class_1222 implements IMessageParser {

        public function class_1222() {
            super();
        }

        private var _bundleDiscountRuleset: class_1639;

        public function get bundleDiscountRuleset(): class_1639 {
            return _bundleDiscountRuleset;
        }

        public function flush(): Boolean {
            _bundleDiscountRuleset = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            _bundleDiscountRuleset = new class_1639(param1);
            return true;
        }
    }
}
