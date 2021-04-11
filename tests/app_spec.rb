require_relative '../lib/app'

describe App do
    # generate a sample database file
    before(:all) do
        @database_file = "test.json"
        @initial_data = {
            "pets": [],
            "pet_sitters": [],
            "clients": [],
            "jobs": [],
            "tasks": []
        }
        File.write(@database_file, @initial_data.to_json)
        @app = App.new(@database_file)
    end

    it 'should only accept dd/mm/YYYY dates' do
        date = "01/01/2021"
        begin
            valid = @app.validate_date(date)
        rescue
            valid = false
        end
        expect(valid).to eq(true)
    end

    it 'should only accept dd/mm/YYYY dates' do
        date = "01/30/2021"
        begin
            valid = @app.validate_date(date)
        rescue
            valid = false
        end
        expect(valid).to eq(false)
    end

    it 'should not accept dd-mm-YYYY dates' do
        date = "01-01-2021"
        begin
            valid = @app.validate_date(date)
        rescue
            valid = false
        end
        expect(valid).to eq(false)
    end

    it 'should not accept dd/mm/YY dates' do
        date = "01/01/21"
        begin
            valid = @app.validate_date(date)
        rescue
            valid = false
        end
        expect(valid).to eq(false)
    end

    it 'should not accept dd/mm/YY dates' do
        date = "01/01/21"
        begin
            valid = @app.validate_date(date)
        rescue
            valid = false
        end
        expect(valid).to eq(false)
    end

    it 'should not accept invalid dates' do
        date = "12th of April"
        begin
            valid = @app.validate_date(date)
        rescue
            valid = false
        end
        expect(valid).to eq(false)
    end

    it 'should not accept invalid dates' do
        date = 123456
        begin
            valid = @app.validate_date(date)
        rescue
            valid = false
        end
        expect(valid).to eq(false)
    end
end
