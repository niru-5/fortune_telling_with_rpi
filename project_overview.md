# Project Overview
This project aims to create an automated palm reading fortune teller using artificial intelligence. The system will:

1. Capture images of users' palms using a camera connected to the system
2. Process and segment the hand images to isolate the palm lines and features
3. Send the processed palm images to ChatGPT via API for analysis
4. Return personalized daily fortune readings based on the AI's interpretation

Key Components:
- Docker containerized environment
- Image processing pipeline for hand/palm segmentation
- Integration with ChatGPT API
- User interface for capturing images and displaying fortunes
- Dev container configuration for consistent development

Technical Stack:
- Docker and Docker Compose
- Python with OpenCV for image processing
- FastAPI for backend services
- Development using VS Code with dev containers

The system provides a fun and interactive way to get AI-generated palm readings from the comfort of home, combining traditional palmistry concepts with modern machine learning capabilities.

Development Environment:
- Containerized development environment ensures consistency across all platforms
- Easy setup and deployment through Docker
- Reproducible builds and testing environment
