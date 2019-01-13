import os


def merge_xml_files(path):
    with open(path + "total.xml", "a+") as f:
        for file_name in os.listdir(path):
            with open(path + file_name) as w:
                f.write(w.read())


if __name__ == "__main__":
    merge_xml_files("/home/nico/GitHub/Assignments_in_GDUFS/Data_Mining/spider/data/")
