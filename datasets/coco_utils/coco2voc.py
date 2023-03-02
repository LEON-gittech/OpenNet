import xml.etree.cElementTree as ET
import os

from pycocotools.coco import COCO
COMMON_CATEGORIES=['pedestrian', 'cyclist', 'car', 'truck', 'tram', 'tricycle']
NOVEL_CATEGORIES=[]
def imagesets(coco_annotation_file, target_folder):
    # os.makedirs(os.path.join(target_folder, 'Main'), exist_ok=True)
    # import pdb;pdb.set_trace()
    coco_instance = COCO(coco_annotation_file)
    # with open(target_folder+"/ImageSets/train.txt", "a") as trainfile:
    with open(target_folder+"/ImageSets/val.txt", "a") as valfile:
        for index, image_id in enumerate(coco_instance.imgToAnns):
            #太多啦！！！！！！！！
            # if index>100:break
            image_details = coco_instance.imgs[image_id]
            # if 'kitti' in image_details['file_name'] or 'nuscenes' in image_details['file_name']: continue
            
            # trainfile.write(image_details['file_name'].split('.')[0])
            # trainfile.write('\n')
            valfile.write(image_details['file_name'].split('.')[0])
            valfile.write('\n')
            # if index%10<=8:
            #     trainfile.write(image_details['file_name'].split('.')[0])
            #     trainfile.write('\n')
            # else:
            #     valfile.write(image_details['file_name'].split('.')[0])
            #     valfile.write('\n')
        
                    
#train和val的nameid不一样！！！！我曹
def coco_to_voc_detection(coco_annotation_file, target_folder):
    os.makedirs(os.path.join(target_folder, 'Annotations'), exist_ok=True)
    coco_instance = COCO(coco_annotation_file)
    for index, image_id in enumerate(coco_instance.imgToAnns):
        # import pdb;pdb.set_trace()
        #实在是太多啦！！！！！！！！！！1
        # if index >100:break
        image_details = coco_instance.imgs[image_id]
        annotation_el = ET.Element('annotation')
        #暂且跳过这俩，这俩只有annotation没有file
        if 'kitti' in image_details['file_name'] or 'nuscenes' in image_details['file_name']: continue
        
        ET.SubElement(annotation_el, 'filename').text = image_details['file_name']
        size_el = ET.SubElement(annotation_el, 'size')
        ET.SubElement(size_el, 'width').text = str(image_details['width'])
        ET.SubElement(size_el, 'height').text = str(image_details['height'])
        ET.SubElement(size_el, 'depth').text = str(3)

        for annotation in coco_instance.imgToAnns[image_id]:
            object_el = ET.SubElement(annotation_el, 'object')
            # import pdb;pdb.set_trace()
            ET.SubElement(object_el,'name').text = coco_instance.cats[annotation['category_id']]['name']
            # ET.SubElement(object_el, 'name').text = 'unknown'
            ET.SubElement(object_el, 'difficult').text = '0'
            bb_el = ET.SubElement(object_el, 'bndbox')
            ET.SubElement(bb_el, 'xmin').text = str(int(annotation['bbox'][0] + 1.0))
            ET.SubElement(bb_el, 'ymin').text = str(int(annotation['bbox'][1] + 1.0))
            ET.SubElement(bb_el, 'xmax').text = str(int(annotation['bbox'][0] + annotation['bbox'][2] + 1.0))
            ET.SubElement(bb_el, 'ymax').text = str(int(annotation['bbox'][1] + annotation['bbox'][3] + 1.0))

        ET.ElementTree(annotation_el).write(os.path.join(target_folder, 'Annotations', image_details['file_name'].split('.')[0] + '.xml'))
        if index % 10000 == 0:
            print('Processed ' + str(index) + ' images.')


if __name__ == '__main__':
    coco_annotation_file = '/home/leon/OWOD_new/Data/SSLAD-2D/SODA/annotations/val.json'
    target_folder = '/home/leon/OWOD_new/Data/SSLAD-2D/SODA/'
    coco_to_voc_detection(coco_annotation_file, target_folder)
    # imagesets(coco_annotation_file, target_folder)