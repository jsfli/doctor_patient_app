require("spec_helper")

describe(Doctor) do

  before() do
    @test_doctor = Doctor.new({:id=>nil, :name=>"Doctor 1", :specialty_id => 1})
  end

  describe('#initialize') do
    it('initialize a doctor with all the parameters') do
      expect(@test_doctor.id()).to(eq(nil))
      expect(@test_doctor.name()).to(eq("Doctor 1"))
      expect(@test_doctor.specialty_id()).to(eq(1))
    end
  end

  describe('.all') do
    it('list of doctors should be empty initiallly') do
      expect(Doctor.all()).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same doctor if it has the same parameters") do
      test_doctor2 = Doctor.new({:id=>nil, :name=>"Doctor 1", :specialty_id => 1})
      expect(@test_doctor).to(eq(test_doctor2))
    end
  end

  describe('#save') do
    it('lets you save a doctor to the database') do
      @test_doctor.save()
      expect(Doctor.all()).to(eq([@test_doctor]))
    end
  end

  describe('.find') do
    it('returns a doctor by its id') do
      @test_doctor.save()
      test_doctor2 = Doctor.new({:id=>nil, :name=>"Doctor 1", :specialty_id => 1})
      test_doctor2.save()
      expect(Doctor.find(test_doctor2.id())).to(eq(test_doctor2))
    end
  end

  describe('#patients') do
    it('returns an array of patients for that doctor') do
      @test_doctor.save()
      test_patient = Patient.new({:id => nil, :name => "Patient 1", :birthdate => '2010-10-29', :doctor_id => @test_doctor.id()})
      test_patient.save()
      test_patient2 = Patient.new({:id => nil, :name => "Patient 2", :birthdate => '2011-11-29', :doctor_id => @test_doctor.id()})
      test_patient2.save()
      expect(@test_doctor.patients()).to(eq([test_patient, test_patient2]))
    end
  end

  describe('#update') do
    it('lets you update the doctor name in the database') do
      @test_doctor.save()
      @test_doctor.update({:name => 'Doctor 2'})
      expect(@test_doctor.name()).to(eq('Doctor 2'))
    end
  end

  describe('#delete') do
    it('lets you delete a doctor from the database') do
      @test_doctor.save()
      test_doctor2 = Doctor.new({:id=>nil, :name=>"Doctor 2", :specialty_id => 1})
      test_doctor2.save()
      @test_doctor.delete()
      expect(Doctor.all()).to(eq([test_doctor2]))
    end
  end
end #end of describe Doctor class
