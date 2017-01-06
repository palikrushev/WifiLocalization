function [ distance ] = convertRssiToDistance( RSSI )

  distance = 10^((56.02-RSSI)/176.3); %R2 = 0.0684

end

