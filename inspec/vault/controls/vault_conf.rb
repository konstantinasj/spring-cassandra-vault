control 'vault-conf-01' do
    impact 0.7
    title 'ensure config file is owned by root'
    describe file('/vault/config/vault-config.json') do
        it { should be_file }
    	it { should be_owned_by 'root' }
    	it { should be_grouped_into 'root' }
    	it { should_not be_readable.by('others') }
    end
end

control 'vault-conf-02' do
    impact 0.5
    title 'ensure certificate files are owned by root'
    describe file('/vault/config/vault.crt') do
        it { should be_file }
    	it { should be_owned_by 'root' }
    	it { should be_grouped_into 'root' }
    	it { should_not be_readable.by('others') }
	end
	describe file('/vault/config/vault.key') do
        it { should be_file }
    	it { should be_owned_by 'root' }
    	it { should be_grouped_into 'root' }
    	it { should_not be_readable.by('others') }
	end
end

control 'vault-conf-03' do
    impact 0.5
    title 'ensure ssl is configured and correct certificates are used'
	describe json('/vault/config/vault-config.json') do
		its(['listener','tcp', 'tls_cert_file']) { should eq '/vault/config/vault.crt' }
		its(['listener','tcp', 'tls_key_file']) { should eq '/vault/config/vault.key' }
		its(['listener','tcp', 'tls_disable']) { should eq 0 }
	end
end