//
//  XYWZoomImageView.h
//  HapyRead
//
//  Created by xueyognwei on 2017/10/30.
//  Copyright © 2017年 xueyognwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYWZoomImageView : UIView
@property (nonatomic,strong) UIScrollView *scrollview;
@property (nonatomic,strong) UIImageView *imageview;
@property (nonatomic,strong) UIImage *image;
//单击回调
@property (nonatomic, strong) void (^singleTapBlock)(UITapGestureRecognizer *recognizer);

@end
