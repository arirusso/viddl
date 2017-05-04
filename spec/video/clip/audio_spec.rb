require "helper"

describe Viddl::Video::Clip::Audio do

  context ".options_formatted" do

    context "with no options" do

      it "returns audio = true" do
        options = {}
        opts = Viddl::Video::Clip::Audio.send(:options_formatted, options)
        expect(opts).to(include(audio: true))
      end

    end

    context "with audio = false" do

      it "returns audio = false" do
        options = {
          audio: false
        }
        opts = Viddl::Video::Clip::Audio.send(:options_formatted, options)
        expect(opts).to(include(audio: false))
      end

    end

    context "with audio = true" do

      it "returns audio = true" do
        options = {
          audio: true
        }
        opts = Viddl::Video::Clip::Audio.send(:options_formatted, options)
        expect(opts).to(include(audio: true))
      end

    end

  end

  context ".args" do

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
