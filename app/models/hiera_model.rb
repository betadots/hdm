class HieraModel
  include ActiveModel::Model
  include ActiveModel::Attributes

  private

  def hiera_data
    @hiera_data ||= HieraData.new(environment.name) if respond_to?(:environment)
  end
end
