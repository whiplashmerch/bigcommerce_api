ActiveSupport::Inflector.inflections do |inflect|
	# inflect.plural /^(\w+ss)$/i, '\1\2es'
	# inflect.irregular 'octopus', 'octopi'
 #  inflect.uncountable "equipment"

  inflect.singular /^(\w+ss)$/i, '\1'

end