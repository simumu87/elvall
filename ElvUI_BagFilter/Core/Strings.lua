local U = select(2, ...);
local L = {};

U.L = L;
U.Language = GetLocale();

L.Filter = FILTER;
L.All = ALL;
L.Weapon = AUCTION_CATEGORY_WEAPONS;
L.Armor = AUCTION_CATEGORY_ARMOR;
L.Equipment = L.Weapon .. ' & ' .. L.Armor;
L.Consumable = AUCTION_CATEGORY_CONSUMABLES;
L.Quest = AUCTION_CATEGORY_QUEST_ITEMS;
L.Tradegoods = AUCTION_CATEGORY_TRADE_GOODS;
L.Miscellaneous = AUCTION_CATEGORY_MISCELLANEOUS;

L['Custom Filter'] = 'Custom Filter';
L['Change name/icon'] = 'Change name/icon';
L['Enter filter name (Max 30 characters):'] = 'Enter filter name (Max 30 characters):';

if (U.Language == "deDE") then
  L['Custom Filter'] = 'Benutzerdefinierter Filter';
  L['Change name/icon'] = 'Name/Icon ändern';
  L['Enter filter name (Max 30 characters):'] = 'Filternamen eingeben (max. 30 Zeichen):';
elseif (U.Language == "esES") then
  L['Custom Filter'] = 'Filtro personalizado';
  L['Change name/icon'] = 'Cambiar nombre/icono';
  L['Enter filter name (Max 30 characters):'] = 'Ingrese el nombre del filtro (máx. 30 caracteres):';
elseif (U.Language == "esMX") then
  L['Custom Filter'] = 'Filtro personalizado';
  L['Change name/icon'] = 'Cambiar nombre/icono';
  L['Enter filter name (Max 30 characters):'] = 'Ingrese el nombre del filtro (máx. 30 caracteres):';
elseif (U.Language == "frFR") then
  L['Custom Filter'] = 'Filtre personnalisé';
  L['Change name/icon'] = 'Changer le nom/icône';
  L['Enter filter name (Max 30 characters):'] = 'Entrez le nom du filtre (max. 30 caractères):';
elseif (U.Language == "itIT") then
  L['Custom Filter'] = 'Filtro personalizzato';
  L['Change name/icon'] = 'Cambia nome/icona';
  L['Enter filter name (Max 30 characters):'] = 'Inserisci il nome del filtro (max 30 caratteri):';
elseif (U.Language == "koKR") then
  L['Custom Filter'] = '사용자 정의 필터';
  L['Change name/icon'] = '이름/아이콘 변경';
  L['Enter filter name (Max 30 characters):'] = '필터 이름 입력 (최대 30자):';
elseif (U.Language == "ptBR") then
  L['Custom Filter'] = 'Filtro Personalizado';
  L['Change name/icon'] = 'Alterar nome/ícone';
  L['Enter filter name (Max 30 characters):'] = 'Digite o nome do filtro (máx. 30 caracteres):';
elseif (U.Language == "ruRU") then
  L['Custom Filter'] = 'Пользовательский фильтр';
  L['Change name/icon'] = 'Изменить имя/иконку';
  L['Enter filter name (Max 30 characters):'] = 'Введите имя фильтра (макс. 30 символов):';
elseif (U.Language == "zhCN") then
  L['Custom Filter'] = '自定义过滤器';
  L['Change name/icon'] = '更改名称/图标';
  L['Enter filter name (Max 30 characters):'] = '输入过滤器名称（最多30个字符）：';
elseif (U.Language == "zhTW") then
  L['Custom Filter'] = '自訂篩選器';
  L['Change name/icon'] = '更改名稱/圖示';
  L['Enter filter name (Max 30 characters):'] = '輸入篩選器名稱（最多30個字元）：';
end
