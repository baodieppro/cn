//
//  ImagesBrowserViewController.m
//  EasyNet
//
//  Created by 薛永伟 on 2018/8/23.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

#import "ImagesBrowserViewController.h"
#import "UIAlertController+Blocks.h"


@interface ImagesBrowserViewController ()
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation ImagesBrowserViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true animated:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onBackClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:false completion:nil];
}

- (IBAction)onMenuClick:(UIButton *)sender {
    [UIAlertController showActionSheetInViewController:self withTitle:@"将图片" message:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"保存到手机",@"转存到加密相册"] popoverPresentationControllerBlock:^(UIPopoverPresentationController * _Nonnull popover) {
        
    } tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
        NSLog(@"click %ld",(long)buttonIndex);
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ImagesListCollectionViewController"]){
        ImagesListCollectionViewController *list = (ImagesListCollectionViewController*)segue.destinationViewController;
        NSInteger index = [self.imageUrls indexOfObject:self.currentImageUrl];
        if(index != NSNotFound){
            list.defaultIndex = index;
            [self ImagesListCollectionViewControllerScrollTo:index];
        }
        list.imageUrls = self.imageUrls;
        list.delegate = self;
    }
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

@end


@implementation ImagesBrowserViewController(listCollectionVC)

- (void)ImagesListCollectionViewControllerScrollTo:(NSInteger)index {
    self.countLabel.text = [NSString stringWithFormat:@"%ld/%ld",index+1,self.imageUrls.count];
}

@end
