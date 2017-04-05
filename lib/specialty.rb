require('pry')

class Specialty
  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
  end

  attr_reader(:id, :name)

  define_singleton_method(:all) do
    returned_specialtys = DB.exec("SELECT * FROM specialtys")
    specialtys = []
    returned_specialtys.each() do |specialty|
      id = specialty.fetch("id").to_i()
      name = specialty.fetch("name")
      specialtys.push(Specialty.new({:id => id, :name => name}))
    end
    specialtys
  end

  define_method(:==) do |another_patient|
    self.id().==(another_patient.id()) &&
    self.name().==(another_patient.name())
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO specialtys (name) VALUES ('#{name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:find) do |id|
    found_specialty = nil
    Specialty.all().each() do |specialty|
      if specialty.id().==(id)
        found_specialty = specialty
      end
    end
    found_specialty
  end

  define_method(:doctors) do
    specialty_doctors = []
    doctors = DB.exec("SELECT * FROM doctors WHERE specialty_id = #{self.id()};")
    doctors.each() do |doctor|
      id = doctor.fetch("id").to_i()
      name = doctor.fetch("name")
      specialty_id = doctor.fetch("specialty_id").to_i()
      specialty_doctors.push(Doctor.new({:id=>id, :name=>name, :specialty_id=>specialty_id}))
    end
    specialty_doctors
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE specialtys SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM specialtys WHERE id=#{self.id()};")
  end
end #end of specialty class
