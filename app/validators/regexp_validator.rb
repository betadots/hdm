class RegexpValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, values)
    Array(values).each do |value|
      Regexp.new(value)
    end
  rescue RegexpError
    record.errors.add(attribute, :invalid)
  end
end
