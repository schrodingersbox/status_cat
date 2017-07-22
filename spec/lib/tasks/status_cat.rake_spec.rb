require 'rake'

describe 'status_cat rake tasks' do

  before(:each) do
    @rake = Rake::Application.new
    Rake.application = @rake
    Rake::Task.define_task(:environment)
    load 'lib/tasks/status_cat.rake'
  end

  describe 'rake status_cat:check' do

    it 'puts the status report' do
      expect(Kernel).to receive(:puts).with(kind_of(String))
      @rake['status_cat:check'].invoke
    end
  end

  describe 'rake status_cat:cron' do

    it 'calls StatusCat::Status.cron' do
      expect(StatusCat::Status).to receive(:cron)
      @rake['status_cat:cron'].invoke
    end
  end
end
