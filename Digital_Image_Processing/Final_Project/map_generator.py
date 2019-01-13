import os

import pandas
from PIL import Image

from torchvision import transforms
import torch.optim.lr_scheduler
from network import AlexNetLatent

threshold = 0.5
# Load the pre-trained model
print("Loading the model...")
anl = AlexNetLatent(48)    # The width of Latent layer
model = torch.load("./model/1")
anl.load_state_dict(model)
# The transformer
print("Initializing transformer...")
transformer = transforms.Compose(
    [
        transforms.Resize(227),
        transforms.ToTensor(),
        transforms.Normalize(
            (0.4914, 0.4822, 0.4465),
            (0.2023, 0.1994, 0.2010)
        )
    ]
)


def feature_extract(image_path):
    # Calculating the binary hash code
    print("Feature extracting...")
    print(image_path)
    img = Image.open(image_path)
    img = transformer(img)
    img.unsqueeze_(dim=0)
    l8, _ = anl(img)
    l8 = l8.detach().numpy()
    mask_0 = l8 < threshold
    mask_1 = l8 >= threshold
    l8[mask_0] = 0
    l8[mask_1] = 1
    l8 = l8.astype(int).tolist()[0]
    binary_hash = 0
    for i in range(48):
        binary_hash += l8[i] * (2 ** (48 - i))
    return hex(binary_hash)


def generate_the_map(images_path, output_path):
    print("Map generating...")
    hash_map = list()
    for parent, _, file_names in os.walk(images_path, followlinks=True):
        for filename in file_names:
            file_path = os.path.join(parent, filename)
            hash_map.append([file_path, feature_extract(file_path)])
    mdf = pandas.DataFrame(hash_map)
    mdf.to_csv(output_path)


def hamming_distance(x, y):
    return bin(x ^ y).count('1')


def load_map(map_path):
    # Load the hash map
    print("Loading the map...")
    hash_map = pandas.read_csv(map_path)
    return hash_map


def retrieval(query_image, hash_map, limit=5):
    print("Retrieving...")
    # Initialize our dictionary of results
    results = dict()
    qif = int(feature_extract(query_image), 16)
    for _, row in hash_map.iterrows():
        row = row.tolist()
        results[row[1]] = hamming_distance(qif, int(row[2], 16))
    results = sorted([(v, k) for (k, v) in results.items()])
    images = list()
    for result in results:
        if query_image == result[1]:
            continue
        images.append(result[1])
    images = images[1: limit + 1]
    # Return the result
    return images


if __name__ == "__main__":
   generate_the_map("./images", "./maps/map_2.csv")
