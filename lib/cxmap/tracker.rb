require 'uri'
require 'httparty'

module CXMap
  class Tracker
    include HTTParty

    class Error < StandardError; end
        
    class ValidationError < Error
      attr_reader :validation_messages

      def initialize(message, validation_messages=nil)
        super message
        @validation_messages = validation_messages
      end

    end

    class RequestError < Error
      attr_reader :code, :response, :request_params

      def initialize(code, response, request_params={})
        super "CXMap respond with status #{code}. #{response.lines.first}"
        @response = response
        @code = code
        @request_params = request_params
      end
    end

    EVENTS = %w{
      web_session_start
      page_view
      update_person
      transaction
      login
      signup
      subscribe
      unsubscribe
      email_sent
      email_opened
      email_clicked
      form_submit
      phone_call
      meeting
      custom
    }

    def initialize(app_key, tracker_domain, tracker_timeout=nil)
      raise ArgumentError.new('app_key required') if app_key.blank?
      raise ArgumentError.new('tracker_domain required') if tracker_domain.blank?

      @app_key = app_key
      @tracker_domain = tracker_domain
      @tracker_timeout = tracker_timeout
    end

    # event: String - event name (for example email_click)
    # data: Hash - event data
    # true_performed_at: Time - real event time  
    def track(event, data, true_performed_at=nil)
      if event.blank?
        raise ValidationError.new('event required')
      end

      event = event.to_s.underscore

      # if !event.in?(EVENTS) 
      #   raise ValidationError.new("unknown event #{event}")
      # end

      if data.blank?
        raise ValidationError.new('data required')
      end

      data = data.with_indifferent_access

      schema = begin
        "CXMapTracker::#{event.classify}Schema".constantize
      rescue NameError
        CXMapTracker::EventSchema
      end
      
      validation = schema.call(data)
      if validation.failure?
        raise ValidationError.new('data invalid', validation.messages)
      end

      params = data.select{|_, v| v.present?}
      
      # convert to JSON
      if params[:event_properties].present?
        params[:event_properties] = params[:event_properties].to_json
      end
      
      if params[:context].present?
        params[:context] = params[:context].to_json
      end
      
      # add common attributes
      params[:app_key] = app_key
      params[:event] = event
      params[:tracker_sent_at] = Time.now.utc.iso8601
      params[:tracker_ver] = CXMap.tracker_version
      params[:tracker_name] = CXMap.tracker_name
      params[:true_performed_at] = true_performed_at.utc.iso8601 if true_performed_at.present?

      request(params)

      true
    end

    private

    attr_reader :app_key, :tracker_domain, :tracker_timeout

    def request(params={})
      response = self.class.post(
        "https://#{tracker_domain}/event",
        { 
          body: params,
          headers: {'Content-Type' => 'application/x-www-form-urlencoded'},
          timeout: (tracker_timeout || CXMap.tracker_timeout)
        }
      )
      
      status = response.code
      if status != 200
        raise RequestError.new(status, response, params)
      end 
    end    
  end
end
