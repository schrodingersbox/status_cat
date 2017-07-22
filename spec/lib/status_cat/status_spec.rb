describe StatusCat::Status do

  #############################################################################
  # ::all
  #############################################################################

  describe '::all' do

    it 'returns an array of enabled checkers' do
      enabled = StatusCat::Config.instance.enabled
      expect(StatusCat::Config.instance).to receive(:enabled).and_return(enabled)

      all = StatusCat::Status.all
      expect(all).to be_an_instance_of(Array)
      expect(all.length).to eql(StatusCat::Checkers::Base.descendants.length)
      all.each { |checker| expect(checker).to be_a_kind_of(StatusCat::Checkers::Base) }
    end
  end

  #############################################################################
  # ::check
  #############################################################################

  describe '::check' do

    def checker_array_should_have_names(actual, expected)
      expect(actual).to be_a_kind_of(Array)
      expect(actual.length).to eql(expected.length)
      actual.each_index { |i| expect(actual[i].name).to be(expected[i]) }
    end

    it 'defaults to all checkers' do
      names = StatusCat::Status.all.map(&:name)
      checkers = StatusCat::Status.check
      checker_array_should_have_names(checkers, names)
    end

    it 'returns all checkers when :all is specified' do
      names = StatusCat::Status.all.map(&:name)
      checkers = StatusCat::Status.check(:all)
      checker_array_should_have_names(checkers, names)
    end

    it 'returns a single checker when given a single symbolic name' do
      expect(StatusCat::Status.check(:active_record)).to be_an_instance_of(StatusCat::Checkers::ActiveRecord)
    end

    it 'returns an array of checkers when given an array of symbolic name' do
      names = [:active_record, :action_mailer]
      checkers = StatusCat::Status.check(names)
      checker_array_should_have_names(checkers, names)
    end
  end

  #############################################################################
  # ::cron
  #############################################################################

  describe '::cron' do

    it 'delivers email if ::failed is not empty' do
      failed = [StatusCat::Checkers::Base.new]
      mail = StatusCat::StatusMailer.failure(failed)
      expect(StatusCat::Status).to receive(:failed).and_return(failed)
      expect(StatusCat::StatusMailer).to receive(:failure).with(failed).and_return(mail)
      StatusCat::Status.cron
    end

    it 'does not email when ::failed is empty' do
      expect(StatusCat::Status).to receive(:failed).and_return([])
      expect(StatusCat::StatusMailer).to_not receive(:failure)
      StatusCat::Status.cron
    end
  end

  #############################################################################
  # ::factory
  #############################################################################

  describe '::factory' do

    it 'constructs a checker given its symbolic name' do
      expect(StatusCat::Status.factory(:action_mailer)).to be_an_instance_of(StatusCat::Checkers::ActionMailer)
      expect(StatusCat::Status.factory(:active_record)).to be_an_instance_of(StatusCat::Checkers::ActiveRecord)
    end
  end

  #############################################################################
  # ::failed
  #############################################################################

  describe '::failed' do

    before(:each) do
      @pass = StatusCat::Checkers::Base.new

      @fail = StatusCat::Checkers::Base.new
      allow(@fail).to receive(:status).and_return(:fail)
    end

    it 'returns only failed checkers from ::all' do
      expect(StatusCat::Status).to receive(:all).and_return([@pass, @fail])
      expect(StatusCat::Status.failed).to eql([@fail])
    end

    it 'returns an empty list if all checkers pass' do
      expect(StatusCat::Status).to receive(:all).and_return([@pass])
      expect(StatusCat::Status.failed).to eql([])
    end
  end
end
