package com.sulake.habbo.communication.demo {
   import assets.class_14

   import com.sulake.core.assets.XmlAsset
   import com.sulake.core.assets.IAssetLibrary
   import com.sulake.core.runtime.ICoreConfiguration
   import com.sulake.core.runtime.events.EventDispatcherWrapper
   import com.sulake.core.window.ICoreWindowManager
   import com.sulake.core.window.IWindow
   import com.sulake.core.window.IWindowContainer
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow
   import com.sulake.core.window.components.class_3539
   import com.sulake.core.window.events.WindowEvent
   import com.sulake.habbo.utils.CommunicationUtils

   import flash.events.Event
   import flash.events.IOErrorEvent
   import flash.events.ProgressEvent
   import flash.events.SecurityErrorEvent
   import flash.net.Socket

   [SecureSWF(rename="true")]
    public class LoginEnvironmentsController extends EventDispatcherWrapper {

        public static const ENVIRONMENT_SELECTED_EVENT: String = "ENVIRONMENT_SELECTED_EVENT";

        public function LoginEnvironmentsController(param1: class_3539, param2: ICoreConfiguration, param3: ICoreWindowManager, param4: IAssetLibrary) {
            super();
            var_2917 = param2;
            _windowManager = param3;
            var_4041 = param4;
            var_2019 = param1;
            init();
        }
        private var var_2917: ICoreConfiguration;
        private var _windowManager: ICoreWindowManager;
        private var var_4041: IAssetLibrary;
        private var var_4573: IWindow;
        private var var_2554: int;
        private var var_2019: class_3539;
        private var var_3818: String;

        public function get selectedEnvironment(): String {
            return var_3818;
        }

        override public function dispose(): void {
            var_2019 = null;
            super.dispose();
        }

        public function getEnvironmentName(param1: String): String {
            var _loc3_: * = param1;
            var _loc2_: String = "connection.info.name." + param1;
            if (var_2917.propertyExists(_loc2_)) {
                _loc3_ = String(var_2917.getProperty(_loc2_));
            } else {
                class_14.log("Could not find name for environment: " + param1);
            }
            return _loc3_;
        }

        private function getAvailableEnvironments(): Array {
            return var_2917.getProperty("live.environment.list").split("/");
        }

        private function createListItem(param1: String): IWindow {
            var _loc2_: XmlAsset = var_4041.getAssetByName(param1) as XmlAsset;
            return _windowManager.buildFromXML(_loc2_.content as XML);
        }

        private function init(): void {
            var _loc5_: int = 0;
            var _loc6_: IWindowContainer = null;
            var_4573 = createListItem("login_environment_list_item");
            var _loc3_: Array = getAvailableEnvironments();
            var _loc1_: String = CommunicationUtils.readSOLString("environment");
            _loc1_ = _loc1_ == null ? "d63" : _loc1_;
            var _loc4_: Array = getEnvironmentNames(_loc3_);
            var_3818 = _loc1_;
            var _loc7_: int = var_2019.numMenuItems;
            _loc5_ = 0;
            while (_loc5_ < _loc7_) {
                var_2019.removeMenuItemAt(0);
                _loc5_++;
            }
            for each(var _loc2_ in _loc4_) {
                (_loc6_ = var_4573.clone() as IWindowContainer).findChildByName("title").caption = _loc2_;
                var_2019.addMenuItem(_loc6_);
            }
            var_2019.selection = _loc3_.indexOf(_loc1_);
            var_2019.procedure = dropMenuEventHandler;
            var_2554 = -1;
            testEnvironmentAvailable(false);
        }

        private function testEnvironmentAvailable(param1: Boolean): void {
            var environmentIds: Array;
            var window: IWindowContainer;
            var environment: String;
            var host: String;
            var ports: Array;
            var socket: Socket;
            var lastEnvironmentConnected: Boolean = param1;
            if (_disposed || var_2019 == null || Boolean(var_2019.disposed)) {
                return;
            }
            environmentIds = getAvailableEnvironments();
            if (var_2019 && var_2554 > -1 && var_2554 < var_2019.numMenuItems) {
                window = var_2019.getMenuItemAt(var_2554) as IWindowContainer;
                (window.findChildByName("icon") as IStaticBitmapWrapperWindow).assetUri = lastEnvironmentConnected ? "help_accept_icon" : "help_decline_icon";
            }
            var_2554++;
            if (var_2554 >= environmentIds.length) {
                return;
            }
            environment = String(environmentIds[var_2554]);
            host = String(var_2917.getProperty("connection.info.host." + environment));
            ports = var_2917.getProperty("connection.info.port." + environment).split(",");
            socket = new Socket();
            socket.addEventListener("connect", function (param1: Event): void {
                (param1.target as Socket).close();
                testEnvironmentAvailable(true);
            });
            socket.addEventListener("complete", function (param1: Event): void {
                (param1.target as Socket).close();
            });
            socket.addEventListener("close", function (param1: Event): void {
                (param1.target as Socket).close();
            });
            socket.addEventListener("socketData", function (param1: ProgressEvent): void {
                (param1.target as Socket).close();
            });
            socket.addEventListener("securityError", function (param1: SecurityErrorEvent): void {
                (param1.target as Socket).close();
                testEnvironmentAvailable(false);
            });
            socket.addEventListener("ioError", function (param1: IOErrorEvent): void {
                (param1.target as Socket).close();
                testEnvironmentAvailable(false);
            });
            socket.connect(host, ports[0]);
        }

        private function getEnvironmentNames(param1: Array): Array {
            var _loc3_: Array = [];
            for each(var _loc2_ in param1) {
                _loc3_.push(getEnvironmentName(_loc2_));
            }
            return _loc3_;
        }

        private function dropMenuEventHandler(param1: WindowEvent, param2: IWindow): void {
            if (param1.type != "WE_SELECTED") {
                return;
            }
            var _loc4_: Array = getAvailableEnvironments();
            var _loc5_: int = var_2019.selection;
            var _loc3_: String = String(_loc4_[_loc5_]);
            var_3818 = _loc3_;
            dispatchEvent(new Event("ENVIRONMENT_SELECTED_EVENT"));
            param1.stopPropagation();
            param1.stopImmediatePropagation();
        }
    }
}
