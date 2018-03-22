require "yaml"
require "cinch"
require "twitter"

class TwitterAlerts
    include Cinch::Plugin
    listen_to :connect, method: :on_connect
    match "help", method: :help
    match "help twitter", method: :help_twitter

    def on_connect(m)

        conf = YAML.load_file("./Plugins/conf/twitter.yaml")

        client = Twitter::Streaming::Client.new do |config|
            config.consumer_key = conf['consumer_key']
            config.consumer_secret = conf['consumer_secret']
            config.access_token = conf['access_token']
            config.access_token_secret = conf['access_token_secret']
        end

        def is_originator?(object,sn)
            if object.user.screen_name != sn || object.quote?
                return false
            end
            if object.reply? && (not object.in_reply_to_screen_name == sn)
                return false
            end
            return true
        end
        loop do
            client.filter(follow: "22589282,4194486134,216522918,1965093320") do |object|
                if object.is_a?(Twitter::Tweet)
                    debug "User #{object.user.screen_name} sends #{object.text}. Reply #{object.reply?} Retweet #{object.retweet?} Quote #{object.quote?}"
                    if object.text.start_with?("PSU Alert") && is_originator?(object,"Portland_State")
                        Channel("#robots").send object.text
                    end
                    if is_originator?(object,"trimetalerts")
                        Channel("#robots").send "Trimet alert: " + object.text
                    end
                    if is_originator?(object,"Ananstra22")
                        Channel("#bots").send "Kimani test message: " + object.text
                    end
                    if is_originator?(object,"cat_alerts")
                        Channel("#robots").send "CAT Alert:" + object.text
                    end
                end
            end
        end
    end

    def help(m)
        m.reply "See !help twitter"
    end

    def help_twitter(m)
        m.reply "Twitter has no associated commands. Monobot will automatically report alerts from PSU, CAT, and Trimet."
    end

end
