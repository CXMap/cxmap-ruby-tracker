require 'spec_helper'

RSpec.describe CXMap::Tracker do
  let(:app_key){'xxx'} 
  let(:tracker_domain){'test_tracker.cxmap.io'} 
  let(:instance){described_class.new(app_key, tracker_domain)}

  describe '#track'  do
    context 'event blank' do
      it 'should raise validation error' do
        expect{instance.track(nil, nil)}.to raise_error(CXMap::Tracker::ValidationError, 'event required')
      end
    end

    context 'data blank' do
      it 'should raise validation error' do
        expect{instance.track('event', nil)}.to raise_error(CXMap::Tracker::ValidationError, 'data required')
      end
    end

    context 'event data is not valid' do
      let(:event){'test'}
      let(:data){{person: {}}}

      it 'should raise validation error' do
        expect{instance.track(event, data)}.to raise_error(CXMap::Tracker::ValidationError, 'data invalid')
      end

      it 'should raise fill validation_messages for error object' do
        expect{instance.track(event, data)}.to raise_error(CXMap::Tracker::ValidationError) do |e|
          expect(e.validation_messages).to be_present
          expect(e.validation_messages).to include(:person)
        end
      end
    end

    context 'valid data' do
      let(:event){'event'}
      let(:data){{person: {client_id: 'xxx'}}}
      
      before{
        expect_any_instance_of(described_class).to receive(:request).and_return(true)
      }

      it 'should call request with event data' do
        instance.track(event, data)
      end
    end

    # context 'hit to real tracker' do
    #   let(:tracker_domain){'tracker-us-1.cxmap.io'} 
    #   let(:event){'event'}
    #   let(:data){{person: {client_id: 'xxx'}}}

    #   before{
    #     described_class.debug_output $stdout
    #   }

    #   it 'xxx' do
    #     instance.track(event, data)
    #   end
    # end
  end
end

