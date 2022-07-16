# frozen_string_literal: true

class Processable
  @@registered_steps = []
  class Error < StandardError; end

  class << self
    def step(name, &block)
      @@registered_steps = @@registered_steps << { name: name, block: block }
    end
  end

  def process
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

  private

  attr_accessor :registered_steps
end
