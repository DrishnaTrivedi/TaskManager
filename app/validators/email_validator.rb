class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      record.errors.add(attribute, "Add a valid email address")
    end
  end
end