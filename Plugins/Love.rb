require "cinch"

class Love 
    include Cinch::Plugin
    
    match "love"

    def execute(m)
        m.reply (m.user.nick=="kimani" or rand(3) > 0) ? "<3" : "Maybe someday, #{m.user.nick}"
    end
end
