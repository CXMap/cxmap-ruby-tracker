require 'spec_helper'

RSpec.describe CXMapTracker::EventSchema do  
  let(:schema){described_class}
  let(:validation){schema.call(data)}
  
  describe 'validation' do
    context 'valid data' do
      let(:data){
        {
          person: {client_id: 'xxx'}
        }
      }

      it 'should be success' do
        expect(validation).to be_success
      end
    end

    context 'invalid data' do
      let(:data){Hash.new()}
      
      before{
        expect(validation).to be_failure
      }

      it 'should return error messages' do
        expect(validation.messages).to be_present
        expect(validation.messages).to include(:person)
        expect(validation.messages[:person]).to include(/is missing/)
      end
    end
  end
end
