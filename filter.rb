require './conf.rb'
require 'json'

def minzoom(f)
  case f['properties']['code'].to_i
  when 10101, 1010101, 11201, 11202, 11203, 11204
    DST_MAXZOOM - 1
  when 10301, 10302, 10303, 10304, 10308, 10314, 10305,
    10508, 2010101, 10306, 10307, 10310, 10312
    DST_MINZOOM
  else
    DST_MAXZOOM
  end
end

while gets
  f = JSON.parse($_.strip)
  f['tippecanoe'] = {
    minzoom: minzoom(f),
    maxzoom: DST_MAXZOOM,
    layer: 'one'
  }
  print "\x1e#{JSON.dump(f)}\n"
end

