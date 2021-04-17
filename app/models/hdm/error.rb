module Hdm
  class Error < ::StandardError
    def initialize(msg_or_error)
      if msg_or_error.is_a?(Exception)
        super("#{msg_or_error.class}: #{msg_or_error}")
      else
        super
      end
    end
  end
end
