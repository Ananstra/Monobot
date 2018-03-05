require "cinch"

class Monobye
    include Cinch::Plugin
    
    match "mono bye", method: :quit
    def quit(m)
        if m.user.nick == "kimani"
            m.reply "But I don't want to go..."
            @bot.quit("Ouch, RIP Me")            
        end
    end
end
