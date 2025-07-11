package com.sulake.habbo.communication.demo {
    import assets.class_14

    import com.hurlant.crypto.rsa.RSAKey
    import com.hurlant.math.BigInteger
    import com.sulake.core.class_79
    import com.sulake.core.communication.connection.IConnection
    import com.sulake.core.communication.encryption.CryptoTools
    import com.sulake.core.communication.encryption.IEncryption
    import com.sulake.core.communication.handshake.class_42
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.habbo.communication.IHabboCommunicationManager
    import com.sulake.habbo.communication.login.AvatarData
    import com.sulake.habbo.communication.messages.incoming.availability.class_1083
    import com.sulake.habbo.communication.messages.incoming.availability.class_1090
    import com.sulake.habbo.communication.messages.incoming.error.class_231
    import com.sulake.habbo.communication.messages.incoming.handshake.class_1060
    import com.sulake.habbo.communication.messages.incoming.handshake.class_1103
    import com.sulake.habbo.communication.messages.incoming.handshake.class_134
    import com.sulake.habbo.communication.messages.incoming.handshake.class_223
    import com.sulake.habbo.communication.messages.incoming.handshake.class_257
    import com.sulake.habbo.communication.messages.incoming.handshake.class_280
    import com.sulake.habbo.communication.messages.incoming.handshake.class_483
    import com.sulake.habbo.communication.messages.incoming.handshake.class_485
    import com.sulake.habbo.communication.messages.outgoing.handshake.PongMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.handshake.class_385
    import com.sulake.habbo.communication.messages.outgoing.handshake.ClientHelloMessageComposer
    import com.sulake.habbo.communication.messages.outgoing.handshake.class_622
    import com.sulake.habbo.communication.messages.outgoing.handshake.class_840
    import com.sulake.habbo.communication.messages.outgoing.tracking.class_955
    import com.sulake.habbo.communication.messages.parser.availability.class_1211
    import com.sulake.habbo.communication.messages.parser.availability.class_1528
    import com.sulake.habbo.communication.messages.parser.error.class_1334
    import com.sulake.habbo.communication.messages.parser.handshake.class_1366
    import com.sulake.habbo.utils.CommunicationUtils
    import com.sulake.habbo.utils.HabboWebTools

    import flash.events.Event
    import flash.external.ExternalInterface
    import flash.utils.ByteArray
    import flash.utils.Dictionary

    [SecureSWF(rename="true")]
    public class IncomingMessages {

        private static function setReasonProperty(param1: String, param2: String): String {
            if (param1.indexOf("%reason%") != -1) {
                return param1.replace("%reason%", param2);
            }
            return param1;
        }

        public function IncomingMessages(param1: HabboCommunicationDemo, param2: IHabboCommunicationManager) {
            _messageEvents = new Vector.<IMessageEvent>(0);
            super();
            var_1660 = param1;
            _communication = param2;
            var _loc3_: IConnection = _communication.connection;
            if (_loc3_ == null) {
                throw new Error("Connection is required to initialize!");
            }
            _loc3_.addEventListener("connect", onConnectionEstablished);
            _loc3_.addEventListener("close", onConnectionDisconnected);
            addHabboConnectionMessageEvent(new class_1083(onLoginFailedHotelClosed));
            addHabboConnectionMessageEvent(new class_280(onDisconnectReason));
            addHabboConnectionMessageEvent(new class_1090(onMaintenance));
            addHabboConnectionMessageEvent(new class_485(onGenericError));
            addHabboConnectionMessageEvent(new class_134(onInitDiffieHandshake));
            addHabboConnectionMessageEvent(new class_223(onUniqueMachineId));
            addHabboConnectionMessageEvent(new class_1060(onCompleteDiffieHandshake));
            addHabboConnectionMessageEvent(new class_231(onErrorReport));
            addHabboConnectionMessageEvent(new class_1103(onIdentityAccounts));
            addHabboConnectionMessageEvent(new class_257(onPing));
            addHabboConnectionMessageEvent(new class_483(onAuthenticationOK));
            var_1660.context.events.addEventListener("unload", unloading);
        }
        private var var_1660: HabboCommunicationDemo;
        private var _communication: IHabboCommunicationManager;
        private var var_2512: class_42;
        private var _privateKey: String;
        private var var_2764: Boolean;
        private var var_2788: Boolean;
        private var _messageEvents: Vector.<IMessageEvent>;
        private var _rsa: RSAKey;

        public function dispose(): void {
            var _loc1_: IConnection = null;
            if (_communication) {
                _loc1_ = _communication.connection;
                if (_loc1_ != null) {
                    _loc1_.removeEventListener("connect", onConnectionEstablished);
                    _loc1_.removeEventListener("close", onConnectionDisconnected);
                }
                for each(var _loc2_ in _messageEvents) {
                    _communication.removeHabboConnectionMessageEvent(_loc2_);
                }
                _messageEvents = new Vector.<IMessageEvent>(0);
            }
            var_1660 = null;
            _communication = null;
            var_2512 = null;
        }

        private function addHabboConnectionMessageEvent(param1: IMessageEvent): void {
            _communication.addHabboConnectionMessageEvent(param1);
            _messageEvents.push(param1);
        }

        private function onInitDiffieHandshake(param1: IMessageEvent): void {
            var _loc9_: String = null;
            var _loc16_: IConnection = param1.connection;
            var _loc2_: class_134 = param1 as class_134;
            var _loc3_: ByteArray = new ByteArray();
            var _loc4_: ByteArray = new ByteArray();
            _loc3_.writeBytes(CryptoTools.hexStringToByteArray(_loc2_.encryptedPrime));
            _loc4_.writeBytes(CryptoTools.hexStringToByteArray(_loc2_.encryptedGenerator));
            var _loc5_: ByteArray = new ByteArray();
            var _loc8_: ByteArray = new ByteArray();
            _rsa = RSAKey.parsePublicKey("86851dd364d5c5cece3c883171cc6ddc5760779b992482bd1e20dd296888df91b33b936a7b93f06d29e8870f703a216257dec7c81de0058fea4cc5116f75e6efc4e9113513e45357dc3fd43d4efab5963ef178b78bd61e81a14c603b24c8bcce0a12230b320045498edc29282ff0603bc7b7dae8fc1b05b52b2f301a9dc783b7", "3");
            _rsa.verify(_loc3_, _loc5_, _loc3_.length);
            _rsa.verify(_loc4_, _loc8_, _loc4_.length);
            var _loc11_: BigInteger = new BigInteger(_loc5_.toString(), 10);
            var _loc12_: BigInteger = new BigInteger(_loc8_.toString(), 10);
            var _loc10_: BigInteger = BigInteger.nbv(2);
            if (_loc11_.compareTo(_loc10_) <= 0 || _loc12_.compareTo(_loc11_) >= 0) {
                class_79.crash("Invalid DH prime and generator", 29);
                return;
            }
            if (_loc11_.equals(_loc12_)) {
                class_79.crash("Invalid DH prime and generator", 29);
                return;
            }
            var_2512 = _communication.initializeKeyExchange(_loc11_, _loc12_);
            var _loc6_: * = null;
            var _loc13_: int = 10;
            var _loc7_: String = null;
            while (_loc13_ > 0) {
                _loc7_ = generateRandomHexString(30);
                var_2512.init(_loc7_);
                if ((_loc9_ = String(var_2512.getPublicKey(10))).length >= 64) {
                    _loc6_ = _loc9_;
                    _privateKey = _loc7_;
                    break;
                }
                if (_loc6_ == null || _loc9_.length > _loc6_.length) {
                    _loc6_ = _loc9_;
                    _privateKey = _loc7_;
                }
                _loc13_--;
            }
            if (_loc7_ != _privateKey) {
                var_2512.init(_privateKey);
            }
            var _loc15_: ByteArray = new ByteArray();
            var _loc14_: ByteArray = new ByteArray();
            _loc15_.writeMultiByte(_loc6_, "iso-8859-1");
            _rsa.encrypt(_loc15_, _loc14_, _loc15_.length);
            _loc16_.sendUnencrypted(new class_385(CryptoTools.byteArrayToHexString(_loc14_)));
        }

        private function onCompleteDiffieHandshake(param1: IMessageEvent): void {
            var _loc9_: IEncryption = null;
            var _loc7_: IConnection = param1.connection;
            var _loc4_: class_1060 = param1 as class_1060;
            var _loc6_: ByteArray = new ByteArray();
            var _loc3_: ByteArray = new ByteArray();
            _loc6_.writeBytes(CryptoTools.hexStringToByteArray(_loc4_.encryptedPublicKey));
            _rsa.verify(_loc6_, _loc3_, _loc6_.length);
            _rsa.dispose();
            var_2512.generateSharedKey(_loc3_.toString(), 10);
            var _loc2_: String = String(var_2512.getSharedKey(16).toUpperCase());
            if (!var_2512.isValidServerPublicKey()) {
                return;
            }
            var _loc8_: ByteArray;
            (_loc8_ = CryptoTools.hexStringToByteArray(_loc2_)).position = 0;
            var _loc5_: IEncryption;
            (_loc5_ = _communication.initializeEncryption()).init(_loc8_);
            if (_loc4_.serverClientEncryption) {
                (_loc9_ = _communication.initializeEncryption()).init(_loc8_);
            }
            _loc7_.setEncryption(_loc5_, _loc9_);
            var_2764 = false;
            var_1660.dispatchLoginStepEvent("HABBO_CONNECTION_EVENT_HANDSHAKED");
            var_1660.sendConnectionParameters(_loc7_);
        }

        private function onAuthenticationOK(param1: class_483): void {
            var _loc4_: IConnection = param1.connection;
            var_1660.dispatchLoginStepEvent("HABBO_CONNECTION_EVENT_AUTHENTICATED");
            var _loc2_: class_840 = new class_840();
            _loc4_.send(_loc2_);
            var _loc3_: class_955 = new class_955("Login", "socket", "client.auth_ok");
            _loc4_.send(_loc3_);
            _communication.suggestedLoginActions = param1.suggestedLoginActions;
            var_1660.loginOk();
        }

        private function onLoginFailedHotelClosed(param1: IMessageEvent): void {
            var _loc2_: class_1528 = (param1 as class_1083).getParser();
            var_1660.handleLoginFailedHotelClosedMessage(_loc2_.openHour, _loc2_.openMinute);
        }

        private function onGenericError(param1: IMessageEvent): void {
            var _loc2_: class_1366 = (param1 as class_485).getParser();
            switch (_loc2_.errorCode) {
                case -3:
                    var_1660.alert("${connection.error.id.title}", "${connection.login.error.-3.desc}");
                    break;
                case -400:
                    var_1660.alert("${connection.error.id.title}", "${connection.login.error.-400.desc}");
            }
        }

        private function onPing(param1: IMessageEvent): void {
            var _loc2_: IConnection = param1.connection;
            var _loc3_: PongMessageComposer = new PongMessageComposer();
            _loc2_.send(_loc3_);
        }

        [SecureSWF(controlFlow="0", codeWrap="off")]
        private function onUniqueMachineId(param1: class_223): void {
            CommunicationUtils.writeSOLProperty("machineid", param1.machineID);
        }

        private function onIdentityAccounts(param1: class_1103): void {
            var _loc3_: String = null;
            var _loc6_: AvatarData = null;
            var _loc4_: Vector.<AvatarData> = new Vector.<AvatarData>(0);
            var _loc2_: Dictionary = param1.getParser().accounts;
            for (var _loc5_ in _loc2_) {
                _loc3_ = String(_loc2_[_loc5_]);
                (_loc6_ = new AvatarData(null)).id = parseInt(_loc5_);
                _loc6_.name = _loc3_;
                _loc4_.push(_loc6_);
            }
            var_1660.onUserList(_loc4_);
        }

        private function onErrorReport(param1: IMessageEvent): void {
            var _loc2_: class_1334 = (param1 as class_231).getParser();
            var _loc3_: int = _loc2_.errorCode;
            var _loc4_: int = _loc2_.messageId;
            var_1660.handleErrorMessage(_loc3_, _loc4_);
        }

        private function onMaintenance(param1: class_1090): void {
            var _loc2_: class_1211 = param1.parser as class_1211;
            class_14.log("Got maintenance status, with minutes left: " + _loc2_.minutesUntilMaintenance.toString());
            var_1660.localization.registerParameter("disconnected.maintenance_status", "%minutes%", _loc2_.minutesUntilMaintenance.toString());
            var _loc3_: String = String(var_1660.localization.getLocalization("disconnected.maintenance_status"));
            var_1660.disconnected(-2, _loc3_);
        }

        private function onDisconnectReason(param1: class_280): void {
            if (var_2764) {
                var_1660.dispatchLoginStepEvent("HABBO_CONNECTION_EVENT_HANDSHAKE_FAIL");
            }
            class_14.log("[HabboLogin] Got disconnect reason: " + param1.reason);
            var_1660.disconnected(param1.reason, param1.getReasonName());
            var_2764 = false;
            var_2788 = true;
        }

        private function handleWebLogout(param1: class_280): void {
            var _loc2_: String = var_1660.getProperty("logout.url");
            if (_loc2_.length > 0) {
                _loc2_ = setReasonProperty(_loc2_, param1.reasonString);
                _loc2_ = setOriginProperty(_loc2_);
                _loc2_ += "&id=" + param1.reason;
                if (var_1660.context.configuration.getInteger("spaweb", 0) == 1) {
                    HabboWebTools.sendDisconnectToWeb(param1.reason, param1.reasonString);
                } else {
                    HabboWebTools.openWebPage(_loc2_, "_self");
                }
            }
        }

        private function setOriginProperty(param1: String): String {
            if (param1.indexOf("%origin%") != -1) {
                return param1.replace("%origin%", var_1660.getProperty("flash.client.origin"));
            }
            return param1;
        }

        private function generateRandomHexString(param1: uint = 16): String {
            var _loc5_: int = 0;
            var _loc4_: * = 0;
            var _loc3_: String = null;
            var _loc2_: String = "";
            _loc5_ = 0;
            while (_loc5_ < param1) {
                _loc3_ = (_loc4_ = Math.random() * 255).toString(16);
                if (_loc3_.length < 2) {
                    _loc3_ = "0" + _loc3_;
                }
                _loc2_ += _loc3_;
                _loc5_++;
            }
            return _loc2_;
        }

        private function unloading(param1: Event): void {
            var_2788 = true;
        }

        private function onConnectionEstablished(param1: Event = null): void {
            var _loc2_: IConnection = _communication.connection;
            if (_loc2_ != null) {
                var_1660.dispatchLoginStepEvent("HABBO_CONNECTION_EVENT_ESTABLISHED");
                var_2788 = false;
                var_2764 = true;
                var_1660.dispatchLoginStepEvent("HABBO_CONNECTION_EVENT_HANDSHAKING");
                _loc2_.sendUnencrypted(new ClientHelloMessageComposer());
                _loc2_.sendUnencrypted(new class_622());
            }
        }

        private function onConnectionDisconnected(param1: Event): void {
            var _loc2_: String = null;
            if (var_1660.isRoomViewerMode) {
                return;
            }
            if (var_2764) {
                var_1660.dispatchLoginStepEvent("HABBO_CONNECTION_EVENT_HANDSHAKE_FAIL");
            }
            if (ExternalInterface.available) {
                ExternalInterface.call("FlashExternalInterface.logDisconnection", "Communication failure, client disconnected.");
                if (param1.type == "close" && !var_2788) {
                    _loc2_ = var_1660.getProperty("logout.disconnect.url");
                    _loc2_ = setOriginProperty(_loc2_);
                    if (var_1660.context.configuration.getInteger("spaweb", 0) == 1) {
                        HabboWebTools.sendDisconnectToWeb(-1, "HABBO_CONNECTION_EVENT_HANDSHAKE_FAIL");
                    } else {
                        HabboWebTools.openWebPage(_loc2_, "_self");
                    }
                }
            }
            if (param1.type == "close" && !var_2788) {
                var_1660.disconnected(-3, "");
            }
        }
    }
}
