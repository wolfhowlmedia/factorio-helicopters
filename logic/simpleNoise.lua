--A very basic sequential 1D-noise generator.
--It's actually just smoothed random values,
--but I guess that can be said about any noise gen.

simpleNoise =
{
	new = function(timeAdvance, minFrequency, maxFrequency)
		local obj =
		{
			timeAdvance = timeAdvance or 0.2,
			minFrequency = minFrequency or 1,
			maxFrequency = maxFrequency or 6,

			nextVal = 0,
			lastVal = 0,

			transitionTime = 0,
		}

		obj.maxFrequency = obj.maxFrequency - obj.minFrequency

		return setmetatable(obj, simpleNoise)
	end,

	easing = function(t)
		if t < 0.5 then
			return 2*t^2
		else
			return -1+(4-2*t)*t
		end
	end,

	advance = function(self)
		self.curTime = self.curTime + self.timeAdvance

		if self.curTime >= self.transitionTime then
			self.lastVal = self.nextVal
			self.nextVal = math.random() * 2 - 1

			self.valDelta = self.nextVal - self.lastVal

			self.curTime = 0
			self.transitionTime = math.random() * self.maxFrequency + self.minFrequency
		end

		return self.lastVal + self.valDelta * self.easing(self.curTime / self.transitionTime)
	end,
}