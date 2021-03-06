//
//  SWProfileViewController.m
//  SmartWatch
//
//  Created by zhuzhi on 14/12/3.
//
//

#import "SWProfileViewController.h"
#import "SWHeadImageCell.h"
#import "SWProfileInfoCell.h"
#import "SWProfileModel.h"
#import "SWUserInfo.h"
#import "WBPath.h"
#import "HTDatePicker.h"
#import "SWPickerView.h"

@interface SWProfileViewController ()<UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,HTDatePickerDelegate,SWPickerViewDelegate>
{
    SWHeadImageCell *headImageCell;
    
    HTDatePicker *datePicker;
    
    SWPickerView *sexPickerView;
    NSArray *sexPickerViewDataSource;
    
    SWPickerView *heightPickerView;
    NSArray *heightPickerViewDataSource;
    
    SWPickerView *weightPickerView;
    NSArray *weightPickerViewDataSource;
    
    SWPickerView *physiologicalDaysPickerView;
    NSArray *physiologicalDaysPickerViewDataSource;
    
    HTDatePicker *physiologicalDatePicker;
    
    SWProfileModel *model;
}

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation SWProfileViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        model = [[SWProfileModel alloc] initWithResponder:self];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(@"Profile", nil);
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"3背景-ios_01"] forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"3背景-ios_02"]];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 17.0f);
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = footView;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([SWUserInfo shareInstance].sex == 1) {
        return 5;
    }
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * headImageCellIdentifier = @"headImageCellIdentifier";
    static NSString * otherCellIdentifier = @"otherCellIdentifier";
    if (indexPath.row == 0) {
        headImageCell = (SWHeadImageCell *)[tableView dequeueReusableCellWithIdentifier:headImageCellIdentifier];
        if (!headImageCell) {
            headImageCell = [[SWHeadImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headImageCellIdentifier];
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImageTap)];
            [headImageCell.headImageView addGestureRecognizer:tapGesture];
            headImageCell.nameTextField.delegate = self;
        }
        
        headImageCell.headImageView.image = [[UIImage alloc] initWithContentsOfFile:[[WBPath documentPath] stringByAppendingPathComponent:[[SWUserInfo shareInstance] headImagePath]]];
        headImageCell.nameTextField.text = [[SWUserInfo shareInstance] name];
        return headImageCell;
    }
    
    SWProfileInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:otherCellIdentifier];
    if (!cell) {
        cell = [[SWProfileInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:otherCellIdentifier];
    }
    
    if (indexPath.row == 1) {
        cell.title = NSLocalizedString(@"Sex", nil);
        if ([[SWUserInfo shareInstance] sex] == 0) {
            cell.value = NSLocalizedString(@"Female", nil);
        } else if ([[SWUserInfo shareInstance] sex] == 1) {
            cell.value = NSLocalizedString(@"Male", nil);
        } else {
            cell.value = @"";
        }
    } else if (indexPath.row == 2) {
        cell.title = NSLocalizedString(@"Birthday", nil);
        cell.value = [[SWUserInfo shareInstance] birthdayString];
    } else if (indexPath.row == 3) {
        cell.title = NSLocalizedString(@"Height", nil);
        if ([[SWUserInfo shareInstance] height] > 0) {
            cell.value = [NSString stringWithFormat:@"%@cm", @([[SWUserInfo shareInstance] height]).stringValue];
        } else {
            cell.value = @"";
        }
    } else if (indexPath.row == 4) {
        cell.title = NSLocalizedString(@"Weight", nil);
		if ([[SWUserInfo shareInstance] weight] > 0) {
			cell.value = [NSString stringWithFormat:@"%@kg", @([[SWUserInfo shareInstance] weight]).stringValue];
		} else {
			cell.value = @"";
		}
    } else if (indexPath.row == 5) {
        cell.title = NSLocalizedString(@"Menstrual cycle", nil);
		if ([[SWUserInfo shareInstance] physiologicalDays] > 0) {
			cell.value = [NSString stringWithFormat:@"%@%@", @([[SWUserInfo shareInstance] physiologicalDays]).stringValue, NSLocalizedString(@"Day", nil)];
		} else {
			cell.value = @"";
		}
    } else if (indexPath.row == 6) {
        cell.title = NSLocalizedString(@"Menstrual date", nil);
        if ([[SWUserInfo shareInstance] physiologicalDateString].length > 0) {
            cell.value = [NSString stringWithFormat:@"%@", [[SWUserInfo shareInstance] physiologicalDateString]];
        } else {
            cell.value = @"";
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 168.0f;
    }
    
    return 45.0f;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (datePicker && !datePicker.hidden) {
        return nil;
    }
    
    if (physiologicalDatePicker && !physiologicalDatePicker.hidden) {
        return nil;
    }
    
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.row != 0) {
        self.tableView.userInteractionEnabled = NO;
    }
    
    if (indexPath.row == 1) {
        if (!sexPickerView) {
            sexPickerView = [[SWPickerView alloc] init];
            sexPickerView.hidden = YES;
            sexPickerView.delegate = self;
            
            sexPickerViewDataSource = @[NSLocalizedString(@"Male", nil), NSLocalizedString(@"Female", nil)];
            sexPickerView.dataSource = sexPickerViewDataSource;
        }
        [sexPickerView selectRow:[SWUserInfo shareInstance].sex == 0 ? 1 : 0 inComponent:0 animated:NO];
        [sexPickerView showFromView:self.view];
    } else if (indexPath.row == 2) {
        if (!datePicker) {
            datePicker = [[HTDatePicker alloc] initWithFrame:CGRectMake(0, self.view.height, IPHONE_WIDTH, 260) date:[NSDate date]];
            datePicker.hidden = YES;
            datePicker.delegate = self;
            [self.view addSubview:datePicker];
        }
        
        NSDate *date = [[SWUserInfo shareInstance].birthdayString dateWithFormat:@"yyy/MM/dd"];
        if (date) {
            [datePicker setDate:date animated:NO];
        }
        [self showDatePicker:YES];
    } else if (indexPath.row == 3) {
        if (!heightPickerView) {
            heightPickerView = [[SWPickerView alloc] init];
            heightPickerView.hidden = YES;
            heightPickerView.delegate = self;
			
			NSMutableArray *tempArr = [NSMutableArray array];
			for (int i = 100; i < 266 ; i++) {
				[tempArr addObject:@(i)];
			}
			
			heightPickerViewDataSource = [NSArray arrayWithArray:tempArr];
            heightPickerView.titleSuffix = @"cm";
            heightPickerView.dataSource = heightPickerViewDataSource;
        }
        
        NSUInteger index = [heightPickerViewDataSource indexOfObject:@([SWUserInfo shareInstance].height)];
        if (index != NSNotFound) {
            [heightPickerView selectRow:index inComponent:0 animated:NO];
		} else {
			NSUInteger index2 = [heightPickerViewDataSource indexOfObject:@(165)];
			if (index2 != NSNotFound) {
				[heightPickerView selectRow:index2 inComponent:0 animated:NO];
			}
		}
        [heightPickerView showFromView:self.view];
    } else if (indexPath.row == 4) {
        if (!weightPickerView) {
            weightPickerView = [[SWPickerView alloc] init];
            weightPickerView.hidden = YES;
            weightPickerView.delegate = self;
            
            NSMutableArray *arr = [NSMutableArray array];
            for (NSInteger i = 20; i < 151; i++) {
                [arr addObject:@(i)];
            }
            weightPickerViewDataSource = arr;
            weightPickerView.titleSuffix = @"kg";
            weightPickerView.dataSource = weightPickerViewDataSource;
        }
        NSUInteger index = [weightPickerViewDataSource indexOfObject:@([SWUserInfo shareInstance].weight)];
        if (index != NSNotFound) {
            [weightPickerView selectRow:index inComponent:0 animated:NO];
        }
        [weightPickerView showFromView:self.view];
    } else if (indexPath.row == 5) {
        if (!physiologicalDaysPickerView) {
            physiologicalDaysPickerView = [[SWPickerView alloc] init];
            physiologicalDaysPickerView.hidden = YES;
            physiologicalDaysPickerView.delegate = self;
            
            NSMutableArray *arr = [NSMutableArray array];
            for (NSInteger i = 1; i <= 30; i++) {
                [arr addObject:@(i)];
            }
            physiologicalDaysPickerViewDataSource = arr;
            physiologicalDaysPickerView.titleSuffix = NSLocalizedString(@"Day", nil);
            physiologicalDaysPickerView.dataSource = physiologicalDaysPickerViewDataSource;
        }
        NSUInteger index = [physiologicalDaysPickerViewDataSource indexOfObject:@([SWUserInfo shareInstance].physiologicalDays)];
        if (index != NSNotFound) {
            [physiologicalDaysPickerView selectRow:index inComponent:0 animated:NO];
        }
        [physiologicalDaysPickerView showFromView:self.view];
    } else if (indexPath.row == 6) {
        if (!physiologicalDatePicker) {
            physiologicalDatePicker = [[HTDatePicker alloc] initWithFrame:CGRectMake(0, self.view.height, IPHONE_WIDTH, 260) date:[NSDate date]];
            physiologicalDatePicker.hidden = YES;
            physiologicalDatePicker.delegate = self;
            [self.view addSubview:physiologicalDatePicker];
        }
        NSDate *date = [[SWUserInfo shareInstance].physiologicalDateString dateWithFormat:@"yyy/MM/dd"];
        if (date) {
            [physiologicalDatePicker setDate:date animated:NO];
        }
        
        [self showPhysiologicalDatePicker:YES];
    }
}

#pragma mark - Text field delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (datePicker && !datePicker.hidden) {
        return NO;
    }
    
    if (physiologicalDatePicker && !physiologicalDatePicker.hidden) {
        return NO;
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([newStr length]>20)
    {
        NSString *msg =  NSLocalizedString(@"Name can not exceed 20 characters", nil);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [model saveName:textField.text];
    return YES;
}

#pragma mark - Action sheet

- (void)headImageTap {
    if (datePicker && !datePicker.hidden) {
        return;
    }
    
    if (physiologicalDatePicker && !physiologicalDatePicker.hidden) {
        return;
    }
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:NSLocalizedString(@"Cancel",@"Cancel button text")
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:NSLocalizedString(@"Choose from album",@"Button text"),
                                  NSLocalizedString(@"Take Pictures",@"Camera button text"),nil];
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    [actionSheet showInView:self.tableView];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            [[GCDQueue mainQueue] queueBlock:^{
                [self presentViewController:imagePicker animated:YES completion:nil];
            } afterDelay:0.3f];
        }
    }
    if (buttonIndex == 0){
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        [[GCDQueue mainQueue] queueBlock:^{
            [self presentViewController:imagePicker animated:YES completion:nil];
        } afterDelay:0.3f];
    }
}

#pragma mark - Image picker delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *originalImage = nil;
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        originalImage = [info objectForKey:UIImagePickerControllerEditedImage];
    } else {
        originalImage = [info objectForKey:UIImagePickerControllerEditedImage];
    }
    
    headImageCell.headImageView.image = originalImage;
    [model saveHeadImage:originalImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)selectedImage editingInfo:(NSDictionary *)editingInfo {
    headImageCell.headImageView.image = selectedImage;
    [model saveHeadImage:selectedImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark - HTDatePickerDelegate

- (void)datePickerCancel:(HTDatePicker *)datePic {
    if (datePic == datePicker) {
        [self showDatePicker:NO];
    } else {
        [self showPhysiologicalDatePicker:NO];
    }
}

- (void)datePickerFinished:(HTDatePicker *)datePic date:(NSDate *)date {
    if (datePic == datePicker) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        NSString *dateString = [dateFormatter stringFromDate:date];
        [model saveBirthday:dateString];
        [self showDatePicker:NO];
        [self.tableView reloadData];
    } else if (datePic == physiologicalDatePicker) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        NSString *dateString = [dateFormatter stringFromDate:date];
        if ([[SWBLECenter shareInstance] setphysiologicalInfoWithDateymd:dateString physiologicalDay:[SWUserInfo shareInstance].physiologicalDays]) {
            [model savePhysiologicalDate:dateString];
        }
        [self showPhysiologicalDatePicker:NO];
        [self.tableView reloadData];
    }
    
}

- (void)showDatePicker:(BOOL)show {
    self.tableView.userInteractionEnabled = show ? NO : YES;
    datePicker.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        datePicker.top = show ? self.view.height - 260.0f: self.view.height;
    } completion:^(BOOL finished) {
        if (!show) {
            datePicker.hidden = YES;
        }
    }];
}

- (void)showPhysiologicalDatePicker:(BOOL)show {
    self.tableView.userInteractionEnabled = show ? NO : YES;
    physiologicalDatePicker.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        physiologicalDatePicker.top = show ? self.view.height - 260.0f: self.view.height;
    } completion:^(BOOL finished) {
        if (!show) {
            physiologicalDatePicker.hidden = YES;
        }
    }];
}

#pragma mark - SWPickerViewDelegate 

- (void)pickerView:(SWPickerView *)pickerView didFinished:(NSString *)value {
    if (pickerView == sexPickerView) {
        NSInteger sex = [value isEqualToString:@"男"] ? 1 : 0;
        if ([[SWBLECenter shareInstance] setUserInfoWithHeight:[SWUserInfo shareInstance].height weight:[SWUserInfo shareInstance].weight sex:sex]) {
            [model saveSex:sex];
        }
    } else if (pickerView == heightPickerView) {
        if ([[SWBLECenter shareInstance] setUserInfoWithHeight:value.integerValue weight:[SWUserInfo shareInstance].weight sex:[SWUserInfo shareInstance].sex]) {
            [model saveHeight:value.integerValue];
        }
    } else if (pickerView == weightPickerView) {
        if ([[SWBLECenter shareInstance] setUserInfoWithHeight:[SWUserInfo shareInstance].height weight:value.integerValue sex:[SWUserInfo shareInstance].sex]) {
            [model saveWeight:value.integerValue];
        }
    } else if (pickerView == physiologicalDaysPickerView) {
        if ([[SWBLECenter shareInstance] setphysiologicalInfoWithDateymd:[SWUserInfo shareInstance].physiologicalDateString physiologicalDay:value.integerValue]) {
            [model savePhysiologicalDays:value.integerValue];
        }
    }
    
    [self.tableView reloadData];
    [pickerView hideFromView:self.view];
    self.tableView.userInteractionEnabled = YES;
}

- (void)pickerViewDidCancel:(SWPickerView *)pickerView {
    [pickerView hideFromView:self.view];
    self.tableView.userInteractionEnabled = YES;
}

@end
