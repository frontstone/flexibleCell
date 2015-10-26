//
//  WordViewController.m
//  TestFlexibleCell
//
//  Created by axiBug on 15/10/26.
//  Copyright © 2015年 杭州贝宇网络有限公司. All rights reserved.
//

#import "WordViewController.h"

@interface WordViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) void(^CallBack)(NSString *text);

@end

@implementation WordViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    self.title = @"编辑文字";
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemDone) target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    self.textView.text = self.text;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)done
{
    if (self.CallBack) {
        self.CallBack(self.textView.text);
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)configureWithWord:(NSString *)text andCallBack:(void(^)(NSString *text))callBack
{
    self.text = text;
    self.CallBack = callBack;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
