require 'spec_helper'
describe 'webalizer' do

  context 'with defaults for all parameters' do
    it { should contain_class('webalizer') }
  end
end
