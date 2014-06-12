var tick = 5000;

exports.config = {
	animated_transitions: false
	, screens: [
		{
			  cmd: "/bin/sh ./screens/test.sh"
			, hold_for: tick
		}
		, {
			  cmd: "/bin/sh ./screens/clock.sh"
			, hold_for: tick
		}
	]
};
