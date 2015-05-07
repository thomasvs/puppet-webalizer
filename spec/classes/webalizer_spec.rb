require 'spec_helper'
describe 'webalizer' do

  context 'with defaults for all parameters' do
    it { should compile }
    it { should contain_file('/etc/webalizer.conf').without_content(/^DNSChildren.*$/) }
    it { should contain_file('/etc/webalizer.conf').without_content(/^DNSCache.*$/) }

    context 'with dnschildren = 5' do
       let(:params) {{ :dnschildren => '5' }}
       it  { should contain_file('/etc/webalizer.conf').with_content(/^DNSChildren\s+5$/) }
    end 
    context 'with dnscache = /tmp/dns_cache.db' do
       let(:params) {{ :dnscache => '/tmp/dns_cache.db' }}
       it  { should contain_file('/etc/webalizer.conf').with_content(/^DNSCache\s+\/tmp\/dns_cache.db$/) }      
    end 
  end
end

