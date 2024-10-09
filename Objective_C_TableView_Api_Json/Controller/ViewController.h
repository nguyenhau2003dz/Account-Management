//
//  ViewController.h
//  Objective_C_TableView_Api_Json
//
//  Created by Nguyễn Đức Hậu on 03/10/2024.
//

#import <UIKit/UIKit.h>
#import "AccountModel.h"
typedef void (^CompletionHandler)(NSArray<AccountModel *> *accounts, NSError *error);

typedef void (^PostCompletionHandler)(NSError *error);

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableViewAccount;

@property (nonatomic, strong) NSMutableArray<AccountModel *> *accountArray;

- (IBAction)buttonPost:(id)sender;

@end

