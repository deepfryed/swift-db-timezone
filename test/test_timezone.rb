require 'helper'

describe 'timezone adapter' do
  it 'should convert from database to local time zone' do
    db = TestAdapter.new(db: ':memory:', database_timezone: 'UTC', local_timezone: 'America/Chicago')
    db.execute %Q{create table test(ts timestamp)}
    db.execute %Q{insert into test values(datetime('2014-12-01 00:00:00'))}
    db.execute %Q{insert into test values(datetime('2015-04-01 00:00:00'))}

    ts1, ts2 = db.execute("select * from test").map(&:values).flatten
    assert_equal "-06:00", ts1.zone
    assert_equal "-05:00", ts2.zone

    assert_equal "2014-11-30 18:00:00 -0600", ts1.strftime('%Y-%m-%d %H:%M:%S %z')
    assert_equal "2015-03-31 19:00:00 -0500", ts2.strftime('%Y-%m-%d %H:%M:%S %z')
  end
end

describe 'timezone result' do
  it 'should convert from database to local time zone' do
    db = Swift::DB::Sqlite3.new(db: ':memory:')
    db.execute %Q{create table test(ts timestamp)}
    db.execute %Q{insert into test values(datetime('2014-12-01 00:00:00'))}
    db.execute %Q{insert into test values(datetime('2015-04-01 00:00:00'))}

    result   = db.execute("select * from test")
    result   = Swift::DB::Timezone::Result.wrap result, database_timezone: 'UTC', local_timezone: 'America/Chicago'
    ts1, ts2 = result.map(&:values).flatten
    assert_equal "-06:00", ts1.zone
    assert_equal "-05:00", ts2.zone

    assert_equal "2014-11-30 18:00:00 -0600", ts1.strftime('%Y-%m-%d %H:%M:%S %z')
    assert_equal "2015-03-31 19:00:00 -0500", ts2.strftime('%Y-%m-%d %H:%M:%S %z')
  end
end
