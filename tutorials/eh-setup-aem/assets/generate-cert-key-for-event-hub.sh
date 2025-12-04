# Replace the value of CERT_NAME with the subaccount subdomain.
# You can find this value by navigation to the subaccount > Overview page.
# In the General section there is a field called Subdomain
CERT_NAME="my-subaccount-plw8f86u"

openssl req -x509 -out ${CERT_NAME}.crt -keyout ${CERT_NAME}.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj "/CN=${CERT_NAME}" -extensions EXT -config <( \
   printf "[dn]\nCN=${CERT_NAME}\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:${CERT_NAME}\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")

awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}'  ${CERT_NAME}.crt > ${CERT_NAME}-single-line.crt

awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}'  ${CERT_NAME}.key > ${CERT_NAME}-single-line.key