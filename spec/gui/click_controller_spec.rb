require 'gui/click_controller'

describe GUI::ClickController do
  let(:controller) { controller = GUI::ClickController.new }
  it "returns the data of click on read" do
    controller.click("sentinel")
    expect(controller.read).to eq "sentinel"
  end

  it "is not ready when not clicked" do
    expect(controller).not_to be_ready
  end
  
  it "is ready after click" do
    controller.click("sentinel")
    expect(controller).to be_ready
  end

  it "read will clear the ready state" do
    controller.click("sentinel")
    controller.read
    expect(controller).not_to be_ready
  end
end
