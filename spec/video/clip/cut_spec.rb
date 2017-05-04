require "helper"

describe Viddl::Video::Clip::Cut do

  context ".options_formatted" do

    context "with no args" do

      it "returns hash with no values" do
        options = {}
        formatted_opts = Viddl::Video::Clip::Cut.send(:options_formatted, options)
        expect(formatted_opts.values.compact).to(be_empty)
      end

    end

    context "with start time only" do

      before(:each) do
        @options = {
          start: 12
        }
        @formatted_opts = Viddl::Video::Clip::Cut.send(:options_formatted, @options)
      end

      it "returns hash with only start time" do
        expect(@formatted_opts[:start]).not_to(be_nil)
        expect(@formatted_opts.values.compact.count).to(eq(1))
      end

      it "has correct start time value" do
        expect(@formatted_opts[:start]).to(eq(12))
      end

    end

    context "with end time only" do

      before(:each) do
        @options = {
          end: 14
        }
        @formatted_opts = Viddl::Video::Clip::Cut.send(:options_formatted, @options)
      end

      it "returns hash with only start time" do
        expect(@formatted_opts[:duration]).not_to(be_nil)
        expect(@formatted_opts.values.compact.count).to(eq(1))
      end

      it "has correct end time value" do
        expect(@formatted_opts[:duration]).to(eq(14))
      end

    end

    context "with duration only" do

      before(:each) do
        @options = {
          duration: 16
        }
        @formatted_opts = Viddl::Video::Clip::Cut.send(:options_formatted, @options)
      end

      it "returns hash with only start time" do
        expect(@formatted_opts[:duration]).not_to(be_nil)
        expect(@formatted_opts.values.compact.count).to(eq(1))
      end

      it "has correct end time value" do
        expect(@formatted_opts[:duration]).to(eq(16))
      end

    end

    context "with end time and duration" do

      it "raises" do
        options = {
          duration: 3,
          end: 15
        }
        expect {
          Viddl::Video::Clip::Cut.send(:options_formatted, options)
        }.to(raise_error(RuntimeError))
      end

    end

    context "with start time and end time" do

      before(:each) do
        @options = {
          start: 22,
          end: 25
        }
        @formatted_opts = Viddl::Video::Clip::Cut.send(:options_formatted, @options)
      end

      it "returns hash with start time and duration" do
        expect(@formatted_opts[:start]).not_to(be_nil)
        expect(@formatted_opts[:duration]).not_to(be_nil)
        expect(@formatted_opts.values.compact.count).to(eq(2))
      end

      it "has correct values" do
        expect(@formatted_opts[:start]).to(eq(22))
        expect(@formatted_opts[:duration]).to(eq(3))
      end

    end

    context "with start time and duration" do

      before(:each) do
        @options = {
          start: 2,
          duration: 6
        }
        @formatted_opts = Viddl::Video::Clip::Cut.send(:options_formatted, @options)
      end

      it "returns hash with start time and duration" do
        expect(@formatted_opts[:start]).not_to(be_nil)
        expect(@formatted_opts[:duration]).not_to(be_nil)
        expect(@formatted_opts.values.compact.count).to(eq(2))
      end

      it "has correct values" do
        expect(@formatted_opts[:start]).to(eq(2))
        expect(@formatted_opts[:duration]).to(eq(6))
      end

    end

    context "with start time and end time and duration" do

      it "raises" do
        options = {
          start: 10,
          duration: 3,
          end: 15
        }
        expect {
          Viddl::Video::Clip::Cut.send(:options_formatted, options)
        }.to(raise_error(RuntimeError))
      end

    end

  end

  context ".duration" do

    context "with no options" do

      it "returns nil" do
        options = {}
        args = Viddl::Video::Clip::Cut.send(:duration, options)
        expect(args).to(be_nil)
      end

    end

    context "with duration" do

      it "has correct duration" do
        options = {
          duration: 12
        }
        args = Viddl::Video::Clip::Cut.send(:duration, options)
        expect(args).to(eq(12))
      end

    end

    context "with end time" do

      it "has correct duration" do
        options = {
          start: 10,
          end: 15
        }
        args = Viddl::Video::Clip::Cut.send(:duration, options)
        expect(args).to(eq(5))
      end

    end

    context "with end time and duration" do

      it "raises" do
        options = {
          duration: 3,
          end: 15
        }
        expect {
          Viddl::Video::Clip::Cut.send(:duration, options)
        }.to(raise_error(RuntimeError))
      end

    end

  end

  context ".args" do

    context "with no options" do

      it "return nil" do
        options = {}
        args = Viddl::Video::Clip::Cut.send(:args, options)
        expect(args).to(be_nil)
      end

    end

    context "with only start time" do

      it "has correct args" do
        options = {
          start: 10
        }
        args = Viddl::Video::Clip::Cut.send(:args, options)
        expect(args).to(eq("-ss 10"))
      end

    end

    context "with start time and duration" do

      it "has correct args" do
        options = {
          start: 10,
          duration: 15
        }
        args = Viddl::Video::Clip::Cut.send(:args, options)
        expect(args).to(eq("-ss 10 -t 15"))
      end

    end

  end

end
