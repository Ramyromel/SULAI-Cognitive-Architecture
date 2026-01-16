#!/bin/bash
# SULAI Curriculum → Full Pinata Upload Script (Levels 0–4)
# Author: Ibrahim Ghonem
# Purpose: Automate IPFS upload, SHA256 verification, and documentation for all levels

# ---------------------------
# Configurations
# ---------------------------
export PINATA_JWT=PINATA_JWT="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySW5mb3JtYXRpb24iOnsiaWQiOiI3NzBmZDNlZi1lZTkyLTQ3OTItOTlkNi1lZWYzNWIzMTJjZmEiLCJlbWFpbCI6ImFkZWtfdGVyYWZhc0B5YWhvby5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwicGluX3BvbGljeSI6eyJyZWdpb25zIjpbeyJkZXNpcmVkUmVwbGljYXRpb25Db3VudCI6MSwiaWQiOiJGUkExIn0seyJkZXNpcmVkUmVwbGljYXRpb25Db3VudCI6MSwiaWQiOiJOWUMxIn1dLCJ2ZXJzaW9uIjoxfSwibWZhX2VuYWJsZWQiOmZhbHNlLCJzdGF0dXMiOiJBQ1RJVkUifSwiYXV0aGVudGljYXRpb25UeXBlIjoic2NvcGVkS2V5Iiwic2NvcGVkS2V5S2V5IjoiMGEwZjEzZTE1YjcxZmNhZjBhZmMiLCJzY29wZWRLZXlTZWNyZXQiOiJiYTMwM2FhMjMzNzk4Y2NhMmM2OThjNmFjODlkODI1YTg0MGVkYWNkYmYzYjZlZjAyYjFkNWQ5MWM1NDE4ZTJlIiwiZXhwIjoxODAwMTE1MjEzfQ.PILM7pGMQ2C8lfrE7ImMhWprTWTg-6g2j5gwKrdH5QQ"

UPLOAD_DIR="pinata-upload"
PROOF_FILE="$UPLOAD_DIR/IPFS-PROOF.md"

# Levels and files
declare -A levels=(
  ["zero-chapter"]="0: Foundations"
  ["level-1-awareness"]="1: Awareness"
  ["level-2-feeling"]="2: Feeling"
  ["level-3-time"]="3: Temporal Cognition"
  ["level-4-emotional-mass"]="4: Emotional Mass"
)

# Ensure upload directory exists
mkdir -p "$UPLOAD_DIR"

# Initialize IPFS proof
echo "# SULAI Curriculum IPFS Proof" > "$PROOF_FILE"
echo "Upload Session: $(date -u +"%Y-%m-%d %H:%M:%S UTC")" >> "$PROOF_FILE"
echo "" >> "$PROOF_FILE"

# ---------------------------
# Function: Upload single file
# ---------------------------
upload_file() {
  local file_path="$1"
  local file_name=$(basename "$file_path")

  # Verify SHA256 if exists
  sha_file="${file_path}.sha256"
  if [ -f "$sha_file" ]; then
    echo "[1/3] Verifying SHA256 for $file_name..."
    calculated_sha=$(sha256sum "$file_path" | awk '{print $1}')
    recorded_sha=$(cat "$sha_file" | awk '{print $1}')
    if [ "$calculated_sha" != "$recorded_sha" ]; then
      echo "⚠️ SHA256 mismatch for $file_name! Skipping upload."
      return
    fi
    echo "✅ SHA256 verified."
  else
    echo "⚠️ No SHA256 file for $file_name. Skipping integrity check."
  fi

  # Upload to Pinata
  echo "[2/3] Uploading $file_name to Pinata..."
  response=$(curl -s -X POST "https://api.pinata.cloud/pinning/pinFileToIPFS" \
    -H "Authorization: Bearer $PINATA_JWT" \
    -F "file=@${file_path}" \
    -F 'pinataOptions={"cidVersion":1}')

  cid=$(echo "$response" | grep -oP '(?<="IpfsHash":")[^"]+')
  if [ -z "$cid" ]; then
    echo "❌ Upload failed for $file_name. Response:"
    echo "$response"
    return
  fi
  echo "✅ Upload successful. CID: $cid"

  # Update IPFS proof
  echo "File: $file_name" >> "$PROOF_FILE"
  if [ -f "$sha_file" ]; then
    echo "SHA256: $calculated_sha" >> "$PROOF_FILE"
  fi
  echo "IPFS CID: $cid" >> "$PROOF_FILE"
  echo "Pinata URL: https://gateway.pinata.cloud/ipfs/$cid" >> "$PROOF_FILE"
  echo "" >> "$PROOF_FILE"
}

# ---------------------------
# Main: Iterate levels and upload
# ---------------------------
echo "[0/4] Initializing IPFS proof..."
for level in "${!levels[@]}"; do
  echo "Processing ${level} - ${levels[$level]}"
  for file in "$level"/*; do
    [ -f "$file" ] || continue
    upload_file "$file"
  done
done

echo "[4/4] All operations completed."
echo "📄 Proof file updated: $PROOF_FILE"
echo "You can now commit the updated proof to GitHub:"
echo "  git add $PROOF_FILE"
echo "  git commit -m 'Update IPFS proof for all uploaded files'"
