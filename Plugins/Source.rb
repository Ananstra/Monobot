require "cinch"

class Source
    include Cinch::Plugin
    set :prefix, "Monobot"
    match /:?\W?source/
    def execute(m)
        m.reply "https://github.com/Ananstra/Monobot"
    end
end
