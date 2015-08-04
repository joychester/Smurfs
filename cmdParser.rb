require 'optparse'

module CmdParser

  def getoptions(args)
    options = { :users => nil, :loops => nil, :duration => nil, :script => nil}

    OptionParser.new do |opts|
      opts.banner = "Usage: smurfs.rb [options]"

      opts.on("-u", "--users users", "Concurrent Users") do |u|
          options[:users] = u
      end
      
      opts.on("-l", "--loops loops", "Loop Counts") do |lc|
          options[:loops] = lc
      end
      
      opts.on("-d", "--duration duration", "Test Duration") do |d|
          options[:duration] = d
      end
      
      opts.on("-f", "--file file", "Test Script") do |f|
          options[:file] = f
      end
      
    end.parse!(args)

    return options
  end

end