module CXMapTracker
  EventSchema = Dry::Validation.Form do
    required(:person).schema(PersonSchema)
  end

  # List events with addition validations
  WebSessionStartSchema = Dry::Validation.Schema(EventSchema) do
    event_properties = Dry::Validation.Schema(PropertiesSchema) do
      required(:url).filled(:str?)
      optional(:referrer).maybe(:str?)
      optional(:page_title).maybe(:str?)
    end

    required(:session_id).filled(:str?)
    required(:event_properties).schema(event_properties)
  end

  PageViewSchema = Dry::Validation.Schema(EventSchema) do
    event_properties = Dry::Validation.Schema(PropertiesSchema) do
      required(:url).filled(:str?)
      optional(:referrer).maybe(:str?)
      optional(:page_title).maybe(:str?)
    end

    required(:event_properties).schema(PropertiesSchema)
  end

  TransactionSchema = Dry::Validation.Schema(EventSchema) do
    event_properties = Dry::Validation.Schema(PropertiesSchema) do
      required(:order_id).filled(:str?)
      required(:total).filled(:float?)
      optional(:currency_iso).maybe(:str?)
      required(:items).each do 
        schema(ItemSchema)
      end
    end
    
    required(:event_properties).schema(event_properties)
  end

  EmailSentSchema = Dry::Validation.Schema(EventSchema) do
    required(:label).filled(:str?)
  end

  EmailOpenedSchema = Dry::Validation.Schema(EventSchema) do
    required(:label).filled(:str?)
  end

  EmailClickedSchema = Dry::Validation.Schema(EventSchema) do
    required(:label).filled(:str?)
  end

  FormSubmitSchema = Dry::Validation.Schema(EventSchema) do
    required(:label).filled(:str?)
  end
end
