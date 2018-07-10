require 'spec_helper'

RSpec.describe CXMapTracker::PersonSchema do  
  let(:schema){described_class}
  let(:validation){schema.call(data)}
  
  describe 'validation' do
    context 'valid data' do
      let(:data){
        {
          client_id: 'xxx'
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
        expect(validation.messages).to include(:client_id)
        expect(validation.messages[:client_id]).to include(/must be filled/)
      end
    end
  end
end
