require("spec_helper")

describe(Patient) do

  before() do
    @test_patient = Patient.new({:id => nil, :name => "Patient 1", :birthdate => '2010-10-29', :doctor_id => 1})
  end

  describe('#initialize') do
    it('initialize a patient with all the parameters') do
      expect(@test_patient.name()).to(eq("Patient 1"))
      expect(@test_patient.id()).to(eq(nil))
      expect(@test_patient.birthdate()).to(eq('2010-10-29'))
      expect(@test_patient.doctor_id()).to(eq(1))
    end
  end

  describe('.all') do
    it('the patient list should be empty at first') do
      expect(Patient.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('adds a patient to the array of saved patients') do
      @test_patient.save()
      expect(Patient.all()).to(eq([@test_patient]))
    end
  end

  describe('#==') do
    it("is the same patient if it has the same parameters") do
      test_patient1 = Patient.new({:id => nil, :name => "Patient 1", :birthdate => '2010-10-29', :doctor_id => 1})
      test_patient2 = Patient.new({:id => nil, :name => "Patient 1", :birthdate => '2010-10-29', :doctor_id => 1})
      expect(test_patient1).to(eq(test_patient2))
    end
  end

  describe('.find') do
    it('returns a patient by its id') do
      @test_patient.save()
      test_patient2 = Patient.new({:id => nil, :name => "Patient 2", :birthdate => '2011-10-29', :doctor_id => 1})
      test_patient2.save()
      expect(Patient.find(test_patient2.id())).to(eq(test_patient2))
    end
  end

  describe('#update') do
    it('lets you update the patient details in the database') do
      @test_patient.save()
      @test_patient.update({:name => "Patient 2"})
      @test_patient.update({:birthdate => "2011-10-29"})
      expect(@test_patient.name()).to(eq('Patient 2'))
      expect(@test_patient.birthdate()).to(eq("2011-10-29"))
    end
  end

  describe('#delete') do
    it('lets you delete a patient from the database') do
      @test_patient.save()
      test_patient2 = Patient.new({:id => nil, :name => "Patient 2", :birthdate => '2010-12-29', :doctor_id => 2})
      test_patient2.save()
      @test_patient.delete()
      expect(Patient.all()).to(eq([test_patient2]))
    end
  end
end #end of Patient describe
