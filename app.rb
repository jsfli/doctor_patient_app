require("sinatra")
require("sinatra/reloader")
require("./lib/doctor")
require("./lib/patient")
require("./lib/specialty")
also_reload("lib/**/*.rb")

require("pg")
require("pry")

DB = PG.connect({:dbname => "doctor_patient"})

get('/') do
  @specialtys = Specialty.all()
  @doctors = Doctor.all()
  erb(:index)
end

post("/specialtys") do
  name = params.fetch("name")
  specialty = Specialty.new({:name => name, :id => nil})
  specialty.save()
  @specialtys = Specialty.all()
  erb(:index)
end

post("/doctors") do
  name = params.fetch("name")
  specialty_id = params.fetch("specialty_id").to_i()
  doctor = Doctor.new({:id=>nil, :name=>name, :specialty_id=>specialty_id})
  doctor.save()
  @specialty = Specialty.find(specialty_id)
  erb(:specialty)
end

post("/patients") do
  name = params.fetch("name")
  birthdate = params.fetch("birthdate")
  doctor_id = params.fetch("doctor_id").to_i()
  patient = Patient.new({:id=>nil, :name=>name, :birthdate=>birthdate, :doctor_id=>doctor_id})
  patient.save()
  @doctor = Doctor.find(doctor_id)
  erb(:doctor)
end

get('/specialtys/:id') do
  @specialty = Specialty.find(params.fetch("id").to_i())
  erb(:specialty)
end

get('/doctors/:id') do
  @doctor = Doctor.find(params.fetch("id").to_i())
  erb(:doctor)
end
