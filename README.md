# Swift datetime timezone helper

Timezone helper for Swift DB adapters.

## Features

Uses the well tested TZInfo gem for time zone support and offers implicit time zone conversion for time stamp fields stored in database.

## Example

```ruby
require 'swift/db/timezone'
require 'swift/db/mysql'

class Connection < Swift::DB::Mysql
  include Swift::DB::Timezone
end

zone = {database_timezone: 'Asia/Omsk', local_timezone: 'Europe/Rome'}
db   = Connection.new(db: 'test', zone)
db.execute('select now() as time')


# extending results on a per query basis.
db     = Swift::DB::Mysql.new(db: 'test')
result = Swift::DB::Timezone::Result.wrap db.execute('select now() as time'), zone
```

## Performance

If you're looking for performance, I highly recommend you store and retrieve database timestamps in UTC.

## License

MIT
