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

  def test_loads_spec_with_multiple_steps
    name = "a spec with multiple steps"
    spec = @specs.find(name)

    assert_equal name, spec.name
    assert_equal 2, spec.steps.size

    first_step = spec.steps.first
    assert first_step.is_a? RunStep
    assert_equal 1, first_step.commands.size
    assert_equal "some command", first_step.commands[0]

    second_step = spec.steps.last
    assert second_step.is_a? LinkStep
    assert_equal "source-file", second_step.source
    assert_equal "destination-file", second_step.destination
    refute second_step.force
  end

  def test_loads_a_spec_with_named_steps
    name = "a spec with named steps"
    spec = @specs.find(name)

    assert_equal name, spec.name
    assert_equal 2, spec.steps.size

    first_step = spec.steps.first
    assert first_step.is_a? RunStep
    assert_equal "run the command", first_step.name
    assert_equal "some command", first_step.commands[0]

    second_step = spec.steps.last
    assert second_step.is_a? LinkStep
    assert_equal "link the config file", second_step.name
    assert_equal "src/config-file", second_step.source
    assert_equal "dest/config-file", second_step.destination
  end

  def test_loads_a_spec_with_a_dependency
    name = "a spec with a dependency"
    spec = @specs.find(name)

    assert_equal name, spec.name
    assert_equal 1, spec.steps.size
    assert_equal ["a basic run spec"], spec.needs

    step = spec.steps.first
    assert step.is_a? RunStep
    assert_equal 1, step.commands.size
    assert_equal "some command", step.commands.first
  end

  def test_loads_a_spec_with_multiple_dependencies
    name = "a spec with multiple dependencies"
    spec = @specs.find(name)

    assert_equal name, spec.name
    assert_equal 1, spec.steps.size
    assert_equal ["a basic run spec", "a basic link spec"], spec.needs

    step = spec.steps.first
    assert step.is_a? RunStep
    assert_equal 1, step.commands.size
    assert_equal "some command", step.commands.first
  end

  def test_loads_a_spec_with_an_if_condition
    name = "a spec with an if condition"
    spec = @specs.find(name)

    assert_equal name, spec.name
    assert_equal 1, spec.steps.size
  end
end
