require "cinch"

class Bird
    include Cinch::Plugin
    match /\\o>.*/, strip_colors: true, method: :rightbird
    match /<o\/.*/, strip_colors: true, method: :leftbird
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
