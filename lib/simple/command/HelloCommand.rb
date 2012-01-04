require "simple/commands"

class Simple::Commands::HelloCommand < Simple::Commands::BaseCommand
  def self.load()
  end

  def run(args=[])
    puts "hello world"
    puts args
  end
end
