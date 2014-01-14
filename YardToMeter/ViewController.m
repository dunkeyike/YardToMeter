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

	arrYardValue = [[NSArray alloc] initWithObjects:
					@"50", @"60", @"70", @"80", @"90", @"100", @"120", @"140", @"150", @"160",
					@"170", @"180", @"190", @"200", @"210", @"220", @"230", @"240", @"250", @"260",nil];
	[UIView animateWithDuration:0.1 animations:^{
		tvMeterToYard.alpha = 0.0f;
		tvYardToMeter.alpha = 0.0f;
		svTableView.alpha = 0.0f;
	} completion:^(BOOL finished) {
		[tvYardToMeter reloadData];
		[tvMeterToYard reloadData];
		[UIView animateWithDuration:0.1 animations:^{
			tvMeterToYard.alpha = 1.0f;
			tvYardToMeter.alpha = 1.0f;
			svTableView.alpha = 1.0f;
		}];
	}];

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
	NSLog(@"%s", __FUNCTION__);
}
#pragma mark - User Methods
- (IBAction)onYardToMeter:(id)sender {
	isYardToMeter = YES;
	if ([_tfInputDistance.placeholder isEqualToString:@"미터 입력"] || [_tfInputDistance.placeholder isEqualToString:@"yard"]) {
		_tfInputDistance.placeholder = @"야드 입력";
	}
	
	[self changeInput];
	[UIView animateWithDuration:0.2 animations:^{
		tvMeterToYard.alpha = 0.0f;
		tvYardToMeter.alpha = 0.0f;
		svTableView.alpha = 0.0f;
	} completion:^(BOOL finished) {
		[tvYardToMeter reloadData];
		[tvMeterToYard reloadData];
		[UIView animateWithDuration:0.2 animations:^{
			tvMeterToYard.alpha = 1.0f;
			tvYardToMeter.alpha = 1.0f;
			svTableView.alpha = 1.0f;
		}];
	}];
	
}
- (IBAction)onMeterToYard:(id)sender {
	isYardToMeter = NO;
	if ([_tfInputDistance.placeholder isEqualToString:@"야드 입력"] || [_tfInputDistance.placeholder isEqualToString:@"yard"]) {
		_tfInputDistance.placeholder = @"미터 입력";
	}
	[self changeInput];
	[UIView animateWithDuration:0.2 animations:^{
		tvMeterToYard.alpha = 0.0f;
		tvYardToMeter.alpha = 0.0f;
		svTableView.alpha = 0.0f;
	} completion:^(BOOL finished) {
		[tvYardToMeter reloadData];
		[tvMeterToYard reloadData];
		[UIView animateWithDuration:0.2 animations:^{
			tvMeterToYard.alpha = 1.0f;
			tvYardToMeter.alpha = 1.0f;
			svTableView.alpha = 1.0f;
		}];
	}];
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
    return 10;
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
	if (isYardToMeter) {
		lblValueUnit.text = @"yd";
		lblResultUnit.text = @"m";
		result = [lblValue.text intValue] * kYARDTOMETER;
	} else {
		lblValueUnit.text = @"m";
		lblResultUnit.text = @"yd";
		result = [lblValue.text intValue] * kMETERTOYARD;
	}
	
	if (tableView == tvYardToMeter) {
		lblValue.text = [arrYardValue objectAtIndex:indexPath.row];
	} else {
		lblValue.text = [arrYardValue objectAtIndex:indexPath.row+10];
	}
	
	lblResult.text = [NSString stringWithFormat:@"%.3f", result];
    
    // Configure the cell...
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[DetailViewController alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	NSLog(@"%s", __FUNCTION__);
}
@end
