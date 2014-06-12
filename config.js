var tick = 5000;
var tmp_folder = "./tmp/";

exports.config = {
	animated_transitions: false
	, screens: [
		{
			  cmd: "./screens/test.sh"
			, tmp_folder: tmp_folder
			, hold_for: tick
		}
		, {
			  cmd: "./screens/clock.sh"
			, tmp_folder: tmp_folder
			, hold_for: tick
		}
	]
};
