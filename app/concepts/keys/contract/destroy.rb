module Keys::Contract
  class Destroy < Reform::Form
    include Keys::Representer::OpenStructModule

    validates :path, presence: true
  end
end
