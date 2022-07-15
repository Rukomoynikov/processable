# frozen_string_literal: true

# https://stackoverflow.com/questions/10757991/save-and-re-use-block-for-method-calls

require 'byebug'

class Lined
  @@registered_steps = []
  class Error < StandardError; end

  class << self
    def step(name, &block)
      @@registered_steps = @@registered_steps << { name: name, block: block}
    end
  end

  def process
    @@registered_steps.each_with_index do |step, index|
      previous_step = index.zero? ? {} : @@registered_steps[index - 1]

      result = instance_exec(previous_step.dig(:result),
                             step,
                             @@registered_steps,
                             &step[:block])

      step[:result] = result
    end

    @@registered_steps.last[:result]
  end

  private

  attr_accessor :registered_steps
end
