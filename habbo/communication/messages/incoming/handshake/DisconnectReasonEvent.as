package com.sulake.habbo.communication.messages.incoming.handshake {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.handshake.class_1247

    import flash.utils.Dictionary
    import flash.utils.describeType

    [SecureSWF(rename="true")]
    public class DisconnectReasonEvent extends MessageEvent implements IMessageEvent {

        public static const const_232: int = -1;

        public static const const_64: int = -2;

        public static const const_183: int = -3;

        public static const const_16: int = 0;

        public static const const_189: int = 1;

        public static const const_259: int = 2;

        public static const const_395: int = 3;

        public static const const_27: int = 4;

        public static const const_362: int = 5;

        public static const const_96: int = 10;

        public static const const_291: int = 11;

        public static const const_179: int = 12;

        public static const const_99: int = 13;

        public static const const_55: int = 16;

        public static const const_157: int = 17;

        public static const const_322: int = 18;

        public static const const_400: int = 19;

        public static const const_243: int = 20;

        public static const const_399: int = 22;

        public static const const_213: int = 23;

        public static const const_42: int = 24;

        public static const const_327: int = 25;

        public static const const_169: int = 26;

        public static const const_217: int = 27;

        public static const const_26: int = 28;

        public static const const_212: int = 29;

        public static const const_90: int = 100;

        public static const const_359: int = 101;

        public static const const_24: int = 102;

        public static const const_200: int = 103;

        public static const const_193: int = 104;

        public static const const_77: int = 105;

        public static const const_211: int = 106;

        public static const const_149: int = 107;

        public static const const_125: int = 108;

        public static const const_339: int = 109;

        public static const const_299: int = 110;

        public static const const_133: int = 111;

        public static const const_284: int = 112;

        public static const const_215: int = 113;

        public static const const_44: int = 114;

        public static const const_159: int = 115;

        public static const const_266: int = 116;

        public static const SOCKET_WRITE_EXCEPTION_1: int = 117;

        public static const SOCKET_WRITE_EXCEPTION_2: int = 118;

        public static const SOCKET_WRITE_EXCEPTION_3: int = 119;

        public static const const_121: int = 120;

        public static const const_311: int = 121;

        public static const const_406: int = 122;

        public static const const_84: int = 123;

        public static const const_146: int = 124;

        public static const const_247: int = 125;

        public static const const_168: int = 126;

        private static var var_647: Dictionary;

        public static function resolveDisconnectedReasonLocalizationKey(param1: int): String {
            switch (param1) {
                case -2:
                    return "${disconnected.maintenance}";
                case 0:
                    return "${disconnected.logged_out}";
                case 1:
                    return "${disconnected.just_banned}";
                case 10:
                    return "${disconnected.still_banned}";
                case 2:
                case 13:
                case 11:
                case 18:
                    return "${disconnected.concurrent_login}";
                case 12:
                case 19:
                    return "${disconnected.hotel_closed}";
                case 20:
                    return "${disconnected.incorrect_password}";
                case 112:
                    return "${disconnected.idle}";
                case 122:
                    return "${disconnected.incompatible_client_version}";
                case 4:
                case 5:
                case 16:
                case 17:
                case 22:
                case 23:
                case 24:
                case 25:
                case 26:
                case 27:
                case 28:
                case 29:
                case 100:
                case 101:
                case 102:
                case 103:
                case 104:
                case 105:
                case 106:
                case 107:
                case 108:
                case 109:
                case 110:
                case 111:
                case 113:
                case 114:
                case 115:
                case 116:
                case 117:
                case 118:
                case 119:
                case 120:
                case 121:
                case 123:
                case 124:
                case 125:
                case 126:
                    break;
                default:
                    return "${disconnected.generic}";
            }
            return "${disconnected.generic}";
        }

        public function DisconnectReasonEvent(param1: Function) {
            super(param1, class_1247);
        }

        public function get reason(): int {
            return (this._parser as class_1247).reason;
        }

        public function get reasonString(): String {
            switch (reason) {
                case 1:
                case 10:
                    break;
                case 2:
                    return "concurrentlogin";
                case 20:
                    return "incorrectpassword";
                default:
                    return "logout";
            }
            return "banned";
        }

        public function getReasonName(): String {
            var _loc2_: XML = null;
            var _loc3_: String = null;
            var _loc4_: String = null;
            if (var_647 == null) {
                var_647 = new Dictionary();
                _loc2_ = describeType(DisconnectReasonEvent);
                for each(var _loc1_ in _loc2_.constant) {
                    _loc3_ = _loc1_.@name;
                    _loc4_ = String(DisconnectReasonEvent[_loc1_.@name]);
                    var_647[_loc4_] = _loc3_;
                }
            }
            return var_647[reason];
        }
    }
}
