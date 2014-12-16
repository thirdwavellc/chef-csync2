require 'spec_helper'

describe 'csync2::default' do
  let(:chef_run) { ChefSpec::ServerRunner.new.converge(described_recipe) }

  it 'should install the csync2 package' do
    expect(chef_run).to install_package('csync2')
  end
end
