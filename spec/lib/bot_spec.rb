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
      let(:names) { %w(みゃむ メルパン 上葉みあ 陽比野まつり 黒川冷) }

      it { should eq "8/8はみゃむ、メルパン、上葉みあ、陽比野まつり、黒川冷の誕生日です！ #陽比野まつり生誕祭2021 #みゃむ生誕祭2021 #まつりみゃむ生誕祭2021 #メルパン誕生祭2021 #メルパン生誕祭2021 #上葉みあ誕生祭2021 #上葉みあ生誕祭2021 #黒川冷誕生祭2021 #黒川冷生誕祭2021 https://sue445.github.io/pretty-all-friends-birthday-calendar/" }
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

    context "with Miichiru" do
      let(:date)  { Date.parse("2023-07-13") }
      let(:names) { %w(幸多みちる) }

      it { should eq "7/13は幸多みちるの誕生日です！ #ミーチル誕生祭2023 #ミーチル生誕祭2023 #幸多みちる誕生祭2023 #幸多みちる生誕祭2023 https://sue445.github.io/pretty-all-friends-birthday-calendar/" }
    end

    context "with Amari and Mario" do
      let(:date)  { Date.parse("2024-02-29") }
      let(:names) { %w(マリオ 一条シン 如月ルヰ 香田澄あまり) }

      it { should eq "2/29はマリオ、一条シン、如月ルヰ、香田澄あまりの誕生日です！#香田澄あまり誕生祭2024 #香田澄あまり生誕祭2024 #マリオ誕生祭2024 #マリオ生誕祭2024 #アマリオン合神祭2024 #一条シン誕生祭2024 #一条シン生誕祭2024 #如月ルヰ誕生祭2024 #如月ルヰ生誕祭2024 https://sue445.github.io/pretty-all-friends-birthday-calendar/" }
    end
  end
end
