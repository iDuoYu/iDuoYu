//
//  OrderSuccessViewController.m
//  iDuoYu
//
//  Created by ky01 on 15/4/22.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import "OrderSuccessViewController.h"
#import "OrderService.h"
#import "Context.h"
#import "EngineerCell.h"
#import "Constants.h"
#import "Engineer.h"
#import <AFNetworking/UIKit+AFNetworking.h>
#import "WebRelatedViewController.h"

@interface OrderSuccessViewController ()
@property (strong, nonatomic) NSMutableArray *engineerLists;
@end

@implementation OrderSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.subTitle.text = [NSString stringWithFormat:@"您的订单号为：%@",[[Context sharedContext] OrderSN]];
    self.tableView.backgroundColor = UIColorMake255(239, 239, 239, 1.0);
    [self.tableView registerNib:[UINib nibWithNibName:@"EngineerCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"engineerCell"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.engineerLists removeAllObjects];
    
    [OrderService getCurrentCityEngineerList:^(Engineers *engineers) {
        [self.engineerLists addObjectsFromArray:engineers.Engineers];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"error = %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)engineerLists {
    if (_engineerLists == nil) {
        _engineerLists = [NSMutableArray array];
    }
    
    return _engineerLists;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return 2;
    }else{
        return self.engineerLists.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *cellIdentifier = @"topCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        if (indexPath.row == 0) {
            cell.textLabel.text = NSLocalizedString(@"您可以在下方看到可以为您提供服务的工程师，他们中的一位会联系您 以确认见面的时间地点", nil);
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = [UIColor lightGrayColor];
        }else{
            cell.textLabel.text = NSLocalizedString(@"服务支持", nil);
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }else if (indexPath.section == 1){
        Engineer *engineer = [self.engineerLists objectAtIndex:indexPath.row];
        
        static NSString *reuseIdentifier = @"engineerCell";
        EngineerCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier
                                                             forIndexPath:indexPath];
        [cell.avatarImageView setImageWithURL:[NSURL URLWithString:engineer.EngineerUrl]
                             placeholderImage:nil];
        cell.nameLabel.text = engineer.EngineerName;
        cell.achievementLabel.text = engineer.RepairAmount;
        cell.descLabel.text = engineer.EngineerDescription;
        return cell;
    }else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [tableView deselectRowAtIndexPath:indexPath
                                     animated:YES];
        }else{
            //跳转到技术支持的静态页
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"WebRelated"
                                                                 bundle:nil];
            WebRelatedViewController *webRelatedViewController = [storyboard instantiateViewControllerWithIdentifier:WebRelatedViewController.storyboardID];
            webRelatedViewController.title = NSLocalizedString(@"服务支持", @"服务支持");
            [webRelatedViewController setWebPageFileName:@"support" ofType:@"html"];
            [self.navigationController pushViewController:webRelatedViewController
                                                 animated:YES];
            
        }
    }else if (indexPath.section == 1){
        [tableView deselectRowAtIndexPath:indexPath
                                 animated:YES];
    }else {
        [tableView deselectRowAtIndexPath:indexPath
                                 animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 60;
        }else{
            return 40;
        }
    }else if (indexPath.section == 1){
        return 100;
    }else {
        return 100;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 20;
    }else if (section == 1){
        return 1;
    }else {
        return 1;
    }
}


@end
