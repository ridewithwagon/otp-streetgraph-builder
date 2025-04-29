set -e

wget https://download.geofabrik.de/europe/cyprus-latest.osm.pbf
wget https://download.geofabrik.de/europe/france/ile-de-france-latest.osm.pbf

osmosis \
  --read-pbf cyprus-latest.osm.pbf \
  --write-xml cyprus-latest.osm.bz2

osmosis \
  --read-pbf ile-de-france-latest.osm.pbf \
  --write-xml file=ile-de-france-latest.osm.bz2

s5cmd --endpoint-url="${AWS_ENDPOINT_URL}" \
  cp ./cyprus-latest.osm.bz2 "s3://${AWS_S3_BUCKET}/cyprus-latest.osm.bz2"

s5cmd --endpoint-url="${AWS_ENDPOINT_URL}" \
  cp ./ile-de-france-latest.osm.bz2 "s3://${AWS_S3_BUCKET}/ile-de-france-latest.osm.bz2"

java -Xmx20G -jar otp.jar --buildStreet .

s5cmd --endpoint-url="${AWS_ENDPOINT_URL}" \
  cp ./streetGraph.obj "s3://${AWS_S3_BUCKET}/streetGraph.otp2.7.0.obj"