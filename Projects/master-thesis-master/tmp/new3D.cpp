#include <iostream>
#include <string>
#include <vector>
#include <utility>
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
// #include "opencv2/imgproc/imgproc.hpp"
// #include "opencv2/highgui/highgui.hpp"
// #include <opencv2/opencv.hpp>
// #include "opencv2/xfeatures2d.hpp"
// #include <opencv2/highgui.hpp>
// #include "opencv2/imgproc/imgproc.hpp"
// #include <stdio.h>
// #include <stdlib.h>
// //#include <tinydir.h>
//#include "bal_problem.h"
#include "gflags/gflags.h"
#include "glog/logging.h"
#include <ceres/ceres.h>
// #include <Eigen/Core>
// #include <iostream>
// #include <utility>
// #include <string>
// #include <vector>
#include <ceres/rotation.h>
#include <ceres/problem.h>
// #include <fstream>
// #include <algorithm>
// #include <cmath>
// #include <cstdio>
// #include <cstdlib>


using std::cin;
//using namespace cv;
using namespace std;
using namespace ceres;
using ceres::AutoDiffCostFunction;
using ceres::CostFunction;
using ceres::Problem;
using ceres::Solver;
using ceres::Solve;


float threshold = 70;

float computeResiduals(cv::Point2f pt1, cv::Point2f pt2){
  return pow((pow ((pt1.x-pt2.x),2) + pow ((pt1.y-pt2.y),2)),0.5f);
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
     // cout << index << " " << i << " " << imageId << " " << minRes << endl;
    } 
  }

 //cout<<matched[0].trainIdx<<endl;
}
void matchFeaturesForAll(vector<vector<cv::KeyPoint> >&key_points_for_all, vector<vector<cv::DMatch> >& matches_for_all)
{
  matches_for_all.clear();
  for (int i = 0; i < key_points_for_all.size() - 1; ++i)//??????????????????descriptor
  {
    cout << "Matching images " << i << " - " << i + 1 << endl;//???????????????
    vector<cv::DMatch> matches;
    int imageId = i+1;
    matchFeatures(imageId, key_points_for_all[i], key_points_for_all[i+1], matches);//????????????????????????????????????????????????matchFeaturesForAll???
    matches_for_all.push_back(matches);
  }

}

bool find_transform(cv::Mat& K, vector<cv::Point2f>& p1, vector<cv::Point2f>& p2, cv::Mat& R, cv::Mat& T, cv::Mat& mask)
{

  double focal_length = 0.5*(K.at<double>(0) + K.at<double>(4));
  cv::Point2d principle_point(K.at<double>(2), K.at<double>(5));
  cv::Mat E = cv::findEssentialMat(p1, p2, focal_length, principle_point, cv::RANSAC, 0.99, 1, mask);
  // cout<<p1<<endl;
  // cout<<p2<<endl;
  // cout<<E<<endl;
  if (E.empty()) return false;
  
  double feasible_count = countNonZero(mask);
  cout << (int)feasible_count << " -in- " << p1.size() << endl;

  if (feasible_count <= 4 || (feasible_count / p1.size()) < 0.6)
    return false;

  int pass_count = recoverPose(E, p1, p2, R, T, focal_length, principle_point, mask);
  // cout<<R<<endl;
  // cout<<T<<endl;
  if (((double)pass_count) / feasible_count < 0.7)
    return false;

  return true;
}
//get_matched_points(key_points_for_all[0], key_points_for_all[1], matches_for_all[0], p1, p2);
void get_matched_points(//??????matches,???????????????????????????????????????
  vector<cv::KeyPoint>& p1,
  vector<cv::KeyPoint>& p2,
  vector<cv::DMatch> matches,
  vector<cv::Point2f>& out_p1,
  vector<cv::Point2f>& out_p2
  )
{
  out_p1.clear();
  out_p2.clear();
  for (int i = 0; i < matches.size(); ++i)
  {
    out_p1.push_back(p1[matches[i].queryIdx].pt);
    out_p2.push_back(p2[matches[i].trainIdx].pt);
  }
}

void get_matched_colors(
  vector<cv::Vec3b>& c1,
  vector<cv::Vec3b>& c2,
  vector<cv::DMatch> matches,
  vector<cv::Vec3b>& out_c1,
  vector<cv::Vec3b>& out_c2
  )
{
  out_c1.clear();
  out_c2.clear();
  for (int i = 0; i < matches.size(); ++i)
  {
    out_c1.push_back(c1[matches[i].queryIdx]);
    out_c2.push_back(c2[matches[i].trainIdx]);
  }
}

void maskout_points(vector<cv::Point2f>& p1, cv::Mat& mask)
{
  vector<cv::Point2f> p1_copy = p1;
  p1.clear();

  for (int i = 0; i < mask.rows; ++i)
  {
    if (mask.at<uchar>(i) > 0)
      p1.push_back(p1_copy[i]);
  }
}

void maskout_colors(vector<cv::Vec3b>& p1, cv::Mat& mask)
{
  vector<cv::Vec3b> p1_copy = p1;
  p1.clear();

  for (int i = 0; i < mask.rows; ++i)
  {
    if (mask.at<uchar>(i) > 0)
      p1.push_back(p1_copy[i]);
  }
}
void get_objpoints_and_imgpoints(
  vector<cv::DMatch>& matches,//???????????????????????????????????????matches????????????????????????matchFeaturesForAll
  vector<int>& correspond_struct_idx,
  vector<cv::Point3d>& structure,
  vector<cv::KeyPoint>& key_points,//???????????????key points
  vector<cv::Point3f>& object_points,
  vector<cv::Point2f>& image_points)
{
  object_points.clear();
  image_points.clear();

  for (int i = 0; i < matches.size(); ++i)
  {
    int query_idx = matches[i].queryIdx;//??????????????????????????????feature point
    int train_idx = matches[i].trainIdx;
    //cout<<correspond_struct_idx[1]<<endl;
    int struct_idx = correspond_struct_idx[query_idx];//?????????????????????????????????????????????match??????????????????match???????????????U
    //cout<<structure[1]<<endl;
    //cout << query_idx << " " << train_idx << " " << struct_idx << endl;

    if (struct_idx < 0) continue;

    object_points.push_back(structure[struct_idx]);//???????????????????????????match???3D??????
    image_points.push_back(key_points[train_idx].pt);//???????????????match??????????????????match?????????
  }
}
void reconstruct(cv::Mat& K, cv::Mat& R1, cv::Mat& T1, cv::Mat& R2, cv::Mat& T2, vector<cv::Point2f>& p1, vector<cv::Point2f>& p2, vector<cv::Point3d>& structure)//??????????????????????????????
{
  //??????????????????????????????????????????????[R T]??????triangulatePoints??????????float??????
  cv::Mat proj1(3, 4, CV_32FC1);
  cv::Mat proj2(3, 4, CV_32FC1);

  R1.convertTo(proj1(cv::Range(0, 3), cv::Range(0, 3)), CV_32FC1);//???R1???????????????proj1?????????????????????
  T1.convertTo(proj1.col(3), CV_32FC1);//???T????????????????????????
  // cout<<R2;

  R2.convertTo(proj2(cv::Range(0, 3),cv::Range(0, 3)), CV_32FC1);//???R2???????????????proj2?????????????????????
  T2.convertTo(proj2.col(3), CV_32FC1);

  cv::Mat fK;
  K.convertTo(fK, CV_32FC1);
  proj1 = fK*proj1;
  proj2 = fK*proj2;

  cv::Mat s;
  triangulatePoints(proj1, proj2, p1, p2, s);//??????????????????s

  structure.clear();
  structure.reserve(s.cols);//Requests that the vector capacity be at least enough to contain s.cols elements.
  for (int i = 0; i < s.cols; ++i)
   {
     cv::Mat_<float> col = s.col(i);
     col /= col(3);  ///?????????????????????????????????????????????????????????????????????
     structure.push_back(cv::Point3f(col(0), col(1), col(2)));//???????????????????????????
   }
}
void fusion_structure(
  vector<cv::DMatch>& matches,
  vector<int>& struct_indices,
  vector<int>& next_struct_indices,
  vector<cv::Point3d>& structure,
  vector<cv::Point3d>& next_structure,
  vector<cv::Vec3b>& colors,
  vector<cv::Vec3b>& next_colors
  )
{
  for (int i = 0; i < matches.size(); ++i)
  {
    int query_idx = matches[i].queryIdx;
    int train_idx = matches[i].trainIdx;

    int struct_idx = struct_indices[query_idx];//????????????????????????????????????????????????????????????3D????????????????????????????????????????????????3D???
    if (struct_idx >= 0)
    {
      next_struct_indices[train_idx] = struct_idx;
      continue;
    }
    structure.push_back(next_structure[i]);
    colors.push_back(next_colors[i]);
    struct_indices[query_idx] = next_struct_indices[train_idx] = structure.size() - 1;
  }
}
void init_structure(//?????????
  cv::Mat K,
  vector<vector<cv::KeyPoint> >& key_points_for_all,
  vector<vector<cv::Vec3b> >& colors_for_all,
  vector<vector<cv::DMatch> >& matches_for_all,
  vector<cv::Point3d>& structure,
  vector<vector<int> >& correspond_struct_idx,
  vector<cv::Vec3b>& colors,
  vector<cv::Mat>& rotations,
  vector<cv::Mat>& motions
  )
{
  vector<cv::Point2f> p1, p2;
  vector<cv::Vec3b> c2;
  cv::Mat R, T; 
  cv::Mat mask; 
  get_matched_points(key_points_for_all[0], key_points_for_all[1], matches_for_all[0], p1, p2);
  get_matched_colors(colors_for_all[0], colors_for_all[1], matches_for_all[0], colors, c2);
  find_transform(K, p1, p2, R, T, mask);//?????????????????????P

  maskout_points(p1, mask);
  maskout_points(p2, mask);
  maskout_colors(colors, mask);

  cv::Mat R0 = cv::Mat::eye(3, 3, CV_64FC1);//???????????????P
  cv::Mat T0 = cv::Mat::zeros(3, 1, CV_64FC1);
  reconstruct(K, R0, T0, R, T, p1, p2, structure);
  //cout<<structure[1]<<endl;
  rotations.push_back(R0);
  rotations.push_back(R);
  motions.push_back(T0);
  motions.push_back(T);

  //???correspond_struct_idx??????key_points_for_all?????????
  correspond_struct_idx.clear();
  correspond_struct_idx.resize(key_points_for_all.size());
  for (int i = 0; i < key_points_for_all.size(); ++i)
  {
    correspond_struct_idx[i].resize(key_points_for_all[i].size(), -1);//???key points???size??????????????????????????????-1???
  }

  int idx = 0;
  vector<cv::DMatch>& matches = matches_for_all[0];//???matches_for_all?????????????????????matches
  for (int i = 0; i < matches.size(); ++i)
  {
    if (mask.at<uchar>(i) == 0)//???????????????match???outlier
      continue;//??????mask????????????0??????????????????????????????????????????????????????

    correspond_struct_idx[0][matches[i].queryIdx] = idx;//??????idx???match,???idx?????????correspond_struct_idx?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????feature point
    correspond_struct_idx[1][matches[i].trainIdx] = idx;
    ++idx;
  }
}
void save_structure(string file_name, vector<cv::Mat>& rotations, vector<cv::Mat>& motions, vector<cv::Point3d>& structure, vector<cv::Vec3b>& colors)
{
  int n = (int)rotations.size();

  cv::FileStorage fs(file_name, cv::FileStorage::WRITE);
  fs << "Camera Count" << n;
  fs << "Point Count" << (int)structure.size();

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
  for (size_t i = 0; i < structure.size(); ++i)
  {
    fs << structure[i];
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

/////////////////////////////////////////////////////////////////////////
//////////////// Bundle Adjustment-Google ceres//////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////

//??????????????????
struct ReprojectCost
{
    cv::Point2d observation;

    ReprojectCost(cv::Point2d& observation)
        : observation(observation)
    {
    }
   //???????????????????????????????????????????????????????????????????????????
  //AutoDiffCostFunction<ReprojectCost, 2, 4, 6, 3>
    template <typename T>
    bool operator()(const T* const intrinsic, const T* const extrinsic, const T* const pos3d, T* residuals) const//pos3d:?????????3D??????observation:???????????????????????????
   //?????????3D????????????2D????????????????????????????????????R???T????????????
    {
        const T* r = extrinsic;//?????? R
        const T* t = &extrinsic[3];//T

        T pos_proj[3];//?????????????????????4???pos_proj

       AngleAxisRotatePoint(r, pos3d, pos_proj);//y=r(angle_axis)pos3d,??????R??????????????????

        // Apply the camera translation
        pos_proj[0] += t[0];//????????????
        pos_proj[1] += t[1];
        pos_proj[2] += t[2];

        const T x = pos_proj[0] / pos_proj[2];//???x???y
        const T y = pos_proj[1] / pos_proj[2];

        const T fx = intrinsic[0];//??????????????????
        const T fy = intrinsic[1];
        const T cx = intrinsic[2];
        const T cy = intrinsic[3];

        // Apply intrinsic
        const T u = fx * x + cx;//????????????
        const T v = fy * y + cy;

        residuals[0] = u - T(observation.x);//??????????????????
        residuals[1] = v - T(observation.y);

        return true;
    }
};
//??????
 //Solver??????BA??????????????????Ceres?????????Huber????????????????????????
void bundle_adjustment(
    cv::Mat& intrinsic,
    vector<cv::Mat>& extrinsics,
    vector<vector<int> >& correspond_struct_idx,
    vector<vector<cv::KeyPoint> >& key_points_for_all,
    vector<cv::Point3d>& structure
)
{
    Problem problem;

    // load extrinsics (rotations and motions)
    for (size_t i = 0; i < extrinsics.size(); ++i)
    {
        problem.AddParameterBlock(extrinsics[i].ptr<double>(), 6);//Add a parameter block with appropriate size and parameterization to the problem.
       //Repeated calls with the same arguments are ignored. Repeated calls with the same double pointer but a different size results in undefined behavior.
    }
    // fix the first camera.
    problem.SetParameterBlockConstant(extrinsics[0].ptr<double>());//Hold the indicated parameter block constant during optimization.?????????????????????????????????

    // load intrinsic
    problem.AddParameterBlock(intrinsic.ptr<double>(), 4); // fx, fy, cx, cy

    // load points
    LossFunction* loss_function = new HuberLoss(4);   // loss function make bundle adjustment robuster.
    for (size_t img_idx = 0; img_idx < correspond_struct_idx.size(); ++img_idx)
    {
        vector<int>& point3d_ids = correspond_struct_idx[img_idx];
        vector<cv::KeyPoint>& key_points = key_points_for_all[img_idx];
        for (size_t point_idx = 0; point_idx < point3d_ids.size(); ++point_idx)
        {
            int point3d_id = point3d_ids[point_idx];
            if (point3d_id < 0)
                continue;

            cv::Point2d observed = key_points[point_idx].pt;//corresponding 2D points coordinates with feasible 3D point
            // ???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
            CostFunction* cost_function = new AutoDiffCostFunction<ReprojectCost, 2, 4, 6, 3>(new ReprojectCost(observed));
            //???????????????????????????
            problem.AddResidualBlock(//adds a residual block to the problem,implicitly adds the parameter blocks(This causes additional correctness checking) if they are not present
                cost_function,
                loss_function,
                intrinsic.ptr<double>(),            // Intrinsic
                extrinsics[img_idx].ptr<double>(),  // View Rotation and Translation
                &(structure[point3d_id].x)          // Point in 3D space
            );
        }
    }

    // Solve BA
    Solver::Options ceres_config_options;
    ceres_config_options.minimizer_progress_to_stdout = false;
    ceres_config_options.logging_type = SILENT;
    ceres_config_options.num_threads = 1;//Number of threads to be used for evaluating the Jacobian and estimation of covariance.
    ceres_config_options.preconditioner_type = JACOBI;
   ceres_config_options.linear_solver_type = DENSE_SCHUR;
    // ceres_config_options.linear_solver_type = ceres::SPARSE_SCHUR;//ype of linear solver used to compute the solution to the linear least squares problem in each iteration of the Levenberg-Marquardt algorithm
    // ceres_config_options.sparse_linear_algebra_library_type = ceres::EIGEN_SPARSE;

    Solver::Summary summary;
    Solve(ceres_config_options, &problem, &summary);

    if (!summary.IsSolutionUsable())
    {
        std::cout << "Bundle Adjustment failed." << std::endl;
    }
    else
    {
        // Display statistics about the minimization
        std::cout << std::endl
            << "Bundle Adjustment statistics (approximated RMSE):\n"
            << " #views: " << extrinsics.size() << "\n"
            << " #residuals: " << summary.num_residuals << "\n"
            << " Initial RMSE: " << std::sqrt(summary.initial_cost / summary.num_residuals) << "\n"
            << " Final RMSE: " << std::sqrt(summary.final_cost / summary.num_residuals) << "\n"
            << " Time (s): " << summary.total_time_in_seconds << "\n"
            << std::endl;
    }
}
int main( int argc, char** argv )
{
  cv::Mat K(cv::Matx33d(
    350.6847, 0, 332.4661,
    0, 350.0606, 163.7461,
    0, 0, 1));
  cv::Mat yellow = (cv::Mat_<double>(1, 3) << 0,255,255);
  cv::Mat blue = (cv::Mat_<double>(1, 3) << 255,0,0);
  cv::Mat orange = (cv::Mat_<double>(1, 3) << 0,165,255);

  vector<vector<cv::KeyPoint> > key_points_for_all;
  vector<vector<cv::Vec3b> > colors_for_all;
  vector<vector<cv::DMatch> > matches_for_all;

  for(int i = 0; i < 3; i++)
  {
    vector<cv::KeyPoint> feature;
    vector<cv::Vec3b> colors;
    ifstream file ( "result/"+to_string(i)+".csv" );
    string line, x, y, label;  
    while (getline(file, line)) 
    {  
        stringstream liness(line);  
        getline(liness, x, ',');  
        getline(liness, y, ','); 
        getline(liness, label);
        feature.push_back(cv::KeyPoint(stof(x),stof(y),3,-1,0,0,stof(label)));
        if(stof(label) == 1)
          colors.push_back(yellow);
        if(stof(label) == 2)
          colors.push_back(blue);
        if(stof(label) == 3)
          colors.push_back(orange);
    }
    key_points_for_all.push_back(feature);
    colors_for_all.push_back(colors);
    if (i > 0){
      vector<cv::DMatch> matched;
      matchFeatures(i, key_points_for_all[i-1], key_points_for_all[i], matched);
      matches_for_all.push_back(matched);
    }
  }      
  
  // matchFeaturesForAll(key_points_for_all, matches_for_all);
  //cout<<matches_for_all[0][0].queryIdx;
  // vector<cv::Point2f> p1;
  // vector<cv::Point2f> p2;
  vector<cv::Point3d> structure;
  vector<vector<int> > correspond_struct_idx;
  vector<cv::Vec3b> colors;
  vector<cv::Mat> rotations;
  vector<cv::Mat> motions;
 
  init_structure(//??????????????????????????????????????????????????????rotations???motions?????????????????????R???T
    K,
    key_points_for_all,
    colors_for_all,
    matches_for_all,
    structure,
    correspond_struct_idx,
    colors,
    rotations,
    motions
  );

  for (int i = 1; i < matches_for_all.size(); ++i)//??????????????????????????????????????????????????????????????????match
  {
    vector<cv::Point3f> object_points;//3D points
    vector<cv::Point2f> image_points;
    cv::Mat r, R, T;
    //Mat mask;

    //???????????????????????????????????????match???3D????????????????????????2D??????
    get_objpoints_and_imgpoints(
      matches_for_all[i],
      correspond_struct_idx[i],
      structure,
      key_points_for_all[i+1],
      object_points,
      image_points
      );
    // cout << matches_for_all[i].size() << endl;
    // cout << image_points.size() << endl;
    // bool solvePnPRansac(InputArray objectPoints, InputArray imagePoints, InputArray cameraMatrix, InputArray distCoeffs, OutputArray rvec, OutputArray tvec,
    // bool useExtrinsicGuess=false, int iterationsCount=100, float reprojectionError=8.0, double confidence=0.99, OutputArray inliers=noArray(), int flags=SOLVEPNP_ITERATIVE )
    // rvec ??? Output rotation vector (see Rodrigues() ) that, together with tvec , brings points from the model coordinate system to the camera coordinate system.
    // tvec ??? Output translation vector.
    solvePnPRansac(object_points, image_points, K, cv::noArray(), r, T);
    Rodrigues(r, R);//Converts a rotation matrix to a rotation vector or vice versa.
    // //????????????????????????R???T
    rotations.push_back(R);
    motions.push_back(T);

    vector<cv::Point2f> p1, p2;
    vector<cv::Vec3b> c1, c2;
    get_matched_points(key_points_for_all[i], key_points_for_all[i + 1], matches_for_all[i], p1, p2);//??????p1,p2?????????????????????????????????????????????
    get_matched_colors(colors_for_all[i], colors_for_all[i + 1], matches_for_all[i], c1, c2);

    //???3D???
    vector<cv::Point3d> next_structure;
    reconstruct(K, rotations[i], motions[i], R, T, p1, p2, next_structure);//???????????????
    fusion_structure(
      matches_for_all[i],
      correspond_struct_idx[i],
      correspond_struct_idx[i + 1],
      structure,
      next_structure,
      colors,
      c1
      );
  }
    //??????BA
  google::InitGoogleLogging(argv[0]);
  cv::Mat intrinsic(cv::Matx41d(K.at<double>(0, 0), K.at<double>(1, 1), K.at<double>(0, 2), K.at<double>(1, 2)));
  vector<cv::Mat> extrinsics;
  for (size_t i = 0; i < rotations.size(); ++i)
  {
      cv::Mat extrinsic(6, 1, CV_64FC1);
      cv::Mat r;
      Rodrigues(rotations[i], r);

      r.copyTo(extrinsic.rowRange(0, 3));
      motions[i].copyTo(extrinsic.rowRange(3, 6));

      extrinsics.push_back(extrinsic);
  }

  bundle_adjustment(intrinsic, extrinsics, correspond_struct_idx, key_points_for_all, structure);
  for(u=0; u<structure.size; u++){
    cout<<structure[u]<<endl;
  };
  save_structure("structure444.yml", rotations, motions, structure, colors);
  cout<<"done"<<endl;

}
