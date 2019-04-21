
PrefabFiles = {
	"trap_packbox"
}

Assets = {	

}

GLOBAL.STRINGS.NAMES.TRAP_PACKBOX = "狗牙陷阱盒"
GLOBAL.STRINGS.RECIPE_DESC.TRAP_PACKBOX = "快速部署狗牙陷阱阵"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.TRAP_PACKBOX = "啊哈哈~~~"

AddRecipe("trap_packbox",{GLOBAL.Ingredient("trap_teeth", 1),GLOBAL.Ingredient("log", 1)}, GLOBAL.RECIPETABS.WAR, GLOBAL.TECH.SCIENCE_ONE, 
nil,nil,nil,nil, nil,
"images/inventoryimages/trap_packbox.xml", 
"trap_packbox.tex")


GLOBAL.TUNING.TRAP_PACKBOX_SIZE = GetModConfigData("trap_size") or 5
GLOBAL.TUNING.TRAP_PACKBOX_PADDING = GetModConfigData("trap_padding") or 1
local trapPackResetInte = GetModConfigData("trap_reset_interval") or 30

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
