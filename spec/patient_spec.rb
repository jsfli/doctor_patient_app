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
      test_patient2 = Patient.new({:id => nil, :name => "Patient 1", :birthdate => '2010-10-29', :doctor_id => 1})
      expect(@test_patient).to(eq(test_patient2))
    end
  end
end #end of Patient describe
