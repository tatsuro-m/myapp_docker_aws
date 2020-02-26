require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Dockerとの兼ね合いを見るためのどうでも良いスペックではある" do
    it "nameが空でも有効なこと" do
      user = User.new(name: nil)
      expect(user).to be_valid
    end

    it "ageが空でも有効なこと" do
      user = User.new(age: nil)
      expect(user).to be_valid
    end
  end
end
