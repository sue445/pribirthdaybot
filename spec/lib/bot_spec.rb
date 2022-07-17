RSpec.describe Bot do
  let(:bot) { Bot.new }

  describe "#generate_birthday_message" do
    subject { bot.generate_birthday_message(date, names) }

    context "with 1 name" do
      let(:date)  { Date.parse("2021-02-09") }
      let(:names) { %w(太陽ペッパー) }

      it { should eq "2/9は太陽ペッパーの誕生日です！ #太陽ペッパー誕生祭2021 #太陽ペッパー生誕祭2021 https://sue445.github.io/pretty-all-friends-birthday-calendar/" }
    end

    context "with greater than 1 names" do
      let(:date)  { Date.parse("2021-08-08") }
      let(:names) { %w(メルパン 上葉みあ 陽比野まつり 黒川冷) }

      it { should eq "8/8はメルパン、上葉みあ、陽比野まつり、黒川冷の誕生日です！ #メルパン誕生祭2021 #メルパン生誕祭2021 #上葉みあ誕生祭2021 #上葉みあ生誕祭2021 #陽比野まつり誕生祭2021 #陽比野まつり生誕祭2021 #黒川冷誕生祭2021 #黒川冷生誕祭2021 https://sue445.github.io/pretty-all-friends-birthday-calendar/" }
    end

    context "with falala and garara" do
      let(:date)  { Date.parse("2021-06-10") }
      let(:names) { %w(ガァララ・ス・リープ ファララ・ア・ラーム) }

      it { should eq "6/10はガァララ・ス・リープ、ファララ・ア・ラームの誕生日です！ #ファララ生誕祭2021 #ガァララ生誕祭2021 #ファララガァララ生誕祭2021 https://sue445.github.io/pretty-all-friends-birthday-calendar/" }
    end

    context "with falala, garara and other" do
      let(:date)  { Date.parse("2021-06-10") }
      let(:names) { %w(ガァララ・ス・リープ ファララ・ア・ラーム xxxxx) }

      it { should eq "6/10はガァララ・ス・リープ、ファララ・ア・ラーム、xxxxxの誕生日です！ #ファララ生誕祭2021 #ガァララ生誕祭2021 #ファララガァララ生誕祭2021 #xxxxx誕生祭2021 #xxxxx生誕祭2021 https://sue445.github.io/pretty-all-friends-birthday-calendar/" }
    end

    context "with Jennifer" do
      let(:date)  { Date.parse("2022-07-17") }
      let(:names) { %w(ジェニファー・純恋・ソル) }

      it { should eq "7/17はジェニファー・純恋・ソルの誕生日です！ #ジェニファー誕生祭2022 #ジェニファー生誕祭2022 https://sue445.github.io/pretty-all-friends-birthday-calendar/" }
    end
  end
end
