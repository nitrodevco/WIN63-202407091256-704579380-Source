package com.sulake.habbo.ui.widget.avatarinfo.botskills
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.ui.widget.avatarinfo.AvatarInfoWidget;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import com.sulake.habbo.communication.messages.incoming.room.bots.class_1088;
   import com.sulake.habbo.communication.messages.outgoing.room.bots.GetBotCommandConfigurationDataComposer;
   
   public class BotSkillConfigurationViewBase implements class_3551
   {
       
      
      private var var_2819:IMessageEvent;
      
      protected var var_1629:AvatarInfoWidget;
      
      protected var _window:IWindowContainer;
      
      protected var var_536:int;
      
      public function BotSkillConfigurationViewBase(param1:AvatarInfoWidget)
      {
         super();
         var_1629 = param1;
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_1629)
         {
            if(var_1629.handler.container.connection && var_2819)
            {
               var_1629.handler.container.connection.removeMessageEvent(var_2819);
               var_2819 = null;
            }
            var_1629 = null;
         }
         var_536 = -1;
      }
      
      public function get disposed() : Boolean
      {
         return var_1629 == null;
      }
      
      public function open(param1:int, param2:Point = null) : void
      {
         var _loc3_:XML = null;
         var _loc4_:Rectangle = null;
         var_536 = param1;
         if(!var_2819)
         {
            var_2819 = new class_1088(onBotCommandConfigurationEvent);
            var_1629.handler.container.connection.addMessageEvent(var_2819);
         }
         var_1629.handler.container.connection.send(new GetBotCommandConfigurationDataComposer(var_536,skillType));
         if(!_window)
         {
            _loc3_ = var_1629.assets.getAssetByName(windowAssetName).content as XML;
            _window = var_1629.windowManager.buildFromXML(_loc3_,1) as IWindowContainer;
         }
         if(param2)
         {
            _loc4_ = _window.rectangle;
            _window.x = param2.x - _loc4_.width / 2;
            _window.y = param2.y - _loc4_.height;
         }
         fitToScreen();
         _window.visible = true;
         deactivateInputs();
      }
      
      public function close() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function parseConfiguration(param1:String) : void
      {
      }
      
      protected function deactivateInputs() : void
      {
      }
      
      protected function get windowAssetName() : String
      {
         return "";
      }
      
      protected function get skillType() : int
      {
         return -1;
      }
      
      private function onBotCommandConfigurationEvent(param1:class_1088) : void
      {
         if(param1.getParser().botId == var_536 && param1.getParser().commandId == skillType)
         {
            parseConfiguration(param1.getParser().data);
         }
      }
      
      private function fitToScreen() : void
      {
         var _loc1_:Rectangle = new Rectangle();
         _window.getGlobalRectangle(_loc1_);
         if(_loc1_.top < 0)
         {
            _window.y += -_loc1_.top;
         }
         if(_loc1_.left < 0)
         {
            _window.x += -_loc1_.left;
         }
         if(_loc1_.right > _window.desktop.width)
         {
            _window.x -= _loc1_.right - _window.desktop.width;
         }
         if(_loc1_.bottom > _window.desktop.height)
         {
            _window.y -= _loc1_.bottom - _window.desktop.height;
         }
      }
   }
}
