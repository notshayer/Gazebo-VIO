#!/bin/bash
sudo pip install wstool
sudo apt-get update
cd ../..
catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release -DGTSAM_USE_SYSTEM_EIGEN=ON
catkin config --merge-devel
cd src
git clone https://github.com/MIT-SPARK/Kimera-VIO-ROS.git
wstool init
wstool merge Kimera-VIO-ROS/install/kimera_vio_ros_https.rosinstall
wstool update

mkdir eig_build
cd eig_build
git clone https://gitlab.com/libeigen/eigen.git ~
cmake ~/eigen 
sudo make install

cd ..
sudo rm -r dbow2_catkin
git clone https://github.com/uzh-rpg/dbow2_catkin.git
cd DBoW2
cmake . 
make
sudo make install 

catkin clean --y
roscd gtsam
git checkout develop
cd ..
catkin build opengv_catkin 
catkin build kimera_vio_ros -DCMAKE_BUILD_TYPE=Release -DGTSAM_USE_SYSTEM_EIGEN=ON
