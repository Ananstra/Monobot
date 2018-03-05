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
conf = YAML.load_file("./server.conf")

puts conf

bot = Cinch::Bot.new do
    configure do |c|
        c.server = conf['server']
        c.port = conf['port']
        c.channels = conf['channels'] 
        c.ssl.use = true
        c.nick = conf['nick']
        c.realname = conf['realname']
        c.user = conf['user']
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
