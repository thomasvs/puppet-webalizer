require 'spec_helper'
describe 'webalizer' do

  context 'with defaults for all parameters' do
    it { should compile }
    it { should contain_file('/etc/webalizer.conf') }
  end
end

