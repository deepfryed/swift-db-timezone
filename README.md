# Swift datetime timezone helper

Timezone helper for Swift DB adapters.

## Features

Uses the well tested TZInfo gem for time zone support and offers implicit time zone conversion for time stamp fields stored in database.

## Example

```ruby
require 'swift/db/timezone'

class Connection < Swift::DB::Mysql
  include Swift::DB::Timezone
end

db = Connection.new(db: 'test', database_timezone: 'Asia/Omsk', local_timezone: 'Europe/Prague')

db.execute('select now() as time')
```

## Performance

If you're looking for performance, I highly recommend you store and retrieve database timestamps in UTC.

## License

MIT
