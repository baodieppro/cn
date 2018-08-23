//
//  NSURLRequest+Easy.m
//  EasyNet
//
//  Created by 薛永伟 on 2018/8/23.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

#import "NSURLRequest+Easy.h"

@implementation NSURLRequest (Easy)
+(NSURLRequest *)homeUrlRequest{
    NSString *localHome = [[NSBundle mainBundle] pathForResource:@"easynet" ofType:@"html"];
    NSURL *url = [[NSURL alloc]initFileURLWithPath:localHome];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    return  request;
}
@end
