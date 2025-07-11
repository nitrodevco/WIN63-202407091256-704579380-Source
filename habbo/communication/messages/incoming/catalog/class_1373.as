package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1373 {

        public function class_1373(param1: IMessageDataWrapper) {
            var _loc3_: int = 0;
            super();
            var_848 = param1.readBoolean();
            _icon = param1.readInteger();
            var_562 = param1.readInteger();
            _pageName = param1.readString();
            _localization = param1.readString();
            _offerIds = new Vector.<int>(0);
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                _offerIds.push(param1.readInteger());
                _loc3_++;
            }
            _children = new Vector.<class_1373>(0);
            var _loc4_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc4_) {
                _children.push(new class_1373(param1));
                _loc3_++;
            }
        }
        private var var_848: Boolean;
        private var var_562: int;

        private var _icon: int;

        public function get icon(): int {
            return _icon;
        }

        private var _pageName: String;

        public function get pageName(): String {
            return _pageName;
        }

        private var _localization: String;

        public function get localization(): String {
            return _localization;
        }

        private var _children: Vector.<class_1373>;

        public function get children(): Vector.<class_1373> {
            return _children;
        }

        private var _offerIds: Vector.<int>;

        public function get offerIds(): Vector.<int> {
            return _offerIds;
        }

        public function get visible(): Boolean {
            return var_848;
        }

        public function get pageId(): int {
            return var_562;
        }
    }
}
