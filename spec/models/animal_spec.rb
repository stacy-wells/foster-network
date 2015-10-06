require "rails_helper"

describe Animal do
  it { should have_valid(:name).when("Max", "Sparky") }
  it { should_not have_valid(:name).when(nil, "") }

  it { should have_valid(:species).when("Dog", "Cat") }
  it { should_not have_valid(:species).when(nil, "", "other", "word") }

  it { should have_valid(:gender).when("Male", "Female") }
  it { should_not have_valid(:gender).when(nil, "", "other", "word") }

  it { should have_valid(:age).when("1-3 years", "3-6 years", "6-10 years") }
  it { should_not have_valid(:age).when(nil, "", "other", "word") }

  it { should have_valid(:size).when("Extra Small: under 10lbs", "Small: 10lbs to 20lbs") }
  it { should_not have_valid(:size).when(nil, "", "other", "word") }

  it { should have_valid(:fixed).when(true, false) }
  it { should_not have_valid(:fixed).when(nil, "") }

  it { should have_valid(:dog_friendly).when(true, false) }
  it { should_not have_valid(:dog_friendly).when(nil, "") }

  it { should have_valid(:cat_friendly).when(true, false) }
  it { should_not have_valid(:cat_friendly).when(nil, "") }

  it { should have_valid(:kid_friendly).when(true, false) }
  it { should_not have_valid(:kid_friendly).when(nil, "") }

  it { should have_valid(:fixed).when(true, false) }
  it { should_not have_valid(:fixed).when(nil, "") }

  it { should belong_to :animal_rescue }
end
