//
//  ImagesBrowserViewController.h
//  EasyNet
//
//  Created by 薛永伟 on 2018/8/23.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagesListCollectionViewController.h"

@interface ImagesBrowserViewController : UIViewController
@property (nonatomic,strong) NSArray *imageUrls;
@property (nonatomic,strong) NSString *currentImageUrl;
@end

@interface ImagesBrowserViewController(listCollectionVC)<ImagesListCollectionViewControllerProtocol>
@end
