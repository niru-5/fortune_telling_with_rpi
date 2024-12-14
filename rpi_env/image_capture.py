# image capture by rpi camera


import cv2
import os
import time

params = {
    "image_width": 640,
    "image_height": 480,
    "image_folder": "images",
    "image_prefix": "image_",
    "image_format": ".bmp",
    "time_to_capture": 10, # seconds
}


def capture_images(params: dict):
    # initialize camera
    camera = cv2.VideoCapture(0)
    camera.set(cv2.CAP_PROP_FRAME_WIDTH, params["image_width"])
    camera.set(cv2.CAP_PROP_FRAME_HEIGHT, params["image_height"])

    # create image folder if not exists
    if not os.path.exists(params["image_folder"]):
        os.makedirs(params["image_folder"])
    
    # capture images
    for i in range(params["time_to_capture"]):
        _, image = camera.read()
        cv2.imwrite(os.path.join(params["image_folder"], f"{params['image_prefix']}{i}{params['image_format']}"), image)
        time.sleep(1)

    # release camera
    camera.release()


def main():
    # Use the params to capture image
    capture_images(params)

if __name__ == "__main__":
    # capture_image()
    main()


