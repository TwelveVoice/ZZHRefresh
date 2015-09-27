//
//  GPRefreshBaseView.h

//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 张智慧. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPRefreshBaseView;

typedef enum GPRefreshViewStatus {
    GPRefreshViewStatusBeginDrap,
    GPRefreshViewStatusDraping,
    GPRefreshViewStatusLoading,
} GPRefreshViewStatus;


@interface GPRefreshBaseView : UIView
@property(nonatomic,assign)UIScrollView *scrollView;


@property(nonatomic ,copy)void(^refreshBlock)();

@property(nonatomic,assign)GPRefreshViewStatus status;


+(id)refreshBaseView;

-(void)stopAnimation;

-(void)setTitle:(NSString *)title forState:(GPRefreshViewStatus)stat;

@end
