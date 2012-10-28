namespace :'status-cat' do

  desc 'Run all checkers and output results'
  task :check => :environment do
    puts StatusCat::Status.report
  end

end
