connection = influx_connection(scheme = "http", host, port, user, pass)
statement = paste("SELECT time, content FROM", measurement, "WHERE time > now() -", from, "AND time < now() -", to, "AND content =~ /.*stock*./ OR content =~ /.*share*./")

query = influx_query (
  con = connection,
  db = database,
  query = statement,
  return_xts = FALSE,
  chunked = 1000)

data = data.frame(query)
data[,1:4] = NULL