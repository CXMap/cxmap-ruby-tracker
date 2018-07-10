module CXMapTracker
  ItemSchema = Dry::Validation.Form do
    required(:sku).filled(:str?)
    optional(:name).maybe(:str?)
    optional(:category_id).maybe(:str?)
    optional(:category_name).maybe(:str?)
    required(:price).filled(:float?)
    required(:qnt).filled(:float?)
  end
end
