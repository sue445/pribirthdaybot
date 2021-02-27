RSpec.describe Bot do
  let(:bot) { Bot.new }

  describe "#generate_birthday_message" do
    subject { bot.generate_birthday_message(year, names) }

    let(:year) { 2021 }

    context "with 1 name" do
      let(:names) { %w(太陽ペッパー) }

      it { should eq "今日は太陽ペッパーの誕生日です！ #太陽ペッパー誕生祭2021 #太陽ペッパー生誕祭2021" }
    end

    context "with greater than 1 names" do
      let(:names) { %w(メルパン 上葉みあ 黒川冷) }

      it { should eq "今日はメルパン、上葉みあ、黒川冷の誕生日です！ #メルパン誕生祭2021 #メルパン生誕祭2021 #上葉みあ誕生祭2021 #上葉みあ生誕祭2021 #黒川冷誕生祭2021 #黒川冷生誕祭2021" }
    end
  end
end
