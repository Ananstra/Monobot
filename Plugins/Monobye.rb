require "cinch"

class Monobye
    include Cinch::Plugin
    
    match "monobye"

    def execute(m)
        if m.user.nick == "kimani"
            m.reply "But I don't want to go..."
            @bot.quit("Ouch, RIP Me")            
        end
    end
end
