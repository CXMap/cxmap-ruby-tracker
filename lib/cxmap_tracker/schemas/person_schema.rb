module CXMapTracker
  PersonSchema = Dry::Validation.Form do
    optional(:cxm).maybe(:str?)
    optional(:client_id).maybe(:str?)
    optional(:email).maybe(:str?)
    optional(:phone).maybe(:str?)    

    optional(:first_name).maybe(:str?)
    optional(:last_name).maybe(:str?)
    optional(:gender).maybe(:str?)
    optional(:date_of_birth).maybe(:date?)
    optional(:ip_address).maybe(:str?)
    optional(:geo_country_code).maybe(:str?)
    optional(:geo_subdevision_code).maybe(:str?)
    optional(:geo_city_name).maybe(:str?)
    optional(:geo_time_zone).maybe(:str?)
    optional(:properties).maybe(:hash?)
    optional(:tags).each(:str?)
    
    validate(filled?: [:phone, :email, :client_id, :cxm]) do |phone, email, client_id, cxm|
      cxm.present? || client_id.present? || phone.present? || email.present?
    end
  end
end
