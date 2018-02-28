require 'mechanize'
require 'cinch'
require 'socket'
require 'net/ping'

class Isup
    include Cinch::Plugin

    def initialize(*args)
        super

        @agent = Mechanize.new
        @agent.user_agent_alias = "Linux Mozilla"
    end

    match /isup (.+)/, method: :isup
    match "help", method: :help
    match "help isup", method: :help_isup

    def isup(m, url)
        if up?(url) 
            m.reply "It's just you. #{url} is up."
        else
            m.reply "It's not just you. #{url} looks down."
        end
    end

    private
    def up?(url)
        url = url.gsub(/^https?:\/\//, '')
        page = @agent.get("http://downforeveryoneorjustme.com/#{url}")
        !!page.at('[id="container"]').content.match("It's just you")
    end

    def help(m)
        m.reply "See !help isup"
    end

    def help_isup(m)
        m.reply "Format: !isup <url>"
        m.reply "Checks isup.me to see if a website is up."
    end
end
