require "cinch"

class Harbinger
    include Cinch::Plugin
    @direct_control = false
    @chan = false
    match /assume direct control (\S+)/, method: :assume
    match /release/, method: :release
    match /(.*)/, method: :proxy
    set :prefix, ":"
    def assume(m, chan)
        return if (not m.user.nick == "kimani") || (not m.channel.nil?)
        @direct_control = true
        @chan = chan
        m.reply "Assuming Direct Control in #{chan}"
    end

    def release(m)
        return if (not m.user.nick == "kimani") || (not m.channel.nil?)
        @direct_control = false
        m.reply "Releasing Control"
    end

    def proxy(m, message)
        puts "Channel: #{m.channel.nil?}"
        return if (not m.user.nick == "kimani") || (not m.channel.nil?) || (not @direct_control) || m.message.start_with?("assume direct control") || m.message.start_with?("release")
        Channel(@chan).send message
    end
end
