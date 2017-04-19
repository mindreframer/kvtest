require "kvtest/version"
require "pry"

require "lmdb"
module Kvtest
  def self.run
    path   = "data"
    env    = LMDB.new(path)
    maindb = env.database

    maindb['key'] = 'value'
    maindb['key3'] = 'value3'
    maindb['some'] = "another value"

    maindb.cursor do |c|
      while a = c.next
        puts a
      end
    end
    env.close
  end
end
Kvtest.run
