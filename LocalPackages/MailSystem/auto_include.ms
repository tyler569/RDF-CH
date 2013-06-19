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

proc(_mail_gen, @to, @from, @msg,
	assign(@mail, array(time(), @to, @from, @msg))
	assign(@mailarray, get_value('mail'))
	if(equals(@mailarray, 'null'),
		assign(@mailarray, array())
	)
	array_push(@mailarray, @mail)
	store_value('mail', @mailarray)
	msg(concat(color(7), 'Mail sent!'))
	tmsg(@to, concat(color(c), 'You have mail!', color(f), ' Do /mail read to view your messages'))
)

proc(_mail_stat, @player,
	assign(@mailarray, get_value('mail'))
	if(is_array(@mailarray),
		foreach(@mailarray, @mail,
			if(equals(@mail[1], @player),
				msg(concat('From: ', @mail[2], ' ', _timediff(@mail[0])))
			)
		)
	)
)

proc(_mail_read, @player, @id,
	return()
)

proc(_mail_clear, @player,
	assign(@mailarray, get_value('mail'))
	if(is_array(@mailarray),
		assign(@length, length(@mailarray))
		for(assign(@i, 0), lt(@i, @length), inc(@i),
			if(equals(@mailarray[@i][1], @player),
				array_remove(@mailarray, @i)
			)
		)
		store_value('mail', @mailarray)
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