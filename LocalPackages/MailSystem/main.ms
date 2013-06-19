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

bind(player_join, null, null, @event,
	if(equals(_has_mail(player()), 'true'),
		set_timeout(2000, closure(msg(concat(color(c), 'You have mail!', color(f), ' Do /mail read to view your messages'))))
	)
)