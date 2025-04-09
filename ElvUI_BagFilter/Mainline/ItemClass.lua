local U = select(2, ...);

-- Enum.ItemConsumableSubclass is wrong
local ItemConsumableSubclass = {
    ExplosiveDevice = 0,
    Potion = 1,
    Elixir = 2,
    FlaskPhial = 3,
    FoodDrink = 5,
    Bandage = 7,
    Other = 8,
    VantusRune = 9
};

local ItemContainerSubclass = {
    Bag = 0,
    SoulBag = 1,
    HerbBag = 2,
    EnchantingBag = 3,
    EngineeringBag = 4,
    GemBag = 5,
    MiningBag = 6,
    LeatherworkingBag = 7,
    InscriptionBag = 8,
    TackleBox = 9,
    CookingBag = 10,
    ReagentBag = 11
};

local ItemWeaponSubclass = {
    Axe1H = 0,
    Axe2H = 1,
    Bows = 2,
    Guns = 3,
    Mace1H = 4,
    Mace2H = 5,
    Polearm = 6,
    Sword1H = 7,
    Sword2H = 8,
    Warglaive = 9,
    Staff = 10,
    BearClaw = 11,
    CatClaw = 12,
    FistWeapon = 13,
    Miscellaneous = 14,
    Dagger = 15,
    Thrown = 16,
    Spears = 17,
    Crossbow = 18,
    Wand = 19,
    FishingPole = 20
};

local ItemGemSubclass = {
    Intellect = 0,
    Agility = 1,
    Strength = 2,
    Stamina = 3,
    Spirit = 4,
    CriticalStrike = 5,
    Mastery = 6,
    Haste = 7,
    Versatility = 8,
    Other = 9,
    MultipleStats = 10,
    ArtifactRelic = 11
};

local ItemArmorSubclass = {
    Miscellaneous = 0,
    Cloth = 1,
    Leather = 2,
    Mail = 3,
    Plate = 4,
    Cosmetic = 5,
    Shield = 6,
    Libram = 7,
    Idol = 8,
    Totem = 9,
    Sigil = 10,
    Relic = 11
};

local ItemReagentSubclass = {
    Reagent = 0,
    Keystone = 1,
    ContextToken = 2
};

local ItemProjectileSubclass = {
    Arrow = 2,
    Bullet = 3
};

local ItemTradegoodsSubclass =  {
    Part = 1,
    Jewelcrafting = 4,
    Cloth = 5,
    Leather = 6,
    MetalStone = 7,
    Cooking = 8,
    Herb = 9,
    Elemental = 10,
    Other = 11,
    Enchanting = 12,
    Inscription = 16,
    Optional = 18,
    Finishing = 19
};

local ItemEnhancementSubclass = {
    Head = 0,
    Neck = 1,
    Shoulder = 2,
    Cloak = 3,
    Chest = 4,
    Wrist = 5,
    Hands = 6,
    Waist = 7,
    Legs = 8,
    Feet = 9,
    Finger = 10,
    Weapon = 11,
    Weapon2H = 12,
    Offhand = 13,
    Miscellaneous = 14
};

local ItemRecipeSubclass = {
    Book = 0,
    Leatherworking = 1,
    Tailoring = 2,
    Engineering = 3,
    Blacksmithing = 4,
    Cooking = 5,
    Alchemy = 6,
    FirstAid = 7,
    Enchanting = 8,
    Fishing = 9,
    Jewelcrafting = 10,
    Inscription = 11
};

local ItemQuiverSubclass = {
    Quiver = 2,
    AmmoPouch = 3
};

local ItemKeySubclass = {
    Key = 0,
    Lockpick = 1
};

local ItemMiscellaneousSubclass = {
    Junk = 0,
    Reagent = 1,
    CompanionPet = 2,
    Holiday = 3,
    Other = 4,
    Mount = 5,
    MountEquipment = 6
};

local ItemGlyphSubclass = {
    Warrior = 1,
    Paladin = 2,
    Hunter = 3,
    Rogue = 4,
    Priest = 5,
    DeathKnight = 6,
    Shaman = 7,
    Mage = 8,
    Warlock = 9,
    Monk = 10,
    Druid = 11,
    DemonHunter = 12
};

local ItemBattlePetSubclass = {
    Humanoid = 0,
    Dragonkin = 1,
    Flying = 2,
    Undead = 3,
    Critter = 4,
    Magic = 5,
    Elemental = 6,
    Beast = 7,
    Aquatic = 8,
    Mechanical = 9
};

local ItemProfessionSubclass = {
    Blacksmithing = 0,
    Leatherworking = 1,
    Alchemy = 2,
    Herbalism = 3,
    Cooking = 4,
    Mining = 5,
    Tailoring = 6,
    Engineering = 7,
    Enchanting = 8,
    Fishing = 9,
    Skinning = 10,
    Jewelcrafting = 11,
    Inscription = 12,
    Archaeology = 13
};

U.ItemClass = {
    { id = Enum.ItemClass.Consumable, subClass = {
        { id = ItemConsumableSubclass.ExplosiveDevice },
        { id = ItemConsumableSubclass.Potion },
        { id = ItemConsumableSubclass.Elixir },
        { id = ItemConsumableSubclass.FlaskPhial },
        { id = ItemConsumableSubclass.FoodDrink },
        { id = ItemConsumableSubclass.Bandage },
        { id = ItemConsumableSubclass.Other },
        { id = ItemConsumableSubclass.VantusRune }
    }},
    { id = Enum.ItemClass.Container, subClass = {
        { id = ItemContainerSubclass.Bag },
        { id = ItemContainerSubclass.SoulBag },
        { id = ItemContainerSubclass.HerbBag },
        { id = ItemContainerSubclass.EnchantingBag },
        { id = ItemContainerSubclass.EngineeringBag },
        { id = ItemContainerSubclass.GemBag },
        { id = ItemContainerSubclass.MiningBag },
        { id = ItemContainerSubclass.LeatherworkingBag },
        { id = ItemContainerSubclass.InscriptionBag },
        { id = ItemContainerSubclass.TackleBox },
        { id = ItemContainerSubclass.CookingBag },
        { id = ItemContainerSubclass.ReagentBag }
    }},
    { id = Enum.ItemClass.Weapon, subClass = {
        { id = ItemWeaponSubclass.Axe1H },
        { id = ItemWeaponSubclass.Axe2H },
        { id = ItemWeaponSubclass.Bows },
        { id = ItemWeaponSubclass.Guns },
        { id = ItemWeaponSubclass.Mace1H },
        { id = ItemWeaponSubclass.Mace2H },
        { id = ItemWeaponSubclass.Polearm },
        { id = ItemWeaponSubclass.Sword1H },
        { id = ItemWeaponSubclass.Sword2H },
        { id = ItemWeaponSubclass.Warglaive },
        { id = ItemWeaponSubclass.Staff },
        { id = ItemWeaponSubclass.BearClaw },
        { id = ItemWeaponSubclass.CatClaw },
        { id = ItemWeaponSubclass.FistWeapon },
        { id = ItemWeaponSubclass.Miscellaneous },
        { id = ItemWeaponSubclass.Dagger },
        { id = ItemWeaponSubclass.Thrown },
        { id = ItemWeaponSubclass.Spears },
        { id = ItemWeaponSubclass.Crossbow },
        { id = ItemWeaponSubclass.Wand },
        { id = ItemWeaponSubclass.FishingPole }
    }},
    { id = Enum.ItemClass.Gem, subClass = {
        { id = ItemGemSubclass.Intellect },
        { id = ItemGemSubclass.Agility },
        { id = ItemGemSubclass.Strength },
        { id = ItemGemSubclass.Stamina },
        { id = ItemGemSubclass.Spirit },
        { id = ItemGemSubclass.CriticalStrike },
        { id = ItemGemSubclass.Mastery },
        { id = ItemGemSubclass.Haste },
        { id = ItemGemSubclass.Versatility },
        { id = ItemGemSubclass.Other },
        { id = ItemGemSubclass.MultipleStats },
        { id = ItemGemSubclass.ArtifactRelic }
    }},
    { id = Enum.ItemClass.Armor, subClass = {
        { id = ItemArmorSubclass.Miscellaneous },
        { id = ItemArmorSubclass.Cloth },
        { id = ItemArmorSubclass.Leather },
        { id = ItemArmorSubclass.Mail },
        { id = ItemArmorSubclass.Plate },
        { id = ItemArmorSubclass.Cosmetic },
        { id = ItemArmorSubclass.Shield },
        { id = ItemArmorSubclass.Libram },
        { id = ItemArmorSubclass.Idol },
        { id = ItemArmorSubclass.Totem },
        { id = ItemArmorSubclass.Sigil },
        { id = ItemArmorSubclass.Relic }
    }},
    { id = Enum.ItemClass.Reagent, subClass = {
        { id = ItemReagentSubclass.Reagent },
        { id = ItemReagentSubclass.Keystone },
        { id = ItemReagentSubclass.ContextToken }
    }},
    { id = Enum.ItemClass.Projectile, subClass = {
        { id = ItemProjectileSubclass.Arrow },
        { id = ItemProjectileSubclass.Bullet }
    }},
    { id = Enum.ItemClass.Tradegoods, subClass = {
        { id = ItemTradegoodsSubclass.Part },
        { id = ItemTradegoodsSubclass.Jewelcrafting },
        { id = ItemTradegoodsSubclass.Cloth },
        { id = ItemTradegoodsSubclass.Leather },
        { id = ItemTradegoodsSubclass.MetalStone },
        { id = ItemTradegoodsSubclass.Cooking },
        { id = ItemTradegoodsSubclass.Herb },
        { id = ItemTradegoodsSubclass.Elemental },
        { id = ItemTradegoodsSubclass.Other },
        { id = ItemTradegoodsSubclass.Enchanting },
        { id = ItemTradegoodsSubclass.Inscription },
        { id = ItemTradegoodsSubclass.Optional },
        { id = ItemTradegoodsSubclass.Finishing }
    }},
    { id = Enum.ItemClass.ItemEnhancement, subClass = {
        { id = ItemEnhancementSubclass.Head },
        { id = ItemEnhancementSubclass.Neck },
        { id = ItemEnhancementSubclass.Shoulder },
        { id = ItemEnhancementSubclass.Cloak },
        { id = ItemEnhancementSubclass.Chest },
        { id = ItemEnhancementSubclass.Wrist },
        { id = ItemEnhancementSubclass.Hands },
        { id = ItemEnhancementSubclass.Waist },
        { id = ItemEnhancementSubclass.Legs },
        { id = ItemEnhancementSubclass.Feet },
        { id = ItemEnhancementSubclass.Finger },
        { id = ItemEnhancementSubclass.Weapon },
        { id = ItemEnhancementSubclass.Weapon2H },
        { id = ItemEnhancementSubclass.Offhand },
        { id = ItemEnhancementSubclass.Miscellaneous }
    }},
    { id = Enum.ItemClass.Recipe, subClass = {
        { id = ItemRecipeSubclass.Book },
        { id = ItemRecipeSubclass.Leatherworking },
        { id = ItemRecipeSubclass.Tailoring },
        { id = ItemRecipeSubclass.Engineering },
        { id = ItemRecipeSubclass.Blacksmithing },
        { id = ItemRecipeSubclass.Cooking },
        { id = ItemRecipeSubclass.Alchemy },
        { id = ItemRecipeSubclass.FirstAid },
        { id = ItemRecipeSubclass.Enchanting },
        { id = ItemRecipeSubclass.Fishing },
        { id = ItemRecipeSubclass.Jewelcrafting },
        { id = ItemRecipeSubclass.Inscription }
    }},
    { id = Enum.ItemClass.Quiver, subClass = {
        { id = ItemQuiverSubclass.Quiver },
        { id = ItemQuiverSubclass.AmmoPouch }
    }},
    { id = Enum.ItemClass.Questitem },
    { id = Enum.ItemClass.Key, subClass = {
        { id = ItemKeySubclass.Key },
        { id = ItemKeySubclass.Lockpick }
    }},
    { id = Enum.ItemClass.Miscellaneous, subClass = {
        { id = ItemMiscellaneousSubclass.Junk },
        { id = ItemMiscellaneousSubclass.Reagent },
        { id = ItemMiscellaneousSubclass.CompanionPet },
        { id = ItemMiscellaneousSubclass.Holiday },
        { id = ItemMiscellaneousSubclass.Other },
        { id = ItemMiscellaneousSubclass.Mount },
        { id = ItemMiscellaneousSubclass.MountEquipment }
    }},
    { id = Enum.ItemClass.Glyph, subClass = {
        { id = ItemGlyphSubclass.Warrior },
        { id = ItemGlyphSubclass.Paladin },
        { id = ItemGlyphSubclass.Hunter },
        { id = ItemGlyphSubclass.Rogue },
        { id = ItemGlyphSubclass.Priest },
        { id = ItemGlyphSubclass.DeathKnight },
        { id = ItemGlyphSubclass.Shaman },
        { id = ItemGlyphSubclass.Mage },
        { id = ItemGlyphSubclass.Warlock },
        { id = ItemGlyphSubclass.Monk },
        { id = ItemGlyphSubclass.Druid },
        { id = ItemGlyphSubclass.DemonHunter }
    }},
    { id = Enum.ItemClass.Battlepet, subClass = {
        { id = ItemBattlePetSubclass.Humanoid },
        { id = ItemBattlePetSubclass.Dragonkin },
        { id = ItemBattlePetSubclass.Flying },
        { id = ItemBattlePetSubclass.Undead },
        { id = ItemBattlePetSubclass.Critter },
        { id = ItemBattlePetSubclass.Magic },
        { id = ItemBattlePetSubclass.Elemental },
        { id = ItemBattlePetSubclass.Beast },
        { id = ItemBattlePetSubclass.Aquatic },
        { id = ItemBattlePetSubclass.Mechanical }
    }},
    { id = Enum.ItemClass.WoWToken },
    { id = Enum.ItemClass.Profession, subClass = {
        { id = ItemProfessionSubclass.Blacksmithing },
        { id = ItemProfessionSubclass.Leatherworking },
        { id = ItemProfessionSubclass.Alchemy },
        { id = ItemProfessionSubclass.Herbalism },
        { id = ItemProfessionSubclass.Cooking },
        { id = ItemProfessionSubclass.Mining },
        { id = ItemProfessionSubclass.Tailoring },
        { id = ItemProfessionSubclass.Engineering },
        { id = ItemProfessionSubclass.Enchanting },
        { id = ItemProfessionSubclass.Fishing },
        { id = ItemProfessionSubclass.Skinning },
        { id = ItemProfessionSubclass.Jewelcrafting },
        { id = ItemProfessionSubclass.Inscription },
        { id = ItemProfessionSubclass.Archaeology }
    }}
};