require("spec_helper")

describe(Specialty) do

  before() do
    @test_specialty = Specialty.new({:id=>nil, :name=>'Specialty 1'})
  end

  describe('#initialize') do
    it('initalize a specialty with all the parameters') do
      expect(@test_specialty.id()).to(eq(nil))
      expect(@test_specialty.name()).to(eq('Specialty 1'))
    end
  end

  describe('#==') do
    it('is the same specialty if it has the same parameters') do
      test_specialty2 = Specialty.new({:id=>nil, :name=>'Specialty 1'})
      expect(@test_specialty).to(eq(test_specialty2))
    end
  end

  describe('#save') do
    it('lets you save a specialty to the database') do
      @test_specialty.save()
      expect(Specialty.all()).to(eq([@test_specialty]))
    end
  end

  describe('.find') do
    it('returns a specialty by its id') do
      @test_specialty.save()
      test_specialty2 = Specialty.new({:id=>nil, :name=>'Specialty 1'})
      test_specialty2.save()
      expect(Specialty.find(test_specialty2.id())).to(eq(test_specialty2))
    end
  end

  describe('#doctors') do
    it('returns an array of doctors for that specialty') do
      @test_specialty.save()
      test_doctor = Doctor.new({:id=>nil, :name=>"Doctor 1", :specialty_id => @test_specialty.id()})
      test_doctor.save()
      test_doctor2 = Doctor.new({:id=>nil, :name=>"Doctor 2", :specialty_id => @test_specialty.id()})
      test_doctor2.save()
      expect(@test_specialty.doctors()).to(eq([test_doctor, test_doctor2]))
    end
  end

  describe('#update') do
    it('lets you update the specialty name in the database') do
      @test_specialty.save()
      @test_specialty.update({:name => 'Specialty 2'})
      expect(@test_specialty.name()).to(eq('Specialty 2'))
    end
  end

  describe('@delete') do
    it('lets you delete a specialty from the database') do
      @test_specialty.save()
      test_specialty2 = Specialty.new({:id=>nil, :name=>'Specialty 1'})
      test_specialty2.save()
      @test_specialty.delete()
      expect(Specialty.all()).to(eq([test_specialty2]))
    end
  end
end
