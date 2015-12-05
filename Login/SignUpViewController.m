

//
//  SignUpViewController.m
//  Login
//
//  Created by ParkerLovely on 15/11/8.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

#import "SignUpViewController.h"
#import "ViewController.h"
@interface SignUpViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)selectProfileButtonTapped:(id)sender {
    UIImagePickerController *pickerController = [UIImagePickerController new];
    pickerController.delegate = self;
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pickerController animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    self.profilePhotoImageView.image = info[UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)callBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)signUpButtonTapped:(id)sender {
    
    NSString *userName = self.userEmailAddressTextField.text;
    NSString *userPassWord = self.userPasswordTextField.text;
    NSString *userPasswordRepeat = self.userPasswordRepeatTextField.text;
    NSString *userFirstName = self.userFirstNameTextField.text;
    NSString *userLastName = self.userLastNameTextField.text;
    if (!userName.length || !userPassWord.length || !userPasswordRepeat.length || !userFirstName.length || !userLastName.length) {
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"警告" contentText:@"所有字段不能为空" leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
        [alert show];
        return;
    }
    if (![userPassWord isEqualToString:userPasswordRepeat]) {
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"警告" contentText:@"两次密码不相同" leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
        [alert show];
        return;

    }
    
    //PFUser
    PFUser *myUser = [PFUser user];
    myUser.username = userName;
    myUser.password = userPassWord;
    myUser.email = userName;
    [myUser setObject:userFirstName forKey:@"first_name"];
    [myUser setObject:userLastName forKey:@"last_name"];
    //调parse方法在success的block中弹出当前VC
    NSData *data = UIImageJPEGRepresentation(self.profilePhotoImageView.image, 1);
    if (data) {
        [myUser setObject:[PFFile fileWithData:data] forKey:@"profile_picture"];
    }
    __block NSString *userMessage = @"注册成功";
    
 
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"发送";
    hud.detailsLabelText = @"请等待..";
    hud.userInteractionEnabled = NO;

    
    [myUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (!succeeded) {
            userMessage = error.localizedDescription;
        }
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:userMessage leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
        [alert show];
        alert.rightBlock = ^(){
            if (succeeded) {
                id vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
                UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
                CATransition *tran = [CATransition animation];
                tran.type = @"cube";
                tran.duration = 1;
                [self.navigationController.view.layer addAnimation:tran forKey:nil];
                [self.navigationController showViewController:navi sender:nil];
              
               
            }
            
        };
              
    }];
}
@end
