# coverage_spec.rb
#
# Ensures every eligible file has a corresponding spec
################################################################################

describe 'coverage' do

  it 'has a spec for every file' do
    [
      'app',
      'lib',
    ].each do |dir|
      Dir.glob( File.join( ENGINE_ROOT, dir, '**', '*.{rb,erb,rake}' ) ) do |path|
        path = path.sub( /#{ENGINE_ROOT}\//, '' )
        expect( path ).to have_a_spec
      end
    end
  end

end
