import re
import os
import map_generator
from PIL import Image
import matplotlib.pyplot as plt


def images_display(ori_image, image_list):
    if len(image_list) != 5:
        # Check list length
        print("Unexpected image list length")
        return -1
    ori_image = Image.open(ori_image)
    results = list()
    print("Loading the images...")
    for image in image_list:
        image = Image.open(image)
        results.append(image)
    plt.suptitle("Retrieval Result")  # The title
    plt.subplot(2, 3, 1), plt.title('Image:origin')
    plt.imshow(ori_image), plt.axis('off')
    plt.subplot(2, 3, 2), plt.title('Result 1')
    plt.imshow(results[0]), plt.axis('off')
    plt.subplot(2, 3, 3), plt.title('Result 2')
    plt.imshow(results[1]), plt.axis('off')
    plt.subplot(2, 3, 4), plt.title('Result 3')
    plt.imshow(results[2]), plt.axis('off')
    plt.subplot(2, 3, 5), plt.title('Result 4')
    plt.imshow(results[3]), plt.axis('off')
    plt.subplot(2, 3, 6), plt.title('Result 5')
    plt.imshow(results[4]), plt.axis('off')
    # Show the result
    plt.show()
    return 0


print("#---System Start---#")
# Configuration
map_path = "./maps/map_2.csv"

if __name__ == "__main__":
    h_map = map_generator.load_map(map_path)
    os.system("clear")
    while True:
        os.system("clear")
        image_path = input("Please input your image:")
        image_path = re.sub("file://", '', image_path).strip()
        images = map_generator.retrieval(image_path, h_map)
        images_display(image_path, images)
