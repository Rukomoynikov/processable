# frozen_string_literal: true

RSpec.describe Processable do
  describe "developers can control which steps to call" do
    let(:class_1) do
      Class.new(Processable) do
        step :step1 do
          1
        end

        step :step2 do |previous_step_result|
          previous_step_result + 2
        end
      end
    end

    it "calls only until second step" do
      expect(class_1.new.process(run_until: :step1)).to eq(1)
    end

    it "calls only until second step" do
      expect(class_1.new.exec_step(step_name: :step2, options: 3)).to eq(5)
    end
  end

  describe "using previous results in further steps" do
    let(:github_to_database_class) do
      Class.new(Processable) do
        attr_accessor :starting_params

        def initialize
          super
          @starting_params = 1
        end

        step :get_repos do |_result_from_previous_step, _current_step, _all_steps|
          starting_params
        end

        step :get_repos_2 do |result_from_previous_step, _current_step, _all_steps|
          result_from_previous_step + 1
        end
      end
    end

    it "calculates 1 + 1" do
      expect(github_to_database_class.new.process).to eq(2)
    end
  end
end
