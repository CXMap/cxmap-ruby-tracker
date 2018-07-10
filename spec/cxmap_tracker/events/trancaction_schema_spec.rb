require 'spec_helper'

RSpec.describe CXMapTracker::TransactionSchema do  
  let(:schema){described_class}
  let(:validation){schema.call(data)}
  
  describe 'validation' do
    context 'valid data' do
      let(:data){
        {
          person: {client_id: 'xxx'},
          event_properties: {
            order_id: 'xxx',
            total: 100.0,
            currency_iso: '', 
            items: [
              {sku: 'xxx', name: '', category_id: '', category_name: '', price: 100.0, qnt: 1.0}
            ]
          }
        }
      }

      it 'should be success' do
        expect(validation).to be_success
      end
    end
  end
end
