require "helper"

describe Viddl::Video::Download do

  before(:each) do
    @source_url = "https://youtube.com/watch?v=6g4dkBF5anU.mkv"
    @video = Viddl::Video::Instance.new(@source_url)
    @download = Viddl::Video::Download.new(@video)
  end

  context "#process" do

    context "with no options" do

      it "execs command line" do
        @options = {}
        expect(Kernel).to(receive(:system).and_return(true))
        @result = @download.send(:process, @options)
      end

    end

  end

end
