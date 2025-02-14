Hdm::VERSION = if File.exist? '/VERSION'
                 File.read('/VERSION')
               else
                'unknown'
               end
