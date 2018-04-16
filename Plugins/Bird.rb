require "cinch"

class Bird
    include Cinch::Plugin
    match "\\o>", method: :rightbird
    match "<o/", method: :leftbird
    set :prefix, /^/
    def rightbird(m)
        m.reply "/)"
        m.reply "^"
    end

    def leftbird(m)
        m.reply "(\\"
        m.reply "^"
    end

end
