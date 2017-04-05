require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/doctor")
require("./lib/patient")
require("pg")

DB = PG.connect({:dbname => "doctor_patient"})

get('/') do

  erb(:index)
end
