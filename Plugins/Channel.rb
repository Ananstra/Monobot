require 'cinch'

class Channel
    include Cinch::Plugin

    match /mono join (#?\S+)( \S+)?/, method: :join
    match /mono part (#?\S+)( \S+)?/, method: :part

    def join(m,chan,key = nil)
        return if not m.user.nick == "kimani"
        chan = "#" + chan if (!chan.start_with?("#"))
        key.lstrip! if (!key.nil?)
        Channel(chan).join(key)
        m.reply "Joining #{chan}"
    end

    def part(m,chan,msg = nil)
        return if not m.user.nick == "kimani"
        chan = "#" + chan if (!chan.start_with?("#"))
        msg.lstrip! if (!msg.nil?)
        m.reply "Leaving #{chan}"
        Channel(chan).part(msg)
    end
end
