require 'hiera/backend/eyaml'
require 'hiera/backend/eyaml/logginghelper'
require 'hiera/backend/eyaml/utils'
require 'hiera/backend/eyaml/options'
require 'hiera/backend/eyaml/parser/parser'
require 'hiera/backend/eyaml/plugins'
require 'hiera/backend/eyaml/encryptors/pkcs7'

# Register all plugins
Hiera::Backend::Eyaml::Encryptors::Pkcs7.register
Hiera::Backend::Eyaml::Plugins.find
