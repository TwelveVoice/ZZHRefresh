//
//  GPRefreshBaseView.m
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 张智慧 All rights reserved.
//

#import "GPRefreshBaseView.h"

@interface GPRefreshBaseView()
@property (nonatomic,weak) UIButton *alertButton;
@property(nonatomic,weak) UIView *loadingView;
@end

@implementation GPRefreshBaseView

{
    NSString *_beginDrapText;
    NSString *_drapingText;
    NSString *_loadingText;

}

-(void)setTitle:(NSString *)title forState:(GPRefreshViewStatus)state{
    switch (state) {
        case GPRefreshViewStatusBeginDrap:
            _beginDrapText=title;
            break;
        case GPRefreshViewStatusDraping:
            _drapingText=title;
            break;
        case GPRefreshViewStatusLoading:
            _loadingText=title;
            break;
        default:
            break;
    }
}

-(NSString *)titleWithStatus:(GPRefreshViewStatus)status{
    NSString *title=nil;
    switch (status) {
        case GPRefreshViewStatusBeginDrap:
            title=_beginDrapText?_beginDrapText:@"拖拽";
            break;
        case GPRefreshViewStatusDraping:
            title=_drapingText?_drapingText:@"松开";
            break;
        case GPRefreshViewStatusLoading:
            title=_loadingText?_loadingText:@"加载";
            break;
        default:
            break;
    }
    return title;
}

+(id)refreshBaseView{
    return [[self alloc]init];
}

-(void)didMoveToSuperview{
    self.scrollView=self.superview;
    
}

-(void)stopAnimation{
    _scrollView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    
    [self clear];
    
}

-(void)clear{
    [self.alertButton removeFromSuperview];
    [self.loadingView removeFromSuperview];
    self.status=GPRefreshViewStatusBeginDrap;
}

-(void)dealloc{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
}
-(void)setScrollView:(UIScrollView *)scrollView{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    _scrollView=scrollView;
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{

    
}

-(UIView *)loadingView{
    if (_loadingView==nil) {
        UIView *view=[[UIView alloc]init];
        [self addSubview:view];
        view.frame=self.bounds;
        
        UILabel *label=[[UILabel alloc]initWithFrame:view.bounds];
        label.textAlignment=NSTextAlignmentCenter;
        [view addSubview:label];
        label.text=[self titleWithStatus:GPRefreshViewStatusLoading];
        
        UIActivityIndicatorView *active=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        active.frame=CGRectMake(100, 9, 40, 40);
        [view addSubview:active];
        [active startAnimating];
        _loadingView = view;
    }
    return _loadingView;
}

-(UIButton *)alertButton{
    if (_alertButton==nil) {
        UIButton *alertButton=[UIButton buttonWithType:UIButtonTypeCustom];
        alertButton.frame=self.bounds;
        [self addSubview:alertButton];
        _alertButton=alertButton;
        
        [alertButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [alertButton setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    }
    
    return  _alertButton;
}

-(void)setStatus:(GPRefreshViewStatus)status{
    _status=status;
    switch (status) {
        case GPRefreshViewStatusBeginDrap:
            [self.alertButton setTitle:[self titleWithStatus:GPRefreshViewStatusBeginDrap]forState:UIControlStateNormal];
            break;
        case GPRefreshViewStatusDraping:
            [self.alertButton setTitle:[self titleWithStatus:GPRefreshViewStatusDraping] forState:UIControlStateNormal];
            break;
        case GPRefreshViewStatusLoading:
            self.alertButton.hidden=YES;
            self.loadingView;
            break;
        default:
            break;
    }
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    
}
@end
