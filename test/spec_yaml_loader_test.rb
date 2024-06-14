# frozen_string_literal: true

require "minitest/autorun"
require_relative "../lib/spec_yaml_loader"

class TestSpecYAMLLoaderTest < Minitest::Test
  def setup
    @specs = SpecYAMLLoader.load!("test/example")
  end

  def test_loads_basic_run_spec
    name = "a basic run spec"
    spec = @specs.find(name)

    assert spec.name == name
    assert spec.steps.size == 1
    assert spec.steps.first.is_a? RunStep
    assert spec.steps.first.commands.size == 1
    assert spec.steps.first.commands.first == "some command"
  end
end
