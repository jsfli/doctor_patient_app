require("pry")

class Doctor
  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    @specialty_id = attributes.fetch(:specialty_id)
  end

    attr_reader(:id, :name, :specialty_id)

  define_singleton_method(:all) do
    returned_doctors = DB.exec("SELECT * FROM doctors;")
    doctors = []
    returned_doctors.each() do |doctor|
      id = doctor.fetch("id").to_i()
      name = doctor.fetch("name")
      specialty_id = doctor.fetch("specialty_id").to_i()
      doctors.push(Doctor.new({:id => id, :name => name, :specialty_id => specialty_id}))
    end
    doctors
  end

  define_method(:==) do |another_doctor|
    self.id().==(another_doctor.id()) &&
    self.name().==(another_doctor.name()) &&
    self.specialty_id().==(another_doctor.specialty_id())
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO doctors (name, specialty_id) VALUES ('#{@name}', #{@specialty_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:find) do |id|
    found_doctor = nil
    Doctor.all().each() do |doctor|
      if doctor.id().==(id)
        found_doctor = doctor
      end
    end
    found_doctor
  end

  define_method(:patients) do
    doctor_patients = []
    patients = DB.exec("SELECT * FROM patients WHERE doctor_id = #{self.id()};")
    patients.each() do |patient|
      id = patient.fetch("id").to_i()
      name = patient.fetch("name")
      birthdate = patient.fetch("birthdate")
      doctor_id = patient.fetch("doctor_id").to_i()
      doctor_patients.push(Patient.new({:id=>id, :name=>name, :birthdate=>birthdate, :doctor_id=>doctor_id}))
    end
    doctor_patients
  end

end #end of Doctor class
