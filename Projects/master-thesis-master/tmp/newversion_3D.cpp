// #include <opencv2\xfeatures2d\nonfree.hpp>
// #include <opencv2\features2d\features2d.hpp>
// #include <opencv2\highgui\highgui.hpp>
// #include <opencv2\calib3d\calib3d.hpp>
// #include <iostream>
// #include <tinydir.h>
//#include <opencv/nonfree.hpp>
//google::InitGoogleLogging(argv[0]);
#include "math.h"
#include "limits.h"
#include "eigen3/Eigen/Core"
#include "eigen3/Eigen/Dense"
#include <opencv2/features2d.hpp>
#include "opencv2/core/core.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"
#include <opencv2/opencv.hpp>
#include "opencv2/xfeatures2d.hpp"
#include <opencv2/highgui.hpp>
#include "opencv2/imgproc/imgproc.hpp"
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
#include <iostream>
#include <string>
#include "math.h"
#include "limits.h"
#include "eigen3/Eigen/Core"
#include "eigen3/Eigen/Dense"
#include <opencv2/features2d.hpp>
#include "opencv2/core/core.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"
#include <opencv2/opencv.hpp>
#include "opencv2/xfeatures2d.hpp"
#include <opencv2/highgui.hpp>
#include "opencv2/imgproc/imgproc.hpp"
#include <ceres/ceres.h>
#include <Eigen/Core>
#include <opencv2/core/eigen.hpp>
#include <iostream>
#include <utility>
#include <string>
#include <vector>
#include <ceres/rotation.h>
#include <ceres/problem.h>
#include <fstream>
#include <algorithm>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include "eigen3/Eigen/Core"
#include "eigen3/Eigen/Dense"


using std::cin;
using namespace cv;
using namespace std;
using namespace ceres;



float threshold = 30;

float computeResiduals(cv::Point2f pt1, cv::Point2f pt2){
  return pow((pow ((pt1.x-pt2.x),2) + pow ((pt1.y-pt2.y),2)),0.5);
}

void matchFeatures(int imageId, vector<cv::KeyPoint> featureLast, 
                  vector<cv::KeyPoint> featureNext, vector<cv::DMatch> &matched){
  float res, minRes;
  int featureLastRow = featureLast.size();
  int featureNextRow = featureNext.size();
  int index;

  for(int i = 0; i < featureNextRow; i++){
    minRes = threshold;
    for(int j = 0; j < featureLastRow; j++){
      if(featureNext[i].class_id == featureLast[j].class_id){
        res = computeResiduals(featureNext[i].pt, featureLast[j].pt);//check residuals, find the smallest one, save it
        if(res < minRes){
          minRes = res;
          index = j;
        }
      }
    }
    if(minRes < threshold){
      matched.push_back(cv::DMatch(index,i,imageId,minRes));
      cout << index << " " << i << " " << imageId << " " << minRes << endl;
    } 
  }
}

// bool find_transform(Mat& K, vector<Point2f>& p1, vector<Point2f>& p2, Mat& R, Mat& T, Mat& mask)
// {
// 	//????????????????????????????????????????????????????????????????????????????????????????????????????????????????
// 	double focal_length = 0.5*(K.at<double>(0) + K.at<double>(4));
// 	Point2d principle_point(K.at<double>(2), K.at<double>(5));

// 	//????????????????????????????????????????????????????????????????????????RANSAC??????????????????????????????????????????
// 	Mat E = findEssentialMat(p1, p2, focal_length, principle_point, RANSAC, 0.999, 1.0, mask);
// 	if (E.empty()) return false;

// 	double feasible_count = countNonZero(mask);
// 	cout << (int)feasible_count << " -in- " << p1.size() << endl;
// 	//????????????RANSAC??????????????outlier????????????????????????50%??????????????????????????????????????????
// 	if (feasible_count <= 15 || (feasible_count / p1.size()) < 0.6)
// 		return false;

// 	//??????????????????????????????????????????????
// 	int pass_count = recoverPose(E, p1, p2, R, T, focal_length, principle_point, mask);

// 	//????????????????????????????????????????????????????????????????????????????????????
// 	if (((double)pass_count) / feasible_count < 0.7)
// 		return false;

// 	return true;
// }
// //get_matched_points(key_points_for_all[i], key_points_for_all[i + 1], matches_for_all[i], p1, p2);
// void get_matched_points(//??????matches,???????????????????????????????????????
// 	vector<Point2f>& p1,
// 	vector<Point2f>& p2,
// 	//vector<DMatch> matches,
// 	vector<Point2f>& matches,
// 	vector<Point2f>& out_p1,
// 	vector<Point2f>& out_p2
// 	)
// {
// 	out_p1.clear();
// 	out_p2.clear();
// 	for (int i = 0; i < matches.size(); ++i)
// 	{
// 		out_p1.push_back(p1[matches[i].x]);
// 		out_p2.push_back(p2[matches[i].y]);
// 	}
// }

// void get_matched_colors(
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

// void reconstruct(Mat& K, Mat& R1, Mat& T1, Mat& R2, Mat& T2, vector<Point2f>& p1, vector<Point2f>& p2, vector<Point3d>& structure)//??????????????????????????????
// {
// 	Mat proj1(3, 4, CV_32FC1);
// 	Mat proj2(3, 4, CV_32FC1);

// 	R1.convertTo(proj1(Range(0, 3), Range(0, 3)), CV_32FC1);//???R1???????????????proj1?????????????????????
// 	T1.convertTo(proj1.col(3), CV_32FC1);//???T????????????????????????

// 	R2.convertTo(proj2(Range(0, 3), Range(0, 3)), CV_32FC1);//???R2???????????????proj2?????????????????????
// 	T2.convertTo(proj2.col(3), CV_32FC1);

// 	Mat fK;
// 	K.convertTo(fK, CV_32FC1);
// 	proj1 = fK*proj1;
// 	proj2 = fK*proj2;

// 	//????????????????????
// 	Mat s;
// 	triangulatePoints(proj1, proj2, p1, p2, s);//??????????????????s

// 	structure.clear();
// 	structure.reserve(s.cols);//Requests that the vector capacity be at least enough to contain s.cols elements.
// 	for (int i = 0; i < s.cols; ++i)
// 	{
// 		Mat_<float> col = s.col(i);
// 		col /= col(3);	///?????????????????????????????????????????????????????????????????????
// 		structure.push_back(Point3f(col(0), col(1), col(2)));//???????????????????????????
// 	}
// }

// void maskout_points(vector<Point2f>& p1, Mat& mask)
// {
// 	vector<Point2f> p1_copy = p1;
// 	p1.clear();

// 	for (int i = 0; i < mask.rows; ++i)
// 	{
// 		if (mask.at<uchar>(i) > 0)
// 			p1.push_back(p1_copy[i]);
// 	}
// }

// void maskout_colors(vector<Vec3b>& p1, Mat& mask)
// {
// 	vector<Vec3b> p1_copy = p1;
// 	p1.clear();

// 	for (int i = 0; i < mask.rows; ++i)
// 	{
// 		if (mask.at<uchar>(i) > 0)
// 			p1.push_back(p1_copy[i]);
// 	}
// }

// void save_structure(string file_name, vector<Mat>& rotations, vector<Mat>& motions, vector<Point3d>& structure, vector<Vec3b>& colors)
// {
// 	int n = (int)rotations.size();

// 	FileStorage fs(file_name, FileStorage::WRITE);
// 	fs << "Camera Count" << n;
// 	fs << "Point Count" << (int)structure.size();

// 	fs << "Rotations" << "[";
// 	for (size_t i = 0; i < n; ++i)
// 	{
// 		fs << rotations[i];
// 	}
// 	fs << "]";

// 	fs << "Motions" << "[";
// 	for (size_t i = 0; i < n; ++i)
// 	{
// 		fs << motions[i];
// 	}
// 	fs << "]";

// 	fs << "Points" << "[";
// 	for (size_t i = 0; i < structure.size(); ++i)
// 	{
// 		fs << structure[i];
// 	}
// 	fs << "]";

// 	fs << "Colors" << "[";
// 	for (size_t i = 0; i < colors.size(); ++i)
// 	{
// 		fs << colors[i];
// 	}
// 	fs << "]";

// 	fs.release();
// }
// //get_objpoints_and_imgpoints(
// 	// matches_for_all[i],
// 	// correspond_struct_idx[i],
// 	// structure,
// 	// key_points_for_all[i+1],
// 	// object_points,
// 	// image_points
// 	// );
// void get_objpoints_and_imgpoints(
// 	vector<Point2f>& matches,//???????????????????????????????????????matches????????????????????????match_features
// 	vector<int>& struct_indices,
// 	vector<Point3d>& structure,
// 	vector<Point2f>& key_points,//???????????????key points
// 	vector<Point3f>& object_points,
// 	vector<Point2f>& image_points)
// {
// 	object_points.clear();
// 	image_points.clear();

// 	for (int i = 0; i < matches.size(); ++i)
// 	{
// 		int query_idx = matches[i].x;//??????????????????????????????feature point
// 		int train_idx = matches[i].y;

// 		int struct_idx = struct_indices[query_idx];//?????????????????????????????????????????????match??????????????????match???????????????U
// 		if (struct_idx < 0) continue;

// 		object_points.push_back(structure[struct_idx]);//???????????????????????????match???3D??????
// 		image_points.push_back(key_points[train_idx].pt);//???????????????match??????????????????match?????????
// 	}
// }
// // fusion_structure(
// // 	matches_for_all[i],
// // 	correspond_struct_idx[i],
// // 	correspond_struct_idx[i + 1],
// // 	structure,
// // 	next_structure,
// // 	colors,
// // 	c1
// // 	);
// void fusion_structure(
// 	vector<DMatch>& matches,
// 	vector<int>& struct_indices,
// 	vector<int>& next_struct_indices,
// 	vector<Point3d>& structure,
// 	vector<Point3d>& next_structure,
// 	vector<Vec3b>& colors,
// 	vector<Vec3b>& next_colors
// 	)
// {
// 	for (int i = 0; i < matches.size(); ++i)
// 	{
// 		int query_idx = matches[i].queryIdx;
// 		int train_idx = matches[i].trainIdx;

// 		int struct_idx = struct_indices[query_idx];//????????????????????????????????????????????????????????????3D????????????????????????????????????????????????3D???
// 		if (struct_idx >= 0)
// 		{
// 			next_struct_indices[train_idx] = struct_idx;
// 			continue;
// 		}
// 		structure.push_back(next_structure[i]);
// 		colors.push_back(next_colors[i]);
// 		struct_indices[query_idx] = next_struct_indices[train_idx] = structure.size() - 1;
// 	}
// }

// void init_structure(//?????????
// 	Mat K,
// 	vector<vector<Point2f> >& key_points_for_all,
// 	vector<vector<Vec3b> >& colors_for_all,
// 	vector<vector<Point2f> >& matches_for_all,
// 	vector<Point3d>& structure,
// 	vector<vector<int> >& correspond_struct_idx,
// 	vector<Vec3b>& colors,
// 	vector<Mat>& rotations,
// 	vector<Mat>& motions
// 	)
// {
	
// 	vector<Point2f> p1, p2;
// 	vector<Vec3b> c2;
// 	Mat R, T;	
// 	Mat mask;	
// 	get_matched_points(key_points_for_all[0], key_points_for_all[1], matches_for_all[0], p1, p2);
// 	get_matched_colors(colors_for_all[0], colors_for_all[1], matches_for_all[0], colors, c2);
// 	find_transform(K, p1, p2, R, T, mask);//?????????????????????P

// 	maskout_points(p1, mask);
// 	maskout_points(p2, mask);
// 	maskout_colors(colors, mask);

// 	Mat R0 = Mat::eye(3, 3, CV_64FC1);//???????????????P
// 	Mat T0 = Mat::zeros(3, 1, CV_64FC1);
// 	reconstruct(K, R0, T0, R, T, p1, p2, structure);
//   rotations.push_back(R0);
//   rotations.push_back(R);
// 	motions.push_back(T0);
// 	motions.push_back(T);

// 	//???correspond_struct_idx??????key_points_for_all?????????
// 	correspond_struct_idx.clear();
// 	correspond_struct_idx.resize(key_points_for_all.size());
// 	for (int i = 0; i < key_points_for_all.size(); ++i)
// 	{
// 		correspond_struct_idx[i].resize(key_points_for_all[i].size(), -1);//???key points???size??????????????????????????????-1???
// 	}

	
// 	int idx = 0;
// 	vector<DMatch>& matches = matches_for_all[0];//???matches_for_all?????????????????????matches
// 	for (int i = 0; i < matches.size(); ++i)
// 	{
// 		if (mask.at<uchar>(i) == 0)//???????????????match???outlier
// 			continue;//??????mask????????????0??????????????????????????????????????????????????????

// 		correspond_struct_idx[0][matches[i].x] = idx;//??????idx???match,???idx?????????correspond_struct_idx?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????feature point
// 		correspond_struct_idx[1][matches[i].y] = idx;
// 		++idx;
// 	}
// }

// void get_file_names(string dir_name, vector<string> & names)//???????????????????????????????????????????????????
// {
// 	names.clear();
// 	tinydir_dir dir;
// 	tinydir_open(&dir, dir_name.c_str());

// 	while (dir.has_next)
// 	{
// 		tinydir_file file;
// 		tinydir_readfile(&dir, &file);
// 		if (!file.is_dir)
// 		{
// 			names.push_back(file.path);
// 		}
// 		tinydir_next(&dir);
// 	}
// 	tinydir_close(&dir);
// }

int main( int argc, char** argv )

  Mat K(Matx33d(
    350.6847, 0, 332.4661,
    0, 350.0606, 163.7461,
    0, 0, 1));


vector<cv::KeyPoint> featureLast, featureNext;

  featureLast.push_back(cv::KeyPoint(299,198,3,-1,0,0,1));
  featureLast.push_back(cv::KeyPoint(688,199,3,-1,0,0,1));
  featureLast.push_back(cv::KeyPoint(143,201,3,-1,0,0,1));
  featureLast.push_back(cv::KeyPoint(455,187,3,-1,0,0,1));
  featureLast.push_back(cv::KeyPoint(455,195,3,-1,0,0,2));
  featureLast.push_back(cv::KeyPoint(276,180,3,-1,0,0,2));
  featureLast.push_back(cv::KeyPoint(161,183,3,-1,0,0,2));
  featureLast.push_back(cv::KeyPoint(612,208,3,-1,0,0,2));
  featureLast.push_back(cv::KeyPoint(234,211,3,-1,0,0,3));
  featureLast.push_back(cv::KeyPoint(510,223,3,-1,0,0,3));

  featureNext.push_back(cv::KeyPoint(280,209,3,-1,0,0,1));
  featureNext.push_back(cv::KeyPoint(624,207,3,-1,0,0,1));
  featureNext.push_back(cv::KeyPoint(457,194,3,-1,0,0,1));
  featureNext.push_back(cv::KeyPoint(113,214,3,-1,0,0,1));
  featureNext.push_back(cv::KeyPoint(268,188,3,-1,0,0,2));
  featureNext.push_back(cv::KeyPoint(462,204,3,-1,0,0,2));
  featureNext.push_back(cv::KeyPoint(142,192,3,-1,0,0,2));
  featureNext.push_back(cv::KeyPoint(324,181,3,-1,0,0,2));
  featureNext.push_back(cv::KeyPoint(538,241,3,-1,0,0,3));
  featureNext.push_back(cv::KeyPoint(209,228,3,-1,0,0,3));















  // Mat yellow=(Mat_<float>(1,3)<<0, 0, 255);
  // Mat blue=(Mat_<float>(1,3)<<0, 255, 255);
  // Mat orange=(Mat_<float>(1,3)<<0, 128, 255);
  // vector<cv::KeyPoint> feature1, feature2, feature3, feature4;
  // feature1.push_back(cv::KeyPoint(175,326,3,-1,0,0,1));
  // feature1.push_back(cv::KeyPoint(177,258,3,-1,0,0,1));
  // feature1.push_back(cv::KeyPoint(178,5,3,-1,0,0,1));
  // feature1.push_back(cv::KeyPoint(180,162,3,-1,0,0,1));
  // feature1.push_back(cv::KeyPoint(183,196,3,-1,0,0,2));
  // feature1.push_back(cv::KeyPoint(185,614,3,-1,0,0,1));
  // feature1.push_back(cv::KeyPoint(188,69,3,-1,0,0,2));
  // feature1.push_back(cv::KeyPoint(191,469,3,-1,0,0,2));
  // feature1.push_back(cv::KeyPoint(196,610,3,-1,0,0,1));
  // feature1.push_back(cv::KeyPoint(206,360,3,-1,0,0,2));
  // feature1.push_back(cv::KeyPoint(255,582,3,-1,0,0,1));
  // vector<Vec3b>colors1;
  // vector<int>
  // for(int i=0;i<feature1.size;i++){
  // 	if(feature1[i].class_id==1){
  // 		colors1.push_back(yellow);}
  //   elseif(feature1[i].class_id==2){
  //   	colors1.push_back(blue);}
  //   elseif(feature1[i].class_id==3){
  //   	colors1.push_back(orange);}
  // }

  // feature2.push_back(cv::KeyPoint(174,293,3,-1,0,0,1));
  // feature2.push_back(cv::KeyPoint(176,220,3,-1,0,0,1));
  // feature2.push_back(cv::KeyPoint(178,109,3,-1,0,0,1));
  // feature2.push_back(cv::KeyPoint(182,485,3,-1,0,0,2));
  // feature2.push_back(cv::KeyPoint(183,146,3,-1,0,0,2));
  // feature2.push_back(cv::KeyPoint(186,581,3,-1,0,0,1));
  // feature2.push_back(cv::KeyPoint(192,442,3,-1,0,0,2));
  // feature2.push_back(cv::KeyPoint(198,586,3,-1,0,0,1));
  // feature2.push_back(cv::KeyPoint(210,327,3,-1,0,0,2));
  // feature2.push_back(cv::KeyPoint(235,578,3,-1,0,0,1));

  // feature3.push_back(cv::KeyPoint(173,260,3,-1,0,0,1));
  // feature3.push_back(cv::KeyPoint(175,179,3,-1,0,0,1));
  // feature3.push_back(cv::KeyPoint(176,304,3,-1,0,0,2));
  // feature3.push_back(cv::KeyPoint(178,47,3,-1,0,0,1));
  // feature3.push_back(cv::KeyPoint(184,89,3,-1,0,0,2));
  // feature3.push_back(cv::KeyPoint(184,458,3,-1,0,0,2));
  // feature3.push_back(cv::KeyPoint(187,554,3,-1,0,0,1));
  // feature3.push_back(cv::KeyPoint(193,417,3,-1,0,0,2));
  // feature3.push_back(cv::KeyPoint(201,566,3,-1,0,0,1));
  // feature3.push_back(cv::KeyPoint(218,291,3,-1,0,0,2));
  // feature3.push_back(cv::KeyPoint(249,584,3,-1,0,0,1));

  // feature4.push_back(cv::KeyPoint(175,128,3,-1,0,0,1));
  // feature4.push_back(cv::KeyPoint(175.268,3,-1,0,0,2));
  // feature4.push_back(cv::KeyPoint(178,513,3,-1,0,0,1));
  // feature4.push_back(cv::KeyPoint(179,183,3,-1,0,0,2));
  // feature4.push_back(cv::KeyPoint(181,429,3,-1,0,0,2));
  // feature4.push_back(cv::KeyPoint(185,7,3,-1,0,0,2));
  // feature4.push_back(cv::KeyPoint(185,525,3,-1,0,0,1));
  // feature4.push_back(cv::KeyPoint(193,389,3,-1,0,0,2));
  // feature4.push_back(cv::KeyPoint(200,545,3,-1,0,0,1));
  // feature4.push_back(cv::KeyPoint(230,241,3,-1,0,0,2));
  // feature4.push_back(cv::KeyPoint(268,601,3,-1,0,0,1));
 

//     vector<cv::DMatch> matched;
//     matchFeatures(1, featureLast, featureNext, matched);

// 	vector<vector<Point2f> > key_points_for_all;
// 	key_points_for_all.push_back(feature1);
// 	key_points_for_all.push_back(feature2);
// 	key_points_for_all.push_back(feature3);
// 	key_points_for_all.push_back(feature4);
// 	vector<vector<Vec3b> > colors_for_all;

     
// 	// extract_features(img_names, key_points_for_all, descriptor_for_all, colors_for_all);//????????????????????????key points???descriptors
// 	// match_features(descriptor_for_all, matches_for_all);//matches_for_all????????????matches?????????

// 	vector<Point3d> structure;
// 	vector<vector<int> > correspond_struct_idx;
// 	vector<Vec3b> colors;
// 	vector<Mat> rotations;
// 	vector<Mat> motions;

// 	//?????????structure
// 	init_structure(//??????????????????????????????????????????????????????rotations ??? motions ????????????????????? R ??? T
// 		K,
// 		key_points_for_all,
// 		colors_for_all,
// 		matches_for_all,
// 		structure,
// 		correspond_struct_idx,
// 		colors,
// 		rotations,
// 		motions
// 		);


// 	for (int i = 1; i < matches_for_all.size(); ++i)//??????????????????????????????????????????????????????????????????match
// 	{
// 		vector<Point3f> object_points;//3D points
// 		vector<Point2f> image_points;
// 		Mat r, R, T;
// 		//Mat mask;

// 		//???????????????????????????????????????match???3D????????????????????????2D??????
// 		get_objpoints_and_imgpoints(
// 			matches_for_all[i],
// 			correspond_struct_idx[i],
// 			structure,
// 			key_points_for_all[i+1],
// 			object_points,
// 			image_points
// 			);

// 		//bool solvePnPRansac(InputArray objectPoints, InputArray imagePoints, InputArray cameraMatrix, InputArray distCoeffs, OutputArray rvec, OutputArray tvec,
// 		// bool useExtrinsicGuess=false, int iterationsCount=100, float reprojectionError=8.0, double confidence=0.99, OutputArray inliers=noArray(), int flags=SOLVEPNP_ITERATIVE )
// 		//rvec ??? Output rotation vector (see Rodrigues() ) that, together with tvec , brings points from the model coordinate system to the camera coordinate system.
//     //tvec ??? Output translation vector.
// 		solvePnPRansac(object_points, image_points, K, noArray(), r, T);
// 		Rodrigues(r, R);//Converts a rotation matrix to a rotation vector or vice versa.
// 		//????????????????????????R???T
// 		rotations.push_back(R);
// 		motions.push_back(T);

// 		vector<Point2f> p1, p2;
// 		vector<Vec3b> c1, c2;
// 		get_matched_points(key_points_for_all[i], key_points_for_all[i + 1], matches_for_all[i], p1, p2);//??????p1,p2?????????????????????????????????????????????
// 		get_matched_colors(colors_for_all[i], colors_for_all[i + 1], matches_for_all[i], c1, c2);

// 		//???3D???
// 		vector<Point3d> next_structure;
// 		reconstruct(K, rotations[i], motions[i], R, T, p1, p2, next_structure);//???????????????
// 		fusion_structure(
// 			matches_for_all[i],
// 			correspond_struct_idx[i],
// 			correspond_struct_idx[i + 1],
// 			structure,
// 			next_structure,
// 			colors,
// 			c1
// 			);
// 	}
// 	//??????BA
// 	//google::InitGoogleLogging(argv[0]);
// // 	Mat intrinsic(Matx41d(K.at<double>(0, 0), K.at<double>(1, 1), K.at<double>(0, 2), K.at<double>(1, 2)));
// //   vector<Mat> extrinsics;
// // for (size_t i = 0; i < rotations.size(); ++i)
// // {
// //     Mat extrinsic(6, 1, CV_64FC1);
// //     Mat r;
// //     Rodrigues(rotations[i], r);
// //
// //     r.copyTo(extrinsic.rowRange(0, 3));
// //     motions[i].copyTo(extrinsic.rowRange(3, 6));
// //
// //     extrinsics.push_back(extrinsic);
// // }

// // bundle_adjustment(intrinsic, extrinsics, correspond_struct_idx, key_points_for_all, structure);
// //
// // 	//????????????
// 	save_structure("structure222.yml", rotations, motions, structure, colors);
 	return 0;
}
