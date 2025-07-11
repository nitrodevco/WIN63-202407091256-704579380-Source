package com.sulake.habbo.freeflowchat.viewer.enum
{
   import com.sulake.habbo.freeflowchat.data.ChatItem;
   import com.sulake.habbo.freeflowchat.viewer.visualization.style.ChatStyle;
   
   public class ChatColours
   {
      
      public static const COLOUR_ARRAY:Array = [["@red@",9115929],["@cyan@",32639],["@blue@",19609],["@green@",32768],["@purple@",4980812]];
       
      
      public function ChatColours()
      {
         super();
      }
      
      public static function applyColourToChat(param1:ChatItem, param2:ChatStyle) : void
      {
         for each(var _loc3_ in COLOUR_ARRAY)
         {
            if(param1.text.indexOf(_loc3_[0]) == 0)
            {
               param2.textFormat.color = _loc3_[1];
               param1.text = param1.text.substr(_loc3_[0].length);
            }
         }
      }
   }
}
