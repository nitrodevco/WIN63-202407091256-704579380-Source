package com.sulake.habbo.room {
    import com.sulake.core.runtime.Component
    import com.sulake.core.runtime.IContext
    import com.sulake.core.utils.Map
    import com.sulake.habbo.room.object.logic.AvatarLogic
    import com.sulake.habbo.room.object.logic.PetLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureAreaHideLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureClothingChangeLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureCreditLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureCuckooClockLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureDiceLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureEcotronBoxLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureEditableInternalLinkLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureEditableRoomLinkLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureExternalImageLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureFireworksLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureGuildCustomizedLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureHabboWheelLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureHockeyScoreLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureJukeboxLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureMannequinLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureMultiHeightLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureMultiStateLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureMysteryTrophyLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureOneWayDoorLogic
    import com.sulake.habbo.room.object.logic.furniture.FurniturePetProductLogic
    import com.sulake.habbo.room.object.logic.furniture.FurniturePlaceholderLogic
    import com.sulake.habbo.room.object.logic.furniture.FurniturePlanetSystemLogic
    import com.sulake.habbo.room.object.logic.furniture.FurniturePresentLogic
    import com.sulake.habbo.room.object.logic.furniture.FurniturePushableLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureRandomStateLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureRoomBackgroundLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureRoomBillboardLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureRoomDimmerLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureSongDiskLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureSoundMachineLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureStickieLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureTrophyLogic
    import com.sulake.habbo.room.object.logic.furniture.FurnitureWelcomeGiftLogic
    import com.sulake.habbo.room.object.logic.furniture.class_3382
    import com.sulake.habbo.room.object.logic.furniture.class_3391
    import com.sulake.habbo.room.object.logic.furniture.class_3392
    import com.sulake.habbo.room.object.logic.furniture.class_3399
    import com.sulake.habbo.room.object.logic.furniture.class_3406
    import com.sulake.habbo.room.object.logic.furniture.class_3407
    import com.sulake.habbo.room.object.logic.furniture.class_3408
    import com.sulake.habbo.room.object.logic.furniture.class_3416
    import com.sulake.habbo.room.object.logic.furniture.class_3432
    import com.sulake.habbo.room.object.logic.furniture.class_3434
    import com.sulake.habbo.room.object.logic.furniture.class_3435
    import com.sulake.habbo.room.object.logic.furniture.class_3436
    import com.sulake.habbo.room.object.logic.furniture.class_3444
    import com.sulake.habbo.room.object.logic.furniture.class_3451
    import com.sulake.habbo.room.object.logic.furniture.class_3454
    import com.sulake.habbo.room.object.logic.furniture.class_3457
    import com.sulake.habbo.room.object.logic.furniture.class_3462
    import com.sulake.habbo.room.object.logic.furniture.class_3464
    import com.sulake.habbo.room.object.logic.furniture.class_3465
    import com.sulake.habbo.room.object.logic.furniture.class_3469
    import com.sulake.habbo.room.object.logic.furniture.class_3475
    import com.sulake.habbo.room.object.logic.furniture.class_3485
    import com.sulake.habbo.room.object.logic.furniture.class_3486
    import com.sulake.habbo.room.object.logic.furniture.class_3497
    import com.sulake.habbo.room.object.logic.furniture.class_3504
    import com.sulake.habbo.room.object.logic.furniture.class_3506
    import com.sulake.habbo.room.object.logic.furniture.class_3509
    import com.sulake.habbo.room.object.logic.furniture.class_3512
    import com.sulake.habbo.room.object.logic.furniture.class_3516
    import com.sulake.habbo.room.object.logic.game.SnowballLogic
    import com.sulake.habbo.room.object.logic.game.class_3396
    import com.sulake.habbo.room.object.logic.room.RoomLogic
    import com.sulake.habbo.room.object.logic.room.RoomTileCursorLogic
    import com.sulake.habbo.room.object.logic.room.SelectionArrowLogic
    import com.sulake.room.IRoomObjectFactory
    import com.sulake.room.IRoomObjectManager
    import com.sulake.room.RoomObjectManager
    import com.sulake.room.object.logic.IRoomObjectEventHandler

    public class RoomObjectFactory extends Component implements IRoomObjectFactory {

        public function RoomObjectFactory(param1: IContext, param2: uint = 0) {
            super(param1, param2);
            var_3973 = new Map();
            var_3570 = new Map();
            _objectEventListeners = [];
        }

        private var var_3973: Map;
        private var var_3570: Map;
        private var _objectEventListeners: Array;

        public function addObjectEventListener(param1: Function): void {
            var _loc2_: * = null;
            if (_objectEventListeners.indexOf(param1) < 0) {
                _objectEventListeners.push(param1);
                if (param1 != null) {
                    for each(_loc2_ in var_3570.getKeys()) {
                        events.addEventListener(_loc2_, param1);
                    }
                }
            }
        }

        public function removeObjectEventListener(param1: Function): void {
            var _loc3_: * = null;
            var _loc2_: int = _objectEventListeners.indexOf(param1);
            if (_loc2_ >= 0) {
                _objectEventListeners.splice(_loc2_, 1);
                if (param1 != null) {
                    for each(_loc3_ in var_3570.getKeys()) {
                        events.removeEventListener(_loc3_, param1);
                    }
                }
            }
        }

        public function createRoomObjectLogic(param1: String): IRoomObjectEventHandler {
            var _loc6_: IRoomObjectEventHandler = null;
            var _loc2_: Array = null;
            var _loc3_: Class = null;
            switch (param1) {
                case "furniture_basic":
                    _loc3_ = FurnitureLogic;
                    break;
                case "furniture_multistate":
                    _loc3_ = FurnitureMultiStateLogic;
                    break;
                case "furniture_multiheight":
                    _loc3_ = FurnitureMultiHeightLogic;
                    break;
                case "furniture_placeholder":
                    _loc3_ = FurniturePlaceholderLogic;
                    break;
                case "user":
                case "bot":
                case "rentable_bot":
                    _loc3_ = AvatarLogic;
                    break;
                case "pet":
                    _loc3_ = PetLogic;
                    break;
                case "furniture_randomstate":
                    _loc3_ = FurnitureRandomStateLogic;
                    break;
                case "furniture_credit":
                    _loc3_ = FurnitureCreditLogic;
                    break;
                case "furniture_stickie":
                    _loc3_ = FurnitureStickieLogic;
                    break;
                case "furniture_external_image_wallitem":
                    _loc3_ = FurnitureExternalImageLogic;
                    break;
                case "furniture_present":
                    _loc3_ = FurniturePresentLogic;
                    break;
                case "furniture_trophy":
                    _loc3_ = FurnitureTrophyLogic;
                    break;
                case "furniture_ecotron_box":
                    _loc3_ = FurnitureEcotronBoxLogic;
                    break;
                case "furniture_dice":
                    _loc3_ = FurnitureDiceLogic;
                    break;
                case "furniture_hockey_score":
                    _loc3_ = FurnitureHockeyScoreLogic;
                    break;
                case "furniture_habbowheel":
                    _loc3_ = FurnitureHabboWheelLogic;
                    break;
                case "furniture_one_way_door":
                    _loc3_ = FurnitureOneWayDoorLogic;
                    break;
                case "furniture_planet_system":
                    _loc3_ = FurniturePlanetSystemLogic;
                    break;
                case "furniture_window":
                    _loc3_ = class_3435;
                    break;
                case "furniture_roomdimmer":
                    _loc3_ = FurnitureRoomDimmerLogic;
                    break;
                case "tile_cursor":
                    _loc3_ = RoomTileCursorLogic;
                    break;
                case "selection_arrow":
                    _loc3_ = SelectionArrowLogic;
                    break;
                case "furniture_sound_machine":
                    _loc3_ = FurnitureSoundMachineLogic;
                    break;
                case "furniture_jukebox":
                    _loc3_ = FurnitureJukeboxLogic;
                    break;
                case "furniture_crackable":
                    _loc3_ = class_3399;
                    break;
                case "furniture_song_disk":
                    _loc3_ = FurnitureSongDiskLogic;
                    break;
                case "furniture_pushable":
                    _loc3_ = FurniturePushableLogic;
                    break;
                case "furniture_clothing_change":
                    _loc3_ = FurnitureClothingChangeLogic;
                    break;
                case "furniture_counter_clock":
                    _loc3_ = class_3497;
                    break;
                case "furniture_score":
                    _loc3_ = class_3509;
                    break;
                case "furniture_es":
                    _loc3_ = class_3475;
                    break;
                case "furniture_fireworks":
                    _loc3_ = FurnitureFireworksLogic;
                    break;
                case "furniture_bb":
                    _loc3_ = FurnitureRoomBillboardLogic;
                    break;
                case "furniture_bg":
                    _loc3_ = FurnitureRoomBackgroundLogic;
                    break;
                case "furniture_welcome_gift":
                    _loc3_ = FurnitureWelcomeGiftLogic;
                    break;
                case "furniture_floor_hole":
                    _loc3_ = class_3485;
                    break;
                case "room":
                    _loc3_ = RoomLogic;
                    break;
                case "furniture_mannequin":
                    _loc3_ = FurnitureMannequinLogic;
                    break;
                case "furniture_guild_customized":
                    _loc3_ = FurnitureGuildCustomizedLogic;
                    break;
                case "furniture_group_forum_terminal":
                    _loc3_ = class_3406;
                    break;
                case "furniture_pet_customization":
                    _loc3_ = FurniturePetProductLogic;
                    break;
                case "game_snowball":
                    _loc3_ = SnowballLogic;
                    break;
                case "game_snowsplash":
                    _loc3_ = class_3396;
                    break;
                case "furniture_cuckoo_clock":
                    _loc3_ = FurnitureCuckooClockLogic;
                    break;
                case "furniture_vote_counter":
                    _loc3_ = class_3486;
                    break;
                case "furniture_vote_majority":
                    _loc3_ = class_3465;
                    break;
                case "furniture_soundblock":
                    _loc3_ = class_3451;
                    break;
                case "furniture_random_teleport":
                    _loc3_ = class_3454;
                    break;
                case "furniture_monsterplant_seed":
                    _loc3_ = class_3436;
                    break;
                case "furniture_purchasable_clothing":
                    _loc3_ = class_3382;
                    break;
                case "furniture_background_color":
                    _loc3_ = class_3457;
                    break;
                case "furniture_area_hide":
                    _loc3_ = FurnitureAreaHideLogic;
                    break;
                case "furniture_mysterybox":
                    _loc3_ = class_3392;
                    break;
                case "furniture_effectbox":
                    _loc3_ = class_3391;
                    break;
                case "furniture_mysterytrophy":
                    _loc3_ = FurnitureMysteryTrophyLogic;
                    break;
                case "furniture_achievement_resolution":
                    _loc3_ = class_3408;
                    break;
                case "furniture_lovelock":
                    _loc3_ = class_3464;
                    break;
                case "furniture_wildwest_wanted":
                    _loc3_ = class_3416;
                    break;
                case "furniture_hween_lovelock":
                    _loc3_ = class_3516;
                    break;
                case "furniture_badge_display":
                    _loc3_ = class_3407;
                    break;
                case "furniture_high_score":
                    _loc3_ = class_3432;
                    break;
                case "furniture_internal_link":
                    _loc3_ = class_3444;
                    break;
                case "furniture_editable_internal_link":
                    _loc3_ = FurnitureEditableInternalLinkLogic;
                    break;
                case "furniture_editable_room_link":
                    _loc3_ = FurnitureEditableRoomLinkLogic;
                    break;
                case "furniture_custom_stack_height":
                    _loc3_ = class_3434;
                    break;
                case "furniture_youtube":
                    _loc3_ = class_3512;
                    break;
                case "furniture_rentable_space":
                    _loc3_ = class_3506;
                    break;
                case "furniture_change_state_when_step_on":
                    _loc3_ = class_3504;
                    break;
                case "furniture_vimeo":
                    _loc3_ = class_3462;
                    break;
                case "furniture_crafting_gizmo":
                    _loc3_ = class_3469;
            }
            if (_loc3_ == null) {
                return null;
            }
            var _loc4_: Object;
            if ((_loc4_ = new _loc3_()) is IRoomObjectEventHandler) {
                (_loc6_ = _loc4_ as IRoomObjectEventHandler).eventDispatcher = this.events;
                if (var_3973.getValue(param1) == null) {
                    var_3973.add(param1, true);
                    _loc2_ = _loc6_.getEventTypes();
                    for each(var _loc5_ in _loc2_) {
                        addTrackedEventType(_loc5_);
                    }
                }
                return _loc6_;
            }
            return null;
        }

        public function createRoomObjectManager(): IRoomObjectManager {
            return new RoomObjectManager();
        }

        private function addTrackedEventType(param1: String): void {
            if (var_3570.getValue(param1) == null) {
                var_3570.add(param1, true);
                for each(var _loc2_ in _objectEventListeners) {
                    if (_loc2_ != null) {
                        events.addEventListener(param1, _loc2_);
                    }
                }
            }
        }
    }
}
