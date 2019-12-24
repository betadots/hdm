require 'test_helper'

class LookupTest < ActiveSupport::TestCase
  test "reads from environment" do
    generate_scope do |scope|
      keys = ["psick::firstrun::linux_classes", "psick::time::servers"]
      explain = true
      explain_options = false
      options = { type: nil }
      use_default_value = false
      merge_options = nil
      only_explain_options = false
      # formar :s or :yaml
      renderer = Puppet::Network::FormatHandler.format(:s)
    
      lookup_invocation = Puppet::Pops::Lookup::Invocation.new(scope, {}, {}, explain ? Puppet::Pops::Lookup::Explainer.new(explain_options, only_explain_options) : nil)
      begin
        # type = options.include?(:type) ? Puppet::Pops::Types::TypeParser.singleton.parse(options[:type], scope) : nil
        type = nil
        result = Puppet::Pops::Lookup.lookup(keys, type, options[:default_value], use_default_value, merge_options, lookup_invocation)
        puts renderer.render(result) unless explain
      rescue Puppet::DataBinding::LookupError => e
        lookup_invocation.report_text { e.message }
        exit(1) unless explain
      end
      # puts lookup_invocation.explainer.explain
      # puts renderer.render(lookup_invocation.explainer.to_hash)
    end
  end

  def generate_scope
    env_name = 'development'
    env_dir = '/Users/fernandes/src/hdm/puppet/environments'
    Puppet.settings[:vardir] = '/Users/fernandes/src/hdm/tmp'
    Puppet.settings[:codedir] = '/Users/fernandes/src/hdm/puppet'
    Puppet.settings[:confdir] = '/Users/fernandes/src/hdm/puppet'
    Puppet.settings[:rundir] = '/Users/fernandes/src/hdm/puppet'
    Puppet.settings[:logdir] = '/Users/fernandes/src/hdm/puppet'
    env = Puppet::Node::Environment.create(env_name.to_sym, [File.join(env_dir, env_name, 'modules')])
    environments = Puppet::Environments::Directories.new(env_dir, [])
  
    Puppet.override(:environments => environments, :current_environment => env) do
      node = Puppet::Node.new('testhost', :environment => env)
      fact_file = '/Users/fernandes/src/hdm/puppet/testhost_facts.json'
      given_facts = Puppet::Util::Json.load(Puppet::FileSystem.read(fact_file, :encoding => 'utf-8'))
      node.fact_merge(Puppet::Node::Facts.new('me', given_facts))
      compiler = Puppet::Parser::Compiler.new(node)
      compiler.compile { |catalog| yield(compiler.topscope); catalog }
    end
  end
end
