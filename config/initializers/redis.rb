uri = URI.parse(ENV["REDIS_URL"]|| "localhost:6379")
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
