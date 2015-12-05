//
//  PasswordResetViewController.m
//  Login
//
//  Created by ParkerLovely on 15/11/9.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

#import "PasswordResetViewController.h"

@interface PasswordResetViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailAaddressTextField;

@end

@implementation PasswordResetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)sendButtonTapped:(id)sender {
    
    if (!self.emailAaddressTextField.text.length) {
        return;
    }
    [PFUser requestPasswordResetForEmailInBackground:self.emailAaddressTextField.text block:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"警告" contentText:error.localizedDescription leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
            [alert show];
        }else{
            DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"警告" contentText:@"密码重置信息已经发送到您的邮箱中" leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
            [alert show];
        }
    }];
    
    
}

- (IBAction)cancelButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}








@end
