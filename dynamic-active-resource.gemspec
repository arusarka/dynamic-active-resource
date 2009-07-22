Gem::Specification.new do |s|
  s.name = 'dynamic-active-resource'
  s.version = '0.0.2'
  s.author = 'asur'
  s.email = 'arusarka@gmail.com'
  s.homepage = 'http://github.com/arusarka/dynamic-active-resource/'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Wrapper around active resource so that classes can be easily reused'
  s.description = <<-EOS
  A wrapper around active resource. Normally changing active resource attributes doesn't get
  reflected. So this gem allows to dynamically create active resource classes
  EOS
  s.files = Dir['lib/**/*.rb'] + Dir['spec/**/*_spec.rb'] + Dir['test/**/*.rb'] + ['README', 'History.txt']
  s.require_path = 'lib'
  s.extra_rdoc_files = ['README']
  s.add_dependency('activeresource')
end