RSpec.describe BirthdayCalendarClient do
  let(:client) { BirthdayCalendarClient.new }

  describe "#all_characters" do
    subject { client.all_characters }

    include_context :setup_birthday_calendar_stub

    its(:count) { should eq 89 }
  end

  describe "#find_by_birthday" do
    subject { client.find_by_birthday(date) }

    include_context :setup_birthday_calendar_stub

    context "exists birthday" do
      let(:date) { Date.parse("2021-08-08") }

      it { should contain_exactly("黒川冷（DJ.Coo）", "メルパン", "上葉みあ") }
    end

    context "not exists birthday" do
      let(:date) { Date.parse("2021-08-10") }

      it { should eq [] }
    end
  end
end
