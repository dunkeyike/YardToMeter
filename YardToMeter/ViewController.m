//
//  ViewController.m
//  YardToMeter
//
//  Created by Dunkey on 2014. 1. 14..
//  Copyright (c) 2014년 Dunkey. All rights reserved.
//

#import "ViewController.h"

#define kYARDTOMETER	0.9144
#define kMETERTOYARD	1.093613

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	isYardToMeter = YES;
	
	_tfInputDistance.placeholder = NSLocalizedString(@"Input Yard", @"Input Yard");
	
	vTextfieldBackView.layer.borderWidth = 1;
	vTextfieldBackView.layer.borderColor = [UIColor lightGrayColor].CGColor;
	vTextfieldBackView.backgroundColor = [UIColor whiteColor];
	
	[_tfInputDistance addTarget:self action:@selector(changeInput) forControlEvents:UIControlEventEditingChanged];
	
	_lblResultDistance.text = @"0.000";
	[_lblResultDistance sizeToFit];
	_lblResultDistance.center = CGPointMake(self.view.center.x, _lblResultDistance.center.y);
	
	lblDistanceUnit = [[UILabel alloc] init];
	lblDistanceUnit.textAlignment = NSTextAlignmentLeft;
	lblDistanceUnit.textColor = [UIColor blueColor];
	lblDistanceUnit.font = [UIFont boldSystemFontOfSize:18];
	lblDistanceUnit.frame = CGRectMake(
									   _lblResultDistance.frame.origin.x + _lblResultDistance.frame.size.width,
									   (_lblResultDistance.frame.origin.y + _lblResultDistance.frame.size.height) - 26,
									   40,
									   22);
	lblDistanceUnit.text = @" m";
	
	[self.view addSubview:lblDistanceUnit];
	
	svTableView.contentSize = CGSizeMake(160 * 3, 360);
	
	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disappearKeyboard:)];
	[self.view addGestureRecognizer:tapGesture];
	
	
	UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeTable:)];
	swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
	swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;

	[svTableView addGestureRecognizer:swipeGesture];
	[self updateTableView];

	
	NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
	NSLog(@"language : %@", language);
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIGestureRecognizer Methods
- (void)disappearKeyboard:(UIGestureRecognizer*)gesture {
	[_tfInputDistance resignFirstResponder];
}
- (void) swipeTable:(UIGestureRecognizer*)gesture {
#warning TODO : 테이블뷰 페이징 기능
}
#pragma mark - User Methods
- (void) updateTableView {
	[UIView animateWithDuration:0.1 animations:^{
		tvLeftTableView.alpha = 0.0f;
		tvRightTableView.alpha = 0.0f;
		svTableView.alpha = 0.0f;
	} completion:^(BOOL finished) {
		[tvLeftTableView reloadData];
		[tvRightTableView reloadData];
		[UIView animateWithDuration:0.1 animations:^{
			tvLeftTableView.alpha = 1.0f;
			tvRightTableView.alpha = 1.0f;
			svTableView.alpha = 1.0f;
		}];
	}];
}
- (IBAction)onYardToMeter:(id)sender {
	isYardToMeter = YES;
	if ([_tfInputDistance.placeholder isEqualToString:NSLocalizedString(@"Input Meter", @"Input Meter")] || _tfInputDistance.placeholder == nil) {
		_tfInputDistance.placeholder = NSLocalizedString(@"Input Yard", @"Input Yard");
	}
	
	[self changeInput];
	[self updateTableView];
}
- (IBAction)onMeterToYard:(id)sender {
	isYardToMeter = NO;
	if ([_tfInputDistance.placeholder isEqualToString:NSLocalizedString(@"Input Yard", @"Input Yard")] || _tfInputDistance.placeholder == nil) {
		_tfInputDistance.placeholder = NSLocalizedString(@"Input Meter", @"Input Meter");
	}
	[self changeInput];
	[self updateTableView];
}

-(void) changeInput {
	int val = [_tfInputDistance.text intValue];
	if (isYardToMeter) {
		float resultDistance = val * kYARDTOMETER;
		_lblResultDistance.text = [NSString stringWithFormat:@"%.3f", resultDistance];
	} else {
		float resultDistance = val * kMETERTOYARD;
		_lblResultDistance.text = [NSString stringWithFormat:@"%.3f", resultDistance];
	}
	[_lblResultDistance sizeToFit];
	
	_lblResultDistance.center = CGPointMake(self.view.center.x, _lblResultDistance.center.y);
	
	lblDistanceUnit.frame = CGRectMake(
									   _lblResultDistance.frame.origin.x + _lblResultDistance.frame.size.width,
									   (_lblResultDistance.frame.origin.y + _lblResultDistance.frame.size.height) - 26,
									   40,
									   22);
	
	if (isYardToMeter) {
		lblDistanceUnit.text = @" m";
	} else {
		lblDistanceUnit.text = @" yd";
	}
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	UILabel *lblValue = (UILabel *)[cell viewWithTag:1];
	UILabel *lblResult = (UILabel *)[cell viewWithTag:2];
	UILabel *lblValueUnit = (UILabel *)[cell viewWithTag:3];
	UILabel *lblResultUnit = (UILabel *)[cell viewWithTag:4];
	
	float result;
	
	if (tableView == tvLeftTableView) {
		lblValue.text = [NSString stringWithFormat:@"%ld",(indexPath.row+1) * 10];
	} else {
		lblValue.text = [NSString stringWithFormat:@"%ld",((indexPath.row+1) * 10)+100];
	}
	
	if (isYardToMeter) {
		lblValueUnit.text = @"yd";
		lblResultUnit.text = @"m";
		result = [lblValue.text intValue] * kYARDTOMETER;
	} else {
		lblValueUnit.text = @"m";
		lblResultUnit.text = @"yd";
		result = [lblValue.text intValue] * kMETERTOYARD;
	}

	
	lblResult.text = [NSString stringWithFormat:@"%.3f", result];

    
    return cell;
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	float y =scrollView.contentOffset.y;
	if (scrollView == tvLeftTableView){
		if (y < 0) y = 0;
		if	(y > scrollView.contentSize.height - tvLeftTableView.frame.size.height){
			y = scrollView.contentSize.height - tvLeftTableView.frame.size.height;
		}
		if (scrollView.contentOffset.y > scrollView.contentSize.height - tvLeftTableView.frame.size.height) {
			if (scrollView.contentSize.height - tvLeftTableView.frame.size.height > 0) {
				[scrollView setContentOffset:CGPointMake(0, scrollView.contentSize.height - tvLeftTableView.frame.size.height)];
				[UIView animateWithDuration:0.2 animations:^{
					vRightTableEnd.alpha = 1.0;
				}];

			}
		}
		
		[tvRightTableView setContentOffset:CGPointMake(0, y)];
		if (tvRightTableView.contentOffset.y < 0) {
			[tvRightTableView setContentOffset:CGPointMake(0, 0)];
		}
	} else {
		if (y < 0) y = 0;
		
		if	(y > scrollView.contentSize.height - tvRightTableView.frame.size.height){
			y = scrollView.contentSize.height - tvRightTableView.frame.size.height;
		}
		if (scrollView.contentOffset.y < 0) {
			[scrollView setContentOffset:CGPointMake(0, 0)];
			[UIView animateWithDuration:0.2 animations:^{
				vLeftTableEnd.alpha = 1.0;
			}];
		}
		
		[tvLeftTableView setContentOffset:CGPointMake(0, y)];
		if (tvLeftTableView.contentOffset.y < 0) {
			[tvLeftTableView setContentOffset:CGPointMake(0, 0)];
			
		}
	}
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
    //ensure that the end of scroll is fired.
    [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:nil afterDelay:0.3];

}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
	[UIView animateWithDuration:0.2 animations:^{
		vLeftTableEnd.alpha = 0.0;
		vRightTableEnd.alpha = 0.0;
	}];
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
}

@end
