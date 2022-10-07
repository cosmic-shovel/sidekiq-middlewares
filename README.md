# sidekiq-middlewares
Some potentially useful Sidekiq / Rails middlewares.

## MysqlConnectionPoolMiddleware

Our Rails codebase uses `ActiveRecord::Base.connection.execute` and its sibling functions quite a bit.  It turns out, this checks out a connection from the database connection pool but doesn't check it back in.  Naturally, this leads to problems!  Our solution, until we can refactor our code, is to use the server middleware `MysqlConnectionPoolMiddleware` to automatically check in all connections after a job is executed.

## SidekiqNewRelicMiddleware

We use New Relic for application and infrastructure monitoring.  The server middleware `SidekiqNewRelicMiddleware` allows us to track job execution metrics inside New Relic.  The example code uses one Event label, rather than one label per job type, but you could be naughty and change that if you want.  Just ensure you don't go over New Relic's distinct event limit...
