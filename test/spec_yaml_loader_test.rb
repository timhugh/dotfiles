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

    assert_equal name, spec.name
    assert_equal 1, spec.steps.size
    step = spec.steps.first
    assert step.is_a? RunStep
    assert_equal 1, step.commands.size
    assert_equal "some command", step.commands.first
  end

  def test_loads_basic_link_spec
    name = "a basic link spec"
    spec = @specs.find(name)

    assert_equal name, spec.name
    assert_equal 1, spec.steps.size
    step = spec.steps.first
    assert step.is_a? LinkStep
    assert_equal "source-file", step.source
    assert_equal "destination-file", step.destination
    refute step.force
  end

  def test_loads_basic_brew_spec
    name = "a basic brew spec"
    spec = @specs.find(name)

    assert_equal name, spec.name
    assert_equal 1, spec.steps.size
    step = spec.steps.first
    assert step.is_a? BrewStep
    assert_equal ["brew-formula"], step.brews
    assert_equal ["cask-formula"], step.casks
    assert_equal [{"name" => "apple-store-app", "id" => 1234567890}], step.mas
  end

  def test_loads_spec_with_multi_step_run_step
    name = "a spec with a multi-step run step"
    spec = @specs.find(name)

    assert_equal name, spec.name
    assert_equal 1, spec.steps.size
    step = spec.steps.first
    assert step.is_a? RunStep
    assert_equal 3, step.commands.size
    assert_equal "first command", step.commands[0]
    assert_equal "second command", step.commands[1]
    assert_equal "third command", step.commands[2]
  end
end
