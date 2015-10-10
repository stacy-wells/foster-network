require "rails_helper"

describe FosterOffer do
  it { should have_valid(:user_id).when(1, 2) }
  it { should_not have_valid(:user_id).when(nil, "") }

  it { should have_valid(:animal_id).when(3, 4) }
  it { should_not have_valid(:animal_id).when(nil, "") }

  it { should have_valid(:animal_rescue_id).when(55, 4) }
  it { should_not have_valid(:animal_rescue_id).when(nil, "") }
end
