
local assets =
{
    Asset("ANIM", "anim/trap_packbox.zip"),
    Asset("ATLAS", "images/inventoryimages/trap_packbox.xml"),
    Asset("IMAGE", "images/inventoryimages/trap_packbox.tex"),
}

local function OnDeploy(inst, pt, deployer)
    local trapQuantity = TUNING.TRAP_PACKBOX_SIZE or 1
    local trapPadding = TUNING.TRAP_PACKBOX_PADDING or 1
    local half = (trapQuantity+1)/2
    for i=1,trapQuantity do
        for j=1,trapQuantity do
            SpawnPrefab("trap_teeth").Transform:SetPosition(pt.x + (i - half)*trapPadding, pt.y, pt.z + (j - half)*trapPadding)
        end
    end
    inst.components.stackable:Get():Remove()
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("trap_packbox")
    inst.AnimState:SetBuild("trap_packbox")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")

    inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = OnDeploy
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "trap_packbox"    
    inst.components.inventoryitem.atlasname = "images/inventoryimages/trap_packbox.xml"

    inst:AddComponent("selfstacker")

    return inst
end

return Prefab("trap_packbox", fn, assets),MakePlacer("trap_packbox_placer", "trap_packbox", "trap_packbox", "place")
