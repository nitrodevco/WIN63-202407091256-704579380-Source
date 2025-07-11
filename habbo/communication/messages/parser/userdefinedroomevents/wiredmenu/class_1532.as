package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredRoomStatsData

    public class class_1532 implements IMessageParser {

        public function class_1532() {
            super();
        }
        private var var_648: WiredRoomStatsData;

        public function get roomStats(): WiredRoomStatsData {
            return var_648;
        }

        public function flush(): Boolean {
            var_648 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_648 = new WiredRoomStatsData(param1);
            return true;
        }
    }
}
