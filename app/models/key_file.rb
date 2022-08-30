class KeyFile
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :environment
  attribute :hierarchy_name, :string
  attribute :path, :string
  attribute :value, :string

  def self.all(environment, key)
    HieraData.new(environment.name).files_including(key).map do |file|
      new(
        environment: environment,
        path: file[:path],
        hierarchy_name: file[:hierarchy_name],
        value: file[:value]
      )
    end
  end
end
