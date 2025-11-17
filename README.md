# Nvidia
Repo to hold all Nvidia GPU related scripts

The Order of Install:
1. pre-install
2. check1
3. cuda
4. cuDNN
5. cuda_python
6. tensorRT
7. onnx_install
8. tensorrt_llm

1 - 5: Required on a new box with Nvidia GPU
6    : If you are doing Inferencing using nvidia tensorrt (runtime)
7    : For Deep Neural Network we need the onnx framework
8    : For Inferencing LLMs
