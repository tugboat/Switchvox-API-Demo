require_relative '../conductor.rb'

describe Conductor do

	before :each do
		@conductor = Conductor.new("pbx.example.com", "thisguy", "s00p3rs3cr3t")
    @conductor.stub!(:switchvox_login).and_return(true)
	end

  it "should initialize itself with credentials to login to switchvox" do
    @conductor.switchvox_uri.should      == "pbx.example.com"
    @conductor.switchvox_username.should == "thisguy"
    @conductor.switchvox_password.should == "s00p3rs3cr3t"
  end

  it "should record an event in salesforce for the incoming call" do
  end

  it "should initiate a phone call to record dication when logging a call" do
    @conductor.should_receive(:initiate_dictation)
    @conductor.log_call("12", "5555555555", "5555555556")
  end

  it 'should be able to make switchvox initiate a call for dictation' do
    api_params_hash = { :dial_first   => "5555555556",
                        :dial_second  => 808 }

    mock_switchvox = mock("switchvox")
    mock_switchvox.should_receive(:request).with("switchvox.call", api_params_hash)
    @conductor.initiate_dictation(mock_switchvox, "5555555556")
  end

end
