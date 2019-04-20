GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

PrefabFiles = {
	"trap_packbox",
	"trap_packbox_rabbit"
}

Assets = {	

}
STRINGS.NAMES.TRAP_PACKBOX_RABBIT = "陷阱盒"
STRINGS.RECIPE_DESC.TRAP_PACKBOX_RABBIT = "快速部署陷阱阵"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.TRAP_PACKBOX_RABBIT = "呀哈哈哈哈~~~"

STRINGS.NAMES.TRAP_PACKBOX = "狗牙陷阱盒"
STRINGS.RECIPE_DESC.TRAP_PACKBOX = "快速部署狗牙陷阱阵"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.TRAP_PACKBOX = "啊哈哈~~~"

AddRecipe("trap_packbox",{Ingredient("trap_teeth", 1),Ingredient("log", 1)}, RECIPETABS.SURVIVAL, TECH.SCIENCE_TWO, 
nil,nil,nil,nil, nil,
"images/inventoryimages/trap_packbox.xml", 
"trap_packbox.tex")
AddRecipe("trap_packbox_rabbit",{Ingredient("trap", 1),Ingredient("cutgrass", 1)}, RECIPETABS.SURVIVAL, TECH.SCIENCE_TWO, 
nil,nil,nil,nil, nil,
"images/inventoryimages/trap_packbox.xml", 
"trap_packbox.tex")

local trapPackSize = GetModConfigData("trap_size") or 5
local trapPackPadding = GetModConfigData("trap_padding") or 1
local trapPackResetInte = GetModConfigData("trap_reset_interval") or -1
local rabbitTrapSize = GetModConfigData("rabbit_trap_size") or 3
local rabbitTrapPadding = GetModConfigData("rabbit_trap_padding") or 2

AddPrefabPostInit("trap_packbox", function(inst)
		if inst then
		inst.trapPackSize = trapPackSize
		inst.trapPackPadding = trapPackPadding
		end
	end)
AddPrefabPostInit("trap_packbox_rabbit", function(inst)
		if inst then
		inst.rabbitTrapSize = rabbitTrapSize
		inst.rabbitTrapPadding = rabbitTrapPadding
		end
	end)
if trapPackResetInte > 0 then
	local function TrapComponentPostInit(self)
		function self:Explode(target)
			self:StopTesting()
			self.target = target
			self.issprung = true
			self.inactive = false
			if self.onexplode then
				self.onexplode(self.inst, target)
			end
			self.inst.task = self.inst:DoTaskInTime(trapPackResetInte, function()
				if ( self.issprung ) then
					self:Reset()
				end
			end)
		end
		function self:Reset()
			self:StopTesting()
			self.target = nil
			self.issprung = false
			self.inactive = false
			if self.onreset ~= nil then
				self.onreset(self.inst)
			end
			self:StartTesting()
			if self.inst.task ~= nil then
				self.inst.task:Cancel()
				self.inst.task = nil
			end
		end	
		function self:OnLoad(data)
			if data.sprung then
				self.inactive = false
				self.issprung = true
				self:StopTesting()
				if self.onsetsprung ~= nil then
					self.onsetsprung(self.inst)
				end
				self.inst.task = self.inst:DoTaskInTime(trapPackResetInte, function()
					if ( self.issprung ) then
						self:Reset()
					end
				end)
			elseif data.inactive then
				self:Deactivate()
			else
				self:Reset()
			end
		end	
	end
	AddComponentPostInit("mine", TrapComponentPostInit)
end
