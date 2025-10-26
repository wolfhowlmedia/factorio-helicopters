timer =
{
	new = function(frames, isInterval, timerData)
		local timer =
		{
			valid = true,
			runTick = game.tick + frames,
			interval = isInterval and frames,
			paused = false,
			data = timerData,
		}

		mtMgr.set(timer, "timer")

		return insertInGlobal("timers", timer)
	end,

	cancel = function(self)
		self.valid = false
	end,

	pause = function(self)
		self.paused = true
		self.remaining = self.runTick - game.tick
	end,

	resume = function(self)
		self.paused = false
		self.runTick = game.tick + self.remaining
	end,
}

function setTimeout(func, frames, timerData)
	return timer.new(func, frames, false, timerData)
end

function setInterval(frames, timerData)
	return timer.new(frames, true, timerData)
end

function playTimerSound(timer)
	local gg = timer.data.gg
	local _led = timer.data.led

	if not gg.valid then
		timer:cancel()
	else
		gg:setLed("gauge_fs", "fuel", not _led.on)

		if _led.sound and (not gg.muted) and gg.player.mod_settings["heli-gaugeGui-play-fuel-warning-sound"].value then
			gg.player.play_sound{path = _led.sound}
		end
	end
end

function OnTimerTick()
	local timers = storage.timers

	if timers then
		for i = #timers, 1, -1 do
			local curTimer = timers[i]

			if not curTimer.valid then
				table.remove(timers, i)

			else
				if (not curTimer.paused) and curTimer.runTick <= game.tick then
					--curTimer:callback()
					playTimerSound(curTimer)

					if curTimer.interval then
						curTimer.runTick = game.tick + curTimer.interval

					else
						curTimer.valid = false
						table.remove(timers, i)
					end
				end
			end
		end
	end
end

mtMgr.assign("timer", {__index = timer})