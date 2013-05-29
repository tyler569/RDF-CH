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

# Persistence Key -
# bm.<player> - last time player used book macro - used for time restriction



proc(_bookmacro, @commands,
	assign(@lastt, get_value(concat('bm.', player())))
	assign(@thist, time())
	assign(@difft, subtract(@thist, @lastt))
	assign(@mindifft, multiply(3 /* seconds */, 1000))
	
	if(lt(@difft, @mindifft),
		die(concat(color(c), 'Slow down! You can\'t do that so often!'))
	)
	
	store_value(concat('bm.', player()), @thist)
	
	if(gt(array_size(@commands), 5),
		die(concat(color(c), 'Sorry, you can\'t do more than 5 commands per book'))
	)
	
	include('Includes/blacklist.txt')
	foreach(@commands, @command,
		try(
			if(equals(substr(@command, 0, 1), '/'),
				assign(@ckcm, split(' ', @command)[0])
				if(array_contains(@blacklist, @ckcm),
					msg(concat(color(4), @ckcm, ' is not permitted within book macros'))
				, #else
					chat(@command)
				)
			)
		)
	)
)