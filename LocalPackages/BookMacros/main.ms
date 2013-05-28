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
	assign(@page, @meta['pages'][0])
	_bookmacro(split('\n', @page))

	cancel()
)