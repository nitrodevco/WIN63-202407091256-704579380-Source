package com.sulake.habbo.room.object.visualization.furniture {
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData

    public class FurnitureStickieVisualization extends FurnitureVisualization {

        public function FurnitureStickieVisualization() {
            super();
        }
        private var var_47: FurnitureVisualizationData = null;

        override public function initialize(param1: IRoomObjectVisualizationData): Boolean {
            var_47 = param1 as FurnitureVisualizationData;
            return super.initialize(param1);
        }

        override protected function getSpriteColor(param1: int, param2: int, param3: int): int {
            if (var_47 == null) {
                return 16777215;
            }
            return var_47.getColor(param1, param2, param3);
        }
    }
}
