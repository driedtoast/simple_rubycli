module Simple
  module Commands
    def self.load()
      ## load commands
      ## look through directory and add classes to a map      
   
      Dir[File.join(File.dirname(__FILE__), "command", "*.rb")].each do |file|
      require file
      end
    end
    def self.run(command='help', args=[])
      ## look at map
      case(command)
      when 'hello'
        cmd = HelloCommand.new()
        cmd.run(args)
      else
        NoCommand.new().run(args)
      end
    end
  end
end



