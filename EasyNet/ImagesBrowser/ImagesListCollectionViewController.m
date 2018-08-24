//
//  ImagesListCollectionViewController.m
//  EasyNet
//
//  Created by 薛永伟 on 2018/8/23.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

#import "ImagesListCollectionViewController.h"
#import "ImageBrowserCollectionViewCell.h"
#import <YYKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface ImagesListCollectionViewController ()

@property (assign,nonatomic) NSInteger currentIndex;

@end

@implementation ImagesListCollectionViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat lineSpacing = 20;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*) self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(YYScreenSize().width, YYScreenSize().height);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, lineSpacing);
    layout.minimumLineSpacing = lineSpacing;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.defaultIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:false];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageUrls.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageBrowserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageBrowserCollectionViewCell" forIndexPath:indexPath];
    NSString *urlstr = self.imageUrls[indexPath.item];
    NSURL *url = [NSURL URLWithString:urlstr];
    [cell.zoomImgView.imageview sd_setImageWithURL:url];
//    [cell.zoomImgView.imageview setImageWithURL:url placeholder:[UIImage imageWithColor:[UIColor blackColor] size:CGSizeMake(300, 300)]];
    return cell;
}

#pragma mark <scrollViewDelegate>
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.collectionView) {
        [self updatePageNumber:scrollView.contentOffset];
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView == self.collectionView) {
        if (!decelerate) {
            [self updatePageNumber:scrollView.contentOffset];
        }
    }
}
-(void)updatePageNumber:(CGPoint) offset{
    NSIndexPath *current = [self.collectionView indexPathForItemAtPoint:offset];
    [self.delegate ImagesListCollectionViewControllerScrollTo:current.item];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
//    self.currentIndex = current.item;
    
//    self.currentIndex = round(scrollView.contentOffset.x / scrollView.width);
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
