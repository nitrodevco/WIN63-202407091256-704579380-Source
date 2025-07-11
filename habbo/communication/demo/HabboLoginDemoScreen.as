package com.sulake.habbo.communication.demo {
   import com.sulake.core.assets.IAsset
   import com.sulake.core.assets.XmlAsset
   import com.sulake.core.assets.IAssetLibrary
   import com.sulake.core.runtime.ICoreConfiguration
   import com.sulake.core.runtime.events.EventDispatcherWrapper
   import com.sulake.core.utils.ErrorReportStorage
   import com.sulake.core.utils.Map
   import com.sulake.core.window.IWindow
   import com.sulake.core.window.IWindowContainer
   import com.sulake.core.window.components.*
   import com.sulake.core.window.events.WindowKeyboardEvent
   import com.sulake.core.window.events.WindowEvent
   import com.sulake.habbo.communication.login.AvatarData
   import com.sulake.habbo.communication.login.ICaptchaView
   import com.sulake.habbo.communication.login.ILoginViewer
   import com.sulake.habbo.utils.CommunicationUtils
   import com.sulake.habbo.window.IHabboWindowManager
   import com.sulake.habbo.window.utils.IModalDialog

   import flash.events.Event
   import flash.utils.Dictionary

   [SecureSWF(rename="true")]
    public class HabboLoginDemoScreen extends EventDispatcherWrapper implements ILoginViewer {

        public static const INIT_LOGIN: String = "INIT_LOGIN";

        public static const AVATAR_SELECTED: String = "AVATAR_SELECTED";

        public static const ENVIRONMENT_SELECTED: String = "ENVIRONMENT_SELECTED";

        public static function getModalXmlWindow(param1: String, param2: IAssetLibrary, param3: IHabboWindowManager, param4: String = "_xml"): IModalDialog {
            var _loc7_: IAsset = null;
            var _loc5_: XmlAsset = null;
            var _loc6_: IModalDialog = null;
            try {
                _loc7_ = param2.getAssetByName(param1 + param4);
                _loc5_ = XmlAsset(_loc7_);
                _loc6_ = param3.buildModalDialogFromXML(XML(_loc5_.content));
            } catch (e: Error) {
                ErrorReportStorage.addDebugData("Communication", "Failed to build modal window " + param1 + "_xml, " + _loc7_ + "!");
                throw e;
            }
            return _loc6_;
        }

        public function HabboLoginDemoScreen(param1: ICoreConfiguration, param2: IAssetLibrary, param3: IHabboWindowManager) {
            super();
            var_2917 = param1;
            var_4041 = param2;
            var_4200 = param3;
            var_4253 = new Dictionary();
            var_1907 = getModalXmlWindow("login_window", var_4041, var_4200, "");
            _window = var_1907.rootWindow as IWindowContainer;
            createWindow();
        }
        public var name: String = "";
        public var password: String = "";
        private var var_2917: ICoreConfiguration;
        private var var_4200: IHabboWindowManager;
        private var var_4041: IAssetLibrary;
        private var var_1907: IModalDialog;
        private var _window: IWindowContainer;
        private var var_4682: Boolean = false;
        private var var_4253: Dictionary;
        private var var_4520: IWindow;
        private var var_201: class_3357;
        private var var_2131: ITextFieldWindow;
        private var var_2694: ITextFieldWindow;
        private var var_2005: LoginEnvironmentsController;
        private var var_894: int;
        private var var_198: Vector.<AvatarData>;
        private var var_4328: AvatarData;

        public function get avatarId(): int {
            return var_894;
        }

        public function get selectedAccount(): AvatarData {
            return var_4328;
        }

        public function get selectedEnvironment(): String {
            return var_2005.selectedEnvironment;
        }

        public function get useWebApi(): Boolean {
            var _loc1_: ISelectableWindow = _window.findChildByName("useTicket") as ISelectableWindow;
            if (_loc1_ != null) {
                return _loc1_.isSelected;
            }
            return false;
        }

        public function get useExistingSession(): Boolean {
            return false;
        }

        override public function dispose(): void {
            super.dispose();
            if (var_1907) {
                var_1907.dispose();
                var_1907 = null;
            }
            if (var_2005) {
                var_2005.removeEventListener("ENVIRONMENT_SELECTED_EVENT", onEnvironmentSelected);
                var_2005.dispose();
                var_2005 = null;
            }
            var_4253 = null;
        }

        public function closeLoginWindow(): void {
            if (var_1907) {
                var_1907.dispose();
                var_1907 = null;
            }
        }

        public function populateUserList(param1: Map): void {
            var _loc3_: IWindow = null;
            var _loc4_: int = 0;
            var _loc5_: IItemListWindow;
            if (!(_loc5_ = _window.findChildByName("list") as IItemListWindow)) {
                return;
            }
            _window.findChildByName("users_info").visible = false;
            var _loc2_: IWindow = var_4520.clone();
            _loc2_.procedure = listEventHandler;
            _loc4_ = 0;
            while (_loc4_ < param1.length) {
                _loc3_ = _loc2_.clone();
                _loc3_.id = param1.getKey(_loc4_);
                _loc3_.caption = param1.getWithIndex(_loc4_);
                _loc5_.addListItem(_loc3_);
                _loc4_++;
            }
            _loc2_.dispose();
        }

        public function displayResults(param1: String): void {
            var _loc2_: ITextWindow = _window.findChildByName("text002") as ITextWindow;
            if (_loc2_ != null) {
                _loc2_.text = param1;
            }
        }

        public function showError(param1: int, param2: int, param3: String): void {
            _window.findChildByName("users_info").caption = "Received error: " + param1 + " regarding message: " + param2;
        }

        public function showLoginScreen(): void {
        }

        public function showRegistrationError(param1: Object): void {
            showErrorMessage("Registration error");
        }

        public function showInvalidLoginError(param1: Object): void {
            showErrorMessage("Invalid login");
        }

        public function nameCheckResponse(param1: Object, param2: Boolean): void {
        }

        public function showCaptchaError(): void {
            showErrorMessage("Captcha required, please add your IP to Housekeeping property to avoid this.");
        }

        public function showAccountError(param1: Object): void {
            showErrorMessage("Error with account during login");
        }

        public function showLoadingScreen(): void {
            dispose();
        }

        public function saveLooksError(param1: Object): void {
            showErrorMessage("Save looks error ");
        }

        public function showTOS(): void {
            showErrorMessage("Web-api wants to show Terms of Service");
        }

        public function environmentReady(): void {
            var_201.enable();
            var_201.caption = "Login (" + var_2005.selectedEnvironment + ")";
            showInfoMessage("Web Api connection is established for (" + var_2005.getEnvironmentName(var_2005.selectedEnvironment) + "). Ready to connect.");
        }

        public function populateCharacterList(param1: Vector.<AvatarData>): void {
            var _loc3_: * = null;
            var_198 = param1;
            var _loc6_: String = CommunicationUtils.readSOLString("useruniqueid");
            var _loc2_: Map = new Map();
            var _loc4_: int = 0;
            for each(var _loc5_ in param1) {
                if (_loc5_.uniqueId == _loc6_) {
                    _loc3_ = _loc5_;
                }
                _loc2_[_loc4_] = _loc5_.name;
                _loc4_++;
            }
            populateUserList(_loc2_);
        }

        public function showSelectAvatar(param1: Object): void {
        }

        public function showPromoHabbos(param1: XML): void {
        }

        public function showSelectRoom(): void {
        }

        public function showDisconnectedWithText(param1: int): void {
            showErrorMessage("Hotel is closed");
        }

        public function showDisconnected(param1: int, param2: String): void {
            showErrorMessage("Disconnected reason: " + param2 + " (" + param1 + ")");
        }

        public function getProperty(param1: String, param2: Dictionary = null): String {
            return !!var_2917 ? var_2917.getProperty(param1, param2) : "";
        }

        public function createCaptchaView(): ICaptchaView {
            return undefined;
        }

        public function captchaReady(): void {
        }

        private function createWindow(): void {
            _window.center();
            _window.caption += " (air)";
            _window.findChildByName("useExistingSession").disable();
            _window.findChildByName("useExistingSession").blend = 0.5;
            var_201 = _window.findChildByName("login_btn") as class_3357;
            var_2131 = _window.findChildByName("name_field") as ITextFieldWindow;
            var_2694 = _window.findChildByName("pwd_field") as ITextFieldWindow;
            var _loc3_: String = CommunicationUtils.readSOLString("environment");
            var_201.addEventListener("WME_CLICK", windowEventProcessor);
            var_201.caption = _loc3_ == null ? "Select environment above" : "Initializing (" + _loc3_ + ")";
            var_201.disable();
            if (var_2131 != null) {
                var_2131.textBackground = true;
                var_2131.textBackgroundColor = 16777215;
                var_2131.text = CommunicationUtils.readSOLString("login");
                var_2131.focus();
                var_2131.setSelection(var_2131.text.length, var_2131.text.length);
                var_2131.addEventListener("WKE_KEY_UP", windowEventProcessor);
            }
            if (var_2694 != null) {
                var_2694.textBackground = true;
                var_2694.textBackgroundColor = 16777215;
                var_2694.text = CommunicationUtils.restorePassword();
                var_2694.addEventListener("WKE_KEY_UP", windowEventProcessor);
            }
            var _loc2_: ISelectableWindow = _window.findChildByName("useTicket") as ISelectableWindow;
            _loc2_.addEventListener("WME_CLICK", windowEventProcessorCheckbox);
            if (_loc2_) {
                _loc2_.select();
            }
            var _loc1_: ISelectableWindow = _window.findChildByName("useExistingSession") as ISelectableWindow;
            if (_loc1_) {
                _loc1_.unselect();
            }
            if (var_2917.getBoolean("try.existing.session")) {
                var_4682 = true;
                _window.visible = false;
                windowEventProcessor(WindowEvent.allocate("WE_OK", _window, null, false));
            }
            var _loc4_: IItemListWindow;
            var_4520 = (_loc4_ = _window.findChildByName("list") as IItemListWindow).removeListItemAt(0);
            var_2005 = new LoginEnvironmentsController(_window.findChildByName("environment_list") as class_3539, var_2917, var_4200, var_4041);
            var_2005.addEventListener("ENVIRONMENT_SELECTED_EVENT", onEnvironmentSelected);
        }

        private function handleKeyUp(param1: WindowKeyboardEvent): void {
            var _loc3_: int = 0;
            var _loc6_: String = null;
            var _loc4_: String = null;
            var _loc5_: ITextFieldWindow = null;
            var _loc2_: ITextFieldWindow = null;
            var _loc7_: WindowKeyboardEvent;
            if ((_loc7_ = param1 as WindowKeyboardEvent).ctrlKey) {
                _loc3_ = _loc7_.keyCode - 49;
                if (_loc3_ >= 0 && _loc3_ < 10) {
                    _loc6_ = String(var_2917.getProperty("login.user." + _loc3_ + ".name"));
                    _loc4_ = String(var_2917.getProperty("login.user." + _loc3_ + ".pass"));
                    _loc5_ = _window.findChildByName("name_field") as ITextFieldWindow;
                    _loc2_ = _window.findChildByName("pwd_field") as ITextFieldWindow;
                    if (_loc6_ != "") {
                        _loc5_.caption = _loc6_;
                    }
                    if (_loc4_ != "") {
                        _loc2_.caption = _loc4_;
                    }
                    _loc5_.setSelection(_loc5_.text.length, _loc5_.text.length);
                    if (_loc7_.cancelable) {
                        _loc7_.preventDefault();
                        _loc7_.preventWindowOperation();
                    }
                    param1.stopImmediatePropagation();
                    param1.stopPropagation();
                }
            }
        }

        private function windowEventProcessor(param1: WindowEvent = null, param2: IWindow = null): void {
            if (param1.type == "WKE_KEY_UP") {
                handleKeyUp(param1 as WindowKeyboardEvent);
                if ((param1 as WindowKeyboardEvent).keyCode != 13) {
                    return;
                }
            }
            if (var_2131 != null) {
                name = var_2131.text;
            }
            if (var_2694 != null) {
                password = var_2694.text;
            }
            CommunicationUtils.writeSOLProperty("login", name);
            CommunicationUtils.storePassword(password);
            dispatchEvent(new Event("INIT_LOGIN"));
            var_201.disable();
        }

        private function windowEventProcessorCheckbox(param1: WindowEvent = null, param2: IWindow = null): void {
            var_201.enable();
        }

        private function listEventHandler(param1: WindowEvent, param2: IWindow): void {
            if (param1.type != "WME_CLICK") {
                return;
            }
            if (useWebApi) {
                var_4328 = var_198[param2.id];
            } else {
                var_894 = var_198[param2.id].id;
            }
            dispatchEvent(new Event("AVATAR_SELECTED"));
        }

        private function showErrorMessage(param1: String): void {
            _window.findChildByName("users_info").caption = "Error:\n\n" + param1;
        }

        private function showInfoMessage(param1: String): void {
            _window.findChildByName("users_info").caption = param1;
        }

        private function onEnvironmentSelected(param1: Event = null): void {
            dispatchEvent(new Event("ENVIRONMENT_SELECTED"));
            var_201.disable();
            var_201.caption = "Initializing (" + var_2005.selectedEnvironment + ")";
            showInfoMessage("Initializing Web Api connection to (" + var_2005.getEnvironmentName(var_2005.selectedEnvironment) + ")");
        }
    }
}
