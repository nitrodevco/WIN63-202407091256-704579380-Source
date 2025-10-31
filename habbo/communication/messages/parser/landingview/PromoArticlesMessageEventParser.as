package com.sulake.habbo.communication.messages.parser.landingview {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.landingview.class_1738

    [SecureSWF(rename="true")]
    public class PromoArticlesMessageEventParser implements IMessageParser {

        public function PromoArticlesMessageEventParser() {
            super();
        }
        private var var_698: Array;

        public function get articles(): Array {
            return var_698;
        }

        public function flush(): Boolean {
            var_698 = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_698.push(new class_1738(param1));
                _loc3_++;
            }
            return true;
        }
    }
}
