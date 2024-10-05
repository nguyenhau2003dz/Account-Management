//
//  AccountCell.h
//  Objective_C_TableView_Api_Json
//
//  Created by Nguyễn Đức Hậu on 03/10/2024.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AccountCell: UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *emailLable;
@property (weak, nonatomic) IBOutlet UILabel *passLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageLabel;

@end

