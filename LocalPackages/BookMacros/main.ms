#=========================================================================#
#
# RDF Server Book Macros
# Authored by: Tyler569
#
# Requires: ch.alias.all
# Risk: low/none
#
#=========================================================================#

# Would like to make Engie+ - find out how...

bind(player_interact, null, array(item:386, button:'left'), @event,

	_checkpermission('all', player()) # see above

	assign(@meta, get_itemmeta(null))
	assign(@cmds, array_implode(@meta['pages'], '\n'))
	
	if(or(equals(@meta, 'null'), equals(trim(@cmds), '')),
		die(concat(color(c), 'That book appears empty'))
	)

	_bookmacro(split('\n', @cmds))

	cancel()
)