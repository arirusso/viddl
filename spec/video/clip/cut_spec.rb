require "helper"

describe Viddl::Video::Clip::Cut do

  context "#duration" do

    context "with no options" do

      it "returns nil" do
        options = {}
        args = Viddl::Video::Clip::Cut.send(:duration, options)
        expect(args).to(eq(nil))
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

  context "#args" do

    context "with no options" do

      it "has correct args" do
        options = {}
        args = Viddl::Video::Clip::Cut.send(:args, options)
        expect(args).to(eq(""))
      end

    end

    context "with only start time" do

      it "has correct args" do
        options = {
          start: 10
        }
        args = Viddl::Video::Clip::Cut.send(:args, options)
        expect(args).to(eq(" -ss 10"))
      end

    end

    context "with start time and duration" do

      it "has correct args" do
        options = {
          start: 10,
          duration: 15
        }
        args = Viddl::Video::Clip::Cut.send(:args, options)
        expect(args).to(eq(" -ss 10 -t 15"))
      end

    end

  end

end
