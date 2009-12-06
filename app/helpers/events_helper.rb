module EventsHelper
  
	def stringPad(str)
		str = "0" + str.to_s if str.to_s.size == 1
		return str.to_s
	end
  
	def to_google_calendar(timeObj)
		timeObj = timeObj.utc
		dateStr = timeObj.year.to_s
        
		dateStr += stringPad(timeObj.month)
		dateStr += stringPad(timeObj.day)
		dateStr += "T" + stringPad(timeObj.hour)
		dateStr += stringPad(timeObj.min) + "00Z"
		
		return dateStr
  end
  
  
end
