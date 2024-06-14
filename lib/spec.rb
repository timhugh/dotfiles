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
  attr_reader :needs
  attr_reader :needs_after
  attr_reader :conditions

  def initialize(name, steps, needs, needs_after, conditions)
    @name = name.freeze
    @steps = steps.freeze
    @needs = Array(needs).freeze
    @needs_after = Array(needs_after).freeze
    @conditions = Array(conditions).freeze
  end

  class << self
    def build_from_raw!(raw_spec)
      Spec.new(
        raw_spec["name"],
        build_steps(raw_spec),
        raw_spec["needs"],
        raw_spec["needs_after"],
        [] # TODO
      )
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
    @commands = Array(commands).map(&:strip).freeze
  end

  def self.build_from_raw!(raw_spec)
    RunStep.new(raw_spec["name"], raw_spec["run"])
  end
end

class LinkStep < Step
  attr_reader :source
  attr_reader :destination
  attr_reader :force

  def initialize(name, source, destination, force)
    super(name)
    @source = source.freeze
    @destination = destination.freeze
    @force = force.freeze
  end

  def self.build_from_raw!(raw_spec)
    LinkStep.new(
      raw_spec["name"],
      raw_spec["link"]["src"],
      raw_spec["link"]["dest"],
      raw_spec["link"]["force"] == "true"
    )
  end
end

class BrewStep < Step
  attr_reader :brews
  attr_reader :casks
  attr_reader :mas

  def initialize(name, brews, casks, mas)
    super(name)
    @brews = brews.freeze
    @casks = casks.freeze
    @mas = mas.freeze
  end

  def self.build_from_raw!(raw_spec)
    BrewStep.new(
      raw_spec["name"],
      raw_spec["brew"]["brews"],
      raw_spec["brew"]["casks"],
      raw_spec["brew"]["mas"]
    )
  end
end

class Condition
  attr_reader :command
  attr_reader :condition

  def initialize(command, condition)
    @command = command
    @condition = condition
  end
end
