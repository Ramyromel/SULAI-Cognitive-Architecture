#!/bin/bash
set -e

UPLOAD_DIR="pinata-upload"
PROOF_FILE="$UPLOAD_DIR/IPFS-PROOF.md"
PINATA_API="https://api.pinata.cloud/pinning/pinFileToIPFS"

mkdir -p "$UPLOAD_DIR"
echo "# IPFS Upload Proof" > "$PROOF_FILE"
echo "" >> "$PROOF_FILE"

for file in *.tar.gz; do
  echo "[*] Processing $file"

  # ---- SHA256 verification ----
  if [[ -f "$file.sha256" ]]; then
    RECORDED_HASH=$(awk '{print $1}' "$file.sha256")
    CALCULATED_HASH=$(sha256sum "$file" | awk '{print $1}')

    if [[ "$RECORDED_HASH" != "$CALCULATED_HASH" ]]; then
      echo "❌ SHA256 mismatch for $file"
      exit 1
    fi

    echo "✔ SHA256 verified for $file"
  else
    echo "⚠️ No SHA256 file found for $file – skipping check"
  fi

  # ---- Upload to Pinata ----
  echo "[*] Uploading $file to Pinata..."

  RESPONSE=$(curl -s -X POST "$PINATA_API" \
    -H "Authorization: Bearer $PINATA_JWT" \
    -F "file=@$file")

  IPFS_HASH=$(echo "$RESPONSE" | jq -r '.IpfsHash')

  if [[ "$IPFS_HASH" == "null" ]]; then
    echo "❌ Upload failed:"
    echo "$RESPONSE"
    exit 1
  fi

  echo "✔ Uploaded: $IPFS_HASH"

  echo "## $file" >> "$PROOF_FILE"
  echo "- SHA256: $CALCULATED_HASH" >> "$PROOF_FILE"
  echo "- IPFS CID: $IPFS_HASH" >> "$PROOF_FILE"
  echo "" >> "$PROOF_FILE"

done

echo "✅ All uploads complete."
echo "📄 Proof file generated at $PROOF_FILE"
