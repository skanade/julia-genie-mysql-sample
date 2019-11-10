using Genie
using Genie.Router
using Genie.Renderer

using ConfParser


struct DatabaseConfig
  host::String 
  user::String 
  password::String 
  database::String 
end

function db_config()
  conf = ConfParse("config.ini")
  parse_conf!(conf)

  host = retrieve(conf, "database", "host")
  user = retrieve(conf, "database", "user")
  password = retrieve(conf, "database", "password")
  database = retrieve(conf, "database", "database")
  dbconfig = DatabaseConfig(host, user, password, database)
  @info dbconfig
  return dbconfig
end

push!(LOAD_PATH,"$(pwd())")
push!(LOAD_PATH,"$(pwd())/app/resources/persons/")

myconfig = db_config()


using PersonsController

route("/people") do
  PersonsController.peoplelist(myconfig)
end

up(8000, async=false)
