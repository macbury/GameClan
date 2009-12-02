module MoviesHelper
  
  def format_time(duration)
    minutes = duration / 60
    seconds = duration / 3600
    
    "#{minutes}:#{seconds}"
  end
  
end
