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
#import "OptionView.h"

#import "BaseModel.h"

#import "UIView+SnapShot.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIView *snapShotView;
    NSIndexPath *startIndexPath;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) OptionView *optionView;
@property (nonatomic, strong) NSMutableArray *dataSorces;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OptionTableViewCell" bundle:nil] forCellReuseIdentifier:@"OptionTableViewCellId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"InsertCallBackCell" bundle:nil] forCellReuseIdentifier:@"InsertCallBackCellId"];
    

    self.tableView.tableFooterView = self.optionView;
    
    [self.tableView addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)]];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.navigationController.navigationBarHidden = YES;
}

#pragma mark - actions
- (void)longPress:(UILongPressGestureRecognizer *)longGes
{
    CGPoint point = [longGes locationInView:self.tableView];
    NSIndexPath *indexPathing = [self.tableView indexPathForRowAtPoint:point];
  
    if (longGes.state == UIGestureRecognizerStateBegan) {
        
        startIndexPath = indexPathing;
        if (![startIndexPath isKindOfClass:[NSIndexPath class]]) {
            return;
        }
        UITableViewCell *moveCell = [self.tableView cellForRowAtIndexPath:startIndexPath];
        snapShotView = [UIView customSnapshoFromView:moveCell];
        __block CGPoint center = moveCell.center;
        snapShotView.center = center;
        snapShotView.alpha = 0.0;
        [self.tableView addSubview:snapShotView];
        [UIView animateWithDuration:0.25 animations:^{
            center.y = point.y;
            snapShotView.center = center;
            snapShotView.transform = CGAffineTransformMakeScale(1.05, 1.05);
            snapShotView.alpha = 0.98;
            moveCell.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            
            moveCell.hidden = YES;
            
        }];
    }else if (longGes.state == UIGestureRecognizerStateChanged){
        if (![snapShotView isKindOfClass:[UIView class]]) {
            return;
        }
        snapShotView.center = CGPointMake(self.tableView.bounds.size.width/2, point.y) ;
        if (indexPathing && ![indexPathing isEqual:startIndexPath]) {
            [self.dataSorces exchangeObjectAtIndex:indexPathing.row withObjectAtIndex:startIndexPath.row];
            [self.tableView moveRowAtIndexPath:indexPathing toIndexPath:startIndexPath];
            startIndexPath = indexPathing;
        }
        
    }else{
        
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:startIndexPath];
        cell.hidden = NO;
        cell.alpha = 0.0;
        
        [UIView animateWithDuration:0.25 animations:^{
            
            snapShotView.center = cell.center;
            snapShotView.transform = CGAffineTransformIdentity;
            snapShotView.alpha = 0.0;
            cell.alpha = 1.0;
            
        } completion:^(BOOL finished) {
            
            startIndexPath = nil;
            snapShotView = nil;
            [snapShotView removeFromSuperview];
    
        }];

        
    }
    
}

#pragma mark - delegate && dataSource

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



#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    BaseModel *baseModel = [[BaseModel alloc] initWithModelType:(ModelTypeImage) andData:originalImage];
    [self.dataSorces addObject:baseModel];
    [self.tableView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - private

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


#pragma mark - getter

- (NSMutableArray *)dataSorces
{
    if (!_dataSorces) {
        _dataSorces = [NSMutableArray array];
    }
    return _dataSorces;
}

- (OptionView *)optionView
{
    if (!_optionView) {
        _optionView = [[[NSBundle mainBundle] loadNibNamed:@"OptionView" owner:self options:nil] objectAtIndex:0];
        __weak ViewController *weakSelf = self;
        _optionView.SelectBlock = ^(OptionType type){
            [weakSelf p_selectedWithOptionType:type andIndex:0];
        };
    }
    return _optionView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
