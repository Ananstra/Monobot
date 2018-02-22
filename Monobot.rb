require "cinch"
require "io/console"
#Load Plugins
plugins = []
Dir.glob("./Plugins/*.rb") do |file|
    load file
    plugin = File.basename file, ".rb"
    plugins.push(Object.const_get(plugin))
end
#Get password (I'm paranoid, okay?)
pass = File.read("./pass.conf")

bot = Cinch::Bot.new do
    configure do |c|
        c.server = "irc.cat.pdx.edu"
        c.port = "6697"
        c.channels = ["#robots catsonly", "#bots"]
        c.ssl.use = true
        c.nick = "Monobot"
        c.realname = "kimani's bot"
        c.user = "Monobot"
        c.plugins.plugins = plugins
    end

    #Authenticate
    on :connect do
        if (bot.nick != "Monobot")
            User('NickServ').send "regain Monobot #{pass}"
        end
        User('NickServ').send "identify Monobot #{pass}"
        pass = ""
    end
end

quit_thread = nil
Kernel.trap('INT') do
    quit_thread = Thread.new { bot.quit("Ouch, RIP me") }
end

bot.start
quit_thread.join
