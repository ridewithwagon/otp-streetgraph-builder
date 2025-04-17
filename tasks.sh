set -e

java -Xmx20G -jar otp.jar --buildStreet .

s5cmd --endpoint-url="${AWS_ENDPOINT_URL}" \
  cp ./streetGraph.obj "s3://${AWS_S3_BUCKET}/streetGraph.otp2.7.0.obj"