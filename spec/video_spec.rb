require "helper"

describe Viddl::Video do

  before(:each) do
    @video_id = "6g4dkBF5anU"
    @source_url = "https://youtube.com/watch?v=#{@video_id}"
  end

  context ".download" do

    context "with no options" do

      it "execs command line" do
        @options = {}
        expect(Kernel).to(receive(:system).and_return(true))
        @result = Viddl::Video.download(@source_url, @options)
      end

    end

  end

end
