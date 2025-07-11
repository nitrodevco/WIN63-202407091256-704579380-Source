package com.sulake.habbo.ui.widget.furniture.dimmer {
    import com.sulake.core.assets.BitmapDataAsset
    import com.sulake.core.assets.IAssetLibrary
    import com.sulake.core.assets.XmlAsset
    import com.sulake.core.window.IWindow
    import com.sulake.core.window.IWindowContainer
    import com.sulake.core.window.components.IBitmapWrapperWindow
    import com.sulake.core.window.components.IItemGridWindow
    import com.sulake.core.window.events.WindowMouseEvent
    import com.sulake.habbo.window.IHabboWindowManager

    import flash.display.BitmapData
    import flash.geom.ColorTransform
    import flash.geom.Point

    public class DimmerViewColorGrid {

        private var var_2317: IItemGridWindow;

        private var var_1631: DimmerView;

        private var _colorCellXML: XML;

        private var _colorCellFrame: BitmapData;

        private var var_3195: BitmapData;

        private var var_2753: BitmapData;

        private var var_2003: IWindowContainer;

        public function DimmerViewColorGrid(param1: DimmerView, param2: IItemGridWindow, param3: IHabboWindowManager, param4: IAssetLibrary) {
            super();
            var_1631 = param1;
            var_2317 = param2;
            storeAssets(param4);
            populate(param3);
        }

        public function dispose(): void {
            var_1631 = null;
            var_2317 = null;
            _colorCellXML = null;
            _colorCellFrame = null;
            var_3195 = null;
            var_2753 = null;
        }

        public function setSelectedColorIndex(param1: int): void {
            if (var_2317 == null) {
                return;
            }
            if (param1 < 0 || param1 >= var_2317.numGridItems) {
                return;
            }
            select(var_2317.getGridItemAt(param1) as IWindowContainer);
        }

        private function populate(param1: IHabboWindowManager): void {
            if (var_1631 == null || var_2317 == null) {
                return;
            }
            populateColourGrid(param1);
        }

        private function select(param1: IWindowContainer): void {
            var _loc2_: IWindow = null;
            if (var_2003 != null) {
                _loc2_ = var_2003.getChildByName("chosen");
                if (_loc2_ != null) {
                    _loc2_.visible = false;
                }
            }
            var_2003 = param1;
            _loc2_ = var_2003.getChildByName("chosen");
            if (_loc2_ != null) {
                _loc2_.visible = true;
            }
        }

        private function populateColourGrid(param1: IHabboWindowManager): void {
            var _loc4_: IWindowContainer = null;
            var _loc8_: IBitmapWrapperWindow = null;
            var _loc14_: IBitmapWrapperWindow = null;
            var _loc11_: * = 0;
            var _loc3_: * = 0;
            var _loc2_: * = 0;
            var _loc7_: Number = NaN;
            var _loc12_: Number = NaN;
            var _loc5_: Number = NaN;
            var _loc13_: ColorTransform = null;
            var _loc6_: BitmapData = null;
            var _loc9_: IBitmapWrapperWindow = null;
            var_2317.destroyGridItems();
            var_2003 = null;
            for each(var _loc10_ in colors) {
                (_loc4_ = param1.buildFromXML(_colorCellXML) as IWindowContainer).addEventListener("WME_CLICK", onClick);
                _loc4_.background = true;
                _loc4_.color = 4294967295;
                _loc4_.width = _colorCellFrame.width;
                _loc4_.height = _colorCellFrame.height;
                var_2317.addGridItem(_loc4_);
                if ((_loc8_ = _loc4_.findChildByTag("BG_BORDER") as IBitmapWrapperWindow) != null) {
                    _loc8_.bitmap = new BitmapData(_colorCellFrame.width, _colorCellFrame.height, true, 0);
                    _loc8_.bitmap.copyPixels(_colorCellFrame, _colorCellFrame.rect, new Point(0, 0));
                }
                if ((_loc14_ = _loc4_.findChildByTag("COLOR_IMAGE") as IBitmapWrapperWindow) != null) {
                    _loc14_.bitmap = new BitmapData(var_3195.width, var_3195.height, true, 0);
                    _loc11_ = uint(_loc10_ >> 16 & 255);
                    _loc3_ = uint(_loc10_ >> 8 & 255);
                    _loc2_ = uint(_loc10_ >> 0 & 255);
                    _loc7_ = _loc11_ / 255 * 1;
                    _loc12_ = _loc3_ / 255 * 1;
                    _loc5_ = _loc2_ / 255 * 1;
                    _loc13_ = new ColorTransform(_loc7_, _loc12_, _loc5_);
                    _loc6_ = var_3195.clone();
                    _loc6_.colorTransform(_loc6_.rect, _loc13_);
                    _loc14_.bitmap.copyPixels(_loc6_, _loc6_.rect, new Point(0, 0));
                }
                if ((_loc9_ = _loc4_.findChildByTag("COLOR_CHOSEN") as IBitmapWrapperWindow) != null) {
                    _loc9_.bitmap = new BitmapData(var_2753.width, var_2753.height, true, 16777215);
                    _loc9_.bitmap.copyPixels(var_2753, var_2753.rect, new Point(0, 0), null, null, true);
                    _loc9_.visible = false;
                }
            }
        }

        private function onClick(param1: WindowMouseEvent): void {
            var _loc2_: int = var_2317.getGridItemIndex(param1.target as IWindow);
            setSelectedColorIndex(_loc2_);
            var_1631.selectedColorIndex = _loc2_;
        }

        private function storeAssets(param1: IAssetLibrary): void {
            var _loc2_: XmlAsset = null;
            var _loc3_: BitmapDataAsset = null;
            if (param1 == null) {
                return;
            }
            _loc2_ = XmlAsset(param1.getAssetByName("dimmer_color_chooser_cell"));
            _colorCellXML = XML(_loc2_.content);
            _loc3_ = BitmapDataAsset(param1.getAssetByName("dimmer_color_frame"));
            _colorCellFrame = BitmapData(_loc3_.content);
            _loc3_ = BitmapDataAsset(param1.getAssetByName("dimmer_color_button"));
            var_3195 = BitmapData(_loc3_.content);
            _loc3_ = BitmapDataAsset(param1.getAssetByName("dimmer_color_selected"));
            var_2753 = BitmapData(_loc3_.content);
        }

        private function get colors(): Array {
            if (var_1631 == null) {
                return [];
            }
            return var_1631.colors;
        }
    }
}
