//
//  ViewController.m
//  Objective_C_TableView_Api_Json
//
//  Created by Nguyễn Đức Hậu on 03/10/2024.
//

#import "ViewController.h"
#import "AccountCell.h"
#import "AccountModel.h"
#import "AFNetworking.h"
#import "WKWebViewController.h"
#import "ExpandableImageView.h"

@interface ViewController ()

@property (nonatomic, strong) ExpandableImageView *expandableImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Tạo và thiết lập ExpandableImageView
    self.expandableImageView = [[ExpandableImageView alloc] initWithFrame:CGRectMake(660, 400, 50, 50)];
    self.expandableImageView.center = CGPointMake(self.view.center.x, 100);
    self.expandableImageView.imageView.image = [UIImage imageNamed:@"logoo"];
    [self.view addSubview:self.expandableImageView];
    
    self.tableViewAccount.delegate = self;
    self.tableViewAccount.dataSource = self;
    self.accountArray = [[NSMutableArray alloc] init];
    
    // Đăng ký NIB
    UINib *nib = [UINib nibWithNibName:@"AccountCell" bundle:nil];
    [self.tableViewAccount registerNib:nib forCellReuseIdentifier:@"cellAccount"];
    
    // Lấy data từ api
    [self getDataFromAPIWithCompletion: ^(NSArray<AccountModel *> *accounts, NSError *error){
        if (error) {
            NSLog(@"Lỗi khi lấy dữ liệu về: %@", error.localizedDescription);
        }else {
            self.accountArray = [accounts mutableCopy];
            [self.tableViewAccount reloadData];
        }
    }];
    
    // Thêm Long Press Gesture vào tableView
       UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]
                                                         initWithTarget:self action:@selector(handleLongPress:)];
       [self.tableViewAccount addGestureRecognizer:longPressGesture];
    
}

//MARK: Even update
// Hàm xử lý long press
- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [gestureRecognizer locationInView:self.tableViewAccount];
        NSIndexPath *indexPath = [self.tableViewAccount indexPathForRowAtPoint:point];
        
        if (indexPath) {
            // Lấy tài khoản từ mảng
            AccountModel *accountToEdit = self.accountArray[indexPath.row];
            
            // Hiển thị form chỉnh sửa
            [self showEditFormForAccount:accountToEdit atIndexPath:indexPath];
        }
    }
}

//Hiển thị form edit và điền thông tin
- (void)showEditFormForAccount:(AccountModel *)account atIndexPath:(NSIndexPath *)indexPath {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Chỉnh sửa tài khoản"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    // Thêm trường văn bản cho username
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = account.username;
    }];
    
    // Thêm trường văn bản cho password
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = account.password;
        textField.secureTextEntry = YES;
    }];
    
    // Thêm trường văn bản cho link ảnh
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = account.imageAccount;
    }];
    
    // Tạo nút "Cập nhật"
    UIAlertAction *updateAction = [UIAlertAction actionWithTitle:@"Cập nhật" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *updatedUsername = alertController.textFields[0].text;
        NSString *updatedPassword = alertController.textFields[1].text;
        NSString *updatedImageLink = alertController.textFields[2].text;
        
        // Gọi API để cập nhật tài khoản
        [self updateAccountWithID:account._id username:updatedUsername password:updatedPassword imageLink:updatedImageLink completion:^(NSError *error) {
            if (error) {
                NSLog(@"Lỗi khi cập nhật tài khoản: %@", error.localizedDescription);
            } else {
                // Cập nhật dữ liệu trong mảng và table view
                account.username = updatedUsername;
                account.password = updatedPassword;
                account.imageAccount = updatedImageLink;
                
                [self.tableViewAccount reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        }];
    }];
    
    // Tạo nút "Hủy"
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Hủy" style:UIAlertActionStyleCancel handler:nil];
    
    // Thêm các hành động vào alert
    [alertController addAction:updateAction];
    [alertController addAction:cancelAction];
    
    // Hiển thị alert
    [self presentViewController:alertController animated:YES completion:nil];
}



//MARK: Even add
- (void)buttonPost:(id)sender {
    // Tạo UIAlertController
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Nhập thông tin tài khoản"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    // Thêm trường văn bản cho username
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Username";
    }];
    
    // Thêm trường văn bản cho password
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Password";
        textField.secureTextEntry = YES; // Ẩn văn bản
    }];
    
    // Thêm trường văn bản cho link ảnh
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Link ảnh";
    }];
    
    // Tạo hành động "Xác nhận"
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Xác nhận" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *username = alertController.textFields[0].text;
        NSString *password = alertController.textFields[1].text;
        NSString *imageLink = alertController.textFields[2].text;
        
        // Gọi hàm postDataToAPI với thông tin nhập vào
        [self postDataToAPIWithUsername:username password:password imageLink:imageLink completion:^(NSError *error) {
            if (error) {
                NSLog(@"Lỗi khi gửi dữ liệu %@", error.localizedDescription);
            } else {
                [self getDataFromAPIWithCompletion:^(NSArray<AccountModel *> *accounts, NSError *error) {
                    if (error) {
                        NSLog(@"Lỗi khi lấy dữ liệu về: %@", error.localizedDescription);
                    } else {
                        self.accountArray = [accounts mutableCopy];
                        [self.tableViewAccount reloadData];
                    }
                }];
            }
        }];
    }];
    
    // Tạo hành động "Hủy"
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Hủy" style:UIAlertActionStyleCancel handler:nil];
    
    // Thêm các hành động vào alert
    [alertController addAction:confirmAction];
    [alertController addAction:cancelAction];
    
    // Hiển thị alert
    [self presentViewController:alertController animated:YES completion:nil];
}

//MARK: Tableview
//trả về số dòng
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.accountArray.count;
}

//trả về custom cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AccountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellAccount" forIndexPath:indexPath];
    
    AccountModel *account = self.accountArray[indexPath.row];
    cell.emailLable.text = account.username;
    cell.passLabel.text = account.password;
    // Tải ảnh từ URL
    NSURL *imageURL = [NSURL URLWithString:account.imageAccount];
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error downloading image: %@", error.localizedDescription);
            return;
        }

        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.imageLabel.image = image; // Cập nhật UIImageView
                });
            }
        }
    }];

    [downloadTask resume];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Khởi tạo ViewController2 từ storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WKWebViewController *vc2 = [storyboard instantiateViewControllerWithIdentifier:@"displayWebView"];
    
    // Đẩy ViewController2 vào NavigationController
    [self.navigationController pushViewController:vc2 animated:YES];
    
    // Bỏ chọn dòng sau khi nhấn
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//MARK: Even delete
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Lấy tài khoản tương ứng với cell đang được xóa
        AccountModel *accountToDelete = self.accountArray[indexPath.row];

        // Gọi API để xóa tài khoản
        [self deleteAccountWithID:accountToDelete._id completion:^(NSError *error) {
            if (error) {
                NSLog(@"Lỗi khi xóa tài khoản: %@", error.localizedDescription);
                NSLog(@"Lỗi khi xóa tài khoản: %@", accountToDelete._id);
            } else {
                // Xóa tài khoản khỏi mảng và cập nhật bảng
                [self.accountArray removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        }];
    }
}

//MARK: Block add, update, delete, get
//Block post data lên api
- (void)postDataToAPIWithUsername:(NSString *)username password:(NSString *)password imageLink:(NSString *)imageLink completion:(PostCompletionHandler)completion {
    NSURL *URL = [NSURL URLWithString:@"https://042c-2001-ee0-4101-15f4-e8ac-6c41-66fb-b0e1.ngrok-free.app/api/post"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSDictionary *parameters = @{
        @"fullname": @"Ko can thiet",
        @"username": username,
        @"password": password,
        @"image_account": imageLink
    };
    
    [manager POST:URL.absoluteString
       parameters:parameters
          headers:nil
          progress:nil
           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completion) {
            completion(nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            completion(error);
        }
    }];
}

// Block update
- (void)updateAccountWithID:(NSString *)accountID username:(NSString *)username password:(NSString *)password imageLink:(NSString *)imageLink completion:(PostCompletionHandler)completion {
    NSString *urlString = [NSString stringWithFormat:@"https://042c-2001-ee0-4101-15f4-e8ac-6c41-66fb-b0e1.ngrok-free.app/api/edit/%@", accountID];
    NSURL *URL = [NSURL URLWithString:urlString];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSDictionary *parameters = @{
        @"username": username,
        @"password": password,
        @"image_account": imageLink
    };
    
    [manager POST:URL.absoluteString
       parameters:parameters
          headers:nil
          progress:nil
           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completion) {
            completion(nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            completion(error);
        }
    }];
}

// Block xoá tài khoản
- (void)deleteAccountWithID:(NSString *)accountID completion:(PostCompletionHandler)completion {
    NSString *urlString = [NSString stringWithFormat:@"https://042c-2001-ee0-4101-15f4-e8ac-6c41-66fb-b0e1.ngrok-free.app/api/delete/%@", accountID];
    NSURL *URL = [NSURL URLWithString:urlString];
    NSLog(@"Lỗi khi xóa tài khoản: %@", urlString);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager DELETE:URL.absoluteString parameters:nil headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completion) {
            completion(nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            completion(error);
        }
    }];
}

//Block get data từ api
- (void)getDataFromAPIWithCompletion:(CompletionHandler)completion {
    NSURL *URL = [NSURL URLWithString:@"https://042c-2001-ee0-4101-15f4-e8ac-6c41-66fb-b0e1.ngrok-free.app/api/getList"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:URL.absoluteString
      parameters:nil
        headers:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             // Xử lý dữ liệu khi thành công
             NSArray *jsonArray = responseObject[@"listAccount"]; // Lấy mảng "listAccount"
             [self.accountArray removeAllObjects]; // Xóa dữ liệu cũ
             
             for (NSDictionary *dict in jsonArray) {
                 AccountModel *account = [[AccountModel alloc] initWithDictionary:dict];
                 NSLog(@"Account ID: %@", account._id);
                 [self.accountArray addObject:account];
             }
             
        if (completion) {
            completion(self.accountArray, nil);
        }
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            completion(nil, error);
        }
         }
     ];
}

@end


