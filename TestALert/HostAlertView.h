//
//  HostAlertView.h
//  TestALert
//
//  Created by tao song on 17/7/29.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

///alertView  宽
#define AlertW 280
///各个栏目之间的距离
#define XLSpace 10.0

#define ScreenHeight  [[UIScreen mainScreen] bounds].size.height


typedef void(^AlertClickCallBack)(NSArray *data);
typedef void(^SelectApiCode)(NSInteger apiCode);
@interface HostAlertView : UIView



//弹窗
@property (nonatomic,retain) UIView *alertView;
//title
@property (nonatomic,retain) UILabel *titleLbl;
//内容
@property (nonatomic,retain) UILabel *msgLbl;
//确认按钮
@property (nonatomic,retain) UIButton *sureBtn;
//取消按钮
@property (nonatomic,retain) UIButton *cancleBtn;
//横线线
@property (nonatomic,retain) UIView *lineView;
//竖线
@property (nonatomic,retain) UIView *verLineView;


@property (nonatomic,retain) UIButton *v1Btn;

@property (nonatomic,retain) UIButton *v2Btn;


@property (nonatomic,retain) UITextField  *hostTextField;

@property (nonatomic,retain) UITextField  *portTextField;



@property (nonatomic,strong) AlertClickCallBack alertCallBack;
@property (nonatomic,assign) SelectApiCode apiCode;






- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle;

- (void)showXLAlertView;

@end
