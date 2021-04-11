require_relative '../lib/client'
require_relative '../lib/job'

describe Job do
    it 'should return job id' do
        id = 0
        date = '20/4/2021'
        client_id = 1
        job = Job.new(id, date, client_id)
        expect(job.id).to eq(id)
    end
    
    it 'should return client existing job list' do
        id = 0
        name = 'Vanessa'
        contact = "vanessa.denardin@gmail.com"
        post_code = 3028
        client = Client.new(id, name, contact, post_code)
        client.job_list.push(Job.new(0, "15/4/2021", client.id))
        client.job_list.push(Job.new(1, "15/4/2021", client.id))

        expect(client.job_list.length).to eq(2)
    end
end
