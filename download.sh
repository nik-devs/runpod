#!/bin/bash

if [ "$1" != "-hf" ] || [ -z "$2" ]; then
  echo "Usage: $0 -hf <huggingface_token>"
  exit 1
fi

HF_TOKEN=$2

for i in checkpoints clip clip_vision configs controlnet embeddings loras style_models upscale_models vae; do
  mkdir -p models/$i
done

cd models || exit

ln -sf checkpoints unet

fetch_model() {
  local url=$1
  local output_dir=$2
  wget --header="Authorization: Bearer $HF_TOKEN" "$url" -P "$output_dir"
}

fetch_model "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp16.safetensors" "clip"
fetch_model "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors" "clip"
fetch_model "https://huggingface.co/Comfy-Org/sigclip_vision_384/resolve/main/sigclip_vision_patch14_384.safetensors" "clip_vision"
fetch_model "https://huggingface.co/black-forest-labs/FLUX.1-Redux-dev/resolve/main/flux1-redux-dev.safetensors" "style_models"
fetch_model "https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/flux1-dev.safetensors" "checkpoints"
fetch_model "https://huggingface.co/black-forest-labs/FLUX.1-schnell/resolve/main/flux1-schnell.safetensors" "checkpoints"
fetch_model "https://huggingface.co/black-forest-labs/FLUX.1-schnell/resolve/main/ae.safetensors" "vae"

echo "Done!"
