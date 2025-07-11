package com.sulake.habbo.friendbar.talent
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   import com.sulake.habbo.communication.messages.parser.talent.class_1158;
   import com.sulake.habbo.communication.messages.parser.talent.class_1700;
   import com.sulake.habbo.communication.messages.parser.talent.class_1756;
   import com.sulake.habbo.communication.messages.outgoing.talent.class_1018;
   import com.sulake.habbo.communication.messages.incoming.talent.class_381;
   
   public class TalentLevelUpController implements IDisposable
   {
       
      
      private var _habboTalent:HabboTalent;
      
      private var _disposed:Boolean;
      
      private var _window:IWindowContainer;
      
      private var var_3966:String;
      
      private var var_3080:IWindow;
      
      private var var_3026:IWindow;
      
      private var var_3239:IWindow;
      
      public function TalentLevelUpController(param1:HabboTalent)
      {
         super();
         _habboTalent = param1;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_3239 != null)
            {
               var_3239.dispose();
               var_3239 = null;
            }
            if(var_3080 != null)
            {
               var_3080.dispose();
               var_3080 = null;
            }
            if(var_3026 != null)
            {
               var_3026.dispose();
               var_3026 = null;
            }
            closeWindow();
            _habboTalent = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function initialize() : void
      {
         _habboTalent.communicationManager.addHabboConnectionMessageEvent(new class_381(onTalentLevelUp));
      }
      
      private function onTalentLevelUp(param1:class_381) : void
      {
         var _loc2_:class_1158 = param1.getParser();
         if(_loc2_.level == 1 && _loc2_.talentTrackName == "helper" && _habboTalent.citizenshipEnabled)
         {
            return;
         }
         showWindow(_loc2_.talentTrackName,_loc2_.level,_loc2_.rewardPerks,_loc2_.rewardProducts);
      }
      
      public function showWindow(param1:String, param2:int, param3:Vector.<class_1756>, param4:Vector.<class_1700>) : void
      {
         closeWindow();
         var_3966 = param1;
         _window = _habboTalent.getXmlWindow("level_up") as IWindowContainer;
         _window.center();
         _window.procedure = onWindowEvent;
         IStaticBitmapWrapperWindow(_window.findChildByName("level_decoration")).assetUri = "${image.library.url}talent/" + param1 + "_levelup_" + param2 + ".png";
         _window.findChildByName("level_up_message").caption = "${talent.track." + param1 + ".levelup.message}";
         _window.findChildByName("level_title").caption = "${talent.track." + param1 + ".level." + param2 + ".title}";
         _window.findChildByName("level_description").caption = "${talent.track." + param1 + ".level." + param2 + ".description}";
         var _loc8_:IItemListWindow = IItemListWindow(_window.findChildByName("reward_list"));
         var _loc6_:IWindow = _loc8_.removeListItem(_loc8_.getListItemByName("plus_template"));
         var_3080 = _loc8_.removeListItem(_loc8_.getListItemByName("reward_product_template"));
         var_3026 = _loc8_.removeListItem(_loc8_.getListItemByName("reward_vip_template"));
         var_3239 = _loc8_.removeListItem(_loc8_.getListItemByName("reward_perk_template"));
         var _loc7_:Boolean = false;
         for each(var _loc5_ in param3)
         {
            if(_loc7_)
            {
               _loc8_.addListItem(_loc6_.clone());
            }
            _loc8_.addListItem(createRewardPerk(_loc5_));
            _loc7_ = true;
         }
         for each(var _loc9_ in param4)
         {
            if(_loc7_)
            {
               _loc8_.addListItem(_loc6_.clone());
            }
            _loc8_.addListItem(createRewardProduct(_loc9_));
            _loc7_ = true;
         }
         if(_loc8_.numListItems < 1)
         {
            _window.findChildByName("level_rewards").visible = false;
            IItemListWindow(_window.findChildByName("level_up_layout")).arrangeListItems();
         }
      }
      
      private function createRewardPerk(param1:class_1756) : IWindow
      {
         var _loc2_:IWindowContainer = var_3239.clone() as IWindowContainer;
         IBadgeImageWidget(IWidgetWindow(_loc2_.findChildByName("perk_image")).widget).badgeId = param1.perkId;
         _loc2_.findChildByName("perk_name").caption = "${perk." + param1.perkId + ".name}";
         return _loc2_;
      }
      
      private function createRewardProduct(param1:class_1700) : IWindow
      {
         var _loc2_:IWindow = null;
         if(param1.vipDays == 0)
         {
            _loc2_ = var_3080.clone();
            IStaticBitmapWrapperWindow(_loc2_).assetUri = "${image.library.url}talent/reward_product_" + param1.productCode.toLowerCase().replace(" ","_") + ".png";
         }
         else
         {
            _loc2_ = var_3026.clone();
            IWindowContainer(_loc2_).findChildByName("vip_length").caption = _habboTalent.localizationManager.getLocalizationWithParams("catalog.vip.item.header.days","","num_days",param1.vipDays);
         }
         return _loc2_;
      }
      
      private function closeWindow() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function onWindowEvent(param1:WindowEvent, param2:IWindow) : void
      {
         if(_window == null || Boolean(_window.disposed) || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "header_button_close":
            case "close_button":
               closeWindow();
               break;
            case "talent_button":
               closeWindow();
               _habboTalent.tracking.trackTalentTrackOpen(var_3966,"levelup");
               _habboTalent.send(new class_1018(var_3966));
         }
      }
   }
}
