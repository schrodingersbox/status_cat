namespace :'status-cat' do

  desc 'Run all checkers and output results'
  task :check => :environment do
    include StatusCat::StatusHelper
    Kernel.puts status_report( StatusCat::Status.all )
  end

  desc 'Run all checkers and email failures'
  task :cron => :environment do
    StatusCat::Status.cron
  end

end
