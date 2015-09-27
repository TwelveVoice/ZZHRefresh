//
//  UITableView+GPRefresh.h
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 张智慧. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPFooterView.h"
#import "GPHeaderView.h"


/**
 *  在此设置头部及尾部视图的显示文字
 */
#define BeginDrapName @"拖拽加载更多"
#define DrapingName @"松开加载更多"
#define LoadingName @"正在加载"


/**
 *  使用时在block中写入网络请求
 */

@interface UITableView (GPRefresh)
- (void)setHeaderRefreshWithBlock:(void (^)())block;
- (void)setFooterRefreshWithBlock:(void (^)())block;

/**
 *  网络请求结束后调用tableView中的下两个方法结束刷新
 */
- (void)headerEndRefreshing;
- (void)footerEndRefreshing;

@end
