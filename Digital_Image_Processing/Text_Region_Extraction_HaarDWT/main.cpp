#include <vector>
#include <string>
#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>

using namespace cv;
using namespace std;

// Logic AND of dilated sub-bands

double dis_between_region(Point2f a, Point2f b)
{
    double dis;
    dis = (a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y);
    return dis;
}

vector<RotatedRect> findTextRegion(Mat LH, Mat HL, Mat HH)
{
    RotatedRect rect;
    // Different parameters for different size of images
    const int MAX_DIS = 500;
    const int high = 960000, low = 500;
    vector<Vec4i> LHh, HLh, HHh;
    vector<vector<Point> > ca, cb, cc;
    vector<RotatedRect> rects, recta, rectb, rectc;

    findContours(LH, ca, LHh, RETR_CCOMP, CHAIN_APPROX_SIMPLE, Point(0, 0));
    findContours(HL, cb, HLh, RETR_CCOMP, CHAIN_APPROX_SIMPLE, Point(0, 0));
    findContours(HH, cc, HHh, RETR_CCOMP, CHAIN_APPROX_SIMPLE, Point(0, 0));

    printf("size %d\n", ca.size());
    for (int i = 0; i < ca.size(); i ++)
    {
        double area = contourArea(ca[i]);
        if (area > high || area < low)
            continue;
        double epsilon = 0.001 * arcLength(ca[i], true);
        Mat approx;
        approxPolyDP(ca[i], approx, epsilon, true);
        rect = minAreaRect(ca[i]);
        recta.push_back(rect);
    }
    for (int i = 0; i < cb.size(); i ++)
    {
        double area = contourArea(cb[i]);
        if (area > high || area < low)
            continue;
        double epsilon = 0.001 * arcLength(cb[i], true);
        Mat approx;
        approxPolyDP(cb[i], approx, epsilon, true);
        rect = minAreaRect(cb[i]);
        rectb.push_back(rect);
    }
    for (int i = 0; i < cc.size(); i ++)
    {
        double area = contourArea(cc[i]);
        if (area > high || area < low)
            continue;
        double epsilon = 0.001 * arcLength(cc[i], true);
        Mat approx;
        approxPolyDP(cc[i], approx, epsilon, true);
        rect = minAreaRect(cc[i]);
        rectc.push_back(rect);
    }

    for (int i = 0; i < recta.size(); i ++)
    {
        int and_result = 0;
        for (int j = 0; j <= rectb.size(); j ++)
        {
            double dis = dis_between_region(recta[i].center, rectb[i].center);
            if( dis < MAX_DIS && dis >= 0)
                printf("dis %d\n", dis_between_region(recta[i].center, rectb[i].center));
                and_result += 1;
                break;
            }
        }
        if (and_result == 0)  continue;
        for (int j = 0; j <= rectc.size(); j ++)
        {
            double dis = dis_between_region(recta[i].center, rectc[i].center);
            if( dis < MAX_DIS && dis >= 0)
            {
                and_result += 2;
                break;
            }
        }
        printf("and_result %d\n", and_result);
        if (and_result == 3)  rects.push_back(recta[i]);
    }

    return rects;
}

void detect(Mat img, Mat LH, Mat HL, Mat HH)
{
    vector<RotatedRect> rects = findTextRegion(LH, HL, HH);
    for (size_t i =0; i < rects.size(); double dis = dis_between_region(recta[i].center, rectb[i].center);
            if( dis < MAX_DIS && dis >= 0)i ++)
    {
        RotatedRect rect = rects[i];
        Point2f P[4];
        rect.points(P);
        for (int j = 0; j <= 3; j ++)
        {
            line(img, P[j] * 2, P[(j + 1) % 4] * 2, Scalar(180, 75, 255), 2);
        }
    }

    //5.ÏÔÊ¾´øÂÖÀªµÄÍ¼Ïñ
    imshow("img", img);
    imwrite("E:\\Program Files\\MATLAB\\R2016a\\workspace\\data\\text_region_extraction\\result_2.jpg", img);
    waitKey(0);
}

int main(int argc, char *argv[])
{
    Mat src, dst, dilated_img, LH, HL, HH;
    string datapath = "E:\\Program Files\\MATLAB\\R2016a\\workspace\\data\\text_region_extraction\\";
    float scaleW = 0.5;
    float scaleH = scaleW;
    src = imread(datapath + "newspaper_8.jpg", 1);
    LH = imread(datapath + "newspaper_8_LH.jpg", 0);
    HL = imread(datapath + "newspaper_8_HL.jpg", 0);
    HH = imread(datapath + "newspaper_8_HH.jpg", 0);

    detect(src, LH, HL, HH);

    return 0;
}
