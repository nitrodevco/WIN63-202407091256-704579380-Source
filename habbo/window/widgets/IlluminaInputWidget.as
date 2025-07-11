package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ILabelWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   
   public class IlluminaInputWidget implements IIlluminaInputWidget
   {
      
      public static const TYPE:String = "illumina_input";
      
      private static const const_694:String = "illumina_input:button_caption";
      
      private static const const_1196:String = "illumina_input:empty_message";
      
      private static const MULTILINE_KEY:String = "illumina_input:multiline";
      
      private static const MAX_CHARS_KEY:String = "illumina_input:max_chars";
      
      private static const BUTTON_CAPTION_DEFAULT:PropertyStruct = new PropertyStruct("illumina_input:button_caption","${widgets.chatinput.say}","String");
      
      private static const EMPTY_MESSAGE_DEFAULT:PropertyStruct = new PropertyStruct("illumina_input:empty_message","","String");
      
      private static const MULTILINE_DEFAULT:PropertyStruct = new PropertyStruct("illumina_input:multiline",false,"Boolean");
      
      private static const MAX_CHARS_DEFAULT:PropertyStruct = new PropertyStruct("illumina_input:max_chars",0,"int");
      
      private static const SINGLE_LINE_HEIGHT:int = 28;
       
      
      private var _disposed:Boolean;
      
      private var var_1759:IWidgetWindow;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_509:IWindowContainer;
      
      private var _submitButton:class_3357;
      
      private var var_1639:ITextFieldWindow;
      
      private var _emptyMessageLabel:ILabelWindow;
      
      private var var_3725:IIlluminaInputHandler;
      
      public function IlluminaInputWidget(param1:IWidgetWindow, param2:HabboWindowManagerComponent)
      {
         super();
         var_1759 = param1;
         _windowManager = param2;
         var_509 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("illumina_input_xml").content as XML) as IWindowContainer;
         var_509.width = var_1759.width;
         _submitButton = var_509.findChildByName("submit") as class_3357;
         var_1639 = var_509.findChildByName("input") as ITextFieldWindow;
         _emptyMessageLabel = var_509.findChildByName("empty_message") as ILabelWindow;
         buttonCaption = String(BUTTON_CAPTION_DEFAULT.value);
         emptyMessage = String(EMPTY_MESSAGE_DEFAULT.value);
         multiline = Boolean(MULTILINE_DEFAULT.value);
         maxChars = int(MAX_CHARS_DEFAULT.value);
         refresh();
         var_509.procedure = widgetProcedure;
         var_1759.rootWindow = var_509;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_1639 != null)
            {
               var_1639 = null;
            }
            _submitButton = null;
            _emptyMessageLabel = null;
            if(var_509 != null)
            {
               var_509.dispose();
               var_509 = null;
            }
            if(var_1759 != null)
            {
               var_1759.rootWindow = null;
               var_1759 = null;
            }
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
      
      public function get properties() : Array
      {
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(BUTTON_CAPTION_DEFAULT.withValue(buttonCaption));
         _loc1_.push(EMPTY_MESSAGE_DEFAULT.withValue(emptyMessage));
         _loc1_.push(MULTILINE_DEFAULT.withValue(multiline));
         _loc1_.push(MAX_CHARS_DEFAULT.withValue(maxChars));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         if(_disposed)
         {
            return;
         }
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "illumina_input:button_caption":
                  buttonCaption = String(_loc2_.value);
                  break;
               case "illumina_input:empty_message":
                  emptyMessage = String(_loc2_.value);
                  break;
               case "illumina_input:multiline":
                  multiline = Boolean(_loc2_.value);
                  break;
               case "illumina_input:max_chars":
                  maxChars = int(_loc2_.value);
                  break;
            }
         }
      }
      
      public function get buttonCaption() : String
      {
         return _submitButton.caption;
      }
      
      public function set buttonCaption(param1:String) : void
      {
         _submitButton.caption = param1;
         _submitButton.visible = param1 != null && param1.length > 0;
         refresh();
      }
      
      public function get emptyMessage() : String
      {
         return _emptyMessageLabel.caption;
      }
      
      public function set emptyMessage(param1:String) : void
      {
         _emptyMessageLabel.caption = param1;
      }
      
      public function get multiline() : Boolean
      {
         return var_1639.multiline;
      }
      
      public function set multiline(param1:Boolean) : void
      {
         var_1639.multiline = param1;
         var_509.setParamFlag(2048,param1);
         var_509.height = param1 ? var_1759.height : 28;
      }
      
      public function get maxChars() : int
      {
         return var_1639.maxChars;
      }
      
      public function set maxChars(param1:int) : void
      {
         var_1639.maxChars = param1;
      }
      
      public function get message() : String
      {
         return var_1639.caption;
      }
      
      public function set message(param1:String) : void
      {
         var_1639.caption = param1;
         refresh();
      }
      
      public function get submitHandler() : IIlluminaInputHandler
      {
         return var_3725;
      }
      
      public function set submitHandler(param1:IIlluminaInputHandler) : void
      {
         var_3725 = param1;
      }
      
      private function widgetProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         switch(param1.type)
         {
            case "WE_CHANGE":
               if(param2 == var_1639)
               {
                  refresh();
               }
               break;
            case "WKE_KEY_DOWN":
               if(param2 == var_1639 && WindowKeyboardEvent(param1).charCode == 13 && Boolean(_submitButton.visible))
               {
                  submitMessage();
               }
               break;
            case "WME_CLICK":
               if(param2 == _submitButton)
               {
                  submitMessage();
               }
         }
      }
      
      private function submitMessage() : void
      {
         if(var_3725 != null)
         {
            var_3725.onInput(var_1759,message);
         }
      }
      
      private function refresh() : void
      {
         _emptyMessageLabel.visible = var_1639.length == 0;
         var_1639.width = (!!_submitButton.visible ? _submitButton.x : int(var_509.width)) - var_1639.x * 2;
      }
   }
}
