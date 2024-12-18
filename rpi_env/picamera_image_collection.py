import time
import os
import argparse
import json
from picamera2 import Picamera2, Preview


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--config", type=str, default="config.json", help="Path to the config file")
    args = parser.parse_args()
    return args


def main(args):
    with open(args.config, "r") as f:
        config = json.load(f)
        
    width = config["image_width"]
    height = config["image_height"]
    image_folder = config["image_folder"]
    os.makedirs(image_folder, exist_ok=True)
    picam2 = Picamera2()
    picam2.start_preview(Preview.QTGL)

    preview_config = picam2.create_preview_configuration()
    capture_config = picam2.create_still_configuration(main={"size": (width, height)})
    
    picam2.configure(preview_config)
    picam2.start()
    time.sleep(1)
    
    for i in range(config["time_to_capture"]):
        time.sleep(1)
        print ("writing one file at a time")
        picam2.switch_mode_and_capture_file(capture_config, f"{image_folder}/image_{i}.jpeg")
    picam2.stop()

if __name__ == "__main__":
    args = parse_args()
    main(args)