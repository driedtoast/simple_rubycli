
module Simple 
  module Commands
  
  class HelloCommand 
    def self.load()
    end
  
    def run(args=[])
      puts "hello world"
      puts args
    end
  end
  
  end
end
