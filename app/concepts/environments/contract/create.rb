module Environments::Contract
  class Create < Reform::Form
    include Environments::Representer::OpenStructModule

    # validates :name, presence: true, length: {minimum: 1}
  end
end
