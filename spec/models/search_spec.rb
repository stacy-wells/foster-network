require "rails_helper"

describe Search do
  it { should have_valid(:dog_friendly).when(true, false, nil) }
  it { should have_valid(:cat_friendly).when(true, false, nil) }
  it { should have_valid(:kid_friendly).when(true, false, nil) }
end
