require "cinch"

class Load
    include Cinch::Plugin

    match(/plugin load (\S+)/, method: :load_plugin)

	def load_plugin(m, plugin)
        if not m.user.nick == "kimani"
            m.reply "You can't do that, sorry, #{m.user.nick}"
            return
        end
        file_name = "./Plugins/#{plugin}.rb"
        unless File.exist?(file_name)
          m.reply "Could not load #{plugin} because #{file_name} does not exist."
          return
        end

        begin
          load(file_name)
        rescue
          m.reply "Could not load #{plugin}."
          raise
        end

        begin
          const = Object.const_get(plugin)
        rescue NameError
          m.reply "Could not load #{plugin} because no matching class was found."
          return
        end

        @bot.plugins.register_plugin(const)
        m.reply "Successfully loaded #{plugin}"
    end
end
