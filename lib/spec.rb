# frozen_string_literal: true

class InvalidSpecError < RuntimeError; end

class SpecTree
  def initialize(specs)
    @specs = specs
  end

  def find(name)
    @specs.find { |spec| spec.name == name }
  end

  def self.build_from_raw!(raw_specs)
    specs = raw_specs.map { |raw_spec| Spec.build_from_raw!(raw_spec) }
    new(specs)
  end
end

class Spec
  attr_reader :name
  attr_reader :steps

  def initialize(name, steps)
    @name = name.freeze
    @steps = steps.freeze
  end

  class << self
    def build_from_raw!(raw_spec)
      Spec.new(raw_spec["name"], build_steps(raw_spec))
    end

    private

    def build_step(raw_step)
      type = raw_step.keys.find { |key| %w[run link brew].include? key }
      case type
      when "run"
        RunStep.build_from_raw!(raw_step)
      when "link"
        LinkStep.build_from_raw!(raw_step)
      when "brew"
        BrewStep.build_from_raw!(raw_step)
      else
        raise "build_step called with unknown type #{type}"
      end
    end

    def build_steps(raw_spec)
      if raw_spec.keys.count { |key| %w[steps run link brew].include? key } != 1
        throw InvalidSpecError, "a spec must have exactly one of 'steps, 'run', 'link' or 'brew'"
      end

      if raw_spec["steps"]
        raw_spec["steps"].map { |step| build_step(step) }
      else
        [build_step(raw_spec)]
      end
    end
  end
end

class Step
  attr_reader :name

  def initialize(name)
    @name = name.freeze
  end
end

class RunStep < Step
  attr_reader :commands

  def initialize(name, commands)
    super(name)
    @commands = Array(commands).freeze
  end

  def self.build_from_raw!(raw_spec)
    RunStep.new(raw_spec["name"], raw_spec["run"])
  end
end

class LinkStep < Step
  def initialize(name, source, destination, force)
    super(name)
    @source = source.freeze
    @destination = destination.freeze
    @force = force.freeze
  end

  def self.build_from_raw!(raw_spec)
    LinkStep.new(raw_spec["name"], raw_spec["src"], raw_spec["dest"], raw_spec["force"] == "true")
  end
end

class BrewStep < Step
  def initialize(name, brews, casks, mas)
    super(name)
    @brews = brews.freeze
    @casks = casks.freeze
    @mas = mas.freeze
  end

  def self.build_from_raw!(raw_spec)
    BrewStep.new(raw_spec["name"], raw_spec["brews"], raw_spec["casks"], raw_spec["mas"])
  end
end
