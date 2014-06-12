var tick = 5000;

exports.config = {
	animated_transitions: false
	, screens: [
		{
			  cmd: "./screens/test.sh"
			, hold_for: tick
		}
		, {
			  cmd: "./screens/clock.sh"
			, hold_for: tick
		}
	]
};
