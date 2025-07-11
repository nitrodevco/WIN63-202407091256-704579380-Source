package com.sulake.habbo.localization {
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.class_79;
   import com.sulake.core.localization.CoreLocalizationManager;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.utils.Map;
   import flash.events.Event;
   import flash.utils.Dictionary;

   public class HabboLocalizationManager extends CoreLocalizationManager implements IHabboLocalizationManager {

      private var isLocalizationInitialized: Boolean;
      private var skipExternals: Boolean;
      private var badgePointLimits: Dictionary;
      private var romanNumerals: Array;

      public function HabboLocalizationManager(context: IContext, flags: uint = 0, assetLibrary: IAssetLibrary = null) {
         badgePointLimits = new Dictionary();
         romanNumerals = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII", "XIII", "XIV", "XV", "XVI", "XVII", "XVIII", "XIX", "XX", "XXI", "XXII", "XXIII", "XXIV", "XXV", "XXVI", "XXVII", "XXVIII", "XXIX", "XXX"];
         skipExternals = (flags & 268435456) > 0;
         super(context, flags, assetLibrary);
      }

      override public function dispose(): void {
         super.dispose();
      }

      override protected function initComponent(): void {
         super.initComponent();
         configureLocalizationLocations();
         if (skipExternals) {
            events.dispatchEvent(new Event("complete"));
         } else {
            context.events.addEventListener("HABBO_CONNECTION_EVENT_AUTHENTICATED", onAuthenticated);
         }
      }

      private function onAuthenticated(event: Event): void {
         requestLocalizationInit();
      }

      public function loadDefaultEmbedLocalizations(language: String, fallback: Boolean = true): Boolean {
         var localizationAssetName: String = "default_localizations_" + language;
         var localizationAsset: IAsset = this.findAssetByName(localizationAssetName);
         if (!localizationAsset && language != "en" && fallback) {
            class_14.log("Could not load default localizations " + localizationAssetName + " : Trying with default_localizations_en...");
            return loadDefaultEmbedLocalizations("en", false);
         }
         var defaultLocalizationAsset: IAsset = this.findAssetByName("default_localizations");
         parseLocalizationData(defaultLocalizationAsset.content as String);
         if (localizationAsset) {
            parseLocalizationData(localizationAsset.content as String);
            return true;
         }
         class_14.log("Could not load " + localizationAssetName);
         return false;
      }

      public function getLocalizationWithParams(key: String, defaultValue: String = "", ...params): String {
         if (params != null && params.length > 0) {
            for (var i: int = 0; i < params.length / 2; i++) {
               registerParameter(key, params[i * 2], params[i * 2 + 1]);
            }
         }
         return this.getLocalization(key, defaultValue);
      }

      public function getLocalizationWithParamMap(key: String, defaultValue: String = "", paramMap: Map = null): String {
         if (paramMap != null) {
            for (var paramKey in paramMap) {
               registerParameter(key, paramKey, paramMap.getValue(paramKey));
            }
         }
         return this.getLocalization(key, defaultValue);
      }

      public function getExternalVariablesUrl(): String {
         return super.getGameDataResources().getExternalVariablesUrl();
      }

      public function getExternalVariablesHash(): String {
         return super.getGameDataResources().getExternalVariablesHash();
      }

      override public function getActiveEnvironmentId(): String {
         return super.getActiveEnvironmentId();
      }

      override public function getLocalization(key: String, defaultValue: String = ""): String {
         var localization: String = super.getLocalization(key, defaultValue);
         return interpolate(localization);
      }

      public function getAchievementName(badgeId: String): String {
         var badgeInfo: BadgeBaseAndLevel = new BadgeBaseAndLevel(badgeId);
         var localizationKey: String = getExistingKey([
            "badge_name_al_" + badgeId,
            "badge_name_al_" + badgeInfo.base,
            "badge_name_" + badgeId,
            "badge_name_" + badgeInfo.base
         ]);
         this.registerParameter(localizationKey, "roman", getRomanNumeral(badgeInfo.level));
         var localization: String = this.getLocalization(localizationKey);
         return localization != null ? localization : "";
      }

      public function getAchievementDesc(badgeId: String, limit: int): String {
         var badgeInfo: BadgeBaseAndLevel = new BadgeBaseAndLevel(badgeId);
         var localizationKey: String = getExistingKey([
            "badge_desc_al_" + badgeId,
            "badge_desc_al_" + badgeInfo.base,
            "badge_desc_" + badgeId,
            "badge_desc_" + badgeInfo.base
         ]);
         this.registerParameter(localizationKey, "limit", "" + limit);
         this.registerParameter(localizationKey, "roman", getRomanNumeral(badgeInfo.level));
         return this.getLocalization(localizationKey);
      }

      public function getAchievementInstruction(badgeId: String): String {
         var badgeInfo: BadgeBaseAndLevel = new BadgeBaseAndLevel(badgeId);
         var localizationKey: String = getExistingKey(["badge_instruction_" + badgeInfo.base]);
         this.registerParameter(localizationKey, "limit", "" + getBadgePointLimit(badgeId));
         var localization: String = this.getLocalization(localizationKey);
         return localization != null ? localization : "";
      }

      public function getBadgeBaseName(badgeId: String): String {
         var badgeInfo: BadgeBaseAndLevel = new BadgeBaseAndLevel(badgeId);
         return badgeInfo.base;
      }

      public function getBadgeName(badgeId: String): String {
         var badgeInfo: BadgeBaseAndLevel = new BadgeBaseAndLevel(badgeId);
         var localizationKey: String = fixBadLocalization(getExistingKey(["badge_name_" + badgeId, "badge_name_" + badgeInfo.base]));
         this.registerParameter(localizationKey, "roman", getRomanNumeral(badgeInfo.level));
         return this.getLocalization(localizationKey);
      }

      public function getBadgeDesc(badgeId: String): String {
         var badgeInfo: BadgeBaseAndLevel = new BadgeBaseAndLevel(badgeId);
         var localizationKey: String = fixBadLocalization(getExistingKey(["badge_desc_" + badgeId, "badge_desc_" + badgeInfo.base]));
         this.registerParameter(localizationKey, "limit", "" + getBadgePointLimit(badgeId));
         this.registerParameter(localizationKey, "roman", getRomanNumeral(badgeInfo.level));
         var localization: String = this.getLocalization(localizationKey);
         return localizationKey == localization ? "" : localization;
      }

      private function fixBadLocalization(localizationKey: String): String {
         var fixedKey: String = localizationKey.replace("${", "$");
         fixedKey = fixedKey.replace("{", "$");
         return fixedKey.replace("}", "$");
      }

      public function getPreviousLevelBadgeId(badgeId: String): String {
         var badgeInfo: BadgeBaseAndLevel = new BadgeBaseAndLevel(badgeId);
         badgeInfo.level--;
         return badgeInfo.badgeId;
      }

      public function setBadgePointLimit(badgeId: String, limit: int): void {
         badgePointLimits[badgeId] = limit;
      }

      private function configureLocalizationLocations(): void {
         var localizationName: String;
         var localizationCode: String;
         var localizationDisplayName: String;
         var localizationUrl: String;
         var index: int = 1;
         while (propertyExists("localization." + index)) {
            localizationName = getProperty("localization." + index);
            localizationCode = getProperty("localization." + index + ".code");
            localizationDisplayName = getProperty("localization." + index + ".name");
            localizationUrl = getProperty("localization." + index + ".url");
            super.registerLocalizationDefinition(localizationName, localizationDisplayName, localizationUrl, localizationCode);
            index++;
         }
      }

      public function requestLocalizationInit(): void {
         if (isLocalizationInitialized) {
            return;
         }
         isLocalizationInitialized = true;
         events.addEventListener("LOCALIZATION_EVENT_LOCALIZATION_LOADED", onLocalizationLoaded);
         events.addEventListener("LOCALIZATION_EVENT_LOCALIZATION_FAILED", onManagerLocalizationFailed);
         super.loadLocalizationFromURL(getProperty("gamedata.hashes.url"), getProperty("environment.id"));
      }

      private function getBadgePointLimit(badgeId: String): int {
         return badgePointLimits[badgeId];
      }

      private function getExistingKey(keys: Array): String {
         var key: String;
         for each (var candidateKey in keys) {
            key = this.getLocalization(candidateKey);
            if (key != "") {
               return candidateKey;
            }
         }
         return keys[0];
      }

      private function getRomanNumeral(level: int): String {
         return romanNumerals[Math.max(0, level - 1)];
      }

      private function onManagerLocalizationFailed(event: Event): void {
         isLocalizationInitialized = false;
         class_79.crash("Failed loading gamedata hashes", 8);
      }

      private function onLocalizationLoaded(event: Event): void {
         isLocalizationInitialized = false;
         events.removeEventListener("LOCALIZATION_EVENT_LOCALIZATION_LOADED", onLocalizationLoaded);
         events.removeEventListener("LOCALIZATION_EVENT_LOCALIZATION_FAILED", onManagerLocalizationFailed);
         localizationsReady();
      }

      private function localizationsReady(): void {
         events.dispatchEvent(new Event("complete"));
      }
   }
}
