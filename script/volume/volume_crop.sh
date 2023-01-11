#! /bin/bash

# inputs:
img4d=$1 # 4D image
dirOut=$2 # output directory

# resample large images
#c3d /Users/jileihao/data/avrspt/bavcta008/image/img-slices/img3d_bavcta008_baseline_*.nii.gz \
# -foreach -resample 50% -endfor \
# -oo /Users/jileihao/data/avrspt/bavcta008/image/img-slices/ds/img3d_ds_bavcta008_baseline_%02d.nii.gz

echo "==================================="
echo "-- image 4D input: ${img4d}"
echo "-- output directory: ${dirOut}"
echo "==================================="


if ! test -d ${dirOut}; then
  echo "output directory ${dirOut} does not exist, creating one..."
  mkdir $dirOut
fi 

# Generate 3d image slices

if [[ "${dirOut}" == *\/ ]]; then
  dirOut="${dirOut::-1}"
fi

dirImgSlice="${dirOut}/img_slices"

echo "-- Image Slices output directory: ${dirImgSlice}"

if ! test -d ${dirImgSlice}; then
  echo ""
  echo "-- Generating 3D Slices..."
  mkdir $dirImgSlice 

  cmdSlice="c4d ${img4d} -slice w 0:-1 -oo ${dirImgSlice}/img_slice_%02d.nii.gz"
  echo "-- Slicing Command: ${cmdSlice}"
  ${cmdSlice}
  echo "-- Slicing Completed"
else
  echo "-- Slicing folder already exist. Proceeding to the next step."
fi

# Crop the 3d slices to reduce size

dirImgCrop="${dirImgSlice}/cropped"
if ! test -d ${dirImgCrop}; then
  echo ""
  echo "-- Cropping 3D Slices..."
  mkdir $dirImgCrop

  cmdCrop="c3d ${dirImgSlice}/*.nii.gz -foreach -trim-to-size 318x362x286vox -endfor -oo ${dirImgCrop}/img_slice_cropped_%02d.nii.gz"
  echo "-- Cropping Command: ${cmdCrop}"
  ${cmdCrop}
  echo "-- Cropping Completed"
else
  echo "-- Cropping folder already exist. Proceeding to the next step."
fi

# Resample the cropped slices

dirImgResample="${dirImgCrop}/resample"
if ! test -d ${dirImgResample}; then
  echo ""
  echo "-- Resampling 3D Slices..."
  mkdir $dirImgResample

  cmdResample="c3d ${dirImgCrop}/*nii.gz -foreach -resample 50% -endfor -oo ${dirImgResample}/img_slice_cropped_rs_%02d.nii.gz"
  echo "-- Resampling Command: ${cmdResample}"
  ${cmdResample}
  echo "-- Resampling Completed"
else
  echo "-- Resampling folder already exist. Proceeding to the next step."
fi

# Generate vti images
scriptVTI="/Users/jileihao/dev/avrspt-dev/AVRSPT-DataService/script/NiftiToVTI.py"
dirVTI="${dirImgResample}/vti"

if ! test -d ${dirVTI}; then
  echo ""
  echo "-- Converting 3D Slices to VTI format..."
  mkdir ${dirVTI}

  # iterate through files in folder and convert nii to vti
  for full in ${dirImgResample}/*.nii.gz
  do
    fn=${full##*/}
    fn=${fn%.*.*}
    echo "---- target filename ${fn}"
    /Users/jileihao/dev/avrspt-dev/AVRSPT-Converter/build/converters/ImageToVTI \
    ${full} ${dirVTI}/${fn}.vti
  done
  echo "-- Converting to VTI completed"
else
  echo "-- VTI folder already exist. Skipping the step."
fi

# 

# iterate through files in folder and convert nii to vti
# for full in /Users/jileihao/data/avrspt/bavcta008/image/img-slices/ds/*.nii.gz
# do
#     echo "processing ${full}"
#     fn=${full##*/}
#     fn=${fn%.*.*}
#     echo "filename ${fn}"
#     /Users/jileihao/dev/avrspt-dev/AVRSPT-Converter/build/converters/ImageToVTI \
#     ${full} /Users/jileihao/data/avrspt/bavcta008/image/img-slices/ds/vti/${fn}.vti
# done