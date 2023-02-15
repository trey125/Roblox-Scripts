local Funcs, Drawables, Instances = {}, {}, {}



function Funcs:Stop()
	for i,v in pairs(Drawables) do
		pcall(function() 
			if rawget(v, '__OBJECT_EXISTS') then 
				v:Remove() 
				v = nil
			end 
		end)
	end
	for i,v in pairs(Instances) do
		pcall(function()
			v:Destroy()
			v = nil
		end)
	end
	
	Drawables = {}
	Instances = {}
end

function Funcs:New(Name, Prop)
	if Name == 'Circle' then
		local c = Drawing.new('Circle')
		c.Visible = Prop.Visible or false
		c.Thickness = Prop.Thickness or 1
		c.NumSides = Prop.NumSides or 200
		c.Radius = Prop.Radius or 60
		c.Filled = Prop.Filled or false
		c.Coor = Prop.Color or Color3.fromRGB(255, 255, 255)
		table.insert(Drawables, c)
		return c
	elseif Name == 'Line' then
		local l = Drawing.new('Line')
		l.Color = Prop.Color or Color3.fromRGB(255, 255, 255)
		l.Thickness = Prop.Thickness or 1
		l.From = Prop.From or Vector2.new(0, 0)
		l.To = Prop.To or Vector2.new(1, 1)
		l.Visible = Prop.Visible or false
		table.insert(Drawables, l)
		return l
	elseif Name == 'Text' then
		local t = Drawing.new('Text')
		t.Size = Prop.Size or 15
		t.Outline = Prop.Outline or true
		t.Center = Prop.Center or true
		t.Visible = Prop.Visible or false
		table.insert(Drawables, t)
		return t
	elseif Name == 'Cham' then
		local c = Instance.new('Highlight', game.Lighting)
		c.Name = 'Cham'
		c.Adornee = Prop.Adornee or nil
		c.FillTransparency = Prop.FT or 0
		c.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		c.Enabled = Prop.Enabled or false
		return c
	elseif Name == '3DBox' then
		local Box3DTable = {
			Line1 = Funcs:New('Line', Prop),
			Line2 = Funcs:New('Line', Prop),
			Line3 = Funcs:New('Line', Prop),
			Line4 = Funcs:New('Line', Prop),
			Line5 = Funcs:New('Line', Prop),
			Line6 = Funcs:New('Line', Prop),
			Line7 = Funcs:New('Line', Prop),
			Line8 = Funcs:New('Line', Prop),
			Line9 = Funcs:New('Line', Prop),
			Line10 = Funcs:New('Line', Prop),
			Line11 = Funcs:New('Line', Prop),
			Line12 = Funcs:New('Line', Prop),
		}
		return Box3DTable
	elseif Name == 'Skeleton' then
		local SkeletonTable = {
			Head = Funcs:New('Line', Prop),
			RUA = Funcs:New('Line', Prop),
			RLA = Funcs:New('Line', Prop),
			RH = Funcs:New('Line', Prop),
			LUA = Funcs:New('Line', Prop),
			LLA = Funcs:New('Line', Prop),
			LH = Funcs:New('Line', Prop),
			RUL = Funcs:New('Line', Prop),
			RLL = Funcs:New('Line', Prop),
			RF= Funcs:New('Line', Prop),
			LUL = Funcs:New('Line', Prop),
			LLL = Funcs:New('Line', Prop),
			LF= Funcs:New('Line', Prop),
		}
		return SkeletonTable
	end
end
function Funcs:Set(Name, Object, Prop)
	if Name == 'Circle' then
		Object.Color = Prop.Color or Color3.fromRGB(255, 255, 255)
		Object.Visible = Prop.Visible or true
	elseif Name == 'Line' then
		Object.From = Prop.From or Vector2.new(Prop.FX, Prop.FY) or Vector2.zero
		Object.To = Prop.To or Vector2.new(Prop.TX, Prop.TY) or Vector2.zero
		Object.Color = Prop.Color or Color3.fromRGB(255, 255, 255)
		Object.Visible = Prop.Visible or true
	elseif Name == 'Text' then
		Object.Text = Prop.Text or ''
		Object.Position = Prop.Position or Vector2.new(Prop.X, Prop.Y) or Vector2.zero
		Object.Color = Prop.Color or Color3.fromRGB(255, 255, 255)
		Object.Visible = Prop.Visible or true
	elseif Name == 'Cham' then
		Object.OutlineColor = Prop.OutlineColor
		Object.FillColor = Prop.FillColor
		Object.Enabled = Prop.Enabled or true
	elseif Name == '3DBox' then
		local X = 1.5
		local Y = 2.5
		local Z = 1.5

		local Table, Cam, Character, Color = Prop.Table, Prop.Cam, Prop.Character, Prop.Color

		local op = Vector3.new(Character.HumanoidRootPart.Position.X - .25, Character.HumanoidRootPart.Position.Y - .5, Character.HumanoidRootPart.Position.Z)

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
	elseif Name == 'Skeleton' then
		local Table, Cam, Character, Color = Prop.Table, Prop.Cam, Prop.Character, Prop.Color
		
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
end



return Funcs
