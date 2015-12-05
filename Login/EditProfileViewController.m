//
//  EditProfileViewController.m
//  Login
//
//  Created by ParkerLovely on 15/11/9.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureImageView;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordrepeatTextField;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *firstName = [[PFUser currentUser] objectForKey:@"first_name"];
    NSString *lastName = [[PFUser currentUser] objectForKey:@"last_name"];
    self.firstNameTextField.text = firstName;
    self.lastNameTextField.text = lastName;
    PFFile *file = [[PFUser currentUser] objectForKey:@"profile_picture"];
    [file getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        self.profilePictureImageView.image = [UIImage imageWithData:data];
    }];
}
- (IBAction)firstNameEnd:(id)sender {
    [self.view endEditing:YES];
}
- (IBAction)lastNameEdn:(id)sender {
    [self.view endEditing:YES];
}
- (IBAction)passwordFirstTimeField:(id)sender {
    [self.view endEditing:YES];
}
- (IBAction)passwordSecoundFieldEnd:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)doneButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)chooseProfileButtonTapped:(id)sender {
    UIImagePickerController *pickerController = [UIImagePickerController new];
    pickerController.delegate = self;
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pickerController animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    self.profilePictureImageView.image = info[UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)saveButtonTapped:(id)sender {
    PFUser *myUser = [PFUser currentUser];
    NSData *data = UIImageJPEGRepresentation(self.profilePictureImageView.image, 1);
    NSString *password = self.passwordTextField.text;
    NSString *passwordRepeat = self.passwordrepeatTextField.text;
    NSString *firstName = self.firstNameTextField.text;
    NSString *lastName = self.lastNameTextField.text;
    if (!password.length && !passwordRepeat.length && !firstName.length && !lastName.length && data) {
        DXAlertView *alertView = [[DXAlertView alloc] initWithTitle:@"警告" contentText:@"所有字段不能为空" leftButtonTitle:@"好的" rightButtonTitle:@"取消"];
        [alertView show];
        return;
    }
    if (![passwordRepeat isEqualToString:password]) {
        DXAlertView *alertView = [[DXAlertView alloc] initWithTitle:@"警告" contentText:@"两次密码不一致" leftButtonTitle:@"好的" rightButtonTitle:@"取消"];
        [alertView show];
        return;
    }
    
    [myUser setObject:firstName forKey:@"first_name"];
    [myUser setObject:lastName forKey:@"last_name"];
    myUser.password = password;
    [myUser setObject:[PFFile fileWithData:data] forKey:@"profile_picture"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Please wait";
    [myUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (error) {
            
            DXAlertView *alertView = [[DXAlertView alloc] initWithTitle:@"警告" contentText:error.localizedDescription leftButtonTitle:@"好的" rightButtonTitle:@"取消"];
            [alertView show];
            return;

        }
        if (succeeded) {
            
            DXAlertView *alertView = [[DXAlertView alloc] initWithTitle:@"恭喜" contentText:@"Profile details successfully updated" leftButtonTitle:@"好的" rightButtonTitle:@"取消"];
            alertView.leftBlock = ^(){
              [self dismissViewControllerAnimated:YES completion:^{
            
                  [self.opener loadUserDetails];
                  
              }];
            };
            [alertView show];
            
        }
        
        
        
        
        
    }];
    
    
}








@end
