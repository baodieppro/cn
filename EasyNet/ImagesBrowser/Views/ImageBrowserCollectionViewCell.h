//
//  ImageBrowserCollectionViewCell.h
//  EasyNet
//
//  Created by 薛永伟 on 2018/8/23.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYWZoomImageView.h"

@interface ImageBrowserCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet XYWZoomImageView *zoomImgView;

@end
