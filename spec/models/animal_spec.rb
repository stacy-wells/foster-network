require "rails_helper"

describe Animal do
  it { should have_valid(:name).when("Max", "Sparky") }
  it { should_not have_valid(:name).when(nil, "") }

  it { should have_valid(:animal).when("Dog", "Cat") }
  it { should_not have_valid(:animal).when(nil, "") }

  it { should have_valid(:sex).when("Male", "Female") }
  it { should_not have_valid(:sex).when(nil, "") }

  it { should have_valid(:age).when("Baby", "Young", "Adult", "Senior") }
  it { should_not have_valid(:age).when(nil, "", "other", "word") }

  it { should belong_to :animal_rescue }
end
