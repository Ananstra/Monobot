require "cinch"

class Test
    include Cinch::Plugin
    
    match "test"

    def execute(m)
        m.reply "Test Module, Please Ignore"
    end
end
