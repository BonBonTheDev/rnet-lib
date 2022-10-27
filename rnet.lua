-- Decompiled with the Synapse X Luau decompiler.

local v1 = {
	DynamicInstanceIds = {
		Character = nil, 
		Backpack = nil
	}, 
	IDCache = {}, 
	AccessoryWeld = nil
};
local v2 = Instance.new("Folder");
v2.Name = "PACKET_SEND";
local v3 = Instance.new("Folder");
v3.Name = "RETURN_INST_ID";
local v4 = Instance.new("StringValue");
v4.Name = "PACKET_COM";
v4.Value = "KO";
local v5 = Instance.new("StringValue");
v5.Name = "INST_ID_COM";
v5.Value = "OK";
while true do
	v4.Parent = v3;
	task.wait(tonumber("0.1"));
	v4.Parent = v2;
	task.wait(tonumber("0.1"));
	if v4.Value == "OK" then
		break;
	end;
end;
v4.Parent = nil;
print("packit loded");
function v1.Send(p1, p2)
	local v6 = nil;
	if type(p2) == "table" then
		local v7 = #p2;
		p2 = "";
		for v8, v9 in pairs(p2) do
			p2 = p2 .. tostring(v9) .. " ";
		end;
		p2 = p2:gsub(".?$", "");
	else
		v7 = #string.split(p2, " ");
	end;
	v4.Value = p2;
	v4.Parent = v2;
	local l__string_char__10 = string.char;
	v6 = "";
	for v11 = 1, v7 + 8 do
		v6 = v6 .. l__string_char__10(143);
	end;
	local v12, v13 = pcall(function()
		game:GetService("Debris").MaxItems = game:GetService("Debris").MaxItems;
	end);
	if not v12 then
		PluginManager();
	else
		print("already elevated");
	end;
	game:GetService("Players"):Chat(local v14);
end;
function v1.GetInstanceId(p3, p4, p5)
	local v15 = v1.IDCache[p4];
	if v15 then
		return v15;
	end;
	v5.Value = "GET";
	v5.Parent = p4;
	while true do
		task.wait();
		if v5.Parent == v3 then
			break;
		end;	
	end;
	local v16 = string.split(v5.Value, " ");
	if #v16 <= 0 then
		return;
	end;
	if p5 then
		local v17 = tonumber(v16[1]);
	else
		table.remove(v16, 1);
		local v18 = "";
		for v19, v20 in next, v16 do
			v18 = v18 .. v20 .. " ";
		end;
		v17 = v18:gsub(".?$", "");
		v1.IDCache[p4] = v17;
	end;
	if v17 == nil then
		error("error grabbing instid");
	end;
	return v17;
end;
function v1.SetInstanceId(p6, p7, p8)
	v5.Value = p8;
	v5.Parent = p7;
	while true do
		task.wait();
		if v5.Parent == v3 then
			break;
		end;	
	end;
end;
function v1.SetParent(p9, p10, p11)
	p9:Send((("83 03 01 INSTANCE_ID 14 47 00 01 CHARACTER_ID 02 04 52 64 01 00 01 81 00 06 01 77 44 00 00 07 01 d8 44 00 00 ff 02 bd 9f 94 80 be 16 97 57 3e 0f 17 87 06 03 00 00 00 00 00 00 00 00 bf c0 00 00 09 05 d2 ff 01 77 44 00 00 03 01 INSTANCE_ID 14 47 00 01 PARENT_ID 01 04 52 64 01 00 03 01 INSTANCE_ID 14 47 00 01 BACKPACK_ID 03 01 INSTANCE_ID 14 47 00 01 PARENT_ID 00"):gsub("INSTANCE_ID", p9:GetInstanceId(p10)):gsub("PARENT_ID", p9:GetInstanceId(p11)):gsub("CHARACTER_ID", p9.DynamicInstanceIds.Character):gsub("BACKPACK_ID", p9.DynamicInstanceIds.Backpack)));
	task.wait();
	p10.Parent = p11;
end;
function v1.CreateWeld(p12, p13, p14, p15)
	local l__LocalPlayer__21 = game:GetService("Players").LocalPlayer;
	if not p14 then
		p14 = l__LocalPlayer__21.Backpack:FindFirstChild("Handle", true);
	end;
	if not p14 then
		error("no handle >: (");
	end;
	local v22 = l__LocalPlayer__21.Character or l__LocalPlayer__21.CharacterAdded:Wait();
	p12:Send((("83 02 04 INSTANCE_ID 01 81 00 06 01 RIGHT_ARM 07 01 HANDLE ff 02 bd 9f 94 80 be 16 97 57 3e 0f 17 87 06 03 00 00 00 00 00 00 00 00 bf c0 00 00 09 05 d2 ff 01 RIGHT_ARM 00"):gsub("INSTANCE_ID", p13):gsub("HANDLE", p12:GetInstanceId(p14)):gsub("RIGHT_ARM", p12:GetInstanceId(p15 or (v22:WaitForChild("Humanoid").RigType == Enum.HumanoidRigType.R15 and v22:WaitForChild("RightHand") or v22:WaitForChild("Right Arm"))))));
end;
function v1.FireTouch(p16, p17, p18)
	if not p17 or not p18 then
		error("part1 or part2 do not exist: " .. tostring(p17) .. " " .. tostring(p18));
	end;
	local v23 = ("86 01 PART_TWO 01 PART_ONE 00 01 PART_ONE 01 PART_TWO 00 00"):gsub("PART_ONE", p16:GetInstanceId(p17)):gsub("PART_TWO", p16:GetInstanceId(p18));
	p16:Send((("86 01 PART_TWO 01 PART_ONE 01 01 PART_ONE 01 PART_TWO 01 00"):gsub("PART_ONE", p16:GetInstanceId(p17)):gsub("PART_TWO", p16:GetInstanceId(p18))));
	task.wait();
	p16:Send(v23);
end;
chatfolder = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents", 10);
currchatid = 0;
lp = game:GetService("Players").LocalPlayer;
if chatfolder then
	sayremote = chatfolder:FindFirstChild("SayMessageRequest");
	getremote = chatfolder:FindFirstChild("GetInitDataRequest");
	if sayremote and getremote then
		function v1.InstExists(p19, p20)
			local v24, v25 = pcall(function()
				local v26 = nil;
				for v27, v28 in pairs(getremote:InvokeServer().Channels) do
					if v28[1] == "All" then
						v26 = v28[3];
					end;
				end;
				for v29, v30 in pairs(v26) do
					if v30.SpeakerUserId == lp.UserId and currchatid < v30.ID then
						currchatid = v30.ID;
					end;
				end;
				local v31, v32 = pcall(function()
					game:GetService("Debris").MaxItems = game:GetService("Debris").MaxItems;
				end);
				if not v31 then
					PluginManager();
				else
					print("already elevated");
				end;
				game.RobloxReplicatedStorage.SetPlayerBlockList:FireServer({ lp.UserId, p20 });
				task.wait();
				sayremote:FireServer("", "All");
				task.wait();
				local v33 = nil;
				for v34, v35 in pairs(getremote:InvokeServer().Channels) do
					if v35[1] == "All" then
						v33 = v35[3];
					end;
				end;
				local v36, v37 = pcall(function()
					game:GetService("Debris").MaxItems = game:GetService("Debris").MaxItems;
				end);
				if not v36 then
					PluginManager();
				else
					print("already elevated");
				end;
				game.RobloxReplicatedStorage.UpdatePlayerBlockList:FireServer(lp.UserId, false);
				for v38, v39 in pairs(v33) do
					if v39.SpeakerUserId == lp.UserId and currchatid < v39.ID and v39.Message == "" then
						return true;
					end;
				end;
				return false;
			end);
			return v25;
		end;
	end;
end;
local l__LocalPlayer__40 = game:GetService("Players").LocalPlayer;
local function v41(p21)
	v1.DynamicInstanceIds.Character = v1:GetInstanceId(p21);
	v1.DynamicInstanceIds.Backpack = v1:GetInstanceId(l__LocalPlayer__40:WaitForChild("Backpack"));
	spawn(function()
		local v42 = nil;
		while true do
			v42 = p21:FindFirstChild("AccessoryWeld", true);
			if v42 then
				break;
			end;
			task.wait(0.1);		
		end;
		v1.AccessoryWeld = v42;
	end);
end;
v41(l__LocalPlayer__40.Character or l__LocalPlayer__40.CharacterAdded:Wait());
l__LocalPlayer__40.CharacterAdded:Connect(v41);
if v1.InstExists then
	v1:InstExists(workspace);
end;
return v1;
