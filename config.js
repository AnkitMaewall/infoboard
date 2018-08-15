var cmd=require('node-cmd');

exports.config = {
	animated_transitions: true
	, screens: [
		{
				cmd: ".\screens\fortune.sh"
			, hold_for: 5000 //ms
		}
		, {
				cmd: ".\screens\clock.sh"
			, hold_for: 1000 
		}
	]
};