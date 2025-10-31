package com.sulake.habbo.communication.messages.parser.nux {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.nux.class_1714

    [SecureSWF(rename="true")]
    public class NewUserExperienceGiftOfferEventParser implements IMessageParser {

        public function NewUserExperienceGiftOfferEventParser() {
            super();
        }
        private var var_717: Vector.<class_1714>;

        public function get giftOptions(): Vector.<class_1714> {
            return var_717;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc2_: int = param1.readInteger();
            var_717 = new Vector.<class_1714>();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_717.push(new class_1714(param1));
                _loc3_++;
            }
            return true;
        }
    }
}
