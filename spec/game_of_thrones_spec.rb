require 'spec_helper'

describe GameOfThrones do
  let(:cache){ ActiveSupport::Cache::MemoryStore.new }

  def new_game(options={})
    GameOfThrones.new({:cache => cache, :mutex_timeout => 0.01}.merge(options))
  end

  it "has a VERSION" do
    GameOfThrones::VERSION.should =~ /^[\.\da-z]+$/
  end

  describe "#rise_to_power" do
    it "executes if there is no king" do
      result = nil
      if new_game.rise_to_power
        result = 1
      end
      result.should == 1
    end

    it "executes if the king is alive" do
      result = nil
      if new_game.rise_to_power
        result = 1
      end
      if new_game.rise_to_power
        result = 2
      end
      result.should == 1
    end

    it "executes if the king died" do
      result = nil
      new_game(:timeout => 0.2).rise_to_power do
        result = 1
      end
      sleep 0.3
      if new_game.rise_to_power
        result = 2
      end
      result.should == 2
    end

    it "ruling keeps the king in power" do
      result = nil
      old_king = new_game(:timeout => 0.2)
      if old_king.rise_to_power
        result = 1
      end
      sleep 0.15
      if old_king.rise_to_power
        result = 2
      end
      sleep 0.15
      if new_game.rise_to_power
        result = 3
      end
      result.should == 2
    end
  end
end
