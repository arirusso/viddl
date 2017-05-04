require "helper"

describe Viddl::Video::Clip::Audio do

  context "#args" do

    context "with no options" do

      it "turns off audio" do
        options = {}
        args = Viddl::Video::Clip::Audio.send(:args, options)
        expect(args).to(eq("-an"))
      end

    end

    context "with audio=false" do

      it "turns off audio" do
        options = {
          audio: false
        }
        args = Viddl::Video::Clip::Audio.send(:args, options)
        expect(args).to(eq("-an"))
      end

    end

    context "with audio=true" do

      it "returns blank string" do
        options = {
          audio: true
        }
        args = Viddl::Video::Clip::Audio.send(:args, options)
        expect(args).to(be_empty)
      end

    end

  end

end
