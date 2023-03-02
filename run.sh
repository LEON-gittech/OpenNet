# General flow: tx_train.yaml -> tx_ft -> tx_val -> tx_test

# tx_train: trains the model.
# tx_ft: uses data-replay to address forgetting. (refer Sec 4.4 in paper)
# tx_val: learns the weibull distribution parameters from a kept aside validation set.
# tx_test: evaluate the final model
# x above can be {1, 2, 3, 4}

# NB: Please edit the paths accordingly.
# NB: Please change the batch-size and learning rate if you are not running on 8 GPUs.
# (if you find something wrong in this, please raise an issue on GitHub)

#SODA
# python tools/train_net.py --num-gpus 2 --dist-url='tcp://127.0.0.1:52125' --resume --config-file /home/leon/OWOD_new/configs/SODA/train_SODA.yaml SOLVER.IMS_PER_BATCH 6 SOLVER.BASE_LR 0.01 OUTPUT_DIR "./output/runs_SODA_1"  MODEL.WEIGHTS '/home/leon/OWOD_new/output/runs_SODA_1/model_0019999.pth'
# python tools/train_net.py --num-gpus 2 --eval-only --config-file ./configs/OWOD/val.yaml SOLVER.IMS_PER_BATCH 12 SOLVER.BASE_LR 0.005 OUTPUT_DIR "./output/eval" MODEL.WEIGHTS '/home/leon/OWOD/output/runs_35/model_0019999.pth'

#CODA
python tools/train_net.py --num-gpus 2 --dist-url='tcp://127.0.0.1:52125'  --config-file /home/leon/OWOD_new/configs/CODA/train.yaml SOLVER.IMS_PER_BATCH 6 SOLVER.BASE_LR 0.01 OUTPUT_DIR "/home/leon/OWOD_new/output/runs_CODA_80_from0/" 
# python tools/train_net.py --num-gpus 2 --eval-only  --config-file /home/leon/OWOD_new/configs/CODA/test.yaml SOLVER.IMS_PER_BATCH 6 SOLVER.BASE_LR 0.01 OUTPUT_DIR "./output/runs_CODA_val"  MODEL.WEIGHTS '/home/leon/OWOD_new/output/runs_CODA/model_final.pth'

# Task 1
# python tools/train_net.py --num-gpus 8 --dist-url='tcp://127.0.0.1:52125' --resume --config-file ./configs/OWOD/t1/t1_train.yaml SOLVER.IMS_PER_BATCH 8 SOLVER.BASE_LR 0.01 OUTPUT_DIR "./output/t1"

# # No need to finetune in Task 1, as there is no incremental component.

# python tools/train_net.py --num-gpus 8 --dist-url='tcp://127.0.0.1:52133' --config-file ./configs/OWOD/t1/t1_val.yaml SOLVER.IMS_PER_BATCH 8 SOLVER.BASE_LR 0.01 OWOD.TEMPERATURE 1.5 OUTPUT_DIR "./output/t1_final" MODEL.WEIGHTS "/home/joseph/workspace/OWOD/output/t1/model_final.pth"

# python tools/train_net.py --num-gpus 8 --eval-only --config-file ./configs/OWOD/t1/t1_test.yaml SOLVER.IMS_PER_BATCH 8 SOLVER.BASE_LR 0.005 OUTPUT_DIR "./output/t1_final" MODEL.WEIGHTS "/home/joseph/workspace/OWOD/output/t1/model_final.pth"


# # Task 2
# cp -r /home/joseph/workspace/OWOD/output/t1 /home/joseph/workspace/OWOD/output/t2

# python tools/train_net.py --num-gpus 8 --dist-url='tcp://127.0.0.1:52127' --resume --config-file ./configs/OWOD/t2/t2_train.yaml SOLVER.IMS_PER_BATCH 8 SOLVER.BASE_LR 0.01 OUTPUT_DIR "./output/t2" MODEL.WEIGHTS "/home/joseph/workspace/OWOD/output/t2/model_final.pth"

# cp -r /home/joseph/workspace/OWOD/output/t2 /home/joseph/workspace/OWOD/output/t2_ft

# python tools/train_net.py --num-gpus 8 --dist-url='tcp://127.0.0.1:52126' --resume --config-file ./configs/OWOD/t2/t2_ft.yaml SOLVER.IMS_PER_BATCH 8 SOLVER.BASE_LR 0.01 OUTPUT_DIR "./output/t2_ft" MODEL.WEIGHTS "/home/joseph/workspace/OWOD/output/t2_ft/model_final.pth"

# python tools/train_net.py --num-gpus 8 --dist-url='tcp://127.0.0.1:52133' --config-file ./configs/OWOD/t2/t2_val.yaml SOLVER.IMS_PER_BATCH 8 SOLVER.BASE_LR 0.01 OWOD.TEMPERATURE 1.5 OUTPUT_DIR "./output/t2_final" MODEL.WEIGHTS "/home/joseph/workspace/OWOD/output/t2_ft/model_final.pth"

# python tools/train_net.py --num-gpus 8 --eval-only --config-file ./configs/OWOD/t2/t2_test.yaml SOLVER.IMS_PER_BATCH 8 SOLVER.BASE_LR 0.005 OUTPUT_DIR "./output/t2_final" MODEL.WEIGHTS "/home/joseph/workspace/OWOD/output/t2_ft/model_final.pth"


# # Task 3
# cp -r /home/joseph/workspace/OWOD/output/t2_ft /home/joseph/workspace/OWOD/output/t3

# python tools/train_net.py --num-gpus 8 --dist-url='tcp://127.0.0.1:52127' --resume --config-file ./configs/OWOD/t3/t3_train.yaml SOLVER.IMS_PER_BATCH 8 SOLVER.BASE_LR 0.01 OUTPUT_DIR "./output/t3" MODEL.WEIGHTS "/home/joseph/workspace/OWOD/output/t3/model_final.pth"

# cp -r /home/joseph/workspace/OWOD/output/t3 /home/joseph/workspace/OWOD/output/t3_ft

# python tools/train_net.py --num-gpus 8 --dist-url='tcp://127.0.0.1:52126' --resume --config-file ./configs/OWOD/t3/t3_ft.yaml SOLVER.IMS_PER_BATCH 8 SOLVER.BASE_LR 0.01 OUTPUT_DIR "./output/t3_ft" MODEL.WEIGHTS "/home/joseph/workspace/OWOD/output/t3_ft/model_final.pth"

# python tools/train_net.py --num-gpus 8 --dist-url='tcp://127.0.0.1:52133' --config-file ./configs/OWOD/t3/t3_val.yaml SOLVER.IMS_PER_BATCH 8 SOLVER.BASE_LR 0.01 OWOD.TEMPERATURE 1.5 OUTPUT_DIR "./output/t3_final" MODEL.WEIGHTS "/home/joseph/workspace/OWOD/output/t3_ft/model_final.pth"

# python tools/train_net.py --num-gpus 8 --eval-only --config-file ./configs/OWOD/t3/t3_test.yaml SOLVER.IMS_PER_BATCH 8 SOLVER.BASE_LR 0.005 OUTPUT_DIR "./output/t3_final" MODEL.WEIGHTS "/home/joseph/workspace/OWOD/output/t3_ft/model_final.pth"


# # Task 4
# cp -r /home/joseph/workspace/OWOD/output/t3_ft /home/joseph/workspace/OWOD/output/t4

# python tools/train_net.py --num-gpus 8 --dist-url='tcp://127.0.0.1:52127' --resume --config-file ./configs/OWOD/t4/t4_train.yaml SOLVER.IMS_PER_BATCH 8 SOLVER.BASE_LR 0.01 OUTPUT_DIR "./output/t4" MODEL.WEIGHTS "/home/joseph/workspace/OWOD/output/t4/model_final.pth"

# cp -r /home/joseph/workspace/OWOD/output/t4 /home/joseph/workspace/OWOD/output/t4_ft

# python tools/train_net.py --num-gpus 8 --dist-url='tcp://127.0.0.1:52126' --resume --config-file ./configs/OWOD/t4/t4_ft.yaml SOLVER.IMS_PER_BATCH 8 SOLVER.BASE_LR 0.01 OUTPUT_DIR "./output/t4_ft" MODEL.WEIGHTS "/home/joseph/workspace/OWOD/output/t4_ft/model_final.pth"

# python tools/train_net.py --num-gpus 8 --eval-only --config-file ./configs/OWOD/t4/t4_test.yaml SOLVER.IMS_PER_BATCH 8 SOLVER.BASE_LR 0.005 OUTPUT_DIR "./output/t4_final" MODEL.WEIGHTS "/home/joseph/workspace/OWOD/output/t4_ft/model_final.pth"