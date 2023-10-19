# frozen_string_literal: true

RSpec.describe Processable do
  describe "developers can control which steps to call" do
    let(:github_to_database_class) do
      Class.new(Processable) do
        step :step1 do
          1
        end

        step :step2 do
          2
        end
      end
    end

    it "calls only until second step" do
      expect(github_to_database_class.new.process(run_until: :step1)).to eq(1)
    end
  end

  describe "developers can execute only one step" do
    let(:github_to_database_class) do
      Class.new(Processable) do
        step :get_repos do
        end
      end
    end

    it 'supports "step" class method' do
      expect { github_to_database_class.new }.not_to raise_error
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
