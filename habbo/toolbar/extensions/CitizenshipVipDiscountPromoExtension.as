package com.sulake.habbo.toolbar.extensions {
   import com.sulake.core.assets.IAsset
   import com.sulake.core.window.components.IRegionWindow
   import com.sulake.core.window.components.class_3357
   import com.sulake.core.window.components.class_3437
   import com.sulake.core.window.events.WindowMouseEvent
   import com.sulake.habbo.communication.messages.outgoing.catalog.class_930
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer
   import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent
   import com.sulake.habbo.toolbar.HabboToolbar
   import com.sulake.habbo.toolbar.IExtensionView

   import flash.events.TimerEvent
   import flash.utils.Timer

   public class CitizenshipVipDiscountPromoExtension {

        private var _toolbar: HabboToolbar;

        private var var_1631: class_3437;

        private var _expanded: Boolean = true;

        private var var_4263: int = 216;

        private var var_2415: Timer;

        public function CitizenshipVipDiscountPromoExtension(param1: HabboToolbar) {
            super();
            _toolbar = param1;
        }

        private function createWindow(): class_3437 {
            var _loc1_: class_3437 = null;
            var _loc2_: IAsset = _toolbar.assets.getAssetByName("vip_discount_promotion_v2_xml");
            if (_loc2_) {
                _loc1_ = _toolbar.windowManager.buildFromXML(_loc2_.content as XML, 1) as class_3437;
                if (_loc1_) {
                    class_3357(_loc1_.findChildByName("extend_button").addEventListener("WME_CLICK", onButtonClicked));
                    IRegionWindow(_loc1_.findChildByName("minimize_region")).addEventListener("WME_CLICK", onMinMax);
                    IRegionWindow(_loc1_.findChildByName("maximize_region")).addEventListener("WME_CLICK", onMinMax);
                    var_4263 = _loc1_.height;
                }
            }
            return _loc1_;
        }

        private function destroyWindow(): void {
            if (var_1631) {
                var_1631.dispose();
                var_1631 = null;
            }
            destroyExpirationTimer();
        }

        private function get extensionView(): IExtensionView {
            return _toolbar.extensionView;
        }

        public function dispose(): void {
            if (_toolbar == null) {
                return;
            }
            if (extensionView != null) {
                extensionView.detachExtension("club_promo");
            }
            destroyWindow();
            _toolbar = null;
        }

        private function onButtonClicked(param1: WindowMouseEvent): void {
            if (_toolbar.inventory.clubLevel == 2) {
                _toolbar.connection.send(new EventLogMessageComposer("DiscountPromo", "citizenshipdiscount", "client.club.extend.discount.clicked"));
                _toolbar.connection.send(new class_930());
            }
        }

        private function assignState(): void {
            var_1631.findChildByName("content_itemlist").visible = _expanded;
            var_1631.findChildByName("promo_img").visible = _expanded;
            var_1631.height = _expanded ? var_4263 : 33;
        }

        public function onClubChanged(param1: HabboInventoryHabboClubEvent): void {
            if (_toolbar.inventory.citizenshipVipIsExpiring && var_1631 == null && isExtensionEnabled()) {
                var_1631 = createWindow();
                if (var_2415 != null) {
                    destroyExpirationTimer();
                }
                if (_toolbar.inventory.clubMinutesUntilExpiration < 1440 && _toolbar.inventory.clubMinutesUntilExpiration > 0) {
                    var_2415 = new Timer(_toolbar.inventory.clubMinutesUntilExpiration * 60 * 1000, 1);
                    var_2415.addEventListener("timerComplete", onExtendOfferExpire);
                    var_2415.start();
                }
                assignState();
                if (!_toolbar.extensionView.hasExtension("vip_quests")) {
                    _toolbar.extensionView.attachExtension("club_promo", var_1631, 10);
                }
            } else {
                _toolbar.extensionView.detachExtension("vip_quests");
                destroyWindow();
            }
        }

        private function destroyExpirationTimer(): void {
            if (var_2415) {
                var_2415.stop();
                var_2415.removeEventListener("timerComplete", onExtendOfferExpire);
                var_2415 = null;
            }
        }

        private function onExtendOfferExpire(param1: TimerEvent): void {
            _toolbar.extensionView.detachExtension("club_promo");
            destroyWindow();
        }

        private function isExtensionEnabled(): Boolean {
            return _toolbar.inventory.clubLevel == 2 && _toolbar.getBoolean("club.membership.extend.vip.promotion.enabled");
        }

        private function onMinMax(param1: WindowMouseEvent): void {
            _expanded = !_expanded;
            assignState();
        }
    }
}
