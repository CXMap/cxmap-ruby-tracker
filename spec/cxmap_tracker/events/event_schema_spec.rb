require 'spec_helper'

RSpec.describe CXMapTracker::EventSchema do  
  let(:schema){described_class}
  let(:validation){schema.call(data)}
  
  describe 'validation' do
    context 'valid data' do
      let(:data){
        {
          person: {client_id: 'xxx'},
        }
      }

      it 'should be success' do
        expect(validation).to be_success
      end
    end
  end
end
