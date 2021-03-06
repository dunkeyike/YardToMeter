//
//  ViewController.h
//  YardToMeter
//
//  Created by Dunkey on 2014. 1. 14..
//  Copyright (c) 2014년 Dunkey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate> {
	BOOL					isYardToMeter;
	UILabel					*lblDistanceUnit;
	IBOutlet UIView			*vTextfieldBackView;
	IBOutlet UITableView	*tvYardToMeter;
	IBOutlet UITableView	*tvMeterToYard;
	
	IBOutlet UIScrollView	*svTableView;
	
	NSArray					*arrYardValue;
	NSArray					*arrMeterValue;
}
@property (weak, nonatomic) IBOutlet UIButton					*btnYardToMeter;
@property (weak, nonatomic) IBOutlet UIButton					*btnMeterToYard;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField	*tfInputDistance;
@property (weak, nonatomic) IBOutlet UILabel					*lblResultDistance;

- (IBAction)onYardToMeter:(id)sender;
- (IBAction)onMeterToYard:(id)sender;
@end
