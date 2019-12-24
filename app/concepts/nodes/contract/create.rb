module Nodes::Contract
  class Create < Reform::Form
    include Nodes::Representer::OpenStructModule

    # validates :name, presence: true, length: {minimum: 1}
  end
end
