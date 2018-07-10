require 'spec_helper'

RSpec.describe CXMapTracker::PageViewSchema do  
  let(:schema){described_class}
  let(:validation){schema.call(data)}
  
  describe 'validation' do
    context 'valid data' do
      let(:data){
        {
          person: {client_id: 'xxx'},
          event_properties: {url: 'xxx', referrer: '', page_title: ''}
        }
      }

      it 'should be success' do
        expect(validation).to be_success
      end
    end
  end
end
