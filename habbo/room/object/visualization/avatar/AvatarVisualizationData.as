package com.sulake.habbo.room.object.visualization.avatar {
    import com.sulake.core.assets.IAsset
    import com.sulake.habbo.avatar.IAvatarRenderManager
    import com.sulake.habbo.avatar.IAvatarImageListener
    import com.sulake.habbo.avatar.class_3374
    import com.sulake.habbo.avatar.class_3375
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData

    public class AvatarVisualizationData implements IRoomObjectVisualizationData {

        public function AvatarVisualizationData() {
            super();
        }

        private var _avatarRenderer: IAvatarRenderManager = null;

        public function get avatarRenderer(): IAvatarRenderManager {
            return _avatarRenderer;
        }

        public function set avatarRenderer(param1: IAvatarRenderManager): void {
            _avatarRenderer = param1;
        }

        public function initialize(param1: XML): Boolean {
            return true;
        }

        public function dispose(): void {
            _avatarRenderer = null;
        }

        public function getAvatar(param1: String, param2: Number, param3: String = null, param4: IAvatarImageListener = null, param5: class_3375 = null): class_3374 {
            var _loc6_: class_3374 = null;
            if (_avatarRenderer != null) {
                _loc6_ = null;
                if (param2 > 48) {
                    _loc6_ = _avatarRenderer.createAvatarImage(param1, "h", param3, param4, param5);
                } else {
                    _loc6_ = _avatarRenderer.createAvatarImage(param1, "h_50", param3, param4, param5);
                }
                return _loc6_;
            }
            return null;
        }

        public function getLayerCount(param1: String): Number {
            return 0;
        }

        public function getAvatarRendererAsset(param1: String): IAsset {
            if (_avatarRenderer == null) {
                return null;
            }
            return _avatarRenderer.assets.getAssetByName(param1);
        }
    }
}
