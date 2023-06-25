-- Candle Shop
-- 
-- A simple shop allowing players to purchase candles

-- Initialize global variables
local candles = {};
local candlesPrice = 10; -- Price of a single candle

-- Loads the shop data from a file
function loadCandleData()
  local file = io.open("candleData.txt", "r");
  if file then
    for line in file:lines() do
      local key, value = unpack(split(line, ";"));
      candles[key] = value;
    end
    file:close();
  else
    print("Error: Cannot find candle data file");
  end
end

-- Saves the shop data to a file
function saveCandleData()
  local file = io.open("candleData.txt", "w");
  if file then
    for key, value in pairs(candles) do
      file:write(key..";"..value.."\n");
    end
    file:close();
  else
    print("Error: Cannot write to candle data file");
  end
end

-- Purchases candles
function purchaseCandles(player, amount)
  if amount <= 0 then
    print("Error: Cannot purchase negative amount of candles");
    return;
  end

  if player.coins < candlesPrice * amount then
    print("Error: Player does not have enough coins");
    return;
  end

  player.coins = player.coins - candlesPrice * amount;
  candles[player.name] = (candles[player.name] or 0) + amount;
  print("Successfully purchased "..amount.." candles");
end

-- Sales candles
function saleCandles(player, amount)
  if amount <= 0 then
    print("Error: Cannot sale negative amount of candles");
    return;
  end

  if (candles[player.name] or 0) < amount then
    print("Error: Player does not have enough candles");
    return;
  end

  player.coins = player.coins + candlesPrice * amount;
  candles[player.name] = (candles[player.name] or 0) - amount;
  print("Successfully sold "..amount.." candles");
end

-- Returns candles owned by a player
function getPlayerCandleAmount(player)
  return (candles[player.name] or 0);
end

-- Splits a string
function split(str, sep)
  local arr = {}
  for s in string.gmatch(str, "([^"..sep.."]+)") do
    table.insert(arr, s)
  end
  return arr
end