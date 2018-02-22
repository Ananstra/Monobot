require "cinch"

class Plugins
    include Cinch::Plugin

    match "plugin list"

    def execute(m)
        return if not m.user.nick == "kimani"
        plugins = "Loaded Plugins Are: "
        @bot.plugins.each do |plugin|
            plugins += plugin.class.name
            plugins += " "
        end
        m.reply plugins
    end
end
