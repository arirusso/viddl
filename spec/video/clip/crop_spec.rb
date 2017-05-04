require "helper"

describe Viddl::Video::Clip::Crop do

  context ".options_formatted" do

    context "with no options" do

      it "returns empty hash" do
        options = {}
        opts = Viddl::Video::Clip::Crop.send(:options_formatted, options)
        expect(opts).to(be_empty)
      end

    end

    context "with crop properties" do

      it "returns crop properties" do
        options = {
          crop: {
            x: 100,
            y: 110,
            width: 120,
            height: 130
          }
        }
        opts = Viddl::Video::Clip::Crop.send(:options_formatted, options)
        expect(opts).to_not(be_empty)
        expect(opts[:crop]).to_not(be_nil)
        expect(opts[:crop]).to_not(be_empty)
        expect(opts[:crop][:x]).to(eq(100))
        expect(opts[:crop][:y]).to(eq(110))
        expect(opts[:crop][:width]).to(eq(120))
        expect(opts[:crop][:height]).to(eq(130))
        expect(opts.values.compact.count).to(eq(1))
      end

    end

    context "with mixed types" do

      it "returns integers" do
        options = {
          crop: {
            x: 60,
            y: "70",
            width: "80",
            height: 90
          }
        }
        opts = Viddl::Video::Clip::Crop.send(:options_formatted, options)
        expect(opts).to_not(be_empty)
        expect(opts[:crop]).to_not(be_nil)
        expect(opts[:crop]).to_not(be_empty)
        expect(opts[:crop][:x]).to(eq(60))
        expect(opts[:crop][:y]).to(eq(70))
        expect(opts[:crop][:width]).to(eq(80))
        expect(opts[:crop][:height]).to(eq(90))
        expect(opts.values.compact.count).to(eq(1))
      end

    end

    context "incomplete crop properties" do

      it "raises" do
        options = {
          crop: {
            x: 20
          }
        }
        expect {
          Viddl::Video::Clip::Crop.send(:options_formatted, options)
        }.to(raise_error(RuntimeError))
      end

    end

  end

  context ".filter_args" do

    context "with no options" do

      it "returns blank string" do
        options = {}
        args = Viddl::Video::Clip::Crop.send(:filter_args, options)
        expect(args).to(be_nil)
      end

    end

    context "with crop properties" do

      it "returns crop arg" do
        options = {
          crop: {
            x: 20,
            y: 30,
            width: 40,
            height: 50
          }
        }
        args = Viddl::Video::Clip::Crop.send(:filter_args, options)
        expect(args).to(eq("crop=40:50:20:30"))
      end

    end

  end

end
