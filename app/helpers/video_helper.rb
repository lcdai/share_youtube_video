module VideoHelper
  def video_info(video)
    VideoInfo.new(video.link)
  end
end
