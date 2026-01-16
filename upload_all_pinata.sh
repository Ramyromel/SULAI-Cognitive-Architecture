#!/bin/bash
# upload_all_pinata.sh

# Load environment
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

UPLOAD_FILE="pinata-upload/sulai-curriculum.tar.gz"
PROOF_FILE="pinata-upload/IPFS-PROOF.md"

echo "[1/2] Uploading $UPLOAD_FILE to Pinata..."
response=$(curl -s -X POST "https://api.pinata.cloud/pinning/pinFileToIPFS" \
-H "Authorization: Bearer $PINATA_JWT" \
-F "file=@${UPLOAD_FILE}" \
-F "pinataOptions={\"cidVersion\":1}")

cid=$(echo $response | grep -oP '(?<="IpfsHash":")[^"]+')

if [ -z "$cid" ]; then
    echo "❌ Upload failed. Response:"
    echo "$response"
    exit 1
fi

echo "✅ Upload successful. CID: $cid"

# Update proof
cat > "$PROOF_FILE" <<EOL
# SULAI Curriculum IPFS Proof

Upload Date: $(date -u +"%Y-%m-%d %H:%M:%S UTC")
File: $(basename "$UPLOAD_FILE")
IPFS CID: $cid
Pinata URL: https://gateway.pinata.cloud/ipfs/$cid
EOL

echo "📄 Proof updated at $PROOF_FILE"
