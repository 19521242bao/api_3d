data_dir="images"
nerf_dir="nerf"
#rm -rf $nerf_dir/*
output_dir="output"
method="nerfacto"
experiment_name="nerf"
export WANDB_API_KEY=f18335acc776513f31621e6ab678f44350c1faf7
config_path="$output_dir/$method/$experiment_name/2023/config.yml"
#ns-process-data images --data $data_dir  --output-dir $nerf_dir
echo $config_path
#ns-train nerfacto --data $nerf_dir --pipeline.model.predict-normals True --output-dir $output_dir --timestamp "2023" --vis wandb
ns-export pointcloud --load-config output/nerf/nerfacto/2023/config.yml --output-dir output --num-points 6000000 --remove-outliers True --use-bounding-box True --bounding-box-min -2 -2 -2 --bounding-box-max 2 2 2

CloudCompare -SILENT  -O /media/skyeye/AI_DEPT2/PhamBao/bts_api/output/point_cloud.ply -SOR 6 1  FILE test_SOR.las
CloudCompare -SILENT -O /media/skyeye/AI_DEPT2/PhamBao/bts_api/output/point_cloud.ply  -NOISE RADIUS 0.002 FILE test_NOISE.las