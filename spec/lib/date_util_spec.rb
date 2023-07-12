# frozen_string_literal: true

RSpec.describe DateUtil do
  describe ".jst_date" do
    subject { DateUtil.jst_date(unixtime) }

    context "with unixtime" do
      # 2023-07-13 00:00:00 +09:00
      let(:unixtime) { 1689174000 }

      it { should eq Date.parse("2023-07-13") }
    end

    context "without unixtime" do
      let(:unixtime) { nil }

      it { should be_an_instance_of Date }
    end
  end
end
