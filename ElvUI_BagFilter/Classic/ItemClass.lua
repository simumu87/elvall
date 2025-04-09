local U = select(2, ...);

local ItemContainerSubclass = {
    Bag = 0,
    SoulBag = 1,
    HerbBag = 2,
    EnchantingBag = 3,
    EngineeringBag = 4
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
    Staff = 10,
    Exotic1H = 11,
    Exotic2H = 12,
    FistWeapon = 13,
    Miscellaneous = 14,
    Dagger = 15,
    Thrown = 16,
    Spear = 17,
    Crossbow = 18,
    Wand = 19,
    FishingPole = 20
};

local ItemArmorSubclass = {
    Miscellaneous = 0,
    Cloth = 1,
    Leather = 2,
    Mail = 3,
    Plate = 4,
    Buckler = 5,
    Shield = 6,
    Libram = 7,
    Idol = 8,
    Totem = 9
};

local ItemProjectileSubclass = {
    Arrow = 2,
    Bullet = 3
};

local ItemTradegoodsSubclass =  {
    TradeGood = 0,
    Part = 1,
    Explosive = 2,
    Device = 3
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
    Fishing = 9
};

local ItemQuiverSubclass = {
    Quiver = 2,
    AmmoPouch = 3
};

local ItemKeySubclass = {
    Key = 0,
    Lockpick = 1
};

U.ItemClass = {
    { id = Enum.ItemClass.Consumable },
    { id = Enum.ItemClass.Container, subClass = {
        { id = ItemContainerSubclass.Bag },
        { id = ItemContainerSubclass.SoulBag },
        { id = ItemContainerSubclass.HerbBag },
        { id = ItemContainerSubclass.EnchantingBag },
        { id = ItemContainerSubclass.EngineeringBag }
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
        { id = ItemWeaponSubclass.Staff },
        { id = ItemWeaponSubclass.Exotic1H },
        { id = ItemWeaponSubclass.Exotic2H },
        { id = ItemWeaponSubclass.FistWeapon },
        { id = ItemWeaponSubclass.Miscellaneous },
        { id = ItemWeaponSubclass.Dagger },
        { id = ItemWeaponSubclass.Thrown },
        { id = ItemWeaponSubclass.Spear },
        { id = ItemWeaponSubclass.Crossbow },
        { id = ItemWeaponSubclass.Wand },
        { id = ItemWeaponSubclass.FishingPole }
    }},
    { id = Enum.ItemClass.Armor, subClass = {
        { id = ItemArmorSubclass.Miscellaneous },
        { id = ItemArmorSubclass.Cloth },
        { id = ItemArmorSubclass.Leather },
        { id = ItemArmorSubclass.Mail },
        { id = ItemArmorSubclass.Plate },
        { id = ItemArmorSubclass.Buckler },
        { id = ItemArmorSubclass.Shield },
        { id = ItemArmorSubclass.Libram },
        { id = ItemArmorSubclass.Idol },
        { id = ItemArmorSubclass.Totem }
    }},
    { id = Enum.ItemClass.Reagent },
    { id = Enum.ItemClass.Projectile, subClass = {
        { id = ItemProjectileSubclass.Arrow },
        { id = ItemProjectileSubclass.Bullet }
    }},
    { id = Enum.ItemClass.Tradegoods, subClass = {
        { id = ItemTradegoodsSubclass.TradeGood },
        { id = ItemTradegoodsSubclass.Part },
        { id = ItemTradegoodsSubclass.Explosive },
        { id = ItemTradegoodsSubclass.Device },
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
        { id = ItemRecipeSubclass.Fishing }
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
    { id = Enum.ItemClass.Miscellaneous },
    { id = Enum.ItemClass.WoWToken }
};