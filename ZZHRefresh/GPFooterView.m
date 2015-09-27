//
//  GPFooterView.m
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 张智慧. All rights reserved.
//

#import "GPFooterView.h"

@interface GPFooterView()
@end

@implementation GPFooterView

+(id)footerView{
    return [[self alloc]init];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if(self.status == GPRefreshViewStatusLoading) return;
    [self willMoveToSuperview:self.scrollView];
    
    if (self.scrollView.isDragging) {
        CGFloat maxY=self.scrollView.contentSize.height-self.scrollView.frame.size.height;
        if (self.scrollView.contentOffset.y>=maxY&&self.scrollView.contentOffset.y<maxY+60) {
            self.status=GPRefreshViewStatusBeginDrap;
        }
        if (self.scrollView.contentOffset.y>=maxY+60) {
            self.status=GPRefreshViewStatusDraping;
        }
    }else{
        if (self.status==GPRefreshViewStatusDraping) {
            self.status=GPRefreshViewStatusLoading;
            self.refreshBlock();
            self.scrollView.contentInset=UIEdgeInsetsMake(0, 0, self.frame.size.height, 0);

        }
    }
}
-(void)willMoveToSuperview:(UIView *)newSuperview{
    UITableView *tableView=(UITableView *)newSuperview;
    CGFloat selfX=0;
    CGFloat selfY=tableView.contentSize.height;
    CGFloat selfW=tableView.frame.size.width;
    CGFloat selfH=60;
    
    self.frame=CGRectMake(selfX, selfY, selfW, selfH);
}
@end
