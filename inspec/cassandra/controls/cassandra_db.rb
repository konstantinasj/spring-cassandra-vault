control 'cassandra-db-01' do
    impact 1.0
    title 'login using default password must be forbidden'
    describe command('cqlsh --ssl -u cassandra -p cassandra localhost') do
        its('exit_status') { should_not eq 0 }
    end
end

control 'cassandra-db-02' do
    impact 0.5
    title 'connection without ssl is forbidden'
    describe command('cqlsh -u ktu -p ktu localhost') do
        its('exit_status') { should_not eq 0 }
    end
end

control 'cassandra-db-03' do
    impact 0.5
    title 'connection using ssl is allowed'
    describe command('cqlsh --ssl -u ktu -p ktu localhost') do
        its('exit_status') { should eq 0 }
    end
end