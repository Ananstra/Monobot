require "cinch"

class Love 
    include Cinch::Plugin
    match "help", method: :help    
    match "love", method: :love
    match "help love", method: :help_love

    def love(m)
        m.reply (m.user.nick=="kimani" or rand(3) > 0) ? "<3" : "Maybe someday, #{m.user.nick}"
    end

    def help(m)
        m.reply "See !help love"
    end

    def help_love(m)
        m.reply "Sorry, I'm just an IRC bot, you're on your own with that."
    end
end
