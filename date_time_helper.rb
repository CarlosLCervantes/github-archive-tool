def get_file_time dt
	dt.strftime('%Y-%m-%d-%k').gsub(' ', '')
end

def is_timespan_valid after, before
	valid = true
	msg = ""
	#Github archive only has data past February 12, 2011
	if after < DateTime.parse("02/12/2011")
		valid = false
		msg = msg + "Dates must be past February 12, 2011.\n"
	end

	if after > before
		valid = false
		msg = msg + "After date must earlier than before date.\n"
	end

	{valid: valid, msg: msg}
end