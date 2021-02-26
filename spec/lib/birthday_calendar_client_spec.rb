RSpec.describe BirthdayCalendarClient do
  let(:client) { BirthdayCalendarClient.new }

  describe "#all_characters" do
    subject { client.all_characters }

    include_context :setup_birthday_calendar_stub

    its(:count) { should eq 89 }
  end
end
