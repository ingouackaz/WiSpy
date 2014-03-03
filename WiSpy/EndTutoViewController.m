//
//  EndTutoViewController.m
//  WiSpy
//
//  Created by Roger Ingouacka on 2014-03-02.
//
//

#import "EndTutoViewController.h"

@interface EndTutoViewController ()

@end

@implementation EndTutoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)goAction:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    [defaults setObject:@"0" forKey:@"alreadyOpen"];
    
    [defaults synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
