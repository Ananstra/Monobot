require "cinch"

class Status 
    include Cinch::Plugin

    match "status"
    def execute(m)
        m.reply "^_^" if m.user.nick == "kimani"
    end
end
