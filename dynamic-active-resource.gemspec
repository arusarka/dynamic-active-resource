Gem::Specification.new do |s|
  s.name = 'dynamic-active-resource'
  s.version = '0.1.9'
  s.author = 'asur'
  s.email = 'arusarka@gmail.com'
  s.homepage = 'http://github.com/arusarka/dynamic-active-resource/'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Wrapper around active resource so that classes can be easily reused and also provides associations.'
  s.description = <<-EOS
  A wrapper around active resource. Normally changing active resource attributes doesn't get
  reflected. So this gem allows to dynamically create active resource classes. This gem also
  provides very lightweight activerecord like associations.
  EOS
  s.files = Dir['spec/**/*_spec.rb'] + Dir['spec/spec_helper.rb'] + Dir['test/**/*.rb'] + ['README', 'History.txt', 'init.rb']
  s.require_paths = ['lib']
  s.extra_rdoc_files = ['README']
  s.add_dependency('activeresource')
end