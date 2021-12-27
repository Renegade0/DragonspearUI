SLIDER_color_hair_start = 1
SLIDER_color_skin_start = 1
SLIDER_color_major_start = 1
SLIDER_color_minor_start = 1

SLIDER_color_hair = 1
SLIDER_color_skin = 1
SLIDER_color_major = 1
SLIDER_color_minor = 1

function rgColorBackground()
	if (e:GetActiveEngine() == createCharScreen) then
	return "RGCOLOR"
	else return "RGCOLOR2"
	end
end