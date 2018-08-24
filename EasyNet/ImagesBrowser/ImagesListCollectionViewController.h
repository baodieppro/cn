//
//  ImagesListCollectionViewController.h
//  EasyNet
//
//  Created by 薛永伟 on 2018/8/23.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImagesListCollectionViewControllerProtocol
-(void)ImagesListCollectionViewControllerScrollTo:(NSInteger)index;
@end

@interface ImagesListCollectionViewController : UICollectionViewController
@property (nonatomic,weak) id<ImagesListCollectionViewControllerProtocol> delegate;
@property (nonatomic,strong) NSArray *imageUrls;
//默认索引
@property (nonatomic,assign) NSInteger defaultIndex;
@end
