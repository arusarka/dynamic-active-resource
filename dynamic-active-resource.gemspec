Gem::Specification.new do |s|
  s.name = 'dynamic-active-resource'
  s.version = '0.2.6'
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
  s.files = ["lib/dynamic_active_resource/associations/base.rb", "lib/dynamic_active_resource/associations/belongs_to.rb", "lib/dynamic_active_resource/associations/has_many.rb", 
    "lib/dynamic_active_resource/associations.rb", "lib/dynamic_active_resource/base.rb", "lib/dynamic_active_resource/common_class_methods.rb", "lib/dynamic_active_resource/common_dynamic_class_instance_methods.rb",
    "lib/dynamic_active_resource/helpers.rb", "lib/dynamic_active_resource/version.rb",
    "lib/dynamic_active_resource.rb", "test/integration/test_dynamic_active_resource.rb", "test/integration/test_dynamic_active_resource2.rb", "spec/dynamic_active_resource/associations_spec.rb",
    "spec/dynamic_active_resource/base_spec.rb", "spec/dynamic_active_resource/common_dynamic_class_instance_methods_spec.rb", "spec/dynamic_active_resource/version_spec.rb", 'spec/spec_helper.rb', 
    'README', 'History.txt', 'init.rb']
  s.require_paths = ['lib']
  s.extra_rdoc_files = ['README']
  s.add_dependency('activeresource')
end