#! /bin/bash

cd /Users/jileihao/dev/avrspt-dev/AVRSPT-Converter/build/converters

dc=90
propagation_dir=/Users/jileihao/dev/propagation-dev/segmentation-propagation


config="/Users/jileihao/dev/propagation-dev/segmentation-propagation/config.json"
img="/Users/jileihao/data/avrspt/bavcta008/propagation/bavcta008/bavcta008_baseline.nii.gz"

vtklevelset -pl \
/Users/jileihao/data/avrspt/bavcta008/propagation/bavcta008/seg02_bavcta008.nii.gz \
/Users/jileihao/data/avrspt/bavcta008/propagation/bavcta008/mesh02_bavcta008.vtk 1

./ModelProcessor /Users/jileihao/data/avrspt/bavcta008/propagation/bavcta008/mesh02_bavcta008.vtk \
 /Users/jileihao/data/avrspt/bavcta008/propagation/bavcta008/mesh-decimated/mesh02_dc${dc}_bavcta008.vtk ${dc} nr

extra_mesh_cmd="-add_mesh extra_warp /Users/jileihao/data/avrspt/bavcta008/propagation/bavcta008/mesh-decimated/mesh02_dc${dc}_bavcta008.vtk"
seg="/Users/jileihao/data/avrspt/bavcta008/propagation/bavcta008/seg02_bavcta008.nii.gz"
tpr="2"
tpt="1;3;4;5;6;7;8;9;10;11;12;13;14"
tag="bavcta008-SYS"
dir_out="/Users/jileihao/data/avrspt/bavcta008/propagation/bavcta008/bavcta008-SYS"
log="/Users/jileihao/data/avrspt/bavcta008/propagation/bavcta008/mesh-decimated/propagation/log${tpr}.log"


# PYTHONPATH="$propagation_dir/src" \
# python3 "$propagation_dir/propagation.py" \
# $img \
# $seg \
# $tag \
# $tpr \
# $tpt \
# "$dir_out" \
# "$config" \
# $extra_mesh_cmd \
# -warp_only


vtklevelset -pl \
/Users/jileihao/data/avrspt/bavcta008/propagation/bavcta008/seg19_bavcta008.nii.gz \
/Users/jileihao/data/avrspt/bavcta008/propagation/bavcta008/mesh19_bavcta008.vtk 1

./ModelProcessor /Users/jileihao/data/avrspt/bavcta008/propagation/bavcta008/mesh19_bavcta008.vtk \
 /Users/jileihao/data/avrspt/bavcta008/propagation/bavcta008/mesh-decimated/mesh19_dc${dc}_bavcta008.vtk ${dc} nr


extra_mesh_cmd="-add_mesh extra_warp /Users/jileihao/data/avrspt/bavcta008/propagation/bavcta008/mesh-decimated/mesh19_dc${dc}_bavcta008.vtk"
seg="/Users/jileihao/data/avrspt/bavcta008/propagation/bavcta008/seg19_bavcta008.nii.gz"
tpr="19"
tpt="15;16;17;18;20"
tag="bavcta008-DIAS"
dir_out="/Users/jileihao/data/avrspt/bavcta008/propagation/bavcta008/bavcta008-DIAS"
log="/Users/jileihao/data/avrspt/bavcta008/propagation/bavcta008/mesh-decimated/propagation/log${tpr}.log"


PYTHONPATH="$propagation_dir/src" \
python3 "$propagation_dir/propagation.py" \
$img \
$seg \
$tag \
$tpr \
$tpt \
"$dir_out" \
"$config" \
$extra_mesh_cmd \
-warp_only