module Simple
  module Commands
    def self.load()
      ## load commands
      ## look through directory, extended classes will be registered
      Dir[File.join(File.dirname(__FILE__), "command", "*.rb")].each do |file|
      require file
      end
    end
    def self.commands
      @@commands ||= {}
    end

    ## called from the BaseCommand class based on
    ## extended class method additions
    def self.register_command(command)
      cmdname = command[:command]
      cmdname = cmdname.gsub(/command/,'') ## add without command at the end
      commands[command[:command]] = command
      commands[cmdname] = command
    end

    ## Called in the /bin/simplecli script
    def self.run(command='help', args=[])
      ## look at map
      cmd = commands[command]
      if(cmd)
        instance = cmd[:klass].new()
        method = cmd[:method]
        m = instance.method(method)
        m.call(args)
      else
        nothing = NoCommand.new()
        nothing.help()
      end
    end
    
    ## Base class for commands
    ## facilates the registration process
    class BaseCommand
        def self.namespace
          self.to_s.split("::").last.downcase
        end
        
        def self.method_added(method)
          help = extract_help_from_caller method.to_s()
          ## register command
          command = [ self.namespace, method.to_s ].compact.join(":")
          Simple::Commands.register_command(
            :klass       => self,
            :method      => method,
            :namespace   => self.namespace,
            :command     => command,
            :help        => help
          )
        end
        
        def self.inherited(klass)
          # do nothing for now 
          return
        end
      
      ## plagarized from heroku client code
      def self.extract_help_from_caller(line)
        # gets the comment from the file containing the line
        if line =~ /^(.+?):(\d+)/
          return extract_help($1, $2)
        end
      end
    
      ## plagarized from heroku client code
      def self.extract_help(file, line)
        buffer = []
        lines  = File.read(file).split("\n")
    
        catch(:done) do
          (line.to_i-2).downto(0) do |i|
            case lines[i].strip[0..0]
              when "", "#" then buffer << lines[i]
              else throw(:done)
            end
          end
        end
      
        buffer.map! do |line|
          line.strip.gsub(/^#/, "")
        end
    
        buffer.reverse.join("\n").strip
      end
    end
  end
end



