# frozen_string_literal: true

require "yaml"
require_relative "spec"

module SpecYAMLLoader
  class << self
    def load!(spec_directory)
      filenames = get_yaml_filenames(spec_directory)
      raw_specs = filenames.map do |filename|
        file = File.read(File.join(spec_directory, filename))
        YAML.load_stream(file)
      end.flatten
      SpecTree.build_from_raw!(raw_specs)
    end

    private

    def get_yaml_filenames(spec_directory)
      Dir.foreach(spec_directory)
        .select { |f| %w[yml yaml].include? f.split(".").last }
    rescue Errno::ENOENT
      []
    end
  end
end
