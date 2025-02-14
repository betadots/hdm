Hdm::VERSION = if ENV['container']
                 File.read('/VERSION')
               else
                'unknown'
               end
