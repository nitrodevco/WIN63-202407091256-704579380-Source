package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPetCommandMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class PetCommandTool
   {
      
      private static const DEFAULT_LOCATION:Point = new Point(100,70);
      
      private static const STATUS_BAR_WIDTH:int = 162;
      
      private static const STATUS_BAR_HEIGHT:int = 16;
      
      private static const STATUS_BAR_HIGHLIGHT_HEIGHT:int = 4;
      
      private static const STATUS_BAR_BORDER_COLOR:uint = 14342874;
      
      private static const STATUS_BAR_BG_COLOR:uint = 3815994;
      
      private static const STATUS_BAR_SKILL_HIGHLIGHT_COLOR:uint = 10513106;
      
      private static const STATUS_BAR_SKILL_CONTENT_COLOR:uint = 8734654;
      
      private static const STATE_SKILL:String = "skill";
      
      private static const PET_TYPE_HORSE:int = 15;
       
      
      private var var_1629:InfoStandWidget;
      
      private var var_1665:class_3514;
      
      private var var_4834:IWindow;
      
      private var var_269:Map;
      
      private var var_2714:int;
      
      private var _currentPetName:String;
      
      private var var_2228:Timer;
      
      private const BUTTONS_DISABLED_MS:int = 1100;
      
      public function PetCommandTool(param1:InfoStandWidget)
      {
         super();
         var_1629 = param1;
         var_269 = new Map();
         var_2228 = new Timer(1100);
         var_2228.addEventListener("timer",onButtonDisableTimeout);
      }
      
      public static function hideChildren(param1:IWindowContainer) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            param1.getChildAt(_loc2_).visible = false;
            _loc2_++;
         }
      }
      
      public static function getLowestPoint(param1:IWindowContainer) : int
      {
         var _loc2_:int = 0;
         var _loc4_:IWindow = null;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            if((_loc4_ = param1.getChildAt(_loc2_)).visible)
            {
               _loc3_ = Math.max(_loc3_,_loc4_.y + _loc4_.height);
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      private static function createPercentageBar(param1:int, param2:int, param3:uint, param4:uint) : BitmapData
      {
         param2 = Math.max(param2,1);
         param1 = Math.max(param1,0);
         if(param1 > param2)
         {
            param1 = param2;
         }
         var _loc10_:Number = param1 / param2;
         var _loc9_:int = 1;
         var _loc7_:BitmapData;
         (_loc7_ = new BitmapData(162,16,false)).fillRect(new Rectangle(0,0,_loc7_.width,_loc7_.height),14342874);
         var _loc8_:Rectangle = new Rectangle(_loc9_,_loc9_,_loc7_.width - _loc9_ * 2,_loc7_.height - _loc9_ * 2);
         _loc7_.fillRect(_loc8_,3815994);
         var _loc6_:Rectangle;
         (_loc6_ = new Rectangle(_loc9_,_loc9_ + 4,_loc7_.width - _loc9_ * 2,_loc7_.height - _loc9_ * 2 - 4)).width = _loc10_ * _loc6_.width;
         _loc7_.fillRect(_loc6_,param3);
         var _loc5_:Rectangle;
         (_loc5_ = new Rectangle(_loc9_,_loc9_,_loc7_.width - _loc9_ * 2,4)).width = _loc10_ * _loc5_.width;
         _loc7_.fillRect(_loc5_,param4);
         return _loc7_;
      }
      
      public function dispose() : void
      {
         if(var_2228)
         {
            var_2228.stop();
            var_2228 = null;
         }
         if(var_1629)
         {
            var_1629 = null;
         }
         if(var_1665)
         {
            var_1665.dispose();
         }
         var_1665 = null;
      }
      
      public function getPetId() : int
      {
         return var_2714;
      }
      
      public function isVisible() : Boolean
      {
         if(var_1665 == null)
         {
            return false;
         }
         return var_1665.visible;
      }
      
      public function showCommandToolForPet(param1:int, param2:String, param3:BitmapData, param4:int, param5:int, param6:Number, param7:int, param8:Array) : void
      {
         if(var_1665 == null)
         {
            return;
         }
         updateStateElement("skill",(param5 + param6) * 100,param7 * 100,8734654,10513106,param4);
         if(var_2714 == param1)
         {
            return;
         }
         var_2714 = param1;
         _currentPetName = param2;
         var _loc10_:ITextWindow;
         if((_loc10_ = var_1665.findChildByName("pet_name") as ITextWindow) != null)
         {
            _loc10_.text = param2;
         }
         updatePetImage(param3);
         var _loc9_:CommandConfiguration;
         if((_loc9_ = var_269.getValue(param1) as CommandConfiguration) == null)
         {
            disableAllButtons();
            requestEnabledCommands(var_2714);
         }
         else
         {
            updateCommandButtonsViewState(_loc9_);
         }
      }
      
      public function updatePetImage(param1:BitmapData) : void
      {
         var _loc2_:BitmapData = null;
         var _loc4_:Point = null;
         var _loc3_:IBitmapWrapperWindow = var_1665.findChildByName("avatar_image") as IBitmapWrapperWindow;
         if(_loc3_ != null)
         {
            if(param1 != null)
            {
               _loc2_ = new BitmapData(_loc3_.width,_loc3_.height,true,0);
               (_loc4_ = new Point(0,0)).x = Math.round((_loc3_.width - param1.width) / 2);
               _loc4_.y = Math.round((_loc3_.height - param1.height) / 2);
               _loc2_.copyPixels(param1,param1.rect,_loc4_);
               _loc3_.bitmap = _loc2_;
            }
            else
            {
               _loc3_.bitmap = null;
            }
            _loc3_.invalidate();
         }
      }
      
      private function onButtonDisableTimeout(param1:TimerEvent) : void
      {
         var _loc2_:CommandConfiguration = var_269.getValue(var_2714) as CommandConfiguration;
         updateCommandButtonsViewState(_loc2_);
         var_2228.stop();
      }
      
      public function setEnabledCommands(param1:int, param2:CommandConfiguration) : void
      {
         var_269.remove(param1);
         var_269.add(param1,param2);
         if(param1 != var_2714)
         {
            return;
         }
         updateCommandButtonsViewState(param2);
         var_2228.stop();
      }
      
      public function showWindow(param1:Boolean) : void
      {
         if(param1)
         {
            if(var_1665 == null)
            {
               createCommandWindow();
            }
            var_1665.visible = true;
         }
         else if(var_1665 != null)
         {
            var_1665.visible = false;
         }
         var_2228.stop();
      }
      
      private function requestEnabledCommands(param1:int) : void
      {
         var _loc2_:RoomWidgetPetCommandMessage = new RoomWidgetPetCommandMessage("RWPCM_REQUEST_PET_COMMANDS",param1);
         var_1629.messageListener.processWidgetMessage(_loc2_);
      }
      
      private function createCommandWindow() : void
      {
         var _loc7_:BitmapDataAsset = null;
         var _loc4_:BitmapData = null;
         var _loc3_:XmlAsset = var_1629.assets.getAssetByName("pet_commands") as XmlAsset;
         var_1665 = var_1629.windowManager.buildFromXML(_loc3_.content as XML) as class_3514;
         if(var_1665 == null)
         {
            throw new Error("Failed to construct command window from XML!");
         }
         var_1665.context.getDesktopWindow().addEventListener("WE_RESIZED",onWindowDesktopResized);
         var_4834 = IWindowContainer(var_1665.findChildByName("commands_container")).removeChildAt(0);
         var _loc1_:IWindow = var_1665.findChildByName("header_button_close");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",onCommandWindowClose);
         }
         var _loc5_:IWindow;
         if((_loc5_ = var_1665.findChildByName("description_link")) != null)
         {
            _loc5_.addEventListener("WME_CLICK",onCommandWindowDescriptionLink);
         }
         var _loc2_:IWindow = var_1665.findChildByName("avatar_image");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onCommandWindowAvatarImageClick);
         }
         var _loc6_:IBitmapWrapperWindow;
         if((_loc6_ = var_1665.findChildByName("status_skill_icon") as IBitmapWrapperWindow) != null)
         {
            _loc4_ = (_loc7_ = var_1629.assets.getAssetByName("icon_pet_skill") as BitmapDataAsset).content as BitmapData;
            _loc6_.bitmap = _loc4_.clone();
         }
         var_1665.position = DEFAULT_LOCATION;
      }
      
      private function updateCommandButtonsViewState(param1:CommandConfiguration) : void
      {
         var _loc7_:int = 0;
         var _loc3_:class_3357 = null;
         var _loc10_:int = 0;
         if(var_1665 == null)
         {
            return;
         }
         var _loc6_:IWindowContainer = IWindowContainer(var_1665.findChildByName("commands_container"));
         hideChildren(_loc6_);
         var _loc8_:Array = param1.allCommandIds;
         var _loc12_:int = 25;
         var _loc11_:int = 0;
         var _loc2_:int = 86;
         var _loc9_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc8_.length)
         {
            _loc3_ = _loc6_.getChildAt(_loc7_) as class_3357;
            if(_loc3_ == null)
            {
               _loc3_ = var_4834.clone() as class_3357;
               _loc3_.addEventListener("WME_CLICK",onTrainButtonMouseClick);
               _loc6_.addChild(_loc3_);
            }
            _loc3_.visible = true;
            _loc10_ = int(_loc8_[_loc7_]);
            _loc3_.id = _loc10_;
            _loc3_.caption = var_1629.localizations.getLocalization("pet.command." + _loc10_);
            if(param1.isEnabled(_loc10_))
            {
               _loc3_.enable();
            }
            else
            {
               _loc3_.disable();
            }
            _loc3_.y = _loc9_;
            if(_loc7_ % 2 == 1)
            {
               _loc9_ += _loc12_;
               _loc3_.x = _loc2_;
            }
            else
            {
               _loc3_.x = _loc11_;
            }
            _loc7_++;
         }
         var _loc4_:Boolean;
         var _loc5_:int = (_loc4_ = Boolean(var_1629.config.getBoolean("pet.enhancements.enabled"))) ? 180 : 160;
         _loc6_.height = getLowestPoint(_loc6_);
         var_1665.height = _loc6_.height + _loc5_;
         var_2228.stop();
      }
      
      private function disableAllButtons() : void
      {
         var _loc3_:int = 0;
         var _loc1_:class_3357 = null;
         if(var_1665 == null)
         {
            return;
         }
         var _loc2_:IWindowContainer = IWindowContainer(var_1665.findChildByName("commands_container"));
         _loc3_ = 0;
         while(_loc3_ < _loc2_.numChildren)
         {
            _loc1_ = class_3357(_loc2_.getChildAt(_loc3_));
            _loc1_.disable();
            _loc3_++;
         }
      }
      
      private function onCommandWindowClose(param1:WindowMouseEvent) : void
      {
         var_1665.visible = false;
      }
      
      private function onCommandWindowDescriptionLink(param1:WindowMouseEvent) : void
      {
         var_1629.windowManager.openHelpPage("help/pets/training");
      }
      
      private function onCommandWindowAvatarImageClick(param1:WindowMouseEvent) : void
      {
         var_1629.messageListener.processWidgetMessage(new RoomWidgetUserActionMessage("RWUAM_REQUEST_PET_UPDATE",var_2714));
      }
      
      private function onTrainButtonMouseClick(param1:WindowMouseEvent) : void
      {
         var _loc6_:IWindow;
         var _loc5_:int = (_loc6_ = param1.target).id;
         var _loc3_:String = "pet.command." + _loc5_;
         var _loc2_:String = String(var_1629.localizations.getLocalization(_loc3_));
         var _loc4_:RoomWidgetPetCommandMessage = new RoomWidgetPetCommandMessage("RWPCM_PET_COMMAND",var_2714,_currentPetName + " " + _loc2_);
         var_1629.messageListener.processWidgetMessage(_loc4_);
         disableAllButtons();
         var_2228.start();
      }
      
      private function onWindowDesktopResized(param1:WindowEvent) : void
      {
         var _loc2_:IWindow = null;
         var _loc3_:Rectangle = null;
         if(var_1665 && !var_1665.disposed)
         {
            _loc2_ = param1.window;
            _loc3_ = new Rectangle();
            var_1665.getGlobalRectangle(_loc3_);
            if(_loc3_.x > _loc2_.width)
            {
               var_1665.x = _loc2_.width - var_1665.width;
               var_1665.getGlobalRectangle(_loc3_);
            }
            if(_loc3_.x + _loc3_.width <= 0)
            {
               var_1665.x = 0;
               var_1665.getGlobalRectangle(_loc3_);
            }
            if(_loc3_.y > _loc2_.height)
            {
               var_1665.y = 0;
               var_1665.getGlobalRectangle(_loc3_);
            }
            if(_loc3_.y + _loc3_.height <= 0)
            {
               var_1665.y = 0;
               var_1665.getGlobalRectangle(_loc3_);
            }
         }
      }
      
      private function updateStateElement(param1:String, param2:int, param3:int, param4:uint, param5:uint, param6:int) : void
      {
         var _loc8_:BitmapData = null;
         if(var_1665 == null)
         {
            return;
         }
         var _loc7_:IWindowContainer;
         if((_loc7_ = var_1665.findChildByName("status_" + param1 + "_container") as IWindowContainer) == null)
         {
            return;
         }
         _loc7_.visible = var_1629.config.getBoolean("pet.enhancements.enabled") && param6 == 15;
         var _loc10_:ITextWindow;
         if((_loc10_ = _loc7_.findChildByName("status_" + param1 + "_value_text") as ITextWindow) != null)
         {
            _loc10_.text = param2 + "/" + param3;
         }
         var _loc11_:ITextWindow;
         if((_loc11_ = _loc7_.findChildByName("status_" + param1 + "_text") as ITextWindow) != null)
         {
            _loc11_.caption = "${infostand.pet.text.skill.next." + param6 + "}";
         }
         var _loc9_:IBitmapWrapperWindow;
         if((_loc9_ = _loc7_.findChildByName("status_" + param1 + "_bitmap") as IBitmapWrapperWindow) != null)
         {
            if((_loc8_ = createPercentageBar(param2,param3,param4,param5)) != null)
            {
               _loc9_.bitmap = _loc8_;
               _loc9_.width = _loc8_.width;
               _loc9_.height = _loc8_.height;
               _loc9_.invalidate();
            }
         }
      }
   }
}
