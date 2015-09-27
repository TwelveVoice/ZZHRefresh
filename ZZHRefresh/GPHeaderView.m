//
//  GPHeaderView.m
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 张智慧. All rights reserved.
//

#import "GPHeaderView.h"

@implementation GPHeaderView

+(id)headerView{
    return [[self alloc]init];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if(self.status == GPRefreshViewStatusLoading) return;
    [self willMoveToSuperview:self.scrollView];
    
    if (self.scrollView.isDragging) {
        if (self.scrollView.contentOffset.y>=-60&&self.scrollView.contentOffset.y<0) {
            self.status=GPRefreshViewStatusBeginDrap;
        }
        if (self.scrollView.contentOffset.y<=-60) {
            self.status=GPRefreshViewStatusDraping;
        }
    }else{
        if (self.status==GPRefreshViewStatusDraping) {
            self.status=GPRefreshViewStatusLoading;
            self.refreshBlock();
            self.scrollView.contentInset=UIEdgeInsetsMake(self.frame.size.height, 0, 0, 0);
            
        }
    }
}


-(void)willMoveToSuperview:(UIView *)newSuperview{
    UITableView *tableView=(UITableView *)newSuperview;
    CGFloat selfX=0;
    CGFloat selfY=0;
    CGFloat selfW=tableView.frame.size.width;
    CGFloat selfH=-60;
    self.frame=CGRectMake(selfX, selfY, selfW, selfH);
}
@end
