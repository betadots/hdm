class Hierarchy
  attr_reader :name, :environment, :datadir, :backend, :files

  def self.all(environment, node)
    facts = node.facts
    HieraData.new(environment.name).hierarchies.map do |hierarchy|
      new(environment: environment,
          name: hierarchy.name,
          datadir: hierarchy.datadir,
          backend: hierarchy.backend,
          files: hierarchy.resolved_paths(facts: facts))
    end
  end

  def self.find(environment, node, name)
    all(environment, node).find { |h| h.name == name }
  end

  def initialize(environment:, name:, datadir:, backend:, files:)
    @environment = environment
    @name = name
    @datadir = datadir
    @backend = backend
    @files = files
  end

  def values_for(key)
    @values ||= {}
    @values[key] ||=
      HieraData.new(@environment.name).search_key(@datadir, @files, key.name).map do |path, path_data|
        Value.new(hierarchy: self,
                  key: key,
                  path: path,
                  file_present: path_data[:file_present],
                  key_present: path_data[:key_present],
                  value: path_data[:value])
      end
  end
end
