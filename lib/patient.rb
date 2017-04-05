require("pry")

class Patient

  attr_reader(:id, :name, :birthdate, :doctor_id)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    @birthdate = attributes.fetch(:birthdate)
    @doctor_id = attributes.fetch(:doctor_id)
  end

  define_singleton_method(:all) do
    returned_patients = DB.exec("SELECT * FROM patients;")
    patients = []
    returned_patients.each() do |patient|
      id = patient.fetch("id").to_i()
      name = patient.fetch("name")
      birthdate = patient.fetch("birthdate")
      doctor_id = patient.fetch("doctor_id").to_i()
      patients.push(Patient.new({:id => id, :name => name, :birthdate => birthdate, :doctor_id => doctor_id}))
    end
    patients
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patients (name, birthdate, doctor_id) VALUES ('#{@name}', '#{@birthdate}', #{@doctor_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_patient|
    self.id().==(another_patient.id()) &&
    self.name().==(another_patient.name()) &&
    self.birthdate().==(another_patient.birthdate()) &&
    self.doctor_id().==(another_patient.doctor_id())
  end

  define_singleton_method(:find) do |id|
    found_patient = nil
    Patient.all().each() do |patient|
      if patient.id().==(id)
        found_patient = patient
      end
    end
    found_patient
  end

  define_method(:update) do |attributes|
    @id = self.id()
    @name = attributes.fetch(:name, @name)
    @birthdate = attributes.fetch(:birthdate, @birthdate)
    @doctor_id = self.doctor_id()
    # DB.exec("UPDATE patients SET name ='#{@name}' WHERE id=#{@id};")
    # DB.exec("UPDATE patients SET birthdate ='#{@birthdate}' WHERE id=#{@id};")
    DB.exec("UPDATE patients SET name='#{@name}', birthdate='#{@birthdate}' WHERE id=#{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM patients where id=#{self.id};")
  end

end #end of Patient class
