class PurchasableValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless Content.find_by(id: value).try(:purchasable?)
      record.errors[attribute] << (options[:message] || 'is not purchasable')
    end
  end
end
