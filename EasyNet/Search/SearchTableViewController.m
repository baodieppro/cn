//
//  SearchTableViewController.m
//  EasyNet
//
//  Created by 薛永伟 on 2018/8/21.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

#import "SearchTableViewController.h"
#import "SearchListModel.h"
#import "NSString+Url.h"
#import <YYKit.h>
#import "MBProgressHUD+Utility.h"

@interface SearchTableViewController ()

@end

@implementation SearchTableViewController
-(NSMutableArray *)dataSource{
    if (_dataSource==nil) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPasteboard *psd  = [UIPasteboard generalPasteboard];
    for (NSString *str in psd.strings) {
        if ([str isURL]) {
            SearchListModel *model = [[SearchListModel alloc]init];
            model.descTitle = @"你最近复制的网址，点击访问";
            model.urlStr = str;
            model.type = SearchListModelTypePastBoardUrl;
            [self.dataSource addObject:model];
        }else{
            SearchListModel *model = [[SearchListModel alloc]init];
            model.descTitle = @"你最近复制的文字，点击搜索";
            model.urlStr = str;
            model.type = SearchListModelTypePastBoardKeyword;
            [self.dataSource addObject:model];
        }
    }
    
    
    
    if (self.currentUrlStr.length > 0 && ![self.currentUrlStr hasPrefix:@"file://"]) {
        SearchListModel *model = [[SearchListModel alloc]init];
        model.descTitle = @"当前网页的网址，点击复制";
        model.urlStr = self.currentUrlStr;
        model.type = SearchListModelTypeCurrentUrl;
        [self.dataSource insertObject:model atIndex:0];
    }
    
     [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SearchListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchListTableViewCell" forIndexPath:indexPath];
    SearchListModel *model = self.dataSource[indexPath.row];
    cell.urlLabel.text = model.urlStr;
    cell.descLabel.text = model.descTitle;
    cell.delegate = self;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    SearchListModel *model = self.dataSource[indexPath.row];
    if (model.type == SearchListModelTypeCurrentUrl) {//点击复制
        UIPasteboard *psd = [UIPasteboard generalPasteboard];
        psd.string = model.urlStr;
        [MBProgressHUD showSuccessImage:@"已复制"];
    }else if (model.type == SearchListModelTypePastBoardUrl){//点击访问
        [self.delegate SearchTableViewControllerClickUrl:model.urlStr];
    }else if (model.type == SearchListModelTypePastBoardKeyword){//点击搜索
        NSString* urlstr = [NSString stringWithFormat:@"https://m.baidu.com/s?word=%@",[model.urlStr stringByURLEncode]];
        [self.delegate SearchTableViewControllerClickUrl:urlstr];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

@implementation SearchTableViewController (ListCell)

-(void)SearchListTableViewCellFillBtnClick:(UITableViewCell *)cell{
    NSIndexPath *idxPath = [self.tableView indexPathForCell:cell];
    SearchListModel *model = self.dataSource[idxPath.row];
    [self.delegate SearchTableViewControllerFillUrl:model.urlStr];
}

@end
