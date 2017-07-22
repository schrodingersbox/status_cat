describe StatusCat::StatusMailer do

  it 'adds StatusCat::StatusHelper as a template helper' do
    modules = StatusCat::StatusMailer._helpers.included_modules
    expect(modules).to include(StatusCat::StatusHelper)
  end

  describe '#failure' do

    let(:mail) { StatusCat::StatusMailer.failure(StatusCat::Status.all) }
    let(:config) { StatusCat.config }

    it 'uses the configured from address' do
      expect(mail.from).to_not be_nil
      expect(mail.from).to eql([config.from])
    end

    it 'uses the configured to address' do
      expect(mail.to).to_not be_nil
      expect(mail.to).to eql([config.to])
    end

    it 'uses the configured subject' do
      expect(mail.subject).to_not be_nil
      expect(mail.subject).to eql(config.subject)
    end

    it 'generates a multipart email with both text and html' do
      expect(mail.parts.first.content_type).to eql('text/plain; charset=UTF-8')
      expect(mail.parts.second.content_type).to eql('text/html; charset=UTF-8')
    end
  end
end
