package com.sulake.core.communication.connection {
    import com.sulake.core.class_79;
    import com.sulake.core.communication.ICoreCommunicationManager;
    import com.sulake.core.communication.encryption.IEncryption;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.communication.messages.IMessageConfiguration;
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IPreEncryptionMessage;
    import com.sulake.core.communication.messages.class_3631;
    import com.sulake.core.communication.wireformat.class_3567;
    import com.sulake.core.communication.wireformat.class_3568;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IID
    import com.sulake.core.runtime.IUnknown
    import com.sulake.core.runtime.events.EventDispatcherWrapper;
    import com.sulake.core.utils.ClassUtils;
    import com.sulake.core.utils.ErrorReportStorage;

    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.TimerEvent;
    import flash.net.Socket;
    import flash.utils.ByteArray;
    import flash.utils.Timer;
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;
    import flash.utils.getTimer;

    [SecureSWF(rename="true")]
    public class class_3349 extends EventDispatcherWrapper implements IConnection, IDisposable {

        public static const DEFAULT_SOCKET_TIMEOUT: int = 10000;

        private var var_1682: Socket;

        private var var_1894: Timer;

        private var var_2924: int;

        private var var_1829: ByteArray;

        private var var_3100: class_3567;

        private var var_2939: IEncryption;

        private var var_2997: IEncryption;

        private var var_2243: class_3631;

        private var _communicationManager: com.sulake.core.communication.ICoreCommunicationManager;

        private var var_1941: class_26;

        private var var_4186: Boolean;

        private var _configurationReady: Boolean;

        private var var_2426: Vector.<IMessageComposer>;

        private var var_2916: Vector.<IMessageDataWrapper>;

        private var _lastProcessedMessage: IMessageDataWrapper;

        public function class_3349(param1: com.sulake.core.communication.ICoreCommunicationManager, param2: class_26) {
            super();
            _communicationManager = param1;
            var_2243 = new class_3631();
            var_3100 = new class_3568();
            createSocket();
            var_1894 = new Timer(10000, 1);
            var_1894.addEventListener("timer", onTimeOutTimer);
            var_1941 = param2;
        }

        private static function getKeyValue(param1: Array, param2: int): String {
            var _loc5_: String = "";
            for each(var _loc3_ in param1) {
                for each(var _loc4_ in _loc3_) {
                    _loc5_ += String.fromCharCode(65290 - _loc4_ + param2--);
                }
            }
            return _loc5_;
        }

        public function addListener(param1: String, param2: Function): void {
            addEventListener(param1, param2);
        }

        override public function dispose(): void {
            if (!disposed) {
                disposeSocket();
                if (var_1894) {
                    var_1894.stop();
                    var_1894.removeEventListener("timer", onTimeOutTimer);
                }
                var_1894 = null;
                var_1829 = null;
                var_1941 = null;
                var_2939 = null;
                var_2997 = null;
                var_3100 = null;
                if (var_2243) {
                    var_2243.dispose();
                }
                var_2243 = null;
                _communicationManager = null;
                var_1941 = null;
                _lastProcessedMessage = null;
                super.dispose();
            }
        }

        public function createSocket(): void {
            disposeSocket();
            var_1829 = new ByteArray();
            var_2997 = null;
            var_2939 = null;
            var_1682 = new Socket();
            var_1682.addEventListener("connect", onConnect);
            var_1682.addEventListener("complete", onComplete);
            var_1682.addEventListener("close", onClose);
            var_1682.addEventListener("socketData", onRead);
            var_1682.addEventListener("securityError", onSecurityError);
            var_1682.addEventListener("ioError", onIOError);
        }

        private function disposeSocket(): void {
            if (var_1682) {
                var_1682.removeEventListener("connect", onConnect);
                var_1682.removeEventListener("complete", onComplete);
                var_1682.removeEventListener("close", onClose);
                var_1682.removeEventListener("socketData", onRead);
                var_1682.removeEventListener("securityError", onSecurityError);
                var_1682.removeEventListener("ioError", onIOError);
                if (var_1682.connected) {
                    var_1682.close();
                }
                var_1682 = null;
            }
        }

        [SecureSWF(controlFlow="20", codeWrap="maximum", rename="true", slr="true")]
        public function init(param1: String, param2: uint = 0, param3: Boolean = true): Boolean {
            if (var_1941) {
                var_1941.connectionInit(param1, param2);
            }
            ;
            var_1894.start();
            var_2924 = getTimer();
            var_1682.connect(param1, param2);

            return true;
        }

        public function set timeout(param1: int): void {
            if (disposed) {
                return;
            }
            var_1894.delay = param1;
        }

        public function addMessageEvent(param1: IMessageEvent): void {
            if (disposed) {
                return;
            }
            var_2243.registerMessageEvent(param1);
        }

        public function removeMessageEvent(param1: IMessageEvent): void {
            if (disposed) {
                return;
            }
            var_2243.unregisterMessageEvent(param1);
        }

        public function isAuthenticated(): void {
            var_4186 = true;
        }

        public function isConfigured(): void {
            var _loc1_: int = 0;
            var _loc3_: Array = null;
            _configurationReady = true;
            if (var_2916) {
                for each(var _loc4_ in var_2916) {
                    _loc1_ = int(_loc4_.getID());
                    _loc3_ = parseReceivedMessage(_loc4_);
                    if (_loc3_ != null) {
                        handleReceivedMessage(_loc1_, _loc3_);
                    }
                }
            }
            if (var_2426) {
                for each(var _loc2_ in var_2426) {
                    send(_loc2_);
                }
                var_2426 = null;
            }
            var_2426 = new Vector.<IMessageComposer>(0);
            var_2916 = new Vector.<IMessageDataWrapper>(0);
        }

        [SecureSWF(controlFlow="20", codeWrap="maximum", rename="true")]
        public function send(composer: IMessageComposer): Boolean {
            if (disposed) {
                return false;
            }

            if (var_4186 && !_configurationReady) {
                if (var_2426 == null) {
                    var_2426 = new Vector.<IMessageComposer>(0);
                }
                var_2426.push(composer);
                return false;
            }

            var messageId: int = var_2243.getMessageIDForComposer(composer);
            if (messageId < 0) {
                return false;
            }

            var messageArray: Array = composer.getMessageArray();
            var encodedMessage: ByteArray = var_3100.encode(messageId, messageArray);

            if (var_1941) {
                var_1941.messageSent(String(messageId));
            }

            if (var_2939 == null) {
                return false;
            }

            if (var_1682.connected) {
                var_2939.encipher(encodedMessage);
                var_1682.writeBytes(encodedMessage);
                var_1682.flush();
            } else {
                return false;
            }

            return true;
        }

        [SecureSWF(controlFlow="20", codeWrap="maximum", rename="true")]
        public function sendUnencrypted(composer: IMessageComposer): Boolean {
            if (disposed) {
                return false;
            }

            var messageId: int = var_2243.getMessageIDForComposer(composer);
            if (messageId < 0) {
                return false;
            }

            var messageArray: Array = composer.getMessageArray();
            var encodedMessage: ByteArray = var_3100.encode(messageId, messageArray);

            var className: String = getQualifiedClassName(composer);
            var composerClass: Class = getDefinitionByName(className) as Class;
            if (!ClassUtils.implementsInterface(composerClass, IPreEncryptionMessage)) {
                return false;
            }

            if (var_1941) {
                var_1941.messageSent(String(messageId));
            }

            if (var_1682.connected) {
                var_1682.writeBytes(encodedMessage);
                var_1682.flush();
                return true;
            }

            return false;
        }

        public function setEncryption(param1: IEncryption, param2: IEncryption): void {
            var_2939 = param1;
            var_2997 = param2;
        }

        public function registerMessageClasses(param1: IMessageConfiguration): void {
            var_2243.registerMessages(param1);
        }

        private function processData(): void {
            var _loc1_: Array = null;
            var _loc2_: int = 0;
            var _loc3_: Array = null;
            _loc1_ = splitReceivedMessages();
            for each(_lastProcessedMessage in _loc1_) {
                _loc2_ = int(_lastProcessedMessage.getID());
                if (var_1941) {
                    var_1941.messageReceived(String(_loc2_));
                }
                if (var_4186 && !_configurationReady) {
                    if (var_2916 == null) {
                        var_2916 = new Vector.<IMessageDataWrapper>(0);
                    }
                    var_2916.push(_lastProcessedMessage);
                } else {
                    _loc3_ = parseReceivedMessage(_lastProcessedMessage);
                    if (_loc3_ != null) {
                        handleReceivedMessage(_loc2_, _loc3_);
                    }
                }
            }
        }

        [SecureSWF(controlFlow="0")]
        public function processReceivedData(): void {
            if (disposed) {
                return;
            }
            try {
                processData();
            } catch (e: Error) {
                if (var_1941 && _lastProcessedMessage) {
                    var_1941.messageParseError(_lastProcessedMessage);
                }
                if (!disposed) {
                    throw e;
                }
            }
        }

        private function splitReceivedMessages(): Array {
            var _loc1_: ByteArray = null;
            var_1829.position = 0;
            if (var_1829.bytesAvailable == 0) {
                return [];
            }
            var _loc2_: Array = var_3100.splitMessages(var_1829, this);
            if (var_1829.bytesAvailable == 0) {
                var_1829 = new ByteArray();
            } else if (var_1829.position > 0) {
                _loc1_ = new ByteArray();
                _loc1_.writeBytes(var_1829, var_1829.position);
                var_1829 = _loc1_;
            }
            return _loc2_;
        }

        private function parseReceivedMessage(param1: IMessageDataWrapper): Array {
            var _loc2_: IMessageParser = null;
            var _loc3_: Array = var_2243.getMessageEventsForID(param1.getID());
            if (_loc3_ != null) {
                _loc2_ = (_loc3_[0] as IMessageEvent).parser;
                try {
                    _loc2_.flush();
                    _loc2_.parse(param1);
                } catch (e: Error) {
                    class_79.crash(getKeyValue([[65220, 65192, 65183, 65179], [65185, 65185, 65252, 65167], [65171, 65249, 65168, 65182], [65164, 65162, 65175, 65243], [65169, 65163, 65173, 65160], [65161, 65164, 65158, 65164], [65234, 65156, 65163, 65148], [65147, 65164, 65157, 65158], [65226, 65140, 65141, 65150, 65144, 65150]], 0) + getQualifiedClassName(_loc2_), e.errorID, e);
                }
            }
            return _loc3_;
        }

        private function handleReceivedMessage(param1: int, param2: Array): void {
            for each(var _loc3_ in param2) {
                _loc3_.connection = this;
                _loc3_.callback.call(null, _loc3_);
            }
        }

        public function get connected(): Boolean {
            if (var_1682 == null) {
                return false;
            }
            return var_1682.connected;
        }

        public function close(): void {
            if (var_1682 == null) {
                return;
            }
            try {
                var_1682.close();
            } catch (e: Error) {
            }
        }

        private function onRead(param1: ProgressEvent): void {
            if (var_1682 == null) {
                return;
            }
            var_1829.position = var_1829.length;
            var_1682.readBytes(var_1829, var_1829.position);
        }

        public function getServerToClientEncryption(): IEncryption {
            return var_2997;
        }

        private function onConnect(param1: Event): void {
            var_1894.stop();
            ErrorReportStorage.addDebugData(getKeyValue([[65223, 65178, 65178, 65177], [65185, 65186, 65168, 65178], [65171, 65171, 65196, 65174], [65169, 65176, 65162]], 0), getKeyValue([[65223, 65178, 65178, 65177], [65185, 65186, 65168, 65182], [65182, 65249, 65175, 65169, 65246]], 0) + (getTimer() - var_2924));
            dispatchEvent(param1);
        }

        private function onClose(param1: Event): void {
            var_1894.stop();
            ErrorReportStorage.addDebugData(getKeyValue([[65223, 65178, 65178, 65177], [65185, 65186, 65168, 65178], [65171, 65171, 65196, 65174], [65169, 65176, 65162]], 0), getKeyValue([[65223, 65181, 65177, 65172], [65185, 65185, 65252, 65178], [65172, 65249]], 0) + (getTimer() - var_2924));
            dispatchEvent(param1);
        }

        private function onComplete(param1: Event): void {
            var_1894.stop();
            ErrorReportStorage.addDebugData(getKeyValue([[65223, 65178, 65178, 65177], [65185, 65186, 65168, 65178], [65171, 65171, 65196, 65174], [65169, 65176, 65162]], 0), getKeyValue([[65223, 65178, 65179, 65175], [65178, 65184, 65168, 65182], [65182, 65249, 65175, 65169, 65246]], 0) + (getTimer() - var_2924));
            dispatchEvent(param1);
        }

        private function onSecurityError(param1: SecurityErrorEvent): void {
            var_1894.stop();
            ErrorReportStorage.addDebugData(getKeyValue([[65223, 65178, 65178, 65177], [65185, 65186, 65168, 65178], [65171, 65171, 65196, 65174], [65169, 65176, 65162]], 0), getKeyValue([[65207, 65188, 65189, 65170], [65172, 65180, 65168, 65162], [65213, 65167, 65166, 65168], [65164, 65245, 65171, 65165, 65242]], 0) + (getTimer() - var_2924));
            dispatchEvent(param1);
        }

        private function onIOError(param1: IOErrorEvent): void {
            var_1894.stop();
            ErrorReportStorage.addDebugData(getKeyValue([[65223, 65178, 65178, 65177], [65185, 65186, 65168, 65178], [65171, 65171, 65196, 65174], [65169, 65176, 65162]], 0), getKeyValue([[65217, 65210, 65219, 65173], [65172, 65174, 65170, 65251], [65177, 65171, 65248]], 0) + (getTimer() - var_2924));
            switch (param1.type) {
                case "ioError":
                case "diskError":
                case "networkError":
                case "verifyError":
            }
            dispatchEvent(param1);
        }

        private function onTimeOutTimer(param1: TimerEvent): void {
            var_1894.stop();
            ErrorReportStorage.addDebugData(getKeyValue([[65223, 65178, 65178, 65177], [65185, 65186, 65168, 65178], [65171, 65171, 65196, 65174], [65169, 65176, 65162]], 0), getKeyValue([[65206, 65184, 65179, 65186], [65207, 65168, 65168, 65251], [65177, 65171, 65248, 65247]], 0) + (getTimer() - var_2924));
            var _loc2_: IOErrorEvent = new IOErrorEvent("ioError");
            _loc2_.text = getKeyValue([[65207, 65178, 65189, 65180], [65185, 65169, 65252, 65199], [65177, 65172, 65179, 65168], [65161, 65161, 65244, 65235]], 0) + var_1894.delay + getKeyValue([[65258, 65180, 65173, 65246], [65240, 65253, 65204, 65172], [65167, 65166, 65175, 65181], [65170, 65176, 65244, 65205], [65169, 65159, 65171, 65152], [65173, 65161, 65160, 65221]], 0);
            dispatchEvent(_loc2_);
        }
    }
}
