package com.sulake.habbo.campaign.calendar {
    import com.sulake.core.window.IWindow
    import com.sulake.core.window.IWindowContainer
    import com.sulake.core.window.components.IItemListWindow
    import com.sulake.core.window.components.ITextWindow
    import com.sulake.core.window.components.class_3357
    import com.sulake.core.window.components.class_3514
    import com.sulake.core.window.events.WindowEvent
    import com.sulake.habbo.campaign.HabboCampaigns
    import com.sulake.habbo.communication.messages.parser.campaign.class_1641
    import com.sulake.habbo.room.IGetImageListener
    import com.sulake.habbo.session.product.class_3423
    import com.sulake.habbo.window.IHabboWindowManager
    import com.sulake.habbo.window.utils.IModalDialog

    import flash.display.BitmapData
    import flash.display.Stage
    import flash.events.Event

    public class CalendarView implements IGetImageListener {

        private static const MARGIN: int = 75;

        private var var_319: HabboCampaigns;

        private var var_1828: IModalDialog;

        private var var_2038: int = -1;

        private var _itemsOnScreen: int;

        public function CalendarView(param1: HabboCampaigns, param2: IHabboWindowManager) {
            var _loc7_: int = 0;
            var _loc5_: IWindowContainer = null;
            super();
            var_319 = param1;
            var_1828 = param2.buildModalDialogFromXML(XML(var_319.assets.getAssetByName("campaign_calendar_xml").content));
            if (!var_1828 || !var_1828.rootWindow || !itemList) {
                return;
            }
            var _loc3_: IWindowContainer = itemList.getListItemAt(0) as IWindowContainer;
            itemList.removeListItems();
            itemList.disableAutodrag = true;
            var _loc6_: int = calendarData.campaignDays;
            _loc7_ = 0;
            while (_loc7_ < _loc6_) {
                (_loc5_ = CalendarItem.populateItem(_loc3_, calendarData, _loc7_)).procedure = onInput;
                itemList.addListItem(_loc5_);
                _loc7_++;
            }
            var _loc4_: Stage;
            (_loc4_ = var_319.context.displayObjectContainer.stage).addEventListener("resize", onResize);
            window.procedure = onInput;
            onResize(null);
            setSelectedIndex(var_319.calendarData.currentDay);
        }

        public function dispose(): void {
            var _loc1_: Stage = null;
            if (var_1828 != null) {
                _loc1_ = var_319.context.displayObjectContainer.stage;
                _loc1_.removeEventListener("resize", onResize);
                var_1828.dispose();
                var_1828 = null;
            }
        }

        public function setReceivedProduct(param1: class_3423, param2: String = null): void {
            setInfoText("${campaign.calendar.heading.product.received}", param1.name);
            updateThumbnail(param2);
        }

        public function imageReady(param1: int, param2: BitmapData): void {
            updateThumbnail(param2);
        }

        private function updateThumbnail(param1: Object): void {
            var _loc2_: IWindowContainer = itemList.getListItemAt(var_2038) as IWindowContainer;
            if (!_loc2_) {
                return;
            }
            CalendarItem.updateThumbnail(_loc2_, param1);
        }

        public function imageFailed(param1: int): void {
        }

        public function hide(): void {
            var_319.hideCalendar();
        }

        private function onResize(param1: Event): void {
            var _loc2_: Stage = var_319.context.displayObjectContainer.stage;
            _itemsOnScreen = Math.floor((_loc2_.stageWidth - 75 * 2) / (itemWidth + itemGap));
            var_1828.rootWindow.width = calculateItemListWidth(_itemsOnScreen);
            var _loc3_: IWindow = window.findChildByName("btn_forward");
            if (_loc3_) {
                _loc3_.x = scrollerWidth - window.findChildByName("btn_back").x - _loc3_.width;
            }
            _loc3_ = window.findChildByName("calendar_scrollbar");
            if (_loc3_) {
                _loc3_.width = scrollerWidth;
            }
            window.center();
            if (var_2038 > -1) {
                setSelectedIndex(var_2038);
            }
        }

        private function onInput(param1: WindowEvent, param2: IWindow): void {
            var _loc3_: int = 0;
            if (param1.type != "WME_DOWN") {
                return;
            }
            switch (param2.name) {
                case "btn_present":
                    _loc3_ = itemList.getListItemIndex(param1.target.parent);
                    if (_loc3_ < 0) {
                        return;
                    }
                    if (_loc3_ != var_2038) {
                        setSelectedIndex(_loc3_);
                    } else {
                        var_319.openPackage(var_2038);
                    }
                    break;
                case "btn_back":
                    setSelectedIndex(var_2038 - 1);
                    break;
                case "btn_forward":
                    setSelectedIndex(var_2038 + 1);
                    break;
                case "btn_force_open":
                    var_319.openPackageAsStaff(var_2038);
                    break;
                case "header_button_close":
                    hide();
            }
        }

        private function setSelectedIndex(param1: int): void {
            var _loc6_: int = 0;
            var _loc2_: IWindowContainer = null;
            var _loc7_: class_3357 = null;
            var _loc5_: String = null;
            var _loc4_: String = null;
            if (param1 < 0 || param1 >= calendarData.campaignDays) {
                return;
            }
            var_2038 = param1;
            itemList.scrollH = calculateCenteredItemScrollH(var_2038);
            _loc6_ = 0;
            while (_loc6_ < calendarData.campaignDays) {
                _loc2_ = itemList.getListItemAt(_loc6_) as IWindowContainer;
                CalendarItem.updateState(_loc2_, calendarData, _loc6_, param1);
                _loc6_++;
            }
            CalendarSpinnerUtil.createGradients(this, var_2038);
            if (var_319.isAnyRoomController) {
                (_loc7_ = window.findChildByName("btn_force_open") as class_3357).visible = true;
            }
            var _loc3_: int = CalendarItem.resolveDayState(calendarData, param1);
            if (var_2038 < 0) {
                setInfoText(null, null);
                if (_loc7_) {
                    _loc7_.disable();
                }
            } else {
                switch (_loc3_ - 1) {
                    case 0:
                        _loc5_ = "${campaign.calendar.info.unlocked}";
                        break;
                    case 1:
                        _loc5_ = "${campaign.calendar.info.available.desktop}";
                        break;
                    case 2:
                        _loc5_ = "${campaign.calendar.info.expired}";
                        break;
                    case 3:
                        _loc5_ = "${campaign.calendar.info.future}";
                }
                _loc4_ = (_loc4_ = String(var_319.localizationManager.getLocalization("campaign.calendar.heading.day") || "")).replace("%number%", var_2038 + 1);
                setInfoText(_loc4_, _loc5_);
                if (_loc7_) {
                    if (_loc3_ != 1) {
                        _loc7_.enable();
                    } else {
                        _loc7_.disable();
                    }
                }
            }
        }

        private function setInfoText(param1: String, param2: String): void {
            (window.findChildByName("info_heading") as ITextWindow).text = param1 || "";
            (window.findChildByName("info_body") as ITextWindow).text = param2 || "";
        }

        private function startItemWiggle(param1: int): void {
        }

        public function get window(): class_3514 {
            return !!var_1828 ? var_1828.rootWindow as class_3514 : null;
        }

        private function getItemIndexAt(param1: int): int {
            return Math.floor((itemList.scrollH * itemList.maxScrollH + param1) / ((itemList.maxScrollH + scrollerWidth) / itemList.numListItems));
        }

        private function calculateCenteredItemScrollH(param1: int): Number {
            return (calculateItemListWidth(param1) - (scrollerWidth - itemWidth) * 0.5) / itemList.maxScrollH;
        }

        public function calculateItemListWidth(param1: int): Number {
            return param1 * itemWidth + Math.max(0, param1 - 1) * itemGap;
        }

        public function get itemList(): IItemListWindow {
            return !!window ? window.findChildByName("calendar_itemlist") as IItemListWindow : null;
        }

        public function get itemWidth(): int {
            return itemList && itemList.numListItems > 0 ? itemList.getListItemAt(0).width : 0;
        }

        public function get itemGap(): int {
            return !!itemList ? itemList.spacing : 0;
        }

        public function get scrollerWidth(): int {
            return window && window.content ? window.content.width : 0;
        }

        private function get calendarData(): class_1641 {
            return var_319.calendarData;
        }
    }
}
