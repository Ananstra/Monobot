require "cinch"

class AtSomeone 
    include Cinch::Plugin

    match /someone/, method: :at_someone
#    match /([0-9A-Za-z_]+) (.*)/, method: :at_person

    set :prefix, /@/ 
    def at_someone(m)
        return if (m.channel.name != "#spectres")
        m.reply m.user.nick + " says: " + m.message.gsub(/@someone/, m.channel.users.keys.sample.nick)
    end
end
