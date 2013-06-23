#=========================================================================#
#
# RDF Server Mail System
# Authored by: Tyler569
#
# Requires: RDF_CH_Commons
# Permissions: ch.alias.all
# Risk: low/none
#
#=========================================================================#

# MAIL STORAGE SYNTAX:
#  All mail (to everyone) stored as array in get_value('mail')
#  each value in array is a mail, stored as:
#    {time() sent, player_to, player_from, message_text}
#

proc(_mail_send, @to, @from, @msg,
	assign(@mail, array(time(), @to, @from, @msg))
	assign(@mailarray, get_value('mail'))
	if(equals(@mailarray, 'null'),
		assign(@mailarray, array())
	)
	array_push(@mailarray, @mail)
	store_value('mail', @mailarray)
	msg(concat(color(7), 'Mail sent!'))
	try(
		tmsg(@to, concat(color(c), 'You have mail!', color(f), ' Do /mail read to view your messages'))
	)
)

proc(_mail_index, @player,
	if(equals(_has_mail(@player), 'true'),
		assign(@mailindex, array())
		assign(@mailarray, get_value('mail'))
		if(is_array(@mailarray),
			foreach(@mailarray, @mail,
				if(equals(@mail[1], @player),
					array_push(@mailindex, @mail)
				)
			)
		)
		return(@mailindex)
	, #else
		return('null')
	)
)

proc(_mail_view, @player,
	assign(@mails, _mail_index(@player))
	if(equals(@mails, 'null'),
		msg(concat(color(7), 'You have no mail!'))
		die()
	)
	for(assign(@i, 0), lt(@i, length(@mails)), inc(@i),
		assign(@mail, @mails[@i])
		assign(@diff, _timediff(@mail[0]))
		msg(concat(add(@i, 1), ': From: ', @mail[1], ', ', @diff))
	)
)

proc(_mail_read, @player, @id,
	return()
)

proc(_mail_clear, @player,
	assign(@mailarray, get_value('mail'))
	if(is_array(@mailarray),
		assign(@length, length(@mailarray))
		assign(@ma_out, array())
		for(assign(@i, 0), lt(@i, @length), inc(@i),
			if(nequals_ic(@mailarray[@i][1], @player),
				array_push(@ma_out, @mailarray[@i])
			)
		)
		store_value('mail', @ma_out)
		msg(concat(color(7), 'Mail cleared'))
	)
)

proc(_has_mail, @player,
	assign(@mailarray, get_value('mail'))
	foreach(@mailarray, @mail,
		if(equals(@mail[1], @player),
			return('true')
		)
	)
	return('false')
)

proc(_timediff, @time, 
	assign(@now, time())
	assign(@diff, subtract(@now, @time))
	if(lt(@diff, 60000),
		return('less than a minute ago')
	)
	if(lt(@diff, 3600000),
		assign(@mins, floor(divide(@diff, 60000)))
		return(concat(@mins,' minutes ago'))
	)
	if(lt(@diff, 86400000),
		assign(@hours, floor(divide(@diff, 3600000)))
		return(concat(@hours,' hours ago'))
	)
	assign(@days, floor(divide(@diff, 86400000)))
	return(concat(@days, ' days ago'))
)