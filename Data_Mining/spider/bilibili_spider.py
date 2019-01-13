import re
import requests
from urllib import request

aid2cid_url = "https://www.bilibili.com/widget/getPageList?aid={}"
comment_url = "http://comment.bilibili.com/{}.xml"


def get_cid_list(aid):
    if type(aid) != type("string"):
        aid = str(aid)
    try:
        response = request.urlopen(aid2cid_url.format(aid))
    except Exception as e:
        print(e)
        return list()
    html = str(response.read())
    cid_list = re.findall("\"cid\":(\d+?)}", html)
    return cid_list


def get_comment_xml(cid_list, page):
    for cid in cid_list:
        try:
            response = requests.get(comment_url.format(cid))
            xml_data = response.content.decode("utf-8")
        except Exception as e:
            print(e)
            return page
        with open("./data/{}.xml".format(str(page)), 'a+') as f:
            f.write(xml_data)
        page += 1
    return page


if __name__ == "__main__":
    page = 1
    cids = list()
    for i in range(4044639, 4056639):
        cid_list = get_cid_list(i)
        if len(cid_list) > 1:
            cids.append(cid_list)
        page = get_comment_xml(cid_list, page)
    print(cids)
