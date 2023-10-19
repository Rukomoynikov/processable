# frozen_string_literal: true

# @example Fetch repos from Github and print to console
#   class PrintGithubRepos < Processable
#     step :get_repos do
#       github_client.where('rails', per_page: 100)
#     end
#
#     step :get_only_essential_fields do |repos_json|
#       repos_json.except(:title, :description)
#     end
#
#     step :print_to_console do |repos_json|
#       print repos_json
#     end
#   end

class Processable
  #  Collections of steps like
  # @type [String]
  @@registered_steps = []
  class Error < StandardError; end

  class << self
    # Adding new step to the process
    # @param [String] name Name of the step to have a reference for further interactions
    # @yieldparam block [block] Block which will be executed when method 'process' called on the instance of the class
    def step(name, &block)
      @@registered_steps = @@registered_steps << { name: name, block: block }
    end
  end

  # Run steps in order as they were defined
  def process(run_until: nil)
    if run_until
      run_until_index = @@registered_steps.find_index { |step| step[:name] == run_until }
      @@registered_steps = @@registered_steps[0..run_until_index]
    end

    @@registered_steps.each_with_index do |step, index|
      previous_step = index.zero? ? {} : @@registered_steps[index - 1]

      result = instance_exec(previous_step[:result],
                             step,
                             @@registered_steps,
                             &step[:block])

      step[:result] = result
    end

    @@registered_steps.last[:result]
  end

  def step(step_name:, options:)
    step = @@registered_steps.find { |step| step[:name] == step_name }

    instance_exec(options, step, @@registered_steps, &step[:block])
  end

  def initialize(*arguments); end

  private

  attr_accessor :registered_steps
end
