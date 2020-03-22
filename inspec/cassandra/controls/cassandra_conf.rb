control 'cassandra-conf-01' do
    impact 1.0
    title 'password autenticator must be used'
    describe yaml('/etc/cassandra/cassandra.yaml') do
        its('authenticator') { should eq 'PasswordAuthenticator' }
    end
end

control 'cassandra-conf-02' do
    impact 1.0
    title 'cassandra authorizer must be used'
    describe yaml('/etc/cassandra/cassandra.yaml') do
        its('authorizer') { should eq 'CassandraAuthorizer' }
    end
end

control 'cassandra-conf-03' do
    impact 0.5
    title 'ssl between client and node must be configured'
    describe yaml('/etc/cassandra/cassandra.yaml') do
        its(['client_encryption_options', 'enabled']) { should eq true }
        its(['client_encryption_options', 'optional']) { should eq false }
        its(['client_encryption_options', 'keystore']) { should eq '/opt/ssl/node1.keystore.jks' }
        its(['client_encryption_options', 'keystore_password']) { should eq 'changeyourdefaults' }
        its(['client_encryption_options', 'require_client_auth']) { should eq false }
        its(['client_encryption_options', 'truststore']) { should eq '/opt/ssl/ca.truststore.jks' }
        its(['client_encryption_options', 'truststore_password']) { should eq 'changeyourdefaults' }
    end
end

control 'cassandra-conf-04' do
    impact 0.5
    title 'ensure config file is owned by cassandra'
    describe file('/etc/cassandra/cassandra.yaml') do
        it { should be_file }
    	it { should be_owned_by 'cassandra' }
    	it { should be_grouped_into 'root' }
    	it { should_not be_readable.by('others') }
    end
end

control 'cassandra-conf-05' do
    impact 0.5
    title 'ensure certificate files are owned by cassandra'
    describe file('/opt/ssl/node1.keystore.jks') do
        it { should be_file }
    	it { should be_owned_by 'cassandra' }
    	it { should be_grouped_into 'root' }
    	it { should_not be_readable.by('others') }
	end
	describe file('/opt/ssl/ca.truststore.jks') do
        it { should be_file }
    	it { should be_owned_by 'cassandra' }
    	it { should be_grouped_into 'root' }
    	it { should_not be_readable.by('others') }
	end
	describe file('/opt/ssl/ca.cer.pem') do
        it { should be_file }
    	it { should be_owned_by 'cassandra' }
    	it { should be_grouped_into 'root' }
    	it { should_not be_readable.by('others') }
    end
end