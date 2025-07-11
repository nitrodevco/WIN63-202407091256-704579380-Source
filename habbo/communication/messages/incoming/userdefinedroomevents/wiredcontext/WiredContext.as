package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params.AllVariablesInRoom
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params.SharedVariableList
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params.VariableInfoAndHolders
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params.VariableInfoAndValue

    public class WiredContext {

        public static var EMPTY: WiredContext = new WiredContext(null);

        public function WiredContext(param1: IMessageDataWrapper) {
            var _loc3_: int = 0;
            var _loc2_: int = 0;
            super();
            if (param1 == null) {
                return;
            }
            var _loc4_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc4_) {
                _loc2_ = param1.readInteger();
                switch (_loc2_) {
                    case class_1789.var_1598:
                        var_1112 = new AllVariablesInRoom(param1);
                        break;
                    case class_1789.var_1587:
                        var_920 = new VariableInfoAndHolders(param1);
                        break;
                    case class_1789.var_1599:
                        var_1085 = new VariableInfoAndHolders(param1);
                        break;
                    case class_1789.var_1583:
                        var_909 = new VariableInfoAndValue(param1);
                        break;
                    case class_1789.var_1594:
                        var_783 = new SharedVariableList(param1);
                }
                _loc3_++;
            }
        }
        private var var_1112: AllVariablesInRoom = null;
        private var var_920: VariableInfoAndHolders = null;
        private var var_1085: VariableInfoAndHolders = null;
        private var var_909: VariableInfoAndValue = null;
        private var var_783: SharedVariableList = null;

        public function get roomVariablesList(): AllVariablesInRoom {
            return var_1112;
        }

        public function get furniVariableInfo(): VariableInfoAndHolders {
            return var_920;
        }

        public function get userVariableInfo(): VariableInfoAndHolders {
            return var_1085;
        }

        public function get globalVariableInfo(): VariableInfoAndValue {
            return var_909;
        }

        public function get referenceVariablesList(): SharedVariableList {
            return var_783;
        }
    }
}
