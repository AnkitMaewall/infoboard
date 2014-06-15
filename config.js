//var tick = 1000 * 60 * 60;
var tick = 1000 * 1;

exports.config = {
	animated_transitions: false
	, screens: [
		{
			  cmd: "/bin/bash ./screens/wikipedia-featured-article.sh"
			, hold_for: tick
		}
		, {
			  cmd: "/bin/bash ./screens/nichtlustig.sh"
			, hold_for: tick
		}
		, {
			  cmd: "/bin/sh ./screens/quote-of-the-day.sh"
			, hold_for: tick
		}
		, {
			  cmd: "/bin/sh ./screens/clock.sh"
			, hold_for: tick
		}
	]
};
