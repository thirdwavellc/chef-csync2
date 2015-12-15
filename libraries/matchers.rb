def create_csync2_config(resource_name)
  ChefSpec::Matchers::ResourceMatcher.new(:csync2_config, :create, resource_name)
end
