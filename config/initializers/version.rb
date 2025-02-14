Hdm::VERSION = if File.exist? '/VERSION'
                 File.read('/VERSION')
               elsif system("git --version > /dev/null 2>&1")
                `git describe`.strip
               else
                'unknown'
               end
