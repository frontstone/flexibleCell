//
//  ViewController.m
//  TestFlexibleCell
//
//  Created by axiBug on 15/10/26.
//  Copyright © 2015年 杭州贝宇网络有限公司. All rights reserved.
//

#import "ViewController.h"
#import "WordViewController.h"

#import "OptionTableViewCell.h"
#import "InsertCallBackCell.h"

#import "BaseModel.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSorces;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OptionTableViewCell" bundle:nil] forCellReuseIdentifier:@"OptionTableViewCellId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"InsertCallBackCell" bundle:nil] forCellReuseIdentifier:@"InsertCallBackCellId"];
    
    OptionTableViewCell *optionView = [[[NSBundle mainBundle] loadNibNamed:@"OptionTableViewCell" owner:self options:nil] lastObject];
    optionView.SelectBlock = ^(OptionType type){
        [self p_selectedWithOptionType:type andIndex:0];
    };
    self.tableView.tableFooterView = optionView;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.navigationController.navigationBarHidden = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSorces.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    BaseModel *baseModel = self.dataSorces[indexPath.row];
    if (baseModel.type == ModelTypeOption) {
        
        OptionTableViewCell *optionCell = [tableView dequeueReusableCellWithIdentifier:@"OptionTableViewCellId"];
        optionCell.SelectBlock = ^(OptionType type){
            [self p_selectedWithOptionType:type andIndex:indexPath.row];
        };
        return optionCell;
        
    }else{
        InsertCallBackCell *insertCell = [tableView dequeueReusableCellWithIdentifier:@"InsertCallBackCellId"];
        [insertCell configureWithBaseModel:baseModel indexPath:indexPath andInsertOptionBlock:^(NSIndexPath *indexPathCallBack) {
            BaseModel *model = [[BaseModel alloc] initWithModelType:(ModelTypeOption) andData:@""];
            [self.dataSorces insertObject:model atIndex:indexPathCallBack.row + 1];
            [self.tableView reloadData];
        }];
        return insertCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseModel *baseModel = [self.dataSorces objectAtIndex:indexPath.row];
    if (baseModel.type == ModelTypeOption) {
        return 50;
    }else if (baseModel.type == ModelTypeImage){
        return 250.f;
    }
    return 100.f;
}

- (void)p_selectedWithOptionType:(OptionType)type andIndex:(NSInteger)index
{
    if (type == OptionTypeWord) {
        WordViewController *wordVC = [[WordViewController alloc] init];
        [wordVC configureWithWord:@"haha" andCallBack:^(NSString *text) {
            BaseModel *baseModel = [[BaseModel alloc] initWithModelType:(ModelTypeWord) andData:text];
            if (index > 0) {
                [self.dataSorces insertObject:baseModel atIndex:index + 1];
            }else{
               [self.dataSorces addObject:baseModel];
            }
            [self.tableView reloadData];
        }];
        [self.navigationController pushViewController:wordVC animated:YES];
        
    }else if (type == OptionTypeImage){
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
       if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
           [self presentViewController:imagePickerController animated:YES completion:nil];
           }
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    BaseModel *baseModel = [[BaseModel alloc] initWithModelType:(ModelTypeImage) andData:originalImage];
    [self.dataSorces addObject:baseModel];
    [self.tableView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (NSMutableArray *)dataSorces
{
    if (!_dataSorces) {
        _dataSorces = [NSMutableArray array];
    }
    return _dataSorces;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
