package com.sulake.habbo.room.object {
    import com.sulake.core.assets.IAssetLibrary
    import com.sulake.core.runtime.Component
    import com.sulake.core.runtime.ComponentDependency
    import com.sulake.core.runtime.IContext
    import com.sulake.core.utils.Map
    import com.sulake.habbo.avatar.IAvatarRenderManager
    import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualization
    import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualizationData
    import com.sulake.habbo.room.object.visualization.furniture.AnimatedFurnitureVisualization
    import com.sulake.habbo.room.object.visualization.furniture.AnimatedFurnitureVisualizationData
    import com.sulake.habbo.room.object.visualization.furniture.AvatarFurnitureVisualizationData
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureBottleVisualization
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureBuilderPlaceholderVisualization
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureCuboidVisualization
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureExternalImageVisualization
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureFireworksVisualization
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureGiftWrappedFireworksVisualization
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureGiftWrappedVisualization
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureHabboWheelVisualization
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureMannequinVisualization
    import com.sulake.habbo.room.object.visualization.furniture.FurniturePartyBeamerVisualization
    import com.sulake.habbo.room.object.visualization.furniture.FurniturePlanetSystemVisualization
    import com.sulake.habbo.room.object.visualization.furniture.FurniturePosterVisualization
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureQueueTileVisualization
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureRoomBackgroundVisualization
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureRoomBillboardVisualization
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureStickieVisualization
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureValRandomizerVisualization
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureVisualization
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureVisualizationData
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureWaterAreaVisualization
    import com.sulake.habbo.room.object.visualization.furniture.class_3379
    import com.sulake.habbo.room.object.visualization.furniture.class_3390
    import com.sulake.habbo.room.object.visualization.furniture.class_3395
    import com.sulake.habbo.room.object.visualization.furniture.class_3426
    import com.sulake.habbo.room.object.visualization.furniture.class_3449
    import com.sulake.habbo.room.object.visualization.furniture.class_3450
    import com.sulake.habbo.room.object.visualization.furniture.class_3461
    import com.sulake.habbo.room.object.visualization.furniture.class_3470
    import com.sulake.habbo.room.object.visualization.furniture.class_3476
    import com.sulake.habbo.room.object.visualization.furniture.class_3480
    import com.sulake.habbo.room.object.visualization.furniture.class_3496
    import com.sulake.habbo.room.object.visualization.game.SnowSplashVisualization
    import com.sulake.habbo.room.object.visualization.game.SnowballVisualization
    import com.sulake.habbo.room.object.visualization.pet.AnimatedPetVisualization
    import com.sulake.habbo.room.object.visualization.pet.AnimatedPetVisualizationData
    import com.sulake.habbo.room.object.visualization.room.RoomVisualization
    import com.sulake.habbo.room.object.visualization.room.RoomVisualizationData
    import com.sulake.habbo.room.object.visualization.room.TileCursorVisualization
    import com.sulake.iid.*
    import com.sulake.room.object.IRoomObjectVisualizationFactory
    import com.sulake.room.object.visualization.IRoomObjectGraphicVisualization
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData
    import com.sulake.room.object.visualization.utils.GraphicAssetCollection
    import com.sulake.room.object.visualization.utils.class_3367

    public class RoomObjectVisualizationFactory extends Component implements IRoomObjectVisualizationFactory {

        public function RoomObjectVisualizationFactory(param1: IContext, param2: uint = 0, param3: IAssetLibrary = null) {
            super(param1, param2, param3);
            var_4262 = param2 == 0;
            var_2519 = new Map();
        }
        private var _habboAvatar: IAvatarRenderManager = null;
        private var var_2519: Map;
        private var var_4262: Boolean = true;

        override protected function get dependencies(): Vector.<ComponentDependency> {
            return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDAvatarRenderManager(), function (param1: IAvatarRenderManager): void {
                _habboAvatar = param1;
            }, false)]);
        }

        override public function dispose(): void {
            var _loc1_: IRoomObjectVisualizationData = null;
            var _loc2_: int = 0;
            if (disposed) {
                return;
            }
            if (var_2519 != null) {
                _loc1_ = null;
                _loc2_ = 0;
                while (_loc2_ < var_2519.length) {
                    _loc1_ = var_2519.getWithIndex(_loc2_) as IRoomObjectVisualizationData;
                    if (_loc1_ != null) {
                        _loc1_.dispose();
                    }
                    _loc2_++;
                }
                var_2519.dispose();
                var_2519 = null;
            }
            super.dispose();
        }

        public function createRoomObjectVisualization(param1: String): IRoomObjectGraphicVisualization {
            var _loc3_: Class = null;
            switch (param1) {
                case "room":
                    _loc3_ = RoomVisualization;
                    break;
                case "tile_cursor":
                    _loc3_ = TileCursorVisualization;
                    break;
                case "user":
                    _loc3_ = AvatarVisualization;
                    break;
                case "bot":
                case "rentable_bot":
                    _loc3_ = AvatarVisualization;
                    break;
                case "pet_animated":
                    _loc3_ = AnimatedPetVisualization;
                    break;
                case "furniture_static":
                    _loc3_ = FurnitureVisualization;
                    break;
                case "furniture_animated":
                    _loc3_ = AnimatedFurnitureVisualization;
                    break;
                case "furniture_resetting_animated":
                    _loc3_ = class_3450;
                    break;
                case "furniture_poster":
                    _loc3_ = FurniturePosterVisualization;
                    break;
                case "furniture_habbowheel":
                    _loc3_ = FurnitureHabboWheelVisualization;
                    break;
                case "furniture_val_randomizer":
                    _loc3_ = FurnitureValRandomizerVisualization;
                    break;
                case "furniture_bottle":
                    _loc3_ = FurnitureBottleVisualization;
                    break;
                case "furniture_planet_system":
                    _loc3_ = FurniturePlanetSystemVisualization;
                    break;
                case "furniture_queue_tile":
                    _loc3_ = FurnitureQueueTileVisualization;
                    break;
                case "furniture_party_beamer":
                    _loc3_ = FurniturePartyBeamerVisualization;
                    break;
                case "furniture_cuboid":
                    _loc3_ = FurnitureCuboidVisualization;
                    break;
                case "furniture_gift_wrapped":
                    _loc3_ = FurnitureGiftWrappedVisualization;
                    break;
                case "furniture_counter_clock":
                    _loc3_ = class_3476;
                    break;
                case "furniture_water_area":
                    _loc3_ = FurnitureWaterAreaVisualization;
                    break;
                case "furniture_score_board":
                    _loc3_ = class_3449;
                    break;
                case "furniture_fireworks":
                    _loc3_ = FurnitureFireworksVisualization;
                    break;
                case "furniture_gift_wrapped_fireworks":
                    _loc3_ = FurnitureGiftWrappedFireworksVisualization;
                    break;
                case "furniture_bb":
                    _loc3_ = FurnitureRoomBillboardVisualization;
                    break;
                case "furniture_bg":
                    _loc3_ = FurnitureRoomBackgroundVisualization;
                    break;
                case "furniture_stickie":
                    _loc3_ = FurnitureStickieVisualization;
                    break;
                case "furniture_mannequin":
                    _loc3_ = FurnitureMannequinVisualization;
                    break;
                case "furniture_guild_customized":
                    _loc3_ = class_3461;
                    break;
                case "furniture_guild_isometric_badge":
                    _loc3_ = class_3390;
                    break;
                case "game_snowball":
                    _loc3_ = SnowballVisualization;
                    break;
                case "game_snowsplash":
                    _loc3_ = SnowSplashVisualization;
                    break;
                case "furniture_vote_counter":
                    _loc3_ = class_3470;
                    break;
                case "furniture_vote_majority":
                    _loc3_ = class_3426;
                    break;
                case "furniture_soundblock":
                    _loc3_ = class_3379;
                    break;
                case "furniture_badge_display":
                    _loc3_ = class_3395;
                    break;
                case "furniture_youtube":
                    _loc3_ = class_3496;
                    break;
                case "furniture_external_image":
                    _loc3_ = FurnitureExternalImageVisualization;
                    break;
                case "furniture_builder_placeholder":
                    _loc3_ = FurnitureBuilderPlaceholderVisualization;
            }
            if (_loc3_ == null) {
                return null;
            }
            var _loc2_: Object = new _loc3_();
            if (_loc2_ is IRoomObjectGraphicVisualization) {
                return _loc2_ as IRoomObjectGraphicVisualization;
            }
            return null;
        }

        public function getRoomObjectVisualizationData(param1: String, param2: String, param3: XML): IRoomObjectVisualizationData {
            var _loc7_: IRoomObjectVisualizationData = null;
            var _loc6_: AvatarVisualizationData = null;
            var _loc5_: AnimatedPetVisualizationData = null;
            var _loc9_: AvatarFurnitureVisualizationData = null;
            var _loc4_: IRoomObjectVisualizationData = null;
            if ((_loc4_ = var_2519.getValue(param1) as IRoomObjectVisualizationData) != null) {
                return _loc4_;
            }
            var _loc8_: Class = null;
            switch (param2) {
                case "furniture_static":
                case "furniture_gift_wrapped":
                case "furniture_bb":
                case "furniture_bg":
                case "furniture_stickie":
                case "furniture_builder_placeholder":
                    _loc8_ = FurnitureVisualizationData;
                    break;
                case "furniture_animated":
                case "furniture_resetting_animated":
                case "furniture_poster":
                case "furniture_habbowheel":
                case "furniture_val_randomizer":
                case "furniture_bottle":
                case "furniture_planet_system":
                case "furniture_queue_tile":
                case "furniture_party_beamer":
                case "furniture_counter_clock":
                case "furniture_water_area":
                case "furniture_score_board":
                case "furniture_fireworks":
                case "furniture_gift_wrapped_fireworks":
                case "furniture_guild_customized":
                case "furniture_guild_isometric_badge":
                case "furniture_vote_counter":
                case "furniture_vote_majority":
                case "furniture_soundblock":
                case "furniture_badge_display":
                case "furniture_external_image":
                case "furniture_youtube":
                case "tile_cursor":
                    _loc8_ = AnimatedFurnitureVisualizationData;
                    break;
                case "furniture_mannequin":
                    _loc8_ = AvatarFurnitureVisualizationData;
                    break;
                case "room":
                    _loc8_ = RoomVisualizationData;
                    break;
                case "user":
                case "bot":
                case "rentable_bot":
                    _loc8_ = AvatarVisualizationData;
                    break;
                case "pet_animated":
                    _loc8_ = AnimatedPetVisualizationData;
                    break;
                case "game_snowball":
                case "game_snowsplash":
                    _loc8_ = class_3480;
            }
            if (_loc8_ == null) {
                return null;
            }
            if ((_loc4_ = new _loc8_()) != null) {
                _loc7_ = null;
                if (!(_loc7_ = _loc4_ as IRoomObjectVisualizationData).initialize(param3)) {
                    _loc7_.dispose();
                    return null;
                }
                if (_loc7_ is AvatarVisualizationData) {
                    (_loc6_ = _loc4_ as AvatarVisualizationData).avatarRenderer = _habboAvatar;
                } else if (_loc7_ is AnimatedPetVisualizationData) {
                    (_loc5_ = _loc4_ as AnimatedPetVisualizationData).commonAssets = assets;
                } else if (_loc7_ is AvatarFurnitureVisualizationData) {
                    (_loc9_ = _loc4_ as AvatarFurnitureVisualizationData).avatarRenderer = _habboAvatar;
                } else if (_loc7_ is class_3480) {
                    class_3480(_loc7_).assets = assets;
                }
                if (var_4262) {
                    var_2519.add(param1, _loc7_);
                }
                return _loc7_;
            }
            return null;
        }

        public function createGraphicAssetCollection(): class_3367 {
            return new GraphicAssetCollection();
        }
    }
}
