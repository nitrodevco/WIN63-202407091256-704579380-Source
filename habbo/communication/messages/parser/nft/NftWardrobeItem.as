package com.sulake.habbo.communication.messages.parser.nft {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    public class NftWardrobeItem {

        public function NftWardrobeItem(param1: IMessageDataWrapper) {
            super();
            var_846 = param1.readString();
            _figureString = param1.readString();
            var_129 = param1.readString();
        }
        private var var_846: String;
        private var var_129: String;
        private var var_1603: int;

        private var var_1591: int;

        private var var_1600: Boolean;

        private var _figureString: String;

        public function get figureString(): String {
            return _figureString;
        }

        public function get tokenId(): String {
            return var_846;
        }

        public function get gender(): String {
            return var_129;
        }

        public function get avatarEffectType(): int {
            return var_1603;
        }

        public function get avatarEffectDuration(): int {
            return var_1591;
        }

        public function get avatarEffectPermanent(): Boolean {
            return var_1600;
        }
    }
}
