
BASE_URL = 'https://maps.gsi.go.jp/xyz/experimental_landformclassification1'
SITE_ROOT = 'https://optgeo.github.io/one'
SRC_Z = 14
DST_Z = 12

desc 'produce vector tiles'
task :produce do
  cmd = [
    'curl --output - ',
    "#{BASE_URL}/mokuroku.csv.gz | ",
    "zcat | grep -o '^#{SRC_Z}\/.*\.geojson' | ",
    "parallel --line-buffer 'curl --output - #{BASE_URL}/{} | tippecanoe-json-tool' | ",
    #"head -n 500000 | ",
    #"tee source.geojsons | ",
    "tippecanoe --minimum-zoom=#{DST_Z} --maximum-zoom=#{DST_Z} --force ",
    "--layer=one ",
    "-o tiles.mbtiles; tile-join --force --no-tile-compression ",
    "--output-to-directory=docs/zxy --no-tile-size-limit tiles.mbtiles"
  ].join
  sh cmd 
end

desc 'run vt-optimizer'
task :optimize do
  sh "node ../vt-optimizer/index.js -m tiles.mbtiles"
end

desc 'build style'
task :style do
  sh [
    "SITE_ROOT=#{SITE_ROOT} ",
    "parse-hocon style.conf > docs/style.json; ",
    "gl-style-validate docs/style.json"
  ].join
end

