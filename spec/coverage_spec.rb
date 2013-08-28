# coverage_spec.rb
#
# Ensures every eligible file has a corresponding spec
################################################################################

require 'spec_helper'

describe 'coverage' do

  it 'has a spec for every file' do
    [
      'app',
      'lib',
    ].each do |dir|
      Dir.glob( File.join( ENGINE_ROOT, dir, '**', '*.{rb,erb,rake}' ) ) do |path|
        path = path.sub( /#{ENGINE_ROOT}\//, '' )
        path.should have_a_spec
      end
    end
  end

end
