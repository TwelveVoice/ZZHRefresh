//
//  UITableView+GPRefresh.m

//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 张智慧 All rights reserved.
//

#import "UITableView+GPRefresh.h"

@interface UITableView()
@property(weak,nonatomic)GPHeaderView *header;
@property(weak,nonatomic)GPFooterView *footer;
@end

@implementation UITableView (GPRefresh)


-(void)setFooterRefreshWithBlock:(void (^)())block{
    GPFooterView *footerView=[GPFooterView footerView];
    [footerView setTitle:BeginDrapName forState:GPRefreshViewStatusBeginDrap];
    [footerView setTitle:DrapingName forState:GPRefreshViewStatusDraping];
    [footerView setTitle:LoadingName forState:GPRefreshViewStatusLoading];
    [self addSubview:footerView];
    footerView.refreshBlock=block;
    self.footer=footerView;
}

-(void)setHeaderRefreshWithBlock:(void (^)())block{
    GPHeaderView *headerView=[GPHeaderView headerView];
    [headerView setTitle:BeginDrapName forState:GPRefreshViewStatusBeginDrap];
    [headerView setTitle:DrapingName forState:GPRefreshViewStatusDraping];
    [headerView setTitle:LoadingName forState:GPRefreshViewStatusLoading];
    [self addSubview:headerView];
    self.header=headerView;
    headerView.refreshBlock=block;
}


- (void)headerEndRefreshing{
    [self.header stopAnimation];
}

- (void)footerEndRefreshing{
    [self.footer stopAnimation];
}

@end
