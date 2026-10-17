package com.bluebyte.tso.chat.Commands
{
    import com.bluebyte.bluefire.api.controller.slashCommands.SlashCommand;

    public class cPresenceStatus extends SlashCommand
    {
        public static const COMMAND_PRESENCE_STATUS:String = "commandPresenceStatus";

        public function cPresenceStatus()
        {
            super();
            _regExArray.push(/^\/status\s+(online|chat|away|xa|dnd)\s*$/i);
        }

        override protected function internalEvaluate(command:String):String
        {
            return (COMMAND_PRESENCE_STATUS);
        }
    }
}
