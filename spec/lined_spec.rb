# frozen_string_literal: true

RSpec.describe Lined do
  let(:github_to_database_class) do
    Class.new(Lined) do
      step :get_repos do |result_from_previous_step, current_step, all_steps|
        1
      end

      step :get_repos_2 do |result_from_previous_step, current_step, all_steps|
        result_from_previous_step + 1
      end
    end
  end

  it "does something useful" do
    expect(github_to_database_class.new.process).to eq(2)
  end
end
