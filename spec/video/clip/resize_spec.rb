require "helper"

describe Viddl::Video::Clip::Resize do

  context ".options_formatted" do

    context "with no options" do

      it "returns empty hash" do
        options = {}
        opts = Viddl::Video::Clip::Resize.send(:options_formatted, options)
        expect(opts).to(be_empty)
      end

    end

    context "with width" do

      it "returns only width" do
        options = {
          width: 640
        }
        opts = Viddl::Video::Clip::Resize.send(:options_formatted, options)
        expect(opts).to_not(be_empty)
        expect(opts[:width]).to_not(be_nil)
        expect(opts[:width]).to(eq(640))
        expect(opts.values.compact.count).to(eq(1))
      end

    end

    context "with height" do

      it "returns only height" do
        options = {
          height: 480
        }
        opts = Viddl::Video::Clip::Resize.send(:options_formatted, options)
        expect(opts).to_not(be_empty)
        expect(opts[:height]).to_not(be_nil)
        expect(opts[:height]).to(eq(480))
        expect(opts.values.compact.count).to(eq(1))
      end

    end

    context "with both width and height" do

      it "returns only height" do
        options = {
          width: 1024,
          height: 768
        }
        opts = Viddl::Video::Clip::Resize.send(:options_formatted, options)
        expect(opts).to_not(be_empty)
        expect(opts[:width]).to_not(be_nil)
        expect(opts[:width]).to(eq(1024))
        expect(opts[:height]).to_not(be_nil)
        expect(opts[:height]).to(eq(768))
        expect(opts.values.compact.count).to(eq(2))
      end

    end

    context "with mixed types" do

      it "returns only ints" do
        options = {
          width: "1920",
          height: 1280
        }
        opts = Viddl::Video::Clip::Resize.send(:options_formatted, options)
        expect(opts).to_not(be_empty)
        expect(opts[:width]).to_not(be_nil)
        expect(opts[:width]).to(eq(1920))
        expect(opts[:height]).to_not(be_nil)
        expect(opts[:height]).to(eq(1280))
        expect(opts.values.compact.count).to(eq(2))
      end

    end

  end

  context ".args" do

    context "with no options" do

      it "returns blank string" do
        options = {}
        args = Viddl::Video::Clip::Resize.send(:args, options)
        expect(args).to(be_empty)
      end

    end

    context "with only width" do

      it "returns width and -1 height" do
        options = {
          width: 1024
        }
        args = Viddl::Video::Clip::Resize.send(:args, options)
        expect(args).to(eq("-vf scale=1024:-1"))
      end

    end

    context "with only height" do

      it "returns height and -1 width" do
        options = {
          height: 768
        }
        args = Viddl::Video::Clip::Resize.send(:args, options)
        expect(args).to(eq("-vf scale=-1:768"))
      end

    end

    context "with width and height" do

      it "returns height and width arg" do
        options = {
          width: 1280,
          height: 720
        }
        args = Viddl::Video::Clip::Resize.send(:args, options)
        expect(args).to(eq("-vf scale=1280:720"))
      end

    end

  end

end
