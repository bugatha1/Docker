FROM pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime

# Install necessary dependencies
RUN pip install --no-cache-dir \
    segment-anything-py \
    opencv-python-headless \
    diffusers \
    transformers \
    torch \
    torchvision \
    torch-vision-utils

# Copy custom handler and model config
COPY custom_handler.py /opt/ml/model/
COPY model-config.yaml /opt/ml/model/

# Set up model server
ENV SAGEMAKER_PROGRAM=custom_handler.py
ENV SAGEMAKER_SUBMIT_DIRECTORY=/opt/ml/model
ENV SAGEMAKER_MODEL_SERVER_TIMEOUT=600
ENV SAGEMAKER_MODEL_SERVER_WORKERS=1

# Entrypoint
ENTRYPOINT ["python", "/opt/ml/model/custom_handler.py"]