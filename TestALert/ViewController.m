//
//  ViewController.m
//  TestALert
//
//  Created by tao song on 17/7/29.
//  Copyright © 2017年 tao song. All rights reserved.
//

#import "ViewController.h"
#import "HostAlertView.h"

@interface ViewController () <UITextFieldDelegate>



@end

@implementation ViewController{

    HostAlertView *hostAlert;
}

- (void)viewDidLoad {
    [super viewDidLoad];



    UIButton  *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(100, 400, 200, 100)];
    
    
    [btn3 addTarget:self action:@selector(show3) forControlEvents:UIControlEventTouchUpInside];
    
    [btn3 setTitle:@"HelloWOrld" forState:UIControlStateNormal];
    [btn3  setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:btn3];

}



- (void)show3
{

     hostAlert =  [[HostAlertView alloc] initWithTitle:@"提示" message:@"设置服务器IP及端口" sureBtn:@"确认" cancleBtn:@"取消"];

    hostAlert.portTextField.delegate = self;
    
    hostAlert.hostTextField.delegate = self;
    
    hostAlert.alertCallBack = ^(NSArray *data){
    
        NSLog(@"============%@",data);
    };
    
    hostAlert.apiCode = ^(NSInteger apiCode){
        
        NSLog(@"============%ld",apiCode);
    };
    
    [hostAlert showXLAlertView];


}



-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (hostAlert.frame.size.height - 216.0);
    //iPhone键盘高度216  iPad  键盘高度352
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:0.3f];
    
    //将视图y坐标向上移动offset个单位，以使下面有地方显示键盘
    if(offset > 0)
       hostAlert.frame = CGRectMake(0.0f, -offset, hostAlert.frame.size.width,
                                     hostAlert.frame.size.height);
    [UIView commitAnimations];
}

//按下return keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//编辑完成，视图恢复原状
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    hostAlert.frame =CGRectMake(0, 0, hostAlert.frame.size.width, hostAlert.frame.size.height);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
