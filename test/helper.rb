require 'bundler/setup'
require 'minitest/autorun'
require 'minitest/reporters'
require 'swift/db/sqlite3'
require 'swift/db/timezone'

MiniTest::Reporters.use! MiniTest::Reporters::SpecReporter.new

class TestAdapter < Swift::DB::Sqlite3
  include Swift::DB::Timezone
end

