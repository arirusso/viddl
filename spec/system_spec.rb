require "helper"

describe Viddl::System do

  context ".validate" do

    context "passes" do

      it "execs command line" do
        expect(Kernel).to(receive(:system).twice.and_return(true))
        @result = Viddl::System.send(:validate)
      end

    end

    context "fails" do

      it "raises" do
        expect(Kernel).to(receive(:system).and_return(nil))
        expect {
          Viddl::System.send(:validate)
        }.to(raise_error(RuntimeError))
      end

    end

  end

  context ".validate_ffmpeg" do

    context "passes" do

      it "execs command line" do
        expect(Kernel).to(receive(:system).and_return(true))
        @result = Viddl::System.send(:validate_ffmpeg)
      end

    end

    context "fails" do

      it "raises" do
        expect(Kernel).to(receive(:system).and_return(nil))
        expect {
          Viddl::System.send(:validate_ffmpeg)
        }.to(raise_error(RuntimeError))
      end

    end

  end

  context ".validate_youtube_dl" do

    context "passes" do

      it "execs command line" do
        expect(Kernel).to(receive(:system).and_return(true))
        @result = Viddl::System.send(:validate_youtube_dl)
      end

    end

    context "fails" do

      it "raises" do
        expect(Kernel).to(receive(:system).and_return(nil))
        expect {
          Viddl::System.send(:validate_youtube_dl)
        }.to(raise_error(RuntimeError))
      end

    end

  end

end
