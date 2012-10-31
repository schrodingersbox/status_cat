namespace :'status-cat' do

  desc 'Run all checkers and output results'
  task :check => :environment do
    Kernel.puts StatusCat::Status.report
  end

end
