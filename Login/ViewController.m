//
//  ViewController.m
//  Login
//
//  Created by ParkerLovely on 15/11/8.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

#import "ViewController.h"

#import "UIImage+BoxBlur.h"
#import "DRNRealTimeBlurView.h"
#import "ParkViewController.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UITextField *userEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordTextField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"PArkerLovely";
    [testObject saveInBackground];
    
    UIImage *image = [self.imageView.image drn_boxblurImageWithBlur:0.1];
    self.imageView.image = image;
       self.headerView.layer.cornerRadius = 15;
    self.headerView.layer.masksToBounds = YES;
    
    
}

- (IBAction)signInButtonTapped:(id)sender {
    
    //获取邮箱和密码
    NSString *userEmail = self.userEmailTextField.text;
    NSString *userPassword = self.userPasswordTextField.text;
    //判断是否为空，弹出alertController，return
    if (!userEmail.length || !userPassword) {
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"警告" contentText:@"所有字段不能为空" leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
        [alert show];
        return;
    }
    
    /*在闭包中如果成功，及返回user不为空，用userDefault存储user，synchronize
     从storyboard中取出主界面，放到navi中，取出delegate把window的root设置为navi
     如果为空，弹出alertController，点按钮弹出注册界面
     */
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"发送";
    hud.detailsLabelText = @"请等待..";
    hud.userInteractionEnabled = NO;
    
    [PFUser logInWithUsernameInBackground:userEmail password:userPassword block:^(PFUser * _Nullable user, NSError * _Nullable error) {
        NSString *userMessage = @"登录成功";
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (user) {
            NSString *userName = user.username;
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:userName forKey:@"user_name"];
            [userDefaults synchronize];
            
            
            AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//            delegate.window.rootViewController = (UIViewController *)delegate.drawerController;
            [delegate buildUserInterface];
            
        }else{
            userMessage = error.localizedDescription;
            DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"警告" contentText:userMessage leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
            [alert show];
        }
        
    }];
    
    
}
- (IBAction)facebookButtonTapped:(id)sender {
    
    [PFFacebookUtils logInInBackgroundWithReadPermissions:@[@"public_profile", @"email"] block:^(PFUser * _Nullable user, NSError * _Nullable error) {
        
        if (error) {
            DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"警告" contentText:error.localizedDescription leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
            [alert show];
            return;
        }
        [self loadFacebookUserDetails];
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (void)loadFacebookUserDetails{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"发送";
    hud.detailsLabelText = @"正在载入Facebook的用户信息";
    hud.userInteractionEnabled = NO;
    
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields" : @"id, email, first_name, lst_name, name"} HTTPMethod:@"get"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (error) {
            DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"警告" contentText:error.localizedDescription leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
            [alert show];
            [PFUser logOut];
            return;
        }
        
        NSString *userId = result[@"id"];
        NSString *stringURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", userId];
        NSData *data= [NSData dataWithContentsOfURL:[NSURL URLWithString:stringURL]];
        PFFile *file = [PFFile fileWithData:data];
        if (data) {
            [[PFUser currentUser] setObject:file forKey:@"profile_picture"];
        }
        if (result[@"first_name"]) {
            [[PFUser currentUser] setObject:result[@"first_name"] forKey:@"first_name"];
        }
        if (result[@"last_name"]) {
            [[PFUser currentUser] setObject:result[@"last_name"] forKey:@"last_name"];
        }
        if (result[@"email"]) {
            [PFUser currentUser].email = result[@"email"];
            [PFUser currentUser].username = result[@"email"];
        }
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"发送";
        hud.detailsLabelText = @"请等待..";
        hud.userInteractionEnabled = NO;
        
        [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {

            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if (error) {
                DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:error.localizedDescription leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
                [alert show];
            }
            
            
            if (succeeded) {
                NSUserDefaults *userDafaults = [NSUserDefaults standardUserDefaults];
                [userDafaults setObject:userId forKey:@"user_name"];
                [userDafaults synchronize];
                dispatch_async(dispatch_get_main_queue(), ^{
                    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
                    [delegate buildUserInterface];
                });
            }
        }];
    }];
    
    
    
    
    
}
















@end
