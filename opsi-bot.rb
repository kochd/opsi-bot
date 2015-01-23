# coding: utf-8
require 'cinch'
require 'yaml'
nick = "opsi-bot-#{rand(1..9999)}"
bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.freenode.org"
    c.channels = ["#test123"]
    c.nick = nick
  end

  on :message, /\b#{nick}/i do |m|
    m.reply "Well i am just a bot, but you can improve me. Just fork me on github"
    m.reply "https://github.com/kochd/opsi-bot/tree/master)"
  end

  YAML.load_file("syntax.yaml").each do |key, value|
    on :message, /\b#{key}\?/i do |m|
      value.each do |flag, text|
        next if value[flag].nil?
        sleep 0.5
        if value[flag].class == Array
          m.reply "#{flag.capitalize}:"
          value[flag].each do |t|
            m.reply "#{t}"
          end
        else
          m.reply "#{flag.capitalize}: #{text}"
        end
      end
    end
  end
end

bot.start
