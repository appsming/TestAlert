
#import "HostAlertView.h"

@interface HostAlertView ()

{
    CGFloat keyboardHeightRe;
}

@end


@implementation HostAlertView


- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle
{
    
    if (self == [super init]) {
        
        self.frame = [UIScreen mainScreen].bounds;
        
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
        
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.layer.cornerRadius = 5.0;
        
        self.alertView.frame = CGRectMake(0, 0, AlertW, 200);
        self.alertView.layer.position = self.center;
        
        
        
        if (title) {
            
            self.titleLbl = [self GetAdaptiveLable:CGRectMake(2*XLSpace, 1*XLSpace, AlertW-4*XLSpace, 20) AndText:title andIsTitle:YES];
            self.titleLbl.textAlignment = NSTextAlignmentCenter;
            
            [self.alertView addSubview:self.titleLbl];
            
            CGFloat titleW = self.titleLbl.bounds.size.width;
            CGFloat titleH = self.titleLbl.bounds.size.height;
            
            self.titleLbl.frame = CGRectMake((AlertW-titleW)/2, 1*XLSpace, titleW, titleH);
            
        }
        if (message) {
            
            self.msgLbl = [self GetAdaptiveLable:CGRectMake(XLSpace, CGRectGetMaxY(self.titleLbl.frame)+XLSpace, AlertW-2*XLSpace, 20) AndText:message andIsTitle:NO];
            self.msgLbl.textAlignment = NSTextAlignmentCenter;
            
            [self.alertView addSubview:self.msgLbl];
            
            CGFloat msgW = self.msgLbl.bounds.size.width;
            CGFloat msgH = self.msgLbl.bounds.size.height;
            
            self.msgLbl.frame = self.titleLbl?CGRectMake((AlertW-msgW)/2, CGRectGetMaxY(self.titleLbl.frame)+XLSpace, msgW, msgH):CGRectMake((AlertW-msgW)/2, 2*XLSpace, msgW, msgH);
        }
        
        
        self.v1Btn  = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"unchecked"] ;
        self.v1Btn.frame = self.msgLbl ? CGRectMake(0, CGRectGetMaxY(self.msgLbl.frame)+1*XLSpace, AlertW/2, image.size.height):CGRectMake(0, CGRectGetMaxY(self.titleLbl.frame)+1*XLSpace, AlertW/2, image.size.height);
        [self.v1Btn setTag:10001];
        [self.v1Btn setImage:image forState:UIControlStateNormal];
        [self.v1Btn setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
        [self.v1Btn setTitle:@"V1" forState:UIControlStateNormal];
        [self.v1Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.v1Btn addTarget:self action:@selector(updateApiCode:) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:self.v1Btn];
        
        
        
        self.v2Btn  = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.v2Btn setTag:10002];
        self.v2Btn.frame = self.msgLbl ? CGRectMake(CGRectGetMaxX(self.v1Btn.frame), CGRectGetMaxY(self.msgLbl.frame)+1*XLSpace, AlertW/2, image.size.height):CGRectMake(CGRectGetMaxX(self.v1Btn.frame), CGRectGetMaxY(self.titleLbl.frame)+1*XLSpace, AlertW/2, image.size.height);
        [self.v2Btn addTarget:self action:@selector(updateApiCode:) forControlEvents:UIControlEventTouchUpInside];
        [self.v2Btn setImage:image forState:UIControlStateNormal];
        [self.v2Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.v2Btn setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
        [self.v2Btn setTitle:@"V2" forState:UIControlStateNormal];
        [self.alertView addSubview:self.v2Btn];
        
        
        self.hostTextField = [[UITextField alloc] init];
        
        self.hostTextField.frame = CGRectMake(10, CGRectGetMaxY(self.v1Btn.frame)+1*XLSpace, AlertW-20, 35);
        [self.hostTextField setBorderStyle:UITextBorderStyleLine];
        
        [self.hostTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        self.hostTextField.layer.borderColor= [UIColor blackColor].CGColor;
        
        self.hostTextField.layer.borderWidth= 0.8f;
        [self.alertView addSubview:self.hostTextField];
        
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入ip" attributes:
                                          @{NSForegroundColorAttributeName:[UIColor grayColor],
                                            NSFontAttributeName:self.hostTextField.font
                                            }];
        self.hostTextField.attributedPlaceholder = attrString;
        
        
        CGRect frame = [self.hostTextField frame];
        frame.size.width = 7.0f;
        UIView *leftview = [[UIView alloc] initWithFrame:frame];
        self.hostTextField.leftViewMode = UITextFieldViewModeAlways;
        self.hostTextField.leftView = leftview;
        
        
        
        
        
        
        
        self.portTextField = [[UITextField alloc] init];
        
        self.portTextField.frame = CGRectMake(10, CGRectGetMaxY(self.hostTextField.frame)+5, AlertW-20, 35);
        [self.portTextField setBorderStyle:UITextBorderStyleLine];
        
        [self.portTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        self.portTextField.layer.borderColor= [UIColor blackColor].CGColor;
        
        self.portTextField.layer.borderWidth= 0.8f;
        [self.alertView addSubview:self.portTextField];
        
        NSAttributedString *portAttrString = [[NSAttributedString alloc] initWithString:@"请输入端口" attributes:
                                              @{NSForegroundColorAttributeName:[UIColor grayColor],
                                                NSFontAttributeName:self.portTextField.font
                                                }];
        self.portTextField.attributedPlaceholder = portAttrString;
        
        
        CGRect frame1 = [self.portTextField frame];
        frame1.size.width = 7.0f;
        UIView *leftview1 = [[UIView alloc] initWithFrame:frame1];
        self.portTextField.leftViewMode = UITextFieldViewModeAlways;
        self.portTextField.leftView = leftview1;
        
        
        
        
        self.lineView = [[UIView alloc] init];
        self.lineView.frame = self.portTextField?CGRectMake(0, CGRectGetMaxY(self.portTextField.frame)+2*XLSpace, AlertW, 1):CGRectMake(0, CGRectGetMaxY(self.hostTextField.frame)+2*XLSpace, AlertW, 1);
        self.lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
        [self.alertView addSubview:self.lineView];
        
        
        
        //两个按钮
        if (cancleTitle && sureTitle) {
            
            self.cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.cancleBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), (AlertW-1)/2, 40);
            [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.cancleBtn setTitle:cancleTitle forState:UIControlStateNormal];
            //[self.cancleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            self.cancleBtn.tag = 1;
            [self.cancleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cancleBtn.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.cancleBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.cancleBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.cancleBtn];
        }
        
        if (cancleTitle && sureTitle) {
            self.verLineView = [[UIView alloc] init];
            self.verLineView.frame = CGRectMake(CGRectGetMaxX(self.cancleBtn.frame), CGRectGetMaxY(self.lineView.frame), 1, 40);
            self.verLineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
            [self.alertView addSubview:self.verLineView];
        }
        
        if(sureTitle && cancleTitle){
            
            self.sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.sureBtn.frame = CGRectMake(CGRectGetMaxX(self.verLineView.frame), CGRectGetMaxY(self.lineView.frame), (AlertW-1)/2+1, 40);
            [self.sureBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.sureBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.sureBtn setTitle:sureTitle forState:UIControlStateNormal];
            //[self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.sureBtn.tag = 2;
            [self.sureBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.sureBtn.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.sureBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.sureBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.sureBtn];
            
        }
        
        //只有取消按钮
        if (cancleTitle && !sureTitle) {
            
            self.cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.cancleBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), AlertW, 40);
            [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.cancleBtn setTitle:cancleTitle forState:UIControlStateNormal];
            //[self.cancleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            self.cancleBtn.tag = 1;
            [self.cancleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cancleBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.cancleBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.cancleBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.cancleBtn];
        }
        
        //只有确定按钮
        if(sureTitle && !cancleTitle){
            
            self.sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.sureBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), AlertW, 40);
            [self.sureBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.sureBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.sureBtn setTitle:sureTitle forState:UIControlStateNormal];
            //[self.sureBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            self.sureBtn.tag = 2;
            [self.sureBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.sureBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.sureBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.sureBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.sureBtn];
            
        }
        
        //计算高度
        CGFloat alertHeight = cancleTitle?CGRectGetMaxY(self.cancleBtn.frame):CGRectGetMaxY(self.sureBtn.frame);
        self.alertView.frame = CGRectMake(0, 0, AlertW, alertHeight);
        self.alertView.layer.position = self.center;
        
        [self addSubview:self.alertView];
        
        //发送通知
        [self addKeyboardNotification];
        
    }
    return self;
}





#pragma mark - 弹出 -
- (void)showXLAlertView
{
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    [self creatShowAnimation];
}

- (void)creatShowAnimation
{
    self.alertView.layer.position = self.center;
    self.alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
    }];
}


#pragma marker apiCode

- (void)updateApiCode:(UIButton *)sender
{
    
    NSInteger tag =  sender.tag;
    
    if (tag  == 10001) {
        
        _v1Btn.selected = YES;
        if (_v1Btn.isSelected) {
            _v2Btn.selected = NO;
        }
        
        
    }else  if(tag ==10002){
        
        
        _v2Btn.selected = YES;
        if (_v2Btn.isSelected) {
            _v1Btn.selected = NO;
        }
        
    }
    
    if (self.apiCode) {
        
        self.apiCode(tag);
    }
    
    
    
}


#pragma mark - 回调 -设置只有2  -- > 确定才回调
- (void)buttonEvent:(UIButton *)sender
{
    if (sender.tag == 2) {
        if (self.alertCallBack) {
            
            NSInteger apiCode =    _v1Btn.isSelected ? 1:2;
            
            NSString *hostText  =      self.hostTextField.text;
            NSString *portText  = self.portTextField.text;
            
            NSArray *data = @[@(apiCode),hostText,portText];
            
            self.alertCallBack(data);
        }
    }
    
    //[self removeKeyboardNotification];
    
    [self removeFromSuperview];
}


-(UILabel *)GetAdaptiveLable:(CGRect)rect AndText:(NSString *)contentStr andIsTitle:(BOOL)isTitle
{
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:rect];
    contentLbl.numberOfLines = 0;
    contentLbl.text = contentStr;
    contentLbl.textAlignment = NSTextAlignmentCenter;
    if (isTitle) {
        contentLbl.font = [UIFont boldSystemFontOfSize:16.0];
    }else{
        contentLbl.font = [UIFont systemFontOfSize:14.0];
    }
    
    NSMutableAttributedString *mAttrStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
    NSMutableParagraphStyle *mParaStyle = [[NSMutableParagraphStyle alloc] init];
    mParaStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [mParaStyle setLineSpacing:3.0];
    [mAttrStr addAttribute:NSParagraphStyleAttributeName value:mParaStyle range:NSMakeRange(0,[contentStr length])];
    [contentLbl setAttributedText:mAttrStr];
    [contentLbl sizeToFit];
    
    return contentLbl;
}

-(UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


#pragma mark - new add code
- (void)addKeyboardNotification {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
}

- (void)removeKeyboardNotification {
    [[NSNotificationCenter defaultCenter]removeObserver:self forKeyPath:UIKeyboardWillShowNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:UIKeyboardWillHideNotification];
    [[NSNotificationCenter defaultCenter]removeObserver:self forKeyPath:UIKeyboardDidShowNotification];
}

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSTimeInterval time = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    keyboardHeightRe =  keyboardRect.size.height;
    [UIView animateWithDuration:time animations:^{
        _alertView.frame = CGRectMake(CGRectGetMinX(_alertView.frame), ScreenHeight - keyboardHeightRe - CGRectGetHeight(_alertView.frame), CGRectGetWidth(_alertView.frame), CGRectGetHeight(_alertView.frame));
    }];
}


- (void)keyboardDidShow:(NSNotification *)not {
    
    NSDictionary *userInfo = [not userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSInteger keyboardHeight = keyboardRect.size.height;
    NSTimeInterval time = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    if (keyboardHeightRe != keyboardHeight) {
        //键盘向上
        [UIView animateWithDuration:time animations:^{
            _alertView.frame = CGRectMake(CGRectGetMinX(_alertView.frame), ScreenHeight - keyboardHeightRe - CGRectGetHeight(_alertView.frame), CGRectGetWidth(_alertView.frame), CGRectGetHeight(_alertView.frame));
        }];
    }
    
}


-(void)keyboardWillHide:(NSNotification *)aNotification
{
    
    NSDictionary *userInfo = [aNotification userInfo];
    [UIView animateWithDuration:[[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        _alertView.center = CGPointMake(_alertView.center.x, ScreenHeight / 2);
    }];
    
}




@end
