local Funcs = {}
local Drawables, Instances = {},{}

function Funcs:Destroy()
	for i,v in pairs(Drawables) do
		pcall(function() if rawget(v, '__OBJECT_EXISTS') then v:Remove() end end)
	end
	for i,v in pairs(Instances) do
		v:Destroy()
	end
end

function Funcs:CreateCircle()
	local NewCircle = Drawing.new('Circle')
	NewCircle.Visible = false
	NewCircle.Thickness = 1
	NewCircle.NumSides = 200
	NewCircle.Radius = 60
	NewCircle.Filled = false
	NewCircle.Color = Color3.fromRGB(255, 255, 255)
	table.insert(Drawables, NewCircle)
	return NewCircle
end
function Funcs:CreateLine()
	local NewLine = Drawing.new('Line')
	NewLine.Color = Color3.fromRGB(255, 255, 255)
	NewLine.Thickness = 1
	NewLine.From = Vector2.new(0, 0)
	NewLine.To = Vector2.new(1, 1)
	NewLine.Visible = false
	table.insert(Drawables, NewLine)
	return NewLine
end
function Funcs:CreateText()
	local NewText = Drawing.new('Text')
	NewText.Size = 15
	NewText.Outline = true
	NewText.Center = true
	NewText.Visible = false
	table.insert(Drawables, NewText)
	return NewText
end
function Funcs:CreateCham(Adornee)
	local NewCham = Instance.new('Highlight', game.Lighting)
	NewCham.Name = 'Cham'
	NewCham.Adornee = Adornee
	NewCham.FillTransparency = 0
	NewCham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	NewCham.Enabled = false
	table.insert(Instances, NewCham)
	return NewCham
end

function Funcs:SetCircle(Circle, newColor)
	Circle.Color = newColor
	Circle.Visible = true
end
function Funcs:SetLine(Line, newFrom, newTo, newColor)
	Line.From = Vector2.new(newFrom.X, newFrom.Y)
	Line.To = Vector2.new(newTo.X, newTo.Y)
	Line.Color = newColor
	Line.Visible = true
end
function Funcs:SetText(Text, newStr, newPos, newColor)
	Text.Text = newStr
	Text.Position = Vector2.new(newPos.X, newPos.Y)
	Text.Color = newColor
	Text.Visible = true
end
function Funcs:SetChams(Cham, newOutline, newFill)
	Cham.OutlineColor = newOutline
	Cham.FillColor = newFill
	Cham.Enabled = true
end
function Funcs:Draw3DBox(Table, Cam, Character, Color)
	local op = Vector3.new(Character.HumanoidRootPart.Position.X - .25, Character.HumanoidRootPart.Position.Y - .5, Character.HumanoidRootPart.Position.Z)

	local X = 1.5
	local Y = 2.5
	local Z = 1.5

	local Top1 = Cam:WorldToViewportPoint(op + Vector3.new(-X, Y, -Z))
	local Top2 = Cam:WorldToViewportPoint(op + Vector3.new(X, Y, -Z))
	local Top3 = Cam:WorldToViewportPoint(op + Vector3.new(X, Y, Z))
	local Top4 = Cam:WorldToViewportPoint(op + Vector3.new(-X, Y, Z))

	local Bottom1 = Cam:WorldToViewportPoint(op + Vector3.new(-X, -Y, -Z))
	local Bottom2 = Cam:WorldToViewportPoint(op + Vector3.new(X, -Y, -Z))
	local Bottom3 = Cam:WorldToViewportPoint(op + Vector3.new(X, -Y, Z))
	local Bottom4 = Cam:WorldToViewportPoint(op + Vector3.new(-X, -Y, Z))

	Funcs:SetLine(Table.Line1, Vector2.new(Top1.X, Top1.Y), Vector2.new(Top2.X, Top2.Y), Color)
	Funcs:SetLine(Table.Line2, Vector2.new(Top2.X, Top2.Y), Vector2.new(Top3.X, Top3.Y), Color)
	Funcs:SetLine(Table.Line3, Vector2.new(Top3.X, Top3.Y), Vector2.new(Top4.X, Top4.Y), Color)
	Funcs:SetLine(Table.Line4, Vector2.new(Top4.X, Top4.Y), Vector2.new(Top1.X, Top1.Y), Color)

	Funcs:SetLine(Table.Line5, Vector2.new(Bottom1.X, Bottom1.Y), Vector2.new(Bottom2.X, Bottom2.Y), Color)
	Funcs:SetLine(Table.Line6, Vector2.new(Bottom2.X, Bottom2.Y), Vector2.new(Bottom3.X, Bottom3.Y), Color)
	Funcs:SetLine(Table.Line7, Vector2.new(Bottom3.X, Bottom3.Y), Vector2.new(Bottom4.X, Bottom4.Y), Color)
	Funcs:SetLine(Table.Line8, Vector2.new(Bottom4.X, Bottom4.Y), Vector2.new(Bottom1.X, Bottom1.Y), Color)

	Funcs:SetLine(Table.Line9, Vector2.new(Top1.X, Top1.Y), Vector2.new(Bottom1.X, Bottom1.Y), Color)
	Funcs:SetLine(Table.Line10, Vector2.new(Top2.X, Top2.Y), Vector2.new(Bottom2.X, Bottom2.Y), Color)
	Funcs:SetLine(Table.Line11, Vector2.new(Top3.X, Top3.Y), Vector2.new(Bottom3.X, Bottom3.Y), Color)
	Funcs:SetLine(Table.Line12, Vector2.new(Top4.X, Top4.Y), Vector2.new(Bottom4.X, Bottom4.Y), Color)
end
function Funcs:DrawBones(Table, Cam, Character, Color)
	local GetBones = function(Char)
		local BoneTable = {}
		if Char.Humanoid.RigType == Enum.HumanoidRigType.R15 then
			BoneTable[#BoneTable+1] = Cam:WorldToViewportPoint(Char.Head.Position)
			BoneTable[#BoneTable+1] = Cam:WorldToViewportPoint(Char.UpperTorso.Position)
			BoneTable[#BoneTable+1] = Cam:WorldToViewportPoint(Char.LowerTorso.Position)

			BoneTable[#BoneTable+1] = Cam:WorldToViewportPoint(Char.RightUpperArm.Position)
			BoneTable[#BoneTable+1] = Cam:WorldToViewportPoint(Char.RightLowerArm.Position)
			BoneTable[#BoneTable+1] = Cam:WorldToViewportPoint(Char.RightHand.Position)
			BoneTable[#BoneTable+1] = Cam:WorldToViewportPoint(Char.LeftUpperArm.Position)
			BoneTable[#BoneTable+1] = Cam:WorldToViewportPoint(Char.LeftLowerArm.Position)
			BoneTable[#BoneTable+1] = Cam:WorldToViewportPoint(Char.LeftHand.Position)

			BoneTable[#BoneTable+1] = Cam:WorldToViewportPoint(Char.RightUpperLeg.Position)
			BoneTable[#BoneTable+1] = Cam:WorldToViewportPoint(Char.RightLowerLeg.Position)
			BoneTable[#BoneTable+1] = Cam:WorldToViewportPoint(Char.RightFoot.Position)
			BoneTable[#BoneTable+1] = Cam:WorldToViewportPoint(Char.LeftUpperLeg.Position)
			BoneTable[#BoneTable+1] = Cam:WorldToViewportPoint(Char.LeftLowerLeg.Position)
			BoneTable[#BoneTable+1] = Cam:WorldToViewportPoint(Char.LeftFoot.Position)
		elseif Char.Humanoid.RigType == Enum.HumanoidRigType.R6 then
			BoneTable[#BoneTable+1] = Cam:WorldToViewportPoint(Char.Head.Position)
			BoneTable[#BoneTable+1] = Cam:WorldToViewportPoint(Char.Torso.Position)
			BoneTable[#BoneTable+1] = Cam:WorldToViewportPoint(Char['Right Arm'].Position)
			BoneTable[#BoneTable+1] = Cam:WorldToViewportPoint(Char['Left Arm'].Position)
			BoneTable[#BoneTable+1] = Cam:WorldToViewportPoint(Char['Right Leg'].Position)
			BoneTable[#BoneTable+1] = Cam:WorldToViewportPoint(Char['Left Leg'].Position)
		else
			warn('Humanoid not valid.')
		end
		return BoneTable
	end

	local BoneTable = GetBones(Character)
	if #BoneTable == 15 then
		Funcs:SetLine(Table['Head'], BoneTable[1], BoneTable[3], Color)

		Funcs:SetLine(Table['RUA'], BoneTable[2], BoneTable[4], Color)
		Funcs:SetLine(Table['RLA'], BoneTable[4], BoneTable[5], Color)
		Funcs:SetLine(Table['RH'], BoneTable[5], BoneTable[6], Color)
		Funcs:SetLine(Table['LUA'], BoneTable[2], BoneTable[7], Color)
		Funcs:SetLine(Table['LLA'], BoneTable[7], BoneTable[8], Color)
		Funcs:SetLine(Table['LH'], BoneTable[8], BoneTable[9], Color)

		Funcs:SetLine(Table['RUL'], BoneTable[3], BoneTable[10], Color)
		Funcs:SetLine(Table['RLL'], BoneTable[10], BoneTable[11], Color)
		Funcs:SetLine(Table['RF'], BoneTable[11], BoneTable[12], Color)
		Funcs:SetLine(Table['LUL'], BoneTable[3], BoneTable[13], Color)
		Funcs:SetLine(Table['LLL'], BoneTable[13], BoneTable[14], Color)
		Funcs:SetLine(Table['LF'], BoneTable[14], BoneTable[15], Color)
	elseif #BoneTable == 6 then
		Funcs:SetLine(Table['Head'], BoneTable[1], BoneTable[2], Color)

		Funcs:SetLine(Table['RUA'], BoneTable[2], BoneTable[3], Color)
		Funcs:SetLine(Table['LUA'], BoneTable[2], BoneTable[4], Color)
		Funcs:SetLine(Table['RUL'], BoneTable[2], BoneTable[5], Color)
		Funcs:SetLine(Table['LUL'], BoneTable[2], BoneTable[6], Color)
	else
		warn('[Error] Not enough bones.')
	end
end

function Funcs:Create3DBoxTable()
	local Box3DTable = {
		Line1 = Funcs:CreateLine(),
		Line2 = Funcs:CreateLine(),
		Line3 = Funcs:CreateLine(),
		Line4 = Funcs:CreateLine(),
		Line5 = Funcs:CreateLine(),
		Line6 = Funcs:CreateLine(),
		Line7 = Funcs:CreateLine(),
		Line8 = Funcs:CreateLine(),
		Line9 = Funcs:CreateLine(),
		Line10 = Funcs:CreateLine(),
		Line11 = Funcs:CreateLine(),
		Line12 = Funcs:CreateLine(),
	}
	return Box3DTable
end
function Funcs:CreateSkeletonTable()
	local SkeletonTable = {
		Head = Funcs:CreateLine(),
		RUA = Funcs:CreateLine(),
		RLA = Funcs:CreateLine(),
		RH = Funcs:CreateLine(),
		LUA = Funcs:CreateLine(),
		LLA = Funcs:CreateLine(),
		LH = Funcs:CreateLine(),
		RUL = Funcs:CreateLine(),
		RLL = Funcs:CreateLine(),
		RF= Funcs:CreateLine(),
		LUL = Funcs:CreateLine(),
		LLL = Funcs:CreateLine(),
		LF= Funcs:CreateLine(),
	}
	return SkeletonTable
end

return Funcs
