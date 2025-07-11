package com.sulake.habbo.tracking {
   import assets.class_14

   import com.sulake.core.utils.debug.GarbageMonitor
   import com.sulake.habbo.communication.messages.outgoing.tracking.class_207

   import flash.external.ExternalInterface
   import flash.system.Capabilities
   import flash.system.System
   import flash.utils.getTimer

   public class PerformanceTracker {

        private var var_1461: int = 0;

        private var var_2182: Number = 0;

        private var _userAgent: String = "";

        private var _version: String = "";

        private var _os: String = "";

        private var var_4961: String = "";

        private var _isDebugger: Boolean = false;

        private var _garbageMonitor: GarbageMonitor = null;

        private var var_3385: int = 0;

        private var var_3340: int = 0;

        private var _timer: int = 0;

        private var var_3622: int = 0;

        private var var_4700: Number = 0;

        private var _habboTracking: HabboTracking;

        public function PerformanceTracker(param1: HabboTracking) {
            super();
            _habboTracking = param1;
            _version = Capabilities.version;
            _os = Capabilities.os;
            _isDebugger = Capabilities.isDebugger;
            try {
                _userAgent = ExternalInterface.available ? ExternalInterface.call("window.navigator.userAgent.toString") : "unknown";
            } catch (e: Error) {
            }
            if (_userAgent == null) {
                _userAgent = "unknown";
            }
            _garbageMonitor = new GarbageMonitor();
            updateGarbageMonitor();
            _timer = getTimer();
        }

        private static function differenceInPercents(param1: Number, param2: Number): Number {
            if (param1 == param2) {
                return 0;
            }
            var _loc4_: * = param1;
            var _loc3_: * = param2;
            if (param2 > param1) {
                _loc4_ = param2;
                _loc3_ = param1;
            }
            return 100 * (1 - _loc3_ / _loc4_);
        }

        public function get flashVersion(): String {
            return _version;
        }

        public function get averageUpdateInterval(): int {
            return var_2182;
        }

        private function updateGarbageMonitor(): Object {
            var _loc2_: Object = null;
            var _loc1_: Array = _garbageMonitor.list;
            if (_loc1_ == null || _loc1_.length == 0) {
                _loc2_ = new GarbageTester("tester");
                _garbageMonitor.insert(_loc2_, "tester");
                return _loc2_;
            }
            return null;
        }

        public function update(param1: uint, param2: int): void {
            var _loc7_: Object = null;
            var _loc3_: Number = NaN;
            var _loc4_: * = 0;
            var _loc6_: Boolean = false;
            var _loc5_: Number = NaN;
            if (isGarbageMonitored) {
                if ((_loc7_ = updateGarbageMonitor()) != null) {
                    var_3385++;
                    class_14.log("Garbage collection");
                }
            }
            var _loc8_: Boolean = false;
            if (param1 > slowUpdateLimit) {
                var_3340++;
                _loc8_ = true;
            } else {
                var_1461++;
                if (var_1461 <= 1) {
                    var_2182 = param1;
                } else {
                    _loc3_ = var_1461;
                    var_2182 = var_2182 * (_loc3_ - 1) / _loc3_ + param1 / _loc3_;
                }
            }
            if (param2 - _timer > reportInterval * 1000 && var_3622 < reportLimit) {
                _loc4_ = System.totalMemory;
                class_14.log("*** Performance tracker: average frame rate " + 1000 / var_2182 + "/s, system memory usage : " + _loc4_ + " bytes");
                _loc6_ = true;
                if (useDistribution && var_3622 > 0) {
                    if ((_loc5_ = differenceInPercents(var_4700, var_2182)) < meanDevianceLimit) {
                        _loc6_ = false;
                    }
                }
                _timer = param2;
                if (_loc6_ || _loc8_) {
                    var_4700 = var_2182;
                    sendReport(param2);
                    var_3622++;
                }
            }
        }

        private function sendReport(param1: int): void {
            var _loc4_: int = param1 / 1000;
            var _loc3_: int = -1;
            var _loc2_: int = System.totalMemory / 1024;
            _habboTracking.send(new class_207(_loc4_, _userAgent, _version, _os, var_4961, _isDebugger, _loc2_, _loc3_, var_3385, var_2182, var_3340));
            var_3385 = 0;
            var_2182 = 0;
            var_1461 = 0;
            var_3340 = 0;
        }

        private function get isGarbageMonitored(): Boolean {
            return _habboTracking.getBoolean("monitor.garbage.collection");
        }

        private function get slowUpdateLimit(): int {
            return _habboTracking.getInteger("performancetest.slowupdatelimit", 1000);
        }

        private function get reportInterval(): int {
            return _habboTracking.getInteger("performancetest.interval", 60);
        }

        private function get reportLimit(): int {
            return _habboTracking.getInteger("performancetest.reportlimit", 10);
        }

        private function get meanDevianceLimit(): Number {
            return _habboTracking.propertyExists("performancetest.distribution.deviancelimit.percent") ? Number(_habboTracking.getProperty("performancetest.distribution.deviancelimit.percent")) : 10;
        }

        private function get useDistribution(): Boolean {
            return _habboTracking.getBoolean("performancetest.distribution.enabled");
        }
    }
}
