# coverage_spec.rb
#
# Ensures every eligible file has a corresponding spec
################################################################################

require 'spec_helper'

describe 'coverage' do

  it 'has a spec for every file' do
    pending

    [
      'app/controllers',
      'app/helpers',
      'app/mailers',
      'app/models',
      'app/views',
      'lib/status_cat'
    ].each do |dir|
      Dir.glob( File.join( ENGINE_RAILS_ROOT, dir, '**', '*.{rb,erb}' ) ) do |path|
        path = path.sub( /#{ENGINE_RAILS_ROOT}\//, '' )
        path.should have_a_spec
      end
    end
  end

end
