//#include <opencv/nonfree.hpp>
#include <opencv2/features2d.hpp>
#include "opencv2/core/core.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"
#include <opencv2/opencv.hpp>
#include "opencv2/xfeatures2d.hpp"
#include <opencv2/highgui.hpp>
#include "opencv2/imgproc/imgproc.hpp"
#include <stdio.h>
#include <stdlib.h>
#include <Eigen/Core>
#include <opencv2/core/eigen.hpp>
//#include <opencv2/calib3d\calib3d.hpp>
#include <iostream>
#include <utility>
#include <string>
#include <vector>
using std::cin;
using namespace cv;
using namespace std;
//template <typename Derived>



    // cv::BFMatcher matcher(cv::NORM_L2, false); //BFMatcher class已经支持交叉验证, 命名为matcher； NORM_L2：归一化数组的(欧几里德)L2-范数， euclidean；返回欧几里距离
    //  vector< vector < cv::DMatch> > knn_matches; //vector<vector< 二维向量：定义二维向量 knn_matches
    //  matcher.knnMatch(query, train, knn_matches, 2);//knnMatch是matcher的一个属性。此属性包含在BFMatcher中。为每个descriptor查找K-nearest-matches;使用KNN-matching算法，令K=2。

    /////////////////////////////////////////////////////////////////////////////////

//     const float ratio = 0.7;//将比值设为0.7  可以自己调节
//     matches.clear();//清空matches
//     matcher.knnMatch(query, train, matches2, 2);//运用knnmatch
//     for (int n = 0; n < matches2.size(); n++)
//     {
//         DMatch& bestmatch = matches2[n][0];
//         DMatch& bettermatch = matches2[n][1];
//         if (bestmatch.distance < ratio*bettermatch.distance)//筛选出符合条件的点
//         {
//             matches.push_back(bestmatch);//将符合条件的点保存在matches
//         }
//     }
//     cout << "match个数:" << matches.size() << endl;
//
//
//
//     matcher.knnMatch(query, train, matches, 2);
//     //则每个match得到两个最接近的descriptor，返回两个最佳匹配。用交叉验证结合KNN的算法进行匹配，将匹配结果放入maches中
//
//     //获取满足Ratio Test的最小匹配的距离
//     float min_dist = FLT_MAX; //将float的最大值赋值给min_dist
//     for (int r = 0; r < knn_matches.size(); ++r)
//     {
//         //Ratio Test；计算最接近距离和次接近距离之间的比值，当比值大于既定值时，才作为最终match
//         if (knn_matches[r][0].distance > 0.6*knn_matches[r][1].distance)//思想：同种类型的东西，离得不会太远（在此项目中仿佛不可行？）
//             continue;
//
//         float dist = knn_matches[r][0].distance;//存储了最近的距离进入dist
//         if (dist < min_dist) min_dist = dist;//存入匹配对中的最短距离
//     }
//
//     matches.clear();//清空matches
//     for (size_t r = 0; r < knn_matches.size(); ++r)
//     {
//         //排除不满足Ratio Test的点和匹配距离过大的点
//         if (
//             knn_matches[r][0].distance > 0.6*knn_matches[r][1].distance ||
//             knn_matches[r][0].distance > 5 * max(min_dist, 10.0f)
//             )
//             continue;
//
//         //保存匹配点
//         matches.push_back(knn_matches[r][0]);
//     }
// }


// void get_matched_points( //提取出两个图的matched points
// 	vector<KeyPoint>& p1,
// 	vector<KeyPoint>& p2,
// 	vector<DMatch> matches,
// 	vector<Point2f>& out_p1,
// 	vector<Point2f>& out_p2
// 	)
// {
// 	out_p1.clear();
// 	out_p2.clear();
// 	for (int i = 0; i < matches.size(); ++i)
// 	{
// 		out_p1.push_back(p1[matches[i].queryIdx].pt);
// 		out_p2.push_back(p2[matches[i].trainIdx].pt);
// 	}
// }

// void get_matched_colors( //提取出两个图的颜色
// 	vector<Vec3b>& c1,
// 	vector<Vec3b>& c2,
// 	vector<DMatch> matches,
// 	vector<Vec3b>& out_c1,
// 	vector<Vec3b>& out_c2
// 	)
// {
// 	out_c1.clear();
// 	out_c2.clear();
// 	for (int i = 0; i < matches.size(); ++i)
// 	{
// 		out_c1.push_back(c1[matches[i].queryIdx]);
// 		out_c2.push_back(c2[matches[i].trainIdx]);
// 	}
// }

bool find_transform(Mat& K, vector<Point2f>& p1, vector<Point2f>& p2, Mat& R, Mat& T, Mat& mask)//mask – Output array of N elements, 返回R，T，mask
//every element of which is set to 0 for outliers and to 1 for the other points. The array is computed only in the RANSAC and LMedS methods.
{
    //根据内参矩阵获取相机的焦距和光心坐标（主点坐标）
    double focal_length = 0.5*(K.at<double>(0) + K.at<double>(4));//焦距：已知
		//double focal_length = 699.783;
    Point2d principle_point(K.at<double>(2), K.at<double>(5));//中心点，已知
    //Point2d principle_point(637.704, 360.875);
    //根据匹配点求取本征矩阵，使用RANSAC，进一步排除失配点
    Mat E = findEssentialMat(p1, p2, focal_length, principle_point, RANSAC, 0.99, 1.0, mask);
 	// cout<<mask<<endl;
	// p1,p2，feature points from two images；threshold – Parameter used for RANSAC.
  	//   0.999：It is the maximum distance from a point to an epipolar line in pixels, beyond which the point is considered an outlier and is not used for computing the final fundamental matrix.
  	//   prob – Parameter used for the RANSAC or LMedS methods only. It specifies a desirable level of confidence (probability) that the estimated matrix is correct.
  	//   mask – Output array of N elements（matched-feature的个数）, every element of which is set to 0 for outliers and to 1 for the other points. The array is computed only in the RANSAC and LMedS methods.
    if (E.empty()) return false;
	double feasible_count = countNonZero(mask);//计算非零像素点数
    cout << (int)feasible_count << " -in- " << p1.size() << endl;
    // //对于RANSAC而言，outlier数量大于50%时，结果是不可靠的
    // if (feasible_count / p1.size()) < 0.6)
    //     return false;

    //分解本征矩阵，获取相对变换
    int pass_count = recoverPose(E, p1, p2, R, T, focal_length, principle_point, mask);//Recover relative camera rotation and translation from an estimated essential matrix and
    // //the corresponding points in two images, using cheirality check. Returns the number of inliers which pass the check,已知本征矩阵，返回最适合的R，T
    //cout<<mask<<endl;
    // //同时位于两个相机前方的点的数量要足够大
    if (((double)pass_count) / feasible_count < 0.7)
        return false;

    return true;
}
void reconstruct(Mat& K, Mat& R, Mat& T, vector<Point2f>& p1, vector<Point2f>& p2, Mat& structure)
{
    //两个相机的投影矩阵[R T]，triangulatePoints只支持float型
    Mat proj1(3, 4, CV_32FC1);//定义float 32位的3 x 4矩阵
    Mat proj2(3, 4, CV_32FC1);

    proj1(Range(0, 3), Range(0, 3)) = Mat::eye(3, 3, CV_32FC1);//将前三行前三列命名为单位矩阵；proj1=[1 0 0 0;
                                                              //                                 0 1 0 0;
                                                            //                                   0 0 1 0]
    proj1.col(3) = Mat::zeros(3, 1, CV_32FC1);//第四列列为全0

    R.convertTo(proj2(Range(0, 3), Range(0, 3)), CV_32FC1);//将R转换为proj2前三行前三列，类型为32类型float；u不包括第四列;proj2=[R|T]
    T.convertTo(proj2.col(3), CV_32FC1);//将T转换为proj2第四列，类型为32类型float

    Mat fK;
    K.convertTo(fK, CV_32FC1);//将K转换为浮点类型的fk
    proj1 = fK*proj1;//proj1，相当与lab里的camera matrix，此处称为projection matrix
    proj2 = fK*proj2;

    //三角化重建
    triangulatePoints(proj1, proj2, p1, p2, structure);//void cv::sfm::triangulatePoints 	( InputArrayOfArrays points2d, InputArrayOfArrays  projection_matrices, OutputArray  points3d )
    //points2d	Input vector of vectors of 2d points (the inner vector is per image). Has to be 2 X N.
//points3d	Output array with computed 3d points. Is 3 x N.
}

void maskout_colors(vector<Vec3b>& p1, Mat& mask) //去除没有颜色的点
{
	vector<Vec3b> p1_copy = p1;
	p1.clear();

	for (int i = 0; i < mask.rows; ++i)
	{
		if (mask.at<uchar>(i) > 0)
			p1.push_back(p1_copy[i]);
	}
}

void maskout_points(vector<Point2f>& p1, Mat& mask)//去除没有值的点
{
	vector<Point2f> p1_copy = p1;
	p1.clear();

	for (int i = 0; i < mask.rows; ++i)
	{
		if (mask.at<uchar>(i) > 0)
			p1.push_back(p1_copy[i]);
	}
}

void save_structure(string file_name, vector<Mat>& rotations, vector<Mat>& motions, Mat& structure, vector<Vec3b>& colors)//将相关信息保存下来，用于第三张图的时候使用
{
	int n = (int)rotations.size();

	FileStorage fs(file_name, FileStorage::WRITE);
	fs << "Camera Count" << n;
	fs << "Point Count" << structure.cols;

	fs << "Rotations" << "[";
	for (size_t i = 0; i < n; ++i)
	{
		fs << rotations[i];
	}
	fs << "]";

	fs << "Motions" << "[";
	for (size_t i = 0; i < n; ++i)
	{
		fs << motions[i];
	}
	fs << "]";

	fs << "Points" << "[";
	for (size_t i = 0; i < structure.cols; ++i)
	{
		Mat_<float> c = structure.col(i);
		c /= c(3);	//�������꣬��Ҫ��������һ��Ԫ�ز�������������ֵ
		fs << Point3f(c(0), c(1), c(2));
	}
	fs << "]";

	fs << "Colors" << "[";
	for (size_t i = 0; i < colors.size(); ++i)
	{
		fs << colors[i];
	}
	fs << "]";

	fs.release();
}
int main( int argc, char** argv )
{
	// string img1 = "fig1.png";
	// string img2 = "fig2.png";
	// // string img1 = "0004.png";
	// // string img2 = "0006.png";
	// vector<string>img_names;
	// img_names.push_back(img1);
	// img_names.push_back(img2);

	// // Mat img11 = imread("0004.png");
 //  // Mat img22 = imread("0006.png");

	// vector<vector<KeyPoint> > key_points_for_all;
	// vector<Mat> descriptor_for_all;
	vector<vector<Vec3b> > colors_for_all;
	//vector<DMatch> matches;

	//��������
	// Mat K(Matx33d(
	// 	2759.48, 0, 1520.69,
	// 	0, 2764.16, 1006.81,
	// 	0, 0, 1));
	Mat K(Matx33d(
    350.6847, 0, 332.4661,
    0, 350.0606, 163.7461,
    0, 0, 1));
		// for(int i=0;i<2;i++)
		// {
		// cout<<img_names[i]<<endl;
	  // }
   //vector<string>& image_names,
	//  Mat image1,image2;
	// extract_features(img_names, key_points_for_all, descriptor_for_all, colors_for_all);
	//   Mat img_keypoints1,img_keypoints2;
	// //drawKeypoints(img11,key_points_for_all[0],img11,Scalar(255,255,255),DrawMatchesFlags::DRAW_OVER_OUTIMG);
	// // drawKeypoints(img22,key_points_for_all[1],img22,Scalar(255,255,255),DrawMatchesFlags::DRAW_OVER_OUTIMG);
	// // //namedWindow("KeyPoints of image1",0);
	// // namedWindow("KeyPoints of image2",0);
 //  //
	// // //imshow("KeyPoints of image1",img11);
	// // imshow("KeyPoints of image2",img22);
	// // //
 //  //   waitKey(0);
 //  //   system("pause");
 //  //   return 0;
	// // //����ƥ��
	// //Mat img_matches;
	// match_features(descriptor_for_all[0], descriptor_for_all[1], matches);
	// drawMatches(img11,key_points_for_all[0],img22,key_points_for_all[1],matches,img_matches,
  //               Scalar::all(-1)/*CV_RGB(255,0,0)*/,CV_RGB(0,255,0),Mat(),2);
	// imshow("MatchSIFT",img_matches);
  // waitKey(0);
  // return 0;
  //
	// //�����任����
	Mat P1,	P2;
	//Mat M = (Mat_<double>(3,3) << 1, 0, 0, 0, 1, 0, 0, 0, 1);
	Mat keypoint1=(Mat_<float>(2,7) << 175,174,173,195,195,175, 178,
                                       346,197,134,419,277, 37, 111);
	Mat keypoint2=(Mat_<float>(2,7) << 176, 176, 175, 201, 201, 177, 180, 
	                                    248, 185, 117, 428, 264, 6,   87);
	for (int i = 0; i < keypoint1.cols ; ++i)//遍历每个图的descriptor
	{  
	
		P1.push_back(keypoint1.colRange(i,i+1));
     }
    for (int j = 0; j < keypoint2.cols ; ++j)//遍历每个图的descriptor
	{  
	
		P2.push_back(keypoint2.colRange(j,j+1));
     }
	vector<Point2f> p1,p2;  
    p1 = Mat_<Point2f>(P1);
    p2 = Mat_<Point2f>(P2);
    cout<<p1;
    
	// vector<Point2f> p1, p2;
	//color for yellow [0, 255, 255];
	//color for red [0, 0, 255]
	Mat C1=(Mat_<float>(7,3)<<0, 0, 255,
							  0, 0, 255,
							  0, 0, 255,
							  0, 0, 255,
		                     0, 255, 255,
		                      0, 0, 255,
		                      0, 0, 255);
	vector<Vec3b> c1, c2;
	for (int x = 0; x < C1.rows - 1; ++x)//遍历每个图的descriptor
	{  
	
		c1.push_back(C1.rowRange(x,x+1));
    }
    Mat C2=(Mat_<float>(7,3)<<0, 0, 255,
							  0, 0, 255,
							  0, 0, 255,
							  0, 0, 255,
		                     0, 255, 255,
		                      0, 0, 255,
		                      0, 0, 255);
    for (int x1 = 0; x1 < C2.rows - 1; ++x1)//遍历每个图的descriptor
	{  
	
		c2.push_back(C2.rowRange(x1,x1+1));
    }
	Mat R, T;	//��ת������ƽ������
	Mat mask;	//mask�д������ĵ�����ƥ���㣬����������ʧ����
	// //get_matched_points(key_points_for_all[0], key_points_for_all[1], matches, p1, p2);
	// //get_matched_colors(colors_for_all[0], colors_for_all[1], matches, c1, c2);
	find_transform(K, p1, p2, R, T, mask);
	//cout<<mask;
	double feasible_count = countNonZero(mask);
	Mat structure;	//4��N�еľ�����ÿһ�д����ռ��е�һ���㣨�������꣩
	maskout_points(p1, mask);
	maskout_points(p2, mask);
	// //  // return 0;
	reconstruct(K, R, T, p1, p2, structure);
	cout<<structure;
	// //���沢��ʾ
	vector<Mat> rotations;
	rotations.push_back(Mat::eye(3, 3, CV_64FC1));
	rotations.push_back(R);
	//= { Mat::eye(3, 3, CV_64FC1), R };
	vector<Mat> motions;
	motions.push_back(Mat::zeros(3, 1, CV_64FC1));
	motions.push_back(T);
	maskout_colors(c1, mask);
	//save_structure("\\Viewer\\structure.yml", rotations, motions, structure, c1);
    save_structure("structure333.yml", rotations, motions, structure, c1);
	// //system(".\\Viewer\\SfMViewer.exe");
 }