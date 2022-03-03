local hash = {}
for _,v in ipairs(portraits) do
	hash[v[1]] = true
end

local exists = {}
for _, v in pairs(Infinity_GetFilesOfType("bmp")) do
	exists[v[1]:upper()] = true
end

function addPortrait(name, gender)
	if not hash[name] and exists[name .. 'L'] then
		table.insert(portraits, {name, gender})
	end
end

addPortrait('BAELOTH', 1)
addPortrait('BDIMOEN', 2)
addPortrait('BDVICON', 2)
addPortrait('DSCLARA', 2)
addPortrait('GLINT', 1)
addPortrait('MKHIIN', 2)
addPortrait('NAERIE', 2)
addPortrait('NANOMEN', 1)
addPortrait('NCERND', 1)
addPortrait('NEDWIN', 1)
addPortrait('NHAER', 1)
addPortrait('NHORC', 1)
addPortrait('NJAN', 1)
addPortrait('NJAHEIR', 2)
addPortrait('NKELDOR', 1)
addPortrait('NKORGAN', 1)
addPortrait('NMAZZY', 2)
addPortrait('NMINSC', 1)
addPortrait('NNALIA', 2)
addPortrait('NVALYGA', 1)
addPortrait('NVICON', 2)
addPortrait('NYOSHIM', 1)
addPortrait('OHHEXX', 2)
addPortrait('SCHAEL', 2)
addPortrait('VOGHILN', 1)
addPortrait('YANNER1', 2)
addPortrait('YANNER2', 2)
addPortrait('YANNER3', 2)
addPortrait('YANNER4', 1)
addPortrait('YANNER5', 1)
addPortrait('YANNER6', 1)
