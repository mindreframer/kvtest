require "pry"
require "lmdb"
require "kvtest/version"

class DbWrapper
  def self.instance
    @instance ||= env.database
  end

  def self.env
    @env ||= begin
      env = LMDB.new("data", :mapsize => (1024 * 1024 * 512))
      at_exit do
        puts "closing db handle..."
        close(env)
      end
      env
    end
  end

  def self.close(e)
    e.close
  rescue LMDB::Error
    puts "env was closed..."
  end

  def self.get(v)
    instance[v]
  end

  def self.generate
    i = 0
    while i < 100000 do
      instance["key_#{i}"] = "value_#{i}"
      print "." if i % 1000 == 0
      i = i + 1
    end
  end

  def self.reset!
    env.close
    @env      = nil
    @instance = nil
    GC.start
  end

  def self.show_stats
    pid = Process.pid
    rss = `ps -eo pid,rss | grep #{pid} | awk '{print $2}'`.to_i
    puts rss
  end
end
