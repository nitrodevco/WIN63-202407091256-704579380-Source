package com.sulake.habbo.communication.login {
   import assets.class_14

   import com.sulake.habbo.communication.IHabboCommunicationManager
   import com.sulake.habbo.communication.IHabboWebApiListener
   import com.sulake.habbo.communication.IHabboWebApiSession
   import com.sulake.habbo.utils.CommunicationUtils

   import flash.events.EventDispatcher
   import flash.utils.Dictionary

   public class WebApiLoginProvider extends EventDispatcher implements IHabboWebApiListener, ILoginProvider, ICaptchaListener {

        public static const ERROR_TYPE_IO_ERROR: String = "ioError";

        public static const ERROR_CODE_MAINTENANCE: String = "maintenance";

        private static const AUTO_RECONNECT: Boolean = false;

        private static const POCKET_MODE_LOGIN_AND_REGISTER: int = 1;

        private static const const_182: int = 2;

        public function WebApiLoginProvider(param1: ILoginViewer) {
            super();
            var_22 = param1;
        }
        private var _communication: IHabboCommunicationManager;
        private var var_194: String;
        private var var_22: ILoginViewer;
        private var _pendingLoginError: Object;
        private var _autoLogin: Boolean = false;
        private var _localizationLoaded: Boolean;
        private var var_1607: Boolean;
        private var var_1613: Boolean;
        private var var_306: int = 1;
        private var _name: String;
        private var var_937: String;
        private var var_1553: int;
        private var var_1558: String;
        private var _ssoToken: String;
        private var var_52: IHabboWebApiSession;
        private var var_256: ICaptchaView;

        public function get disposed(): Boolean {
            return false;
        }

        public function init(param1: IHabboCommunicationManager): void {
            _communication = param1;
            var _loc2_: String = getProperty("web.api");
            class_14.log("[WebApiLoginProvider] Init with: " + _loc2_);
            if (_loc2_ != null) {
                _communication.createHabboWebApiSession(this, _loc2_);
            }
            var_52 = createHabboWebApiSession();
            initHabboWebApiSession();
        }

        public function loginWithCredentials(param1: String, param2: String, param3: int = 0): void {
            _name = param1;
            var_937 = param2;
            var_1553 = param3;
            if (var_52) {
                var_52.login(param1, param2);
            } else {
                class_14.log("[WebApiLoginProvider] Login not available");
            }
        }

        public function loginWithCredentialsWeb(param1: String): void {
            var_1558 = param1;
            if (var_52) {
                var_52.selectAvatar(param1);
            } else {
                class_14.log("[WebApiLoginProvider] Login not available");
            }
        }

        public function habboWebApiError(param1: String, param2: int, param3: String, param4: Object, param5: Boolean = false): void {
            var _loc8_: Boolean = false;
            class_14.log("[WebApiLoginProvider] Api Error: id: " + param1 + " type: " + param3 + " captcha: " + param5);
            var _loc7_: String;
            if ((_loc7_ = String(param4 && param4.error ? param4.error : "")) == "maintenance") {
            }
            var _loc9_: Boolean = false;
            if (param3 == "ioError") {
                _loc9_ = true;
            }
            var _loc6_: IHabboWebApiSession = _communication.getHabboWebApiSession();
            switch (param1) {
                case "/api/ssotoken":
                    if (_autoLogin) {
                        _loc9_ = true;
                        _loc6_.login(_name, var_937);
                    }
                case "/api/public/info/hello":
                    var_22.showLoginScreen();
                    break;
                case "/api/public/registration/new":
                    var_22.showRegistrationError(param4);
                    break;
                case "/api/ssotoken":
                    class_14.log("[WebApiLoginProvider] There was an error getting the SSO-token (is this an employee account?)...");
                    var_22.showInvalidLoginError(param4);
                    break;
                case "/api/user/avatars":
                    class_14.log("[WebApiLoginProvider] There was an error getting the Avatars");
                    var_22.showInvalidLoginError(param4);
                    break;
                case "/api/newuser/name/check":
                case "/api/newuser/name/select":
                    class_14.log("[WebApiLoginProvider] There was an error checking name");
                    var_22.nameCheckResponse(param4, param1 == "/api/newuser/name/check");
                    break;
                case "/api/public/authentication/login":
                case "/api/public/authentication/facebook":
                case "/api/force/tos-accept":
                    class_14.log("[WebApiLoginProvider] There was an error authorizing connection...");
                    if (param4 != null && (param4.message != null || param4.error != null || param4.errors != null)) {
                        if (param5) {
                            if (!(_loc8_ = param4.captcha == true && param4.message == "invalid-captcha")) {
                                _pendingLoginError = param4;
                            }
                            showCaptchaView();
                        } else {
                            var_22.showInvalidLoginError(param4);
                        }
                    } else if (param5) {
                        showCaptchaView();
                    } else {
                        var_22.showInvalidLoginError(null);
                    }
                    break;
                case "/api/user/avatars/select":
                    class_14.log("[WebApiLoginProvider] There was an error selecting avatar");
                    if (_loc6_) {
                        var_22.showAccountError(param4);
                        var_22.showLoadingScreen();
                        _loc6_.avatars();
                    } else {
                        var_22.showInvalidLoginError(param4);
                    }
                    break;
                case "/api/newuser/room/select":
                    class_14.log("[WebApiLoginProvider] There was an error selecting home room.");
                    break;
                case "/api/user/look/save":
                    var_22.saveLooksError(param4);
                    break;
                default:
                    class_14.log("[WebApiLoginProvider] Did not process Habbo API message: " + param1);
            }
            if (!_loc9_) {
                _autoLogin = false;
            }
        }

        public function onUserList(param1: Vector.<AvatarData>): void {
            var _loc2_: String = null;
            if (_autoLogin) {
                _loc2_ = CommunicationUtils.readSOLString("useruniqueid");
                if (!userExists(param1, _loc2_)) {
                    var_22.populateCharacterList(param1);
                }
            } else {
                var_22.populateCharacterList(param1);
            }
        }

        public function habboWebApiResponse(param1: String, param2: Object): void {
            var _loc5_: String = null;
            var _loc8_: Array = null;
            var _loc7_: * = undefined;
            var _loc4_: int = 0;
            class_14.log("[WebApiLoginProvider] Got Habbo Web Api Response: " + param1, param2);
            var _loc6_: IHabboWebApiSession;
            if ((_loc6_ = _communication.getHabboWebApiSession()) == null) {
                return;
            }
            if (param2 != null && param2.force != null && param2.force is Array) {
                if ((_loc8_ = param2.force as Array).indexOf("TOS") > -1) {
                    var_22.showTOS();
                    return;
                }
                if (_loc8_.indexOf("EMAIL") > -1 || _loc8_.indexOf("PASSWORD") > -1) {
                    var_22.showInvalidLoginError({"errors":["account_issue"]});
                    return;
                }
            }
            switch (param1) {
                case "/api/public/info/hello":
                    if (var_306 == 1) {
                    }
                    if (_autoLogin) {
                        _loc6_.ssoToken();
                    } else {
                        var_22.environmentReady();
                    }
                    break;
                case "/api/user/avatars/select":
                    if (var_306 != 2) {
                        _loc6_.ssoToken();
                    }
                    break;
                case "/api/public/authentication/login":
                case "/api/public/authentication/facebook":
                case "/api/force/tos-accept":
                    _loc5_ = param1 == "/api/public/authentication/login" ? "habbo" : "facebook";
                    CommunicationUtils.writeSOLProperty("loginmethod", _loc5_);
                    fetchAvatars();
                    break;
                case "/api/user/avatars":
                    if (var_306 != 2) {
                        _loc7_ = new Vector.<AvatarData>(0);
                        for each(var _loc3_ in param2) {
                            _loc7_.push(new AvatarData(_loc3_));
                        }
                        if (_loc7_.length == 1) {
                            CommunicationUtils.writeSOLProperty("useruniqueid", _loc7_[0].uniqueId);
                            _loc6_.selectAvatar(_loc7_[0].uniqueId);
                        } else if (!_autoLogin) {
                            var_22.populateCharacterList(_loc7_);
                        }
                    }
                    break;
                case "/api/ssotoken":
                    _ssoToken = param2["ssoToken"];
                    var_306 = 2;
                    dispatchEvent(new SsoTokenAvailableEvent("SSO_TOKEN_AVAILABLE", _ssoToken));
                    break;
                case "/api/public/registration/new":
                    if (param2 != null) {
                        _loc4_ = parseInt(param2.id);
                        CommunicationUtils.writeSOLProperty("userid", _loc4_.toString());
                    }
                    var_22.showSelectAvatar(param2);
                    break;
                case "/api/public/lists/hotlooks":
                    var_22.showPromoHabbos(param2 as XML);
                    break;
                case "/api/newuser/name/select":
                case "/api/newuser/name/check":
                    var_22.nameCheckResponse(param2, param1 == "/api/newuser/name/check");
                    break;
                case "/api/user/look/save":
                    var_22.showSelectRoom();
                    break;
                case "/api/newuser/room/select":
                    CommunicationUtils.writeSOLProperty("loginmethod", "habbo");
                    fetchAvatars();
            }
        }

        public function habboWebApiRawResponse(param1: String, param2: Object): void {
        }

        public function closeCaptcha(): void {
            removeCaptchaView();
        }

        public function handleCaptchaError(): void {
            removeCaptchaView();
            var_22.showCaptchaError();
        }

        public function handleCaptchaResult(param1: String): void {
            removeCaptchaView();
            var_22.captchaReady();
            if (_pendingLoginError) {
                var_22.showInvalidLoginError(_pendingLoginError);
                _pendingLoginError = null;
            }
            if (param1 == null || var_52 == null) {
                var_22.showCaptchaError();
                return;
            }
            var _loc2_: Boolean = var_52.setCaptchaToken(param1);
        }

        public function getProperty(param1: String, param2: Dictionary = null): String {
            return var_22.getProperty(param1, param2);
        }

        public function selectAvatar(param1: int): void {
        }

        public function selectAvatarUniqueid(param1: String): void {
            if (var_52 == null) {
                return;
            }
            var_52.selectAvatar(param1);
        }

        private function createHabboWebApiSession(): IHabboWebApiSession {
            var _loc2_: IHabboWebApiSession = _communication.getHabboWebApiSession();
            if (_loc2_ != null) {
                _loc2_.dispose();
                _loc2_ = null;
            }
            var _loc1_: String = getProperty("web.api");
            if (_loc1_ == "") {
                _loc1_ = getProperty("url.prefix");
                _loc1_ = _loc1_.replace("http:", "https:");
            }
            return _communication.createHabboWebApiSession(this, _loc1_);
        }

        private function initHabboWebApiSession(): void {
            if (var_52) {
                var_52.hello();
                return;
            }
            throw new Error("Tried to init null IHabboWebApiSession");
        }

        private function showCaptchaView(): void {
            var_256 = var_22.createCaptchaView();
            if (var_256 == null) {
                var_22.showCaptchaError();
            }
        }

        private function removeCaptchaView(): void {
            if (var_256 != null) {
                var_256.dispose();
                var_256 = null;
            }
        }

        private function userExists(param1: Vector.<AvatarData>, param2: String): Boolean {
            for each(var _loc3_ in param1) {
                if (_loc3_.uniqueId == param2) {
                    return true;
                }
            }
            return false;
        }

        private function fetchAvatars(): void {
            var _loc1_: String = null;
            if (var_52 == null) {
                return;
            }
            if (_autoLogin) {
                _loc1_ = CommunicationUtils.readSOLString("useruniqueid");
                if (_loc1_) {
                    var_52.selectAvatar(_loc1_);
                } else {
                    var_52.avatars();
                }
            } else if (var_306 == 1) {
                var_52.avatars();
            }
        }
    }
}
