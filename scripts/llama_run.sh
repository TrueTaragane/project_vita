#!/bin/bash

MODEL="models/qwen3-7b-chat-q4_k_m.gguf"
CONTEXT=4096
GPU_LAYERS=35

./llama.cpp/main -m $MODEL -c $CONTEXT --gpu-layers $GPU_LAYERS --n-gpu 1 --color -i