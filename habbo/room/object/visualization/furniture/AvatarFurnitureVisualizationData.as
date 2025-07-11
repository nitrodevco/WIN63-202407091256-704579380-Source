package com.sulake.habbo.room.object.visualization.furniture {
    import com.sulake.habbo.avatar.IAvatarRenderManager
    import com.sulake.habbo.avatar.IAvatarImageListener
    import com.sulake.habbo.avatar.class_3374
    import com.sulake.habbo.avatar.class_3375
    import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualizationData

    public class AvatarFurnitureVisualizationData extends FurnitureVisualizationData {

        public function AvatarFurnitureVisualizationData() {
            super();
            var_3221 = new AvatarVisualizationData();
        }
        private var var_3221: AvatarVisualizationData;

        public function set avatarRenderer(param1: IAvatarRenderManager): void {
            var_3221.avatarRenderer = param1;
        }

        override public function dispose(): void {
            super.dispose();
            var_3221.dispose();
            var_3221 = null;
        }

        public function getAvatar(param1: String, param2: Number, param3: String = null, param4: IAvatarImageListener = null, param5: class_3375 = null): class_3374 {
            return var_3221.getAvatar(param1, param2, param3, param4, param5);
        }
    }
}
