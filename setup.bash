#!/bin/bash
export REF=$(pwd)
echo "$REF"
sudo pip install wstool
sudo apt-get update
cd ..
export REF2=$(pwd)
catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release -DGTSAM_USE_SYSTEM_EIGEN=ON
catkin config --merge-devel
git clone https://github.com/MIT-SPARK/Kimera-VIO-ROS.git
wstool init
wstool merge Kimera-VIO-ROS/install/kimera_vio_ros_https.rosinstall
wstool update

mkdir eig_build
cd ~
git clone https://gitlab.com/libeigen/eigen.git
cd $REF2/eig_build
cmake ~/eigen
sudo make install
cd "$REF"
cd ..

sudo rm -r dbow2_catkin
git clone https://github.com/shinsumicco/DBoW2.git
cd DBoW2
cmake . 
make
sudo make install 
cd ..

cd gtsam
git checkout develop
cd ..
catkin config --link-devel
catkin build opengv_catkin 
catkin build -DCMAKE_BUILD_TYPE=Release -DGTSAM_USE_SYSTEM_EIGEN=ON kimera_vio_ros

cp $REF/launch/* $REF2/Kimera-VIO-ROS/launch
cp -r $REF/params/Pensa $REF2/Kimera-VIO/params
