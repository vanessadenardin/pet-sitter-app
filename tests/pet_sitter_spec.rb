require_relative '../lib/task'

describe Task do
    it 'should return the description of the task' do
        id = 0
        description = 'clean'
        job_id = 1
        task = Task.new(id, description, job_id)
        expect(task.description).to eq(description)
    end

    it 'should update task status' do
        id = 0
        description = 'clean'
        job_id = 1
        task = Task.new(id, description, job_id)
        task.switch_task_status()
        expect(task.status).to eq(true)
    end
end
